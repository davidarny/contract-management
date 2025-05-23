import { ArrowRight } from 'lucide-react';

import { getArticlesByTopic } from '@/lib/data';
import type { Topic } from '@/lib/types';
import { cn } from '@/lib/utils';

import { Button } from './ui/button';

interface TopicsSectionProps {
  topics: Topic[];
  selectedTopicId: string | null;
  onTopicSelect: (topicId: string | null) => void;
}

export function TopicsSection({
  topics,
  selectedTopicId,
  onTopicSelect,
}: TopicsSectionProps) {
  const handleShowAll = () => {
    onTopicSelect(null);
  };

  const handleTopicClick = (topicId: string) => {
    onTopicSelect(topicId);
  };

  const isShowAllActive = selectedTopicId === null;

  return (
    <div className='overflow-hidden rounded-lg bg-white shadow'>
      <div className='border-b p-4'>
        <h3 className='font-medium text-gray-800'>View Topics</h3>
      </div>
      <div className='p-4'>
        <Button
          onClick={handleShowAll}
          disabled={isShowAllActive}
          className={cn('mb-4 w-full font-semibold', {
            'bg-purple-800 hover:bg-purple-900': isShowAllActive,
            'bg-purple-700 hover:bg-purple-800': !isShowAllActive,
          })}
        >
          Show All
          <ArrowRight />
        </Button>
        <ul className='space-y-2'>
          {topics.map(topic => {
            const articleCount = getArticlesByTopic(topic.id).length;
            const isSelected = selectedTopicId === topic.id;

            return (
              <li key={topic.id}>
                <button
                  onClick={() => handleTopicClick(topic.id)}
                  className={cn(
                    'flex w-full items-center justify-between text-left transition-all',
                    {
                      'font-semibold text-purple-700': isSelected,
                      'text-green-700 hover:text-green-800 hover:underline':
                        !isSelected,
                    }
                  )}
                >
                  <span>{topic.name}</span>
                  <span className='ml-2 text-xs text-gray-500'>
                    ({articleCount})
                  </span>
                </button>
              </li>
            );
          })}
        </ul>
      </div>
    </div>
  );
}
