import type { ArticleContent as ArticleContentType } from '@/lib/types';

import HashLink from './ui/hash-link';

interface ArticleContentProps {
  content: ArticleContentType;
}

export function ArticleContent({ content }: ArticleContentProps) {
  return (
    <main id='article-content' className='container mx-auto px-4 py-12 md:px-6'>
      <div className='mx-auto max-w-3xl'>
        <div className='mb-8'>
          <p className='mb-2 text-sm text-gray-500'>{content.date}</p>
          <h2 className='mb-4 text-2xl font-bold text-gray-800'>
            {content.title}
          </h2>

          {/* Table of Contents */}
          <div className='mb-8 rounded-lg bg-gray-50 p-4'>
            <h3 className='mb-2 font-semibold text-gray-700'>
              In this article:
            </h3>
            <ul className='space-y-1'>
              {content.sections.map((section, index) => (
                <li key={index}>
                  <HashLink targetId={`section-${index}`}>
                    {section.title}
                  </HashLink>
                </li>
              ))}
            </ul>
          </div>
        </div>

        {/* Article Sections */}
        {content.sections.map((section, sectionIndex) => (
          <div
            id={`section-${sectionIndex}`}
            key={sectionIndex}
            className='mb-8 scroll-mt-16'
          >
            <h2 className='mb-4 border-b border-gray-200 pb-2 text-2xl font-bold text-gray-800'>
              {section.title}
            </h2>
            <p className='mb-4 text-gray-700'>{section.content}</p>

            {/* List Items */}
            {section.listItems && (
              <ul className='mb-6 list-disc space-y-2 pl-6'>
                {section.listItems.map((item, itemIndex) => (
                  <li key={itemIndex} className='text-gray-700'>
                    {item.includes(':') ? (
                      <>
                        <span className='font-semibold'>
                          {item.split(':')[0]}:
                        </span>
                        {item.split(':')[1]}
                      </>
                    ) : (
                      item
                    )}
                  </li>
                ))}
              </ul>
            )}

            {/* Additional Content */}
            {section.additionalContent && (
              <p className='mb-4 text-gray-700'>{section.additionalContent}</p>
            )}

            {/* Subsections */}
            {section.subsections &&
              section.subsections.map((subsection, subIndex) => (
                <div key={subIndex} className='mb-4 ml-4'>
                  <h3 className='mb-2 text-xl font-semibold text-gray-800'>
                    {subsection.title}
                  </h3>
                  <p className='mb-2 text-gray-700'>{subsection.content}</p>

                  {/* Subsection List Items */}
                  {subsection.listItems && (
                    <ul className='mb-4 list-disc space-y-1 pl-6'>
                      {subsection.listItems.map((item, itemIndex) => (
                        <li key={itemIndex} className='text-gray-700'>
                          {item}
                        </li>
                      ))}
                    </ul>
                  )}
                </div>
              ))}
          </div>
        ))}

        {/* Conclusion */}
        <div className='mb-8 rounded-lg bg-gray-50 p-6'>
          <h2 className='mb-3 text-xl font-bold text-gray-800'>Conclusion</h2>
          <p className='text-gray-700'>{content.conclusion}</p>
        </div>
      </div>
    </main>
  );
}
