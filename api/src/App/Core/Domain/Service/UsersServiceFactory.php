<?php

declare(strict_types=1);

namespace App\Core\Domain\Service;

use App\Domain\Service\UsersService;
use App\Infrastructure\Repository\Users;
use Psr\Container\ContainerInterface;

final class UsersServiceFactory
{
    public function __invoke(ContainerInterface $container): UsersService
    {
        return new UsersService($container->get(Users::class));
    }
}
