import { Role, User } from '@prisma/client';
import { Exclude } from 'class-transformer';

export class UserResponse implements User {
    id: string;
    name: string;
    surname: string;
    email: string;
    @Exclude()
    password: string;
    role: Role[];
    position: string;
    phone: string;
    companyId: string;
    client_type: string;
    notification_sms: boolean;
    notification_email: boolean;
    industries: string[];

    constructor(user: User) {
        Object.assign(this, user);
    }
}
