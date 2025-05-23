interface TagChipProps {
  label: string;
}

export default function TagChip({ label }: TagChipProps) {
  return (
    <span className='inline-block rounded-full bg-gray-200 px-3 py-1 text-sm font-medium text-gray-700'>
      {label}
    </span>
  );
}
