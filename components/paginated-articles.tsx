'use client';

import { compareDesc, parse } from 'date-fns';
import { useQueryState } from 'nuqs';

import { useMemo } from 'react';

import { ArticleCard } from '@/components/article-card';
import {
  Pagination,
  PaginationContent,
  PaginationEllipsis,
  PaginationItem,
  PaginationLink,
  PaginationNext,
  PaginationPrevious,
} from '@/components/ui/pagination';
import { getArticlesByTopic } from '@/lib/data';
import type { Article } from '@/lib/types';

interface PaginatedArticlesProps {
  articles: Article[];
  selectedTopicId: string | null;
  articlesPerPage?: number;
}

export function PaginatedArticles({
  articles,
  selectedTopicId,
  articlesPerPage = 6,
}: PaginatedArticlesProps) {
  const [currentPage, setCurrentPage] = useQueryState('page', {
    defaultValue: '1',
    parse: value => value || '1',
    serialize: value => value,
  });

  // Helper function to parse date strings
  const parseArticleDate = (dateString: string): Date => {
    return parse(dateString, 'MMMM d, yyyy', new Date());
  };

  // Helper function to sort articles by date and isLarge
  const sortArticles = (a: Article, b: Article): number => {
    // First, prioritize isLarge articles
    if (a.isLarge && !b.isLarge) return -1;
    if (!a.isLarge && b.isLarge) return 1;
    // Then sort by date within each group
    return compareDesc(parseArticleDate(a.date), parseArticleDate(b.date));
  };

  // Filter and sort articles
  const filteredArticles = useMemo(() => {
    const filtered = selectedTopicId
      ? getArticlesByTopic(selectedTopicId)
          .filter(article =>
            articles.some(mainArticle => mainArticle.id === article.id)
          )
          .toSorted(sortArticles)
      : articles.toSorted(sortArticles);

    return filtered;
  }, [articles, selectedTopicId]);

  // Calculate pagination
  const totalPages = Math.ceil(filteredArticles.length / articlesPerPage);
  const currentPageNumber = parseInt(currentPage, 10);
  const startIndex = (currentPageNumber - 1) * articlesPerPage;
  const endIndex = startIndex + articlesPerPage;
  const paginatedArticles = filteredArticles.slice(startIndex, endIndex);

  // Reset to page 1 when topic changes
  const handleTopicChange = () => {
    if (currentPageNumber > totalPages && totalPages > 0) {
      setCurrentPage('1');
    }
  };

  // Effect to handle topic changes
  useMemo(() => {
    handleTopicChange();
  }, [selectedTopicId, totalPages]);

  const handlePageChange = (page: number) => {
    setCurrentPage(page.toString());
    // Scroll to top of articles section
    document.getElementById('main-content')?.scrollIntoView({
      behavior: 'smooth',
      block: 'start',
    });
  };

  // Generate page numbers for pagination
  const getPageNumbers = () => {
    const pages: (number | 'ellipsis')[] = [];
    const maxVisiblePages = 5;

    if (totalPages <= maxVisiblePages) {
      // Show all pages if total is small
      for (let i = 1; i <= totalPages; i++) {
        pages.push(i);
      }
    } else {
      // Always show first page
      pages.push(1);

      if (currentPageNumber > 3) {
        pages.push('ellipsis');
      }

      // Show pages around current page
      const start = Math.max(2, currentPageNumber - 1);
      const end = Math.min(totalPages - 1, currentPageNumber + 1);

      for (let i = start; i <= end; i++) {
        if (i !== 1 && i !== totalPages) {
          pages.push(i);
        }
      }

      if (currentPageNumber < totalPages - 2) {
        pages.push('ellipsis');
      }

      // Always show last page
      if (totalPages > 1) {
        pages.push(totalPages);
      }
    }

    return pages;
  };

  if (filteredArticles.length === 0) {
    return (
      <div className='rounded-lg bg-white p-8 text-center shadow'>
        <p className='text-gray-500'>
          No articles found for the selected topic.
        </p>
      </div>
    );
  }

  return (
    <div className='space-y-8'>
      {/* Articles Grid */}
      <div className='space-y-8'>
        {paginatedArticles.map(article => (
          <ArticleCard key={article.id} article={article} />
        ))}
      </div>

      {/* Pagination */}
      {totalPages > 1 && (
        <div className='flex justify-center'>
          <Pagination>
            <PaginationContent>
              {/* Previous Button */}
              <PaginationItem>
                <PaginationPrevious
                  onClick={() =>
                    handlePageChange(Math.max(1, currentPageNumber - 1))
                  }
                  className={
                    currentPageNumber === 1
                      ? 'pointer-events-none opacity-50'
                      : 'cursor-pointer'
                  }
                />
              </PaginationItem>

              {/* Page Numbers */}
              {getPageNumbers().map((page, index) => (
                <PaginationItem key={index}>
                  {page === 'ellipsis' ? (
                    <PaginationEllipsis />
                  ) : (
                    <PaginationLink
                      onClick={() => handlePageChange(page)}
                      isActive={page === currentPageNumber}
                      className='cursor-pointer'
                    >
                      {page}
                    </PaginationLink>
                  )}
                </PaginationItem>
              ))}

              {/* Next Button */}
              <PaginationItem>
                <PaginationNext
                  onClick={() =>
                    handlePageChange(
                      Math.min(totalPages, currentPageNumber + 1)
                    )
                  }
                  className={
                    currentPageNumber === totalPages
                      ? 'pointer-events-none opacity-50'
                      : 'cursor-pointer'
                  }
                />
              </PaginationItem>
            </PaginationContent>
          </Pagination>
        </div>
      )}

      {/* Results Info */}
      <div className='text-center text-sm text-gray-500'>
        Showing {startIndex + 1}-{Math.min(endIndex, filteredArticles.length)}{' '}
        of {filteredArticles.length} articles
        {totalPages > 1 && ` (Page ${currentPageNumber} of ${totalPages})`}
      </div>
    </div>
  );
}
