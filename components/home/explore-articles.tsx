import { ArrowRight } from 'lucide-react';

import Link from 'next/link';

export default function ExploreArticles() {
  return (
    <div className='mb-10 rounded-lg bg-gray-50 p-6'>
      <h2 className='mb-3 text-xl font-bold text-gray-800'>
        Explore Contract Articles
      </h2>
      <p className='mb-4 text-gray-700'>
        Dive deeper into specific contract types, learn about common pitfalls,
        and discover best practices for contract management.
      </p>
      <Link
        href='/articles'
        className='inline-flex items-center font-medium text-green-700 transition-colors hover:text-green-800'
      >
        Browse all articles <ArrowRight className='ml-1 h-4 w-4' />
      </Link>
    </div>
  );
}
