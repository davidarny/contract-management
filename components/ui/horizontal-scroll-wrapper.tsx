import { ReactNode, useCallback, useEffect, useRef, useState } from 'react';

import { cn } from '@/lib/utils';

interface HorizontalScrollWrapperProps {
  children: ReactNode;
  className?: string;
}

export function HorizontalScrollWrapper({
  children,
  className,
}: HorizontalScrollWrapperProps) {
  const scrollRef = useRef<HTMLDivElement>(null);
  const [showLeftShadow, setShowLeftShadow] = useState(false);
  const [showRightShadow, setShowRightShadow] = useState(false);
  const [isDragging, setIsDragging] = useState(false);
  const [startX, setStartX] = useState(0);
  const [scrollLeft, setScrollLeft] = useState(0);

  const checkScrollPosition = useCallback(() => {
    if (!scrollRef.current) return;

    const { scrollLeft, scrollWidth, clientWidth } = scrollRef.current;

    setShowLeftShadow(scrollLeft > 0);
    setShowRightShadow(scrollLeft < scrollWidth - clientWidth - 1);
  }, []);

  const handleMouseDown = useCallback((e: React.MouseEvent) => {
    if (!scrollRef.current) return;

    setIsDragging(true);
    setStartX(e.pageX - scrollRef.current.offsetLeft);
    setScrollLeft(scrollRef.current.scrollLeft);

    // Prevent text selection while dragging
    e.preventDefault();
  }, []);

  const handleMouseMove = useCallback(
    (e: MouseEvent) => {
      if (!isDragging || !scrollRef.current) return;

      e.preventDefault();
      const x = e.pageX - scrollRef.current.offsetLeft;
      const walk = (x - startX) * 2; // Scroll speed multiplier
      scrollRef.current.scrollLeft = scrollLeft - walk;
    },
    [isDragging, startX, scrollLeft]
  );

  const handleMouseUp = useCallback(() => {
    setIsDragging(false);
  }, []);

  useEffect(() => {
    const scrollElement = scrollRef.current;
    if (!scrollElement) return;

    // Check initial state
    checkScrollPosition();

    // Add scroll listener
    scrollElement.addEventListener('scroll', checkScrollPosition);

    // Add resize listener to handle dynamic content changes
    const resizeObserver = new ResizeObserver(checkScrollPosition);
    resizeObserver.observe(scrollElement);

    return () => {
      scrollElement.removeEventListener('scroll', checkScrollPosition);
      resizeObserver.disconnect();
    };
  }, [checkScrollPosition]);

  useEffect(() => {
    if (isDragging) {
      // Add global mouse event listeners when dragging starts
      document.addEventListener('mousemove', handleMouseMove);
      document.addEventListener('mouseup', handleMouseUp);
    } else {
      // Remove global mouse event listeners when dragging stops
      document.removeEventListener('mousemove', handleMouseMove);
      document.removeEventListener('mouseup', handleMouseUp);
    }

    return () => {
      // Cleanup on unmount
      document.removeEventListener('mousemove', handleMouseMove);
      document.removeEventListener('mouseup', handleMouseUp);
    };
  }, [isDragging, handleMouseMove, handleMouseUp]);

  return (
    <div className='relative'>
      <div
        ref={scrollRef}
        className={cn(
          'flex select-none gap-1 overflow-x-auto scrollbar-hide',
          isDragging ? 'cursor-grabbing' : 'cursor-grab',
          className
        )}
        onMouseDown={handleMouseDown}
        style={{
          maskImage: `linear-gradient(
            to right,
            ${showLeftShadow ? 'transparent 0px, black 12px' : 'black 0px'},
            black calc(100% - ${showRightShadow ? '12px' : '0px'}),
            ${showRightShadow ? 'transparent 100%' : 'black 100%'}
          )`,
          WebkitMaskImage: `linear-gradient(
            to right,
            ${showLeftShadow ? 'transparent 0px, black 12px' : 'black 0px'},
            black calc(100% - ${showRightShadow ? '12px' : '0px'}),
            ${showRightShadow ? 'transparent 100%' : 'black 100%'}
          )`,
        }}
      >
        {children}
      </div>

      {/* Left shadow indicator */}
      {showLeftShadow && (
        <div className='pointer-events-none absolute left-0 top-0 h-full w-3 bg-gradient-to-r from-white/80 to-transparent' />
      )}

      {/* Right shadow indicator */}
      {showRightShadow && (
        <div className='pointer-events-none absolute right-0 top-0 h-full w-3 bg-gradient-to-l from-white/80 to-transparent' />
      )}
    </div>
  );
}
