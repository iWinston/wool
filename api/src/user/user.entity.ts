import { Entity, Column, ManyToMany, JoinTable, Index } from 'typeorm';
import { CommonEntity } from '@common/entity/common.entity';
import { Tag } from '@src/tag/tag.entity';

@Entity()
export class User extends CommonEntity<User> {
  @Column({ nullable: true })
  name: string;

  @Index()
  @Column()
  phone: string;

  @Column({ nullable: true })
  avatorPath: string;

  @Column({
    type: 'tinyint',
    default: 0,
  })
  point: number;

  @ManyToMany(type => Tag)
  @JoinTable({ name: 'users_tags' })
  tags: Tag[];
}
