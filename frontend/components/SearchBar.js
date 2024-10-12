import { useState } from 'react';

export default function SearchBar({ onSearch }) {
  const [query, setQuery] = useState('');

  const handleSearch = (e) => {
    e.preventDefault();
    onSearch(query);
  };

  return (
    <form onSubmit={handleSearch} className="flex justify-center mt-8">
      <input
        type="text"
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        placeholder="Buscar produtos..."
        className="border border-gray-300 p-2 rounded-l w-full max-w-lg text-black"
      />
      <button type="submit" className="bg-blue-600 text-white px-4 py-2 rounded-r">
        Buscar
      </button>
    </form>
  );
}