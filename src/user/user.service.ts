import { ForbiddenException, Injectable } from '@nestjs/common';
import { PrismaService } from '@prisma/prisma.service';
import { Role, User } from '@prisma/client';
import { genSaltSync, hashSync } from 'bcrypt';
import { JwtPayload } from '@auth/interfaces';

@Injectable()
export class UserService {
    constructor(private readonly prismaService: PrismaService) {}

    save(user: Partial<User>) {
        const hashedPassword = this.hashPassword(user.password);
        return this.prismaService.user.create({
            data: {
                name: user.name,
                surname: user.surname,
                email: user.email,
                password: hashedPassword,
                role: ['CLIENT'],
                position: user.position,
                phone: user.phone,
                companyId: user.companyId,
                client_type: user.client_type,
                notification_sms: user.notification_sms,
                notification_email: user.notification_email,
                industries: user.industries,
            },
        });
    }

    saveUserForAdmin(user: Partial<User>) {
        const hashedPassword = this.hashPassword(user.password);
        return this.prismaService.user.create({
            data: {
                name: user.name,
                surname: user.surname,
                email: user.email,
                password: hashedPassword,
                role: user.role,
                position: user.position,
                phone: user.phone,
                companyId: user.companyId,
                client_type: user.client_type,
                notification_sms: user.notification_sms,
                notification_email: user.notification_email,
                industries: user.industries,
            },
        });
    }

    findOne(idOrEmail: string) {
        return this.prismaService.user.findFirst({
            where: {
                OR: [{ id: idOrEmail }, { email: idOrEmail }],
            },
        });
    }

    delete(id: string, user: JwtPayload) {
        if (user.id !== id && !user.role.includes(Role.ADMINISTRATOR)) {
            throw new ForbiddenException();
        }
        return this.prismaService.user.delete({ where: { id }, select: { id: true } });
    }

    private hashPassword(password: string) {
        return hashSync(password, genSaltSync(10));
    }
}
