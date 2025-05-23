export interface Article {
  id: string;
  slug: string;
  title: string;
  description: string;
  date: string;
  image: string;
  isLarge?: boolean;
  topicIds?: string[];
}

export interface Topic {
  id: string;
  name: string;
  href: string;
}

// New types for article content
export interface ArticleContent {
  title: string;
  date: string;
  excerpt: string;
  sections: ArticleSection[];
  conclusion: string;
}

export interface ArticleSection {
  title: string;
  content: string;
  listItems?: string[];
  subsections?: ArticleSubsection[];
  additionalContent?: string;
}

export interface ArticleSubsection {
  title: string;
  content: string;
  listItems?: string[];
}
