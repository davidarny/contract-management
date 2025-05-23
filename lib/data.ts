import type { Article, Topic } from './types';

export const articles: Article[] = [
  {
    id: '1',
    slug: 'what-is-a-data-processing-agreement',
    title: 'What is a Data Processing Agreement (DPA)?',
    description:
      "Learn what a data processing agreement is, why it's essential for GDPR compliance, and how it defines roles between data controllers and processors.",
    date: 'May 5, 2023',
    image: '/data-processing-agreement-main.webp',
    isLarge: true,
    topicIds: ['7', '1'], // Agreements, Contracting Basics
  },
  {
    id: '2',
    slug: 'what-is-a-breach-of-contract',
    title: 'What is a Breach of Contract?',
    description:
      'A breach of contract occurs when one party fails to fulfill their obligations in an agreement. Common types include material, minor, anticipatory, and actual breaches. Learn what causes breaches and how to prevent them by creating clear contracts, maintaining communication, and documenting all agreements.',
    date: 'April 28, 2023',
    image: '/breach-of-contract-main.webp',
    topicIds: ['1', '2'], // Contracting Basics, Contract Management
  },
  {
    id: '3',
    slug: 'what-is-a-cost-plus-contract',
    title: 'What is a Cost-Plus Contract?',
    description:
      "Discover the ins and outs of cost-plus contracts. Learn how they work, their advantages and disadvantages, and when they're best suited. Get expert tips on managing cost-plus contracts effectively using contract management software.",
    date: 'April 25, 2023',
    image: '/cost-plus-contract-article-main.webp',
    topicIds: ['1', '2'], // Contracting Basics, Contract Management
  },
  {
    id: '4',
    slug: 'what-is-a-fixed-price-contract',
    title: 'What is a Fixed-Price Contract?',
    description:
      "Learn everything about fixed-price contracts, including how they work, their key features, types, and common terms. Discover when they're ideal to use and how contract management software can help.",
    date: 'April 20, 2023',
    image: '/fixed-price-contract-article-main.webp',
    topicIds: ['1', '2'], // Contracting Basics, Contract Management
  },
  {
    id: '5',
    slug: 'what-is-a-licensing-agreement',
    title: 'What is a Licensing Agreement?',
    description:
      'A licensing agreement is a type of contract in which an IP owner, also known as the licensor, grants another party permission to use their intellectual property under specific terms. This IP can encompass patents, trademarks, copyrights, trade secrets, or even business methodologies. Learn about the types of IP it covers, standard terms and the benefits it provides.',
    date: 'April 15, 2023',
    image: '/licensing-agreement-main.webp',
    topicIds: ['7', '1'], // Agreements, Contracting Basics
  },
  {
    id: '6',
    slug: 'what-is-a-contract-of-adhesion',
    title: 'What is a Contract of Adhesion?',
    description:
      'An adhesion contract is a binding agreement between two parties where one party has significantly more power than the other in setting the terms. It is also known as a "standard form contract" or "boilerplate contract." Keep reading to explore what an adhesion contract is, along with its advantages, possible disadvantages, and how it\'s treated under the Uniform Commercial Code (UCC).',
    date: 'April 10, 2023',
    image: '/adhesion-benefits-and-enforceability-main.webp',
    topicIds: ['1', '6'], // Contracting Basics, Clauses
  },
  {
    id: '7',
    slug: 'what-is-a-purchase-agreement',
    title: 'What is a Purchase Agreement?',
    description:
      "Learn what a purchase agreement is, why it's legally binding, and how it protects buyers and sellers. Discover key purchase agreement sections, clauses, and best practices.",
    date: 'April 5, 2023',
    image: '/purchase-agreement-main.webp',
    topicIds: ['7', '6'], // Agreements, Clauses
  },
  {
    id: '8',
    slug: 'what-is-a-purchase-and-sale-agreement',
    title: 'What is a Purchase and Sale Agreement?',
    description:
      "A purchase and sale agreement is a legally binding contract that outlines the terms of a transaction between a property buyer and seller. It covers the crucial details both parties must follow to complete the sale properly and legally. Learn more about purchase and sale agreements, including key components and when they're needed.",
    date: 'April 1, 2023',
    image: '/blog-purchase-sale-main.webp',
    topicIds: ['7', '1'], // Agreements, Contracting Basics
  },
  {
    id: '11',
    slug: 'what-is-a-contractual-obligation',
    title: 'What is a Contractual Obligation?',
    description:
      'Master your agreements! This guide explains contractual obligations, their importance, and different types. Learn how they ensure compliance, manage risk, build trust in business relationships. Discover the challenges of manual management and the benefits of contract management software.',
    date: 'March 28, 2025',
    image: '/contractual-obligations-main.webp',
    topicIds: ['3', '1', '2'], // Contract Lifecycle Management, Contracting Basics, Contract Management
  },
  {
    id: '12',
    slug: 'what-is-gdpr-compliance',
    title: 'What is GDPR? What does it mean to be GDPR compliant?',
    description:
      'Data privacy has become a crucial concern for individuals and businesses in the age of digitization and AI. The General Data Protection Regulation (GDPR) is landmark legislation aimed at protecting the personal data and privacy of individuals within the European Union (EU). Learn what it means to be GDPR-compliant, its benefits, and contract management best practices.',
    date: 'March 19, 2025',
    image: '/gdpr-article-main.webp',
    topicIds: ['2', '3', '1'], // Contract Management, Contract Lifecycle Management, Contracting Basics
  },
  {
    id: '13',
    slug: 'what-is-an-executed-contract',
    title: 'What Is an Executed Contract?',
    description:
      'An executed contract is a legally binding agreement that has been signed by all the necessary parties involved. Contract execution is the most important step in the contract management process. Learn its key characteristics and how contract management technology makes this process easier.',
    date: 'March 15, 2025',
    image: '/contract-execution-main.jpeg',
    topicIds: ['3', '1', '2'], // Contract Lifecycle Management, Contracting Basics, Contract Management
  },
  {
    id: '14',
    slug: 'what-is-contract-risk-management',
    title: 'What is Contract Risk Management?',
    description:
      "What is contract risk management? Contract risk management assesses a contract's maximum value through compliance tracking by identifying, managing, and minimizing the potential risks throughout the contract lifecycle. This may include loss of opportunity, legal exposure if things go wrong, and potential business impact the contract will have on the involved parties.",
    date: 'October 16, 2024',
    image: '/contract-risk-management-main.png',
    topicIds: ['2', '3', '4'], // Contract Management, Contract Lifecycle Management, Contract Analytics
  },
  {
    id: '15',
    slug: 'non-compete-agreements-and-alternatives',
    title:
      'Non-Compete Agreements and Alternatives. What Businesses Should Consider.',
    description:
      "The Federal Trade Commission's new rule bans non-compete agreements for most workers. A federal judge has subsequently blocked the rule, adding to the uncertainty. Learn about who was covered, what this means for your business, challenges enforcing non-competes, and alternative methods for protecting trade secrets.",
    date: 'October 10, 2024',
    image: '/non-compete-contract-main.webp',
    topicIds: ['7', '6', '2'], // Agreements, Clauses, Contract Management
  },
  {
    id: '16',
    slug: 'ai-chat-and-contract-management',
    title: 'AI Chat and contract management: How does it work?',
    description:
      'Forget tedious document hunts. This guide unlocks the secrets of Conversational AI, your tireless assistant for smarter contract management. Boost efficiency, reduce risks, and make informed decisions - all by simply talking to your contracts. Learn how businesses are benefiting from this AI technology.',
    date: 'October 1, 2024',
    image: '/conversational-ai-learn-article-main.webp',
    topicIds: ['3', '5', '2'], // Contract Lifecycle Management, Artificial Intelligence, Contract Management
  },
  {
    id: '17',
    slug: 'what-is-a-service-level-agreement',
    title: 'What is a Service Level Agreement (SLA)?',
    description:
      "Learn what a Service Level Agreement (SLA) is, how it works, and why it's crucial for setting clear service expectations, accountability, and performance standards.",
    date: 'April 4, 2025',
    image: '/what-is-an-sla-main.jpeg',
    topicIds: ['7', '1', '2'], // Agreements, Contracting Basics, Contract Management
  },
  {
    id: '18',
    slug: 'what-is-contract-visibility',
    title: 'What is Contract Visibility?',
    description:
      "Enhance your organization's efficiency and compliance with contract visibility to streamline contract management and improve decision-making across teams.",
    date: 'March 18, 2025',
    image: '/contract-visibility-main.jpeg',
    topicIds: ['2', '3', '4'], // Contract Management, Contract Lifecycle Management, Contract Analytics
  },
  {
    id: '19',
    slug: 'what-is-a-non-disclosure-agreement',
    title: 'What is a Non-Disclosure Agreement (NDA)?',
    description:
      'This comprehensive guide explains what NDAs are, how they work, different NDA types, and real-world business use cases. Learn how NDAs protect your business secrets and explore best practices for managing them.',
    date: 'March 11, 2025',
    image: '/nda-article-main.jpeg',
    topicIds: ['7', '6', '1'], // Agreements, Clauses, Contracting Basics
  },
  {
    id: '20',
    slug: 'what-is-a-force-majeure-clause',
    title: 'What is a Force Majeure Clause?',
    description:
      'Discover the importance of the Force Majeure clause in contracts. Learn how these provisions protect businesses from unforeseen events like natural disasters, wars, and government actions, while ensuring business continuity and legal protection.',
    date: 'February 28, 2025',
    image: '/force-majeure-article-main.jpg',
    topicIds: ['6', '1', '2'], // Clauses, Contracting Basics, Contract Management
  },
  {
    id: '21',
    slug: 'what-is-a-bilateral-contract',
    title: 'What is a Bilateral Contract?',
    description:
      'Bilateral contracts form the backbone of many business agreements. This guide explores what they are, common real-world examples, when to use them, and how to manage them effectively.',
    date: 'February 26, 2025',
    image: '/bilateral-contract-article-main.jpeg',
    topicIds: ['7', '1', '2'], // Agreements, Contracting Basics, Contract Management
  },
  {
    id: '22',
    slug: 'what-is-an-engagement-letter',
    title: 'What Is an Engagement Letter?',
    description:
      'Learn what an Engagement Letter is, why it matters in business deals, and how it helps establish clear expectations between service providers and clients.',
    date: 'February 13, 2025',
    image: '/letter-of-engagement-blog-main.png',
    topicIds: ['7', '1', '2'], // Agreements, Contracting Basics, Contract Management
  },
  {
    id: '23',
    slug: 'what-is-the-indemnification-clause',
    title: 'What Is the Indemnification Clause in Contracts?',
    description:
      'The indemnification clause is a standard provision in most commercial contracts. They serve as a critical tool for risk allocation between parties. Learn why it is one of the most commonly negotiated terms of a contract.',
    date: 'February 11, 2025',
    image: '/indemnification-clause-article-main.jpg',
    topicIds: ['6', '1', '2'], // Clauses, Contracting Basics, Contract Management
  },
  {
    id: '24',
    slug: 'what-is-a-letter-of-intent',
    title: 'What is a Letter of Intent (LOI)?',
    description:
      'Learn everything about Letters of Intent (LOIs): their purpose, key characteristics, and how to use them effectively in business deals such as mergers & acquisitions, joint ventures, real estate deals, and more.',
    date: 'January 31, 2025',
    image: '/letter-of-intent-blog-main.png',
    topicIds: ['7', '1', '2'], // Agreements, Contracting Basics, Contract Management
  },
  {
    id: '25',
    slug: 'rice-framework-for-contract-management',
    title: 'What is the RICE Framework for Contract Management?',
    description:
      'The RICE framework is a scoring system used in product management to prioritize work initiatives based on four factors: Reach, Impact, Confidence, and Effort. Learn how contract professionals can adopt the framework to streamline their contract management.',
    date: 'January 25, 2025',
    image: '/rice-framework-for-contract-management-article---main.jpg',
    topicIds: ['2', '3', '4'], // Contract Management, Contract Lifecycle Management, Contract Analytics
  },
  {
    id: '26',
    slug: 'what-is-a-unilateral-contract',
    title: 'What is a Unilateral Contract?',
    description:
      'A unilateral contract is a one-sided agreement formed when an offer can only be accepted by performing the specified action, meaning payment is made only after the action is completed. Learn how they differ from bilateral contracts and their business applications.',
    date: 'January 17, 2025',
    image: '/unilateral-contracts-article-main.jpeg',
    topicIds: ['7', '1', '2'], // Agreements, Contracting Basics, Contract Management
  },
  {
    id: '27',
    slug: 'what-is-an-aleatory-contract',
    title: 'What is an Aleatory Contract?',
    description:
      'Have you ever entered an agreement where the outcome depends on an uncertain event? This is the essence of an aleatory contract, a legal concept that governs situations where chance plays a significant role.',
    date: 'December 13, 2024',
    image: '/blog-graphics-aleatory-contract-article-main.jpg',
    topicIds: ['7', '1', '2'], // Agreements, Contracting Basics, Contract Management
  },
  {
    id: '28',
    slug: 'what-is-governing-law',
    title: 'What is Governing Law in Contracts?',
    description:
      'Discover what governing law in contracts means, how it works, and its importance. Learn the difference between governing law and jurisdiction, key risks of omitting it, and how contract lifecycle management software can help companies streamline compliance.',
    date: 'April 25, 2024',
    image: '/governing-law-article-main.png',
    topicIds: ['6', '1', '2'], // Clauses, Contracting Basics, Contract Management
  },
  {
    id: '29',
    slug: 'what-is-contract-redlining',
    title: 'What is Contract Redlining?',
    description:
      'Succeed at contract negotiations with our practical, how-to guide. Learn what contract redlining is and why it matters, best practices, pitfalls of manual management, and how AI-powered contract management tools can empower your business.',
    date: 'March 15, 2024',
    image: '/what-is-contract-redlining-main-image.jpeg',
    topicIds: ['2', '3', '1'], // Contract Management, Contract Lifecycle Management, Contracting Basics
  },
  {
    id: '30',
    slug: 'what-is-contract-analysis-software',
    title: 'What is Contract Analysis Software?',
    description:
      'Contract analysis software helps you reduce cycle times, improve negotiation outcomes, and proactively identify & manage risk and compliance. Learn how AI-powered analysis transforms contract management.',
    date: 'February 20, 2024',
    image: '/contract-analysis-software-main.jpeg',
    topicIds: ['2', '3', '5'], // Contract Management, Contract Lifecycle Management, Artificial Intelligence
  },
  {
    id: '31',
    slug: 'what-is-contract-data',
    title: 'What is Contract Data?',
    description:
      "Contract data is the information that is contained within a company's contracts. This data can be used to track the performance of the entire organization or specific departments within the company. Learn how to track and manage contract data efficiently.",
    date: 'January 15, 2024',
    image: '/contract-data-main.png',
    topicIds: ['2', '4', '3'], // Contract Management, Contract Analytics, Contract Lifecycle Management
  },
  {
    id: '32',
    slug: 'how-to-write-a-solid-statement-of-work',
    title: 'How To Write a Solid Statement of Work',
    description:
      'A good statement of work should accurately define the scope and KPIs of a working arrangement, clearly defining responsibilities and avoiding any misinterpretations. Learn the key elements and best practices.',
    date: 'December 10, 2023',
    image: '/solid-statement-of-work-main.png',
    topicIds: ['7', '1', '2'], // Agreements, Contracting Basics, Contract Management
  },
  {
    id: '33',
    slug: 'what-is-contract-authoring',
    title: 'What is Contract Authoring?',
    description:
      "Contract authoring is the process of drafting and creating a legally binding agreement between two or more parties. It's the initial stage of the contract lifecycle management (CLM) process, where the terms and conditions of the agreement are documented.",
    date: 'November 28, 2023',
    image: '/contract-authoring-main.png',
    topicIds: ['2', '3', '1'], // Contract Management, Contract Lifecycle Management, Contracting Basics
  },
  {
    id: '34',
    slug: 'what-is-contract-analytics',
    title: 'What is Contract Analytics?',
    description:
      'Contract analytics is vital to keeping your finger on any legal agreements that your company drafts and enters into. Learn how analytics and artificial intelligence (AI) machine learning is drastically changing contract management to streamline the process and mitigate risk.',
    date: 'October 15, 2023',
    image: '/what-is-contract-analytics-main.png',
    topicIds: ['4', '5', '2'], // Contract Analytics, Artificial Intelligence, Contract Management
  },
  {
    id: '35',
    slug: 'the-importance-of-the-end-user-license-agreement',
    title: 'The Importance of the End User License Agreement (EULA)',
    description:
      "EULA stands for End User License Agreement. An end-user license agreement (EULA) is a legal contract between the software developer or vendor and the user who purchases or downloads the software. It provides an efficient means of protecting a software publisher's intellectual property.",
    date: 'September 20, 2023',
    image: '/end-user-license-agreement-main.png',
    topicIds: ['7', '1', '2'], // Agreements, Contracting Basics, Contract Management
  },
  {
    id: '36',
    slug: 'the-top-skills-that-make-contract-managers-great',
    title: 'The Top Skills that make Contract Managers Great',
    description:
      'Contract management has strategic importance. Organizations should seek to optimize people, processes, and technology to manage legal agreements for maximum business value. Great contract managers understand the pivotal role they play, and they bring a unique mix of technical and interpersonal skills to the table.',
    date: 'August 15, 2023',
    image: '/top-skills-that-make-contract-managers-great-main.png',
    topicIds: ['2', '1'], // Contract Management, Contracting Basics
  },
  {
    id: '37',
    slug: 'independent-contractor-agreements-beyond-the-boilerplate',
    title: 'Independent Contractor Agreements: Beyond the Boilerplate',
    description:
      'Independent contractor agreements play a critical role in protecting your company from risk and ensuring you get the best possible value from your service providers. Generic boilerplate contracts are risky because they fail to account for the differences in law across multiple jurisdictions.',
    date: 'July 10, 2023',
    image: '/independent-contractor-agreements-main.png',
    topicIds: ['7', '1', '2'], // Agreements, Contracting Basics, Contract Management
  },
  {
    id: '38',
    slug: 'what-is-intellectual-property-law',
    title: 'What is Intellectual Property Law?',
    description:
      'Intellectual property (IP) includes creations like inventions, written works, and designs that have commercial value. It is legally protected, giving creators exclusive rights to use their work for a set period. IP protection encourages innovation by ensuring creators can benefit from their ideas.',
    date: 'April 11, 2025',
    image: '/intellectual-property-blog-graphics-main.png',
    topicIds: ['1', '7'], // Contracting Basics, Agreements
  },
  {
    id: '39',
    slug: 'what-is-contract-management',
    title: 'What is Contract Management?',
    description:
      'Contracts are the foundation of commerce. Discover how contract management streamlines contract creation, execution, and compliance to reduce risks, boost efficiency, and maximize business value.',
    date: 'April 7, 2025',
    image: '/what-is-contract-management-main.png',
    topicIds: ['2', '3', '1'], // Contract Management, Contract Lifecycle Management, Contracting Basics
  },
  {
    id: '40',
    slug: 'what-is-enterprise-contract-management',
    title: 'What Is Enterprise Contract Management?',
    description:
      "Enterprise contract management is an approach to contract management that brings all of a company's commitments into a single CLM system for seamless, holistic management. With enterprise contract management, automated systems replace the inefficient methods of manual contract management systems and streamline the process.",
    date: 'April 2, 2025',
    image: '/what-is-enterprise-contract-management-main.jpeg',
    topicIds: ['2', '3', '5'], // Contract Management, Contract Lifecycle Management, Artificial Intelligence
  },
];

