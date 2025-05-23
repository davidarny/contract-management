import Image from 'next/image';
import Link from 'next/link';

import { TopicTags } from '@/components/topic-tags';
import type { Article } from '@/lib/types';
import { cn } from '@/lib/utils';

interface ArticleCardProps {
  article: Article;
}

export function ArticleCard({ article }: ArticleCardProps) {
  const { date, title, description, image, isLarge, slug } = article;

  return (
    <div className='overflow-hidden rounded-lg bg-white shadow'>
      <div className='flex flex-col md:flex-row'>
        <div
          className={cn({
            'md:w-1/2': isLarge,
            'md:w-1/3': !isLarge,
          })}
        >
          <Image
            src={image || '/placeholder.svg'}
            alt={title}
            width={isLarge ? 400 : 200}
            height={isLarge ? 300 : 200}
            className='h-full w-full object-cover'
          />
        </div>
        <div
          className={cn('p-6', {
            'md:w-1/2': isLarge,
            'md:w-2/3': !isLarge,
          })}
        >
          <div className='mb-2 flex items-center justify-between'>
            <p className='text-sm text-gray-500'>{date}</p>
            <TopicTags article={article} />
          </div>
          <h2 className='mb-2 inline-block text-pretty border-b-2 border-green-700 pb-2 text-xl font-semibold text-green-700'>
            <Link href={`/articles/${slug}`}>{title}</Link>
          </h2>
          <p className='text-balance text-sm text-gray-600'>{description}</p>
        </div>
      </div>
    </div>
  );
}
