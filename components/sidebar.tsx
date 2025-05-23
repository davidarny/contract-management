import { SidebarArticleCard } from '@/components/sidebar-article-card';
import { TopicsSection } from '@/components/topics-section';
import type { Article, Topic } from '@/lib/types';

interface SidebarProps {
  articles: Article[];
  topics: Topic[];
  selectedTopicId: string | null;
  onTopicSelect: (topicId: string | null) => void;
}

export function Sidebar({
  articles,
  topics,
  selectedTopicId,
  onTopicSelect,
}: SidebarProps) {
  return (
    <div className='space-y-8 lg:col-span-1'>
      {articles.map(article => (
        <SidebarArticleCard key={article.id} article={article} />
      ))}

      <TopicsSection
        topics={topics}
        selectedTopicId={selectedTopicId}
        onTopicSelect={onTopicSelect}
      />
    </div>
  );
}
