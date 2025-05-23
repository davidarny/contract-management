'use client';

import { useQueryState } from 'nuqs';

import { PaginatedArticles } from '@/components/paginated-articles';
import { Sidebar } from '@/components/sidebar';
import type { Article, Topic } from '@/lib/types';

interface MainContentProps {
  articles: Article[];
  sidebarArticles: Article[];
  topics: Topic[];
}

export default function MainContent({
  articles,
  sidebarArticles,
  topics,
}: MainContentProps) {
  const [selectedTopicId, setSelectedTopicId] = useQueryState('topic');
  const [, setCurrentPage] = useQueryState('page');

  const handleTopicSelect = (topicId: string | null) => {
    setCurrentPage('1');
    setSelectedTopicId(topicId);
  };

  return (
    <main id='main-content' className='container mx-auto px-4 py-12 md:px-6'>
      <div className='grid grid-cols-1 gap-8 lg:grid-cols-3'>
        {/* Main Articles - 2/3 width */}
        <div className='space-y-8 lg:col-span-2'>
          <PaginatedArticles
            articles={articles}
            selectedTopicId={selectedTopicId}
            articlesPerPage={5}
          />
        </div>

        {/* Sidebar - 1/3 width */}
        <Sidebar
          articles={sidebarArticles}
          topics={topics}
          selectedTopicId={selectedTopicId}
          onTopicSelect={handleTopicSelect}
        />
      </div>
    </main>
  );
}
