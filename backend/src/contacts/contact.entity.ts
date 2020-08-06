import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class Profile {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    name: string;

    @Column()
    age: string;

    @Column()
    type: string;

    @Column()
    email: string;

    @Column()
    password: string;
}