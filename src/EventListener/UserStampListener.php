<?php

namespace App\EventListener;

use Doctrine\Bundle\DoctrineBundle\Attribute\AsDoctrineListener;
use Doctrine\ORM\Event\PrePersistEventArgs;
use Doctrine\ORM\Event\PreUpdateEventArgs;
use Doctrine\ORM\Events;
use Symfony\Bundle\SecurityBundle\Security;

#[AsDoctrineListener(event: Events::prePersist)]
#[AsDoctrineListener(event: Events::preUpdate)]
class UserStampListener
{
    public function __construct(
        private readonly Security $security)
    {
    }

    public function prePersist(PrePersistEventArgs $args): void
    {
        $entity = $args->getObject();

        if (method_exists($entity, 'setCreatedAt') && method_exists($entity, 'setUpdatedAt')) {
            $entity->setCreatedAt(new \DateTimeImmutable());
            $entity->setUpdatedAt(new \DateTimeImmutable());
        }

        $user = $this->security->getUser();

        if ($user === null) {
            return;
        }

        if (method_exists($entity, 'setCreatedBy') && method_exists($entity, 'setUpdatedBy')) {
            $entity->setCreatedBy($user);
            $entity->setUpdatedBy($user);
        }
    }

    public function preUpdate(PreUpdateEventArgs $args): void
    {
        $entity = $args->getObject();

        if (method_exists($entity, 'setUpdatedAt')) {
            $entity->setUpdatedAt(new \DateTimeImmutable());
        }

        $user = $this->security->getUser();

        if ($user === null) {
            return;
        }

        if (method_exists($entity, 'setUpdatedBy')) {
            $entity->setUpdatedBy($user);
        }
    }
}
