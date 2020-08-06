import { Controller, Get, Post, Put, Delete, Body, Param } from '@nestjs/common';
import { Profile } from './contact.entity';
import { ContactsService } from './contacts.service';

@Controller('contacts')
export class ContactsController {
    constructor(private contactsService: ContactsService){}

    @Get()
    index(): Promise<Profile[]> {
        return this.contactsService.findAll();
    }

    @Post('create')
    async create(@Body() contactData: Profile): Promise<any> {
      return this.contactsService.create(contactData);
    }

    @Put(':id/update')
    async update(@Param('id') id, @Body() contactData: Profile): Promise<any> {
        contactData.id = Number(id);
        // console.log('Update #' + contactData.id);
        return this.contactsService.update(contactData);
    }

    @Delete(':id/delete')
    async delete(@Param('id') id): Promise<any> {
      return this.contactsService.delete(id);
    }
}
