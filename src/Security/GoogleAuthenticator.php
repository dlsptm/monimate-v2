<?php

namespace App\Security;

use App\Entity\User;
use Doctrine\ORM\EntityManagerInterface;
use KnpU\OAuth2ClientBundle\Client\ClientRegistry;
use KnpU\OAuth2ClientBundle\Security\Authenticator\OAuth2Authenticator;
use League\OAuth2\Client\Provider\GoogleUser;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\RequestStack;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\RouterInterface;
use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\Security\Core\Exception\AuthenticationException;
use Symfony\Component\Security\Http\Authenticator\Passport\Badge\UserBadge;
use Symfony\Component\Security\Http\Authenticator\Passport\SelfValidatingPassport;

class GoogleAuthenticator extends OAuth2Authenticator
{
    public function __construct(private ClientRegistry $clientRegistry,
        private EntityManagerInterface $em,
        private RouterInterface $router,
        private RequestStack $requestStack,

    ) {
    }

    public function authenticate(Request $request): SelfValidatingPassport
    {
        $client = $this->clientRegistry->getClient('google');
        /** @var GoogleUser $googleUser */
        $googleUser = $client->fetchUser();

        $email = $googleUser->getEmail();

        if ($email === null) {
            throw new \Exception('Email not found');
        }

        return new SelfValidatingPassport(
            new UserBadge($email, function () use ($email, $googleUser) {
                $user = $this->em->getRepository(User::class)->findOneBy(['email' => $email]);
                if (null === $user) {
                    $user = new User();
                    $user->setEmail($email);
                    $user->setPassword('');
                    $user->setRoles(['ROLE_USER']);
                    $user->setUsername($googleUser->getName());
                    $user->setPicture($googleUser->getAvatar());
                    $user->setIsVerified(true);
                    $user->setLastLogin(new \DateTimeImmutable());
                    $this->em->persist($user);
                    $this->em->flush();
                } else {
                    $user->setLastLogin(new \DateTimeImmutable());
                    $this->em->flush();
                }

                return $user;
            })
        );
    }

    public function onAuthenticationFailure(Request $request, AuthenticationException $exception): Response
    {
        $currentRequest = $this->requestStack->getCurrentRequest();
        if ($currentRequest !== null) {
            $session = $currentRequest->getSession();
            // Vérifier que c'est bien l'implémentation concrète Session
            if ($session instanceof \Symfony\Component\HttpFoundation\Session\Session) {
                $session->getFlashBag()->add('error', 'Authentification Google échouée : ' . $exception->getMessage());
            }
        }

        return new RedirectResponse($this->router->generate('app_login'));
    }

    public function onAuthenticationSuccess(Request $request, TokenInterface $token, string $firewallName): RedirectResponse
    {
        // Redirection après succès
        return new RedirectResponse($this->router->generate('app_home'));
    }

    public function supports(Request $request): bool
    {
        return $request->attributes->get('_route') === 'connect_google_check';
    }
}
