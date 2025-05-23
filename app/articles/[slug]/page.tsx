import { ArrowLeft } from 'lucide-react';

import type { Metadata } from 'next';
import Image from 'next/image';
import Link from 'next/link';
import { notFound } from 'next/navigation';

import { ArticleContent } from '@/components/article-content';
import { DefaultArticleContent } from '@/components/default-article-content';
import { articleContents } from '@/lib/article-content';
import { articles, getArticleBySlug, sidebarArticles } from '@/lib/data';

interface ArticlePageProps {
  params: Promise<{ slug: string }>;
}

// Generate static params for all articles
export async function generateStaticParams() {
  const allArticles = [...articles, ...sidebarArticles];
  return allArticles.map(article => ({ slug: article.slug }));
}

// Generate metadata for each article
export async function generateMetadata({
  params,
}: ArticlePageProps): Promise<Metadata> {
  const { slug } = await params;
  const article = getArticleBySlug(slug);

  if (!article) {
    return {
      title: 'Article Not Found',
      description: 'The requested article could not be found.',
    };
  }

  return {
    title: article.title,
    description: article.description,
    openGraph: {
      title: article.title,
      description: article.description,
      images: article.image ? [{ url: article.image, alt: article.title }] : [],
      type: 'article',
      publishedTime: article.date,
      url: `/articles/${article.slug}`,
      siteName: 'Contract Management Hub',
    },
    twitter: {
      title: article.title,
      description: article.description,
      images: article.image ? [{ url: article.image, alt: article.title }] : [],
    },
    alternates: {
      canonical: `/articles/${article.slug}`,
    },
  };
}

export default async function ArticlePage({ params }: ArticlePageProps) {
  const { slug } = await params;
  const article = getArticleBySlug(slug);

  if (!article) {
    notFound();
  }

  const content = articleContents[slug];

  return (
    <div className='flex min-h-screen flex-col'>
      {/* Hero Section */}
      <section className='bg-gray-100 py-12'>
        <div className='container mx-auto px-4 md:px-6'>
          <div className='mb-4'>
            <Link
              href='/articles'
              className='flex items-center text-sm text-gray-600 transition-colors hover:text-purple-700'
            >
              <ArrowLeft className='mr-1 h-4 w-4' />
              Back
            </Link>
          </div>
          <div className='flex flex-col items-start justify-between md:flex-row'>
            <div className='mb-8 md:mb-0 md:w-1/2'>
              <h1 className='mb-4 text-pretty text-3xl font-bold text-gray-800 md:text-4xl'>
                {article.title}
              </h1>
              <p className='mb-4 text-sm text-gray-500'>{article.date}</p>
              <p className='text-balance text-gray-600'>
                {article.description}
              </p>
            </div>
            <div className='flex justify-center md:w-1/2'>
              <Image
                src={article.image || '/placeholder.svg'}
                alt={article.title}
                width={540}
                height={400}
                className='rounded object-cover shadow'
              />
            </div>
          </div>
        </div>
      </section>

      {/* Blue Divider */}
      <div className='h-2 w-full bg-blue-800'></div>

      {/* Article Content */}
      {content ? (
        <ArticleContent content={content} />
      ) : (
        <DefaultArticleContent article={article} />
      )}
    </div>
  );
}
