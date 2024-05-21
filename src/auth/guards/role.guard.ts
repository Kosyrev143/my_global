import { Injectable, CanActivate, ExecutionContext, ForbiddenException } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { Role } from '@prisma/client';
import { ROLES_KEY } from '@common/decorators';

@Injectable()
export class RolesGuard implements CanActivate {
    constructor(private reflector: Reflector) {}

    canActivate(context: ExecutionContext): boolean {
        const requiredRoles = this.reflector.getAllAndOverride<Role[]>(ROLES_KEY, [
            context.getHandler(),
            context.getClass(),
        ]);
        if (!requiredRoles) {
            return true;
        }
        const { user } = context.switchToHttp().getRequest();
        console.log('Required roles:', requiredRoles);
        console.log('User:', user);

        if (!user || !user.role) {
            throw new ForbiddenException('User not found or no roles assigned');
        }

        const hasRole = requiredRoles.some((role) => user.role.includes(role));
        if (!hasRole) {
            throw new ForbiddenException('User does not have the required roles');
        }

        return hasRole;
    }
}
