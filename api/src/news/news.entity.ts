import { Entity, Column, ManyToMany, JoinTable } from 'typeorm';
import { CommonEntity } from '@common/entity/common.entity';
import { Tag } from '@src/tag/tag.entity';

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
  news: Tag[];
}
