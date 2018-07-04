<?php

declare(strict_types=1);

namespace App\Infrastructure\Repository;

use App\Domain\Entity\User;

interface Users
{
    public function add(User $user): int;

    public function all(): array;

    public function findById(int $id): ?User;

    public function findByEmail(string $email): ?User;

    public function edit(User $user): int;

    public function editPartial(int $id, array $data): int;

    public function enableOrDisableUser(User $user): bool;

    public function remove(int $id): int;

    public function count(): int;
}
