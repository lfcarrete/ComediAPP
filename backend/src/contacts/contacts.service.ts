import { Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { Profile } from './contact.entity';
import { UpdateResult, DeleteResult } from  'typeorm';

@Injectable()
export class ContactsService {
    constructor(
        @InjectRepository(Profile)
        private contactRepository: Repository<Profile>,
    ) { }

    async  findAll(): Promise<Profile[]> {
        return await this.contactRepository.find();
    }

    async  create(contact: Profile): Promise<Profile> {
        return await this.contactRepository.save(contact);
    }

    async update(contact: Profile): Promise<UpdateResult> {
        return await this.contactRepository.update(contact.id, contact);
    }

    async delete(id): Promise<DeleteResult> {
        return await this.contactRepository.delete(id);
    }
}