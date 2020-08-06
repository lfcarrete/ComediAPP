import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ContactsModule } from './contacts/contacts.module';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [ContactsModule,
  TypeOrmModule.forRoot({
    type: 'postgres',
    host: 'tuffi.db.elephantsql.com',
    port: 5432,
    username: 'wgamgciv',
    password: '2SucL_mRjMZVmIa4Gexh-O0Uujh42r_o',
    database: 'wgamgciv',
    entities: [__dirname + "/**/*.entity.js"],
    synchronize: true,
  }),],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
