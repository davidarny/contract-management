import Image from 'next/image';
import Link from 'next/link';

import type { Article } from '@/lib/types';

interface SidebarArticleCardProps {
  article: Article;
}

export function SidebarArticleCard({ article }: SidebarArticleCardProps) {
  const { date, title, image, slug } = article;

  return (
    <div className='overflow-hidden rounded-lg bg-white shadow'>
      <Image
        src={image || '/placeholder.svg'}
        alt={title}
        width={300}
        height={200}
        className='h-48 w-full object-cover'
      />
      <div className='p-4'>
        <p className='mb-2 text-sm text-gray-500'>{date}</p>
        <h2 className='mb-2 inline-block border-b-2 border-green-700 pb-2 text-lg font-bold text-green-700'>
          <Link href={`/articles/${slug}`}>{title}</Link>
        </h2>
      </div>
    </div>
  );
}
