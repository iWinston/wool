import { Entity, Column, ManyToMany, JoinTable } from 'typeorm';
import { CommonEntity } from '@common/entity/common.entity';
import { Tag } from '@src/tag/tag.entity';
import { User } from '@src/user/user.entity';

@Entity()
export class News extends CommonEntity<News> {
  @Column({ type: 'tinyint' })
  userId: number;

  @Column()
  content: string;

  @Column()
  photoPath: string;

  @Column()
  location: string;

  @ManyToMany(type => Tag)
  @JoinTable({ name: 'news_tags' })
  tags: Tag[];

  // users who have liked this news
  @ManyToMany(type => User)
  @JoinTable({ name: 'liked_users' })
  likedUsers: User[];
}
