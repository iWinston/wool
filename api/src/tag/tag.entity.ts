import { Entity, PrimaryGeneratedColumn, Column, ManyToMany } from 'typeorm';
import { CommonEntity } from '@common/entity/common.entity';
import { User } from '@src/user/user.entity';
import { News } from '@src/news/news.entity';

@Entity()
export class Tag extends CommonEntity<Tag> {
  @Column()
  name: string;

  @ManyToMany(type => User)
  users: User[];

  @ManyToMany(type => News)
  news: News[];
}
