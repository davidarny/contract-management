import HashLink from '@/components/ui/hash-link';

interface JumpToProps {
  sections: Array<{
    id: string;
    title: string;
  }>;
}

export function JumpTo({ sections }: JumpToProps) {
  return (
    <div className='mb-10 rounded-lg bg-gray-50 p-6'>
      <h3 className='mb-4 font-semibold text-gray-800'>Jump to ↓</h3>
      <ul className='space-y-2'>
        {sections.map(section => (
          <li key={section.id}>
            <HashLink targetId={section.id}>{section.title}</HashLink>
          </li>
        ))}
      </ul>
    </div>
  );
}
