'use client';

import { type ReactNode } from 'react';

import { cn } from '@/lib/utils';

interface HashLinkProps extends React.AnchorHTMLAttributes<HTMLAnchorElement> {
  targetId: string;
  children: ReactNode;
  offset?: number;
  className?: string;
}

export default function HashLink({
  targetId,
  children,
  offset = 80,
  className,
  ...props
}: HashLinkProps) {
  const handleClick = (e: React.MouseEvent<HTMLAnchorElement>) => {
    e.preventDefault();
    const targetElement = document.getElementById(targetId);

    if (targetElement) {
      // Apply offset via scroll-margin-top CSS property
      targetElement.style.scrollMarginTop = `${offset}px`;

      targetElement.scrollIntoView({
        behavior: 'smooth',
        block: 'start',
      });

      // Update URL hash using the modern history API
      window.history.replaceState(
        null,
        '',
        window.location.pathname + '#' + targetId
      );
    }
  };

  return (
    <a
      href={`#${targetId}`}
      onClick={handleClick}
      className={cn('text-green-700 hover:underline', className)}
      {...props}
    >
      {children}
    </a>
  );
}
