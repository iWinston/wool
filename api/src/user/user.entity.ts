import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToMany,
  JoinTable,
} from 'typeorm';
import { CommonEntity } from '@common/entity/common.entity';
import { Tag } from '@src/tag/tag.entity';

@Entity()
export class User extends CommonEntity<User> {
  @Column()
  name: string;

  @Column()
  phone: string;

  @Column()
  avatorPath: string;

  @Column({
    type: 'tinyint',
  })
  point: number;

  @ManyToMany(type => Tag)
  @JoinTable({ name: 'users_tags' })
  tags: Tag[];
}
