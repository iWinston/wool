import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity()
export class AppEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;
}
