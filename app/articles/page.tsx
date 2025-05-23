import { ArrowLeft } from 'lucide-react';

import type { Metadata } from 'next';
import Link from 'next/link';

import MainContent from '@/components/main-content';
import { articles, sidebarArticles, topics } from '@/lib/data';

export const metadata: Metadata = {
  title: 'Contract Management Articles',
  description:
    'Explore our collection of articles on contract management, types of contracts, and legal considerations. Learn about different agreements, how to prevent breaches, and best practices for effective contract management.',
  keywords: [
    'contract management',
    'legal agreements',
    'contract types',
    'GDPR compliance',
    'contract lifecycle',
    'business contracts',
    'contract analytics',
    'artificial intelligence',
    'contract clauses',
  ],
  openGraph: {
    title: 'Contract Management Articles | Expert Insights & Best Practices',
    description:
      'Explore our collection of articles on contract management, types of contracts, and legal considerations. Learn about different agreements, how to prevent breaches, and best practices for effective contract management.',
    type: 'website',
    url: '/articles',
  },
  twitter: {
    title: 'Contract Management Articles | Expert Insights & Best Practices',
    description:
      'Explore our collection of articles on contract management, types of contracts, and legal considerations. Learn about different agreements, how to prevent breaches, and best practices for effective contract management.',
  },
  alternates: {
    canonical: '/articles',
  },
};

export default function ArticlesPage() {
  return (
    <div className='flex min-h-screen flex-col'>
      {/* Hero Section */}
      <section className='bg-gray-100 py-12'>
        <div className='container mx-auto px-4 md:px-6'>
          <div className='mb-4'>
            <Link
              href='/'
              className='flex items-center text-sm text-gray-600 transition-colors hover:text-purple-700'
            >
              <ArrowLeft className='mr-1 h-4 w-4' />
              Back
            </Link>
          </div>
          <div className='flex flex-col items-start justify-between md:flex-row'>
            <div className='mb-8 md:mb-0 md:w-1/2'>
              <h1 className='mb-4 text-pretty text-3xl font-bold text-gray-800 md:text-4xl'>
                Contract Management Articles
              </h1>
              <p className='text-balance text-gray-600'>
                Explore our collection of articles on contract management, types
                of contracts, and legal considerations. Learn about different
                agreements, how to prevent breaches, and best practices for
                effective contract management.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* Blue Divider */}
      <div className='h-2 w-full bg-blue-800'></div>

      {/* Main Content */}
      <MainContent
        articles={articles}
        sidebarArticles={sidebarArticles}
        topics={topics}
      />
    </div>
  );
}
