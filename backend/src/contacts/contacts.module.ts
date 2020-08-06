import { Module } from '@nestjs/common';
import { ContactsService } from './contacts.service';
import { ContactsController } from './contacts.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Profile } from './contact.entity';

@Module({
    imports: [
      TypeOrmModule.forFeature([Profile]),
    ],
    providers: [ContactsService],
    controllers: [ContactsController]
  })
  export class ContactsModule {}