export const sidebarArticles: Article[] = [
  {
    id: '9',
    slug: 'what-is-an-arbitration-agreement',
    title: 'What is an Arbitration Agreement?',
    description:
      'Learn about arbitration agreements and how they affect dispute resolution between parties.',
    date: 'May 1, 2025',
    image: '/arbitration-agreement-main.webp',
    topicIds: ['7', '6'], // Agreements, Clauses
  },
  {
    id: '10',
    slug: 'what-are-terms-and-conditions',
    title: 'What are Terms and Conditions?',
    description:
      'Understand the importance of terms and conditions in contracts and agreements.',
    date: 'April 29, 2025',
    image: '/terms-and-conditions-blog-graphics-main.webp',
    topicIds: ['6', '1'], // Clauses, Contracting Basics
  },
];

export const topics: Topic[] = [
  {
    id: '1',
    name: 'Contracting Basics',
    href: '#',
  },
  {
    id: '2',
    name: 'Contract Management',
    href: '#',
  },
  {
    id: '3',
    name: 'Contract Lifecycle Management',
    href: '#',
  },
  {
    id: '4',
    name: 'Contract Analytics',
    href: '#',
  },
  {
    id: '5',
    name: 'Artificial Intelligence',
    href: '#',
  },
  {
    id: '6',
    name: 'Clauses',
    href: '#',
  },
  {
    id: '7',
    name: 'Agreements',
    href: '#',
  },
];

// Helper function to get article by slug
export function getArticleBySlug(slug: string): Article | undefined {
  return [...articles, ...sidebarArticles].find(
    article => article.slug === slug
  );
}

// Helper function to get articles by topic ID
export function getArticlesByTopic(topicId: string): Article[] {
  return [...articles, ...sidebarArticles].filter(article =>
    article.topicIds?.includes(topicId)
  );
}

// Helper function to get topic names for an article
export function getTopicNamesForArticle(article: Article): string[] {
  if (!article.topicIds) return [];
  return article.topicIds
    .map(topicId => topics.find(topic => topic.id === topicId)?.name)
    .filter((name): name is string => name !== undefined);
}

// Helper function to get topic by ID
export function getTopicById(topicId: string): Topic | undefined {
  return topics.find(topic => topic.id === topicId);
}
