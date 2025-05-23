import { ArrowRight } from 'lucide-react';

import Link from 'next/link';

export function CTASection() {
  return (
    <div className='mb-8 rounded-lg bg-gray-50 p-8 text-center'>
      <h2 className='mb-4 text-2xl font-bold text-gray-800'>
        Explore Contract Articles
      </h2>
      <p className='mb-6 text-balance text-gray-700'>
        Dive deeper into specific contract types, learn about common pitfalls,
        and discover best practices for contract management.
      </p>
      <Link
        href='/articles'
        className='inline-flex items-center rounded-md bg-green-700 px-6 py-3 text-white transition-colors hover:bg-green-800'
      >
        Browse Articles <ArrowRight className='ml-2 h-4 w-4' />
      </Link>
    </div>
  );
}
