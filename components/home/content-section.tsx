import type { ReactNode } from 'react';

interface ContentSectionProps {
  id: string;
  title: string;
  children: ReactNode;
}

export function ContentSection({ id, title, children }: ContentSectionProps) {
  return (
    <section id={id} className='mb-12 scroll-mt-24'>
      <h2 className='mb-4 border-b border-gray-200 pb-2 text-2xl font-bold text-gray-800'>
        {title}
      </h2>
      {children}
    </section>
  );
}
