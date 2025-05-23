'use client';

import { useQueryState } from 'nuqs';

import { HorizontalScrollWrapper } from '@/components/ui/horizontal-scroll-wrapper';
import { getTopicNamesForArticle, topics } from '@/lib/data';
import type { Article } from '@/lib/types';

interface TopicTagsProps {
  article: Article;
}

export function TopicTags({ article }: TopicTagsProps) {
  const [, setSelectedTopicId] = useQueryState('topic');
  const [, setCurrentPage] = useQueryState('page');

  const topicNames = getTopicNamesForArticle(article);

  const handleTopicClick = (topicName: string) => {
    // Find the topic ID by name
    const topic = topics.find(t => t.name === topicName);
    if (topic) {
      setCurrentPage('1');
      setSelectedTopicId(topic.id);
    }
  };

  if (topicNames.length === 0) {
    return null;
  }

  return (
    <div className='max-w-[200px] flex-shrink-0'>
      <HorizontalScrollWrapper>
        {topicNames.map(topicName => (
          <button
            key={topicName}
            onClick={() => handleTopicClick(topicName)}
            className='flex-shrink-0 rounded-full bg-purple-100 px-2 py-1 text-xs text-purple-700 transition-colors hover:bg-purple-200 hover:text-purple-800'
          >
            {topicName}
          </button>
        ))}
      </HorizontalScrollWrapper>
    </div>
  );
}
