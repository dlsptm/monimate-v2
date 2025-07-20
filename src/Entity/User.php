<?php

namespace App\Entity;

use App\Entity\Trait\DateTimeImmutableTrait;
use App\Repository\UserRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Bridge\Doctrine\IdGenerator\UuidGenerator;
use Symfony\Bridge\Doctrine\Validator\Constraints\UniqueEntity;
use Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface;
use Symfony\Component\Security\Core\User\UserInterface;

#[ORM\Entity(repositoryClass: UserRepository::class)]
#[ORM\Table(name: '`user`')]
#[UniqueEntity('email')]
class User implements PasswordAuthenticatedUserInterface, UserInterface
{
    use DateTimeImmutableTrait;

    #[ORM\Column(length: 100)]
    private string $devise = 'euro';

    #[ORM\Column(length: 255)]
    private ?string $email = null;

    #[ORM\Id]
    #[ORM\GeneratedValue(strategy: 'CUSTOM')]
    #[ORM\Column(type: Types::STRING)]
    #[ORM\CustomIdGenerator(class: UuidGenerator::class)]
    /** @phpstan-ignore-next-line */
    private ?string $id = null;

    #[ORM\Column]
    private bool $isVerified = false;

    #[ORM\Column(type: Types::DATE_IMMUTABLE)]
    private ?\DateTimeImmutable $lastLogin = null;

    #[ORM\Column(type: Types::TEXT)]
    private ?string $password = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $picture = null;

    #[ORM\Column]
    private array $roles = [];

    #[ORM\Column(length: 255)]
    private ?string $username = null;

    public function eraseCredentials(): void
    {
        // TODO: Implement eraseCredentials() method.
    }

    public function getDevise(): string
    {
        return $this->devise;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function getId(): ?string
    {
        return $this->id;
    }

    public function getLastLogin(): ?\DateTimeImmutable
    {
        return $this->lastLogin;
    }

    /**
     * @see PasswordAuthenticatedUserInterface
     */
    public function getPassword(): ?string
    {
        return $this->password;
    }

    public function getPicture(): ?string
    {
        return $this->picture;
    }

    /**
     * @see UserInterface
     */
    public function getRoles(): array
    {
        $roles = $this->roles;
        $roles[] = 'ROLE_USER';

        return array_unique($roles);
    }

    /**
     * A visual identifier that represents this user.
     *
     * @see UserInterface
     */
    public function getUserIdentifier(): string
    {
        \assert($this->email !== null && $this->email !== '');

        return $this->email;
    }

    public function getUsername(): ?string
    {
        return $this->username;
    }

    public function isVerified(): bool
    {
        return $this->isVerified;
    }

    public function setDevise(string $devise): static
    {
        $this->devise = $devise;

        return $this;
    }

    public function setEmail(string $email): static
    {
        $this->email = $email;

        return $this;
    }

    public function setIsVerified(bool $isVerified): static
    {
        $this->isVerified = $isVerified;

        return $this;
    }

    public function setLastLogin(\DateTimeImmutable $lastLogin): static
    {
        $this->lastLogin = $lastLogin;

        return $this;
    }

    public function setPassword(string $password): static
    {
        $this->password = $password;

        return $this;
    }

    public function setPicture(?string $picture): static
    {
        $this->picture = $picture;

        return $this;
    }

    public function setRoles(array $roles): static
    {
        $this->roles = $roles;

        return $this;
    }

    public function setUsername(string $username): static
    {
        $this->username = $username;

        return $this;
    }
}
