import { useState } from 'react';

export default function AgeVerification({ onVerify }) {
  const [age, setAge] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    if (parseInt(age) >= 18) {
      onVerify();
    } else {
      alert('Você deve ter pelo menos 18 anos para acessar este site.');
    }
  };

  return (
    <div className="h-screen flex items-center justify-center bg-gray-800">
      <form onSubmit={handleSubmit} className="bg-white p-8 rounded shadow-md">
        <img src="/images/logo.png" alt="logo" className="h-16 mx-auto mb-4" />
        <h2 className="text-2xl font-bold mb-4">Verificação de Idade</h2>
        <p className="mb-4">Por favor, insira sua idade:</p>
        <input
          type="number"
          value={age}
          onChange={(e) => setAge(e.target.value)}
          className="border border-gray-300 p-2 rounded w-full mb-4 text-black"  // Classe 'text-black' adicionada
          min="1"
          max="120"
        />
        <button type="submit" className="bg-yellow-500 text-white px-4 py-2 rounded">
          Verificar
        </button>
      </form>
    </div>
  );
}
