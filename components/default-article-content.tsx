import type { Article } from '@/lib/types';

interface DefaultArticleContentProps {
  article: Article;
}

export function DefaultArticleContent({ article }: DefaultArticleContentProps) {
  return (
    <main id='article-content' className='container mx-auto px-4 py-12 md:px-6'>
      <div className='mx-auto max-w-3xl'>
        <div className='mb-8'>
          <p className='mb-2 text-sm text-gray-500'>
            {article.date} | By The Iuertis Team
          </p>
          <h2 className='mb-4 text-2xl font-bold text-gray-800'>
            {article.title}
          </h2>
          <p className='mb-6 text-gray-700'>{article.description}</p>
        </div>

        <div className='mb-8 rounded-lg bg-gray-50 p-6'>
          <h3 className='mb-3 text-xl font-bold text-gray-800'>
            Article Overview
          </h3>
          <p className='mb-4 text-gray-700'>
            This article provides an overview of {article.title.toLowerCase()}.
            It covers the key concepts, important considerations, and practical
            applications in contract management.
          </p>
          <p className='text-gray-700'>
            We&apos;re currently expanding this article with more detailed
            information. Please check back soon for the complete version with
            comprehensive sections, examples, and best practices.
          </p>
        </div>

        <div className='mb-8'>
          <h2 className='mb-4 border-b border-gray-200 pb-2 text-2xl font-bold text-gray-800'>
            Key Points
          </h2>
          <p className='mb-4 text-gray-700'>
            While we&apos;re working on the full article, here are some key
            points to understand about {article.title.toLowerCase()}:
          </p>

          <ul className='mb-6 list-disc space-y-2 pl-6'>
            <li className='text-gray-700'>
              Understanding the basic definition and purpose of{' '}
              {article.title.toLowerCase().replace('what is ', '')}
            </li>
            <li className='text-gray-700'>
              Legal requirements and standard components
            </li>
            <li className='text-gray-700'>
              Common challenges and how to address them
            </li>
            <li className='text-gray-700'>
              Best practices for implementation in your business
            </li>
            <li className='text-gray-700'>
              How it fits into your overall contract management strategy
            </li>
          </ul>
        </div>

        <div className='mb-8 rounded-lg bg-gray-50 p-6'>
          <h2 className='mb-3 text-xl font-bold text-gray-800'>Coming Soon</h2>
          <p className='text-gray-700'>
            We&apos;re currently working on expanding this article with more
            detailed information, practical examples, and expert insights.
            Please check back soon for the complete version.
          </p>
        </div>

        <div className='mt-8 border-t border-gray-200 pt-6'>
          <p className='text-sm text-gray-500'>
            Last updated on {article.date}.
          </p>
        </div>
      </div>
    </main>
  );
}
