'use client';

import { ChevronDown } from 'lucide-react';

import Image from 'next/image';

import TagChip from '@/components/ui/tag-chip';

export function HeroSection() {
  const scrollToContent = () => {
    document
      .getElementById('main-content')
      ?.scrollIntoView({ behavior: 'smooth' });
  };

  return (
    <section className='bg-gray-100 py-16'>
      <div className='container mx-auto flex flex-col items-center justify-between px-4 md:flex-row md:px-6'>
        <div className='z-20 mb-8 md:mb-0 md:w-1/2'>
          <h3 className='mb-2 font-medium text-purple-700'>
            Contract Law Fundamentals
          </h3>
          <h1 className='mb-4 text-pretty text-3xl font-bold text-gray-800 md:text-4xl'>
            Understanding the Basics of Contract Law
          </h1>
          <p className='text-balance text-gray-600'>
            Explore the fundamentals of contract law from key elements to the
            different types to what constitutes a breach of contract.
          </p>
          <div className='mt-4 flex flex-wrap gap-2'>
            <TagChip label='Legal Terms' />
            <TagChip label='Contract' />
            <TagChip label='Contract Law' />
          </div>
        </div>
        <div className='isolate z-10 flex justify-center md:w-1/2'>
          <div className='relative'>
            <div className='absolute -bottom-[10%] -right-[10%] z-0 h-3/4 w-1/4 border-[12px] border-neutral-300 sm:-left-[10%] sm:-top-[10%]'></div>
            <Image
              src='/contracting-basics-header-inset.webp'
              alt='Contract Law'
              width={540}
              height={400}
              className='relative z-10 rounded object-cover shadow'
              priority
            />
          </div>
        </div>
      </div>
      <div className='container mx-auto mt-8 flex justify-center'>
        <button
          onClick={scrollToContent}
          aria-label='Scroll to content'
          className='text-gray-400 transition-colors hover:text-gray-600'
        >
          <ChevronDown />
        </button>
      </div>
    </section>
  );
}
