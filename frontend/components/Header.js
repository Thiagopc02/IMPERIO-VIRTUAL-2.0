import { useEffect, useState, useContext } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/router';
import dynamic from 'next/dynamic'; 
import { CartContext } from '../components/context/CartContext'; // Caminho atualizado

// Carregar o CartIcon dinamicamente no cliente
const CartIcon = dynamic(() => import('../components/CartIcon'), { ssr: false }); // Caminho atualizado

export default function Header() {
  const [user, setUser] = useState(null);
  const router = useRouter();
  const { totalCartItems } = useContext(CartContext);

  useEffect(() => {
    if (typeof window !== 'undefined') {
      const storedUser = localStorage.getItem('user');
      if (storedUser) {
        setUser(JSON.parse(storedUser));
      }
    }
  }, []);

  const handleLogout = () => {
    if (typeof window !== 'undefined') {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      setUser(null);
    }
    router.push('/login');
  };

  // Função simples para redirecionar diretamente para o checkout/carrinho
  const handleCartClick = () => {
    router.push('/checkout');
  };

  return (
    <header className="bg-gradient-to-r from-black via-gray-900 to-gray-800 text-white p-4 flex justify-between items-center shadow-lg">
      <div className="flex items-center space-x-4">
        <img src="/images/logo.png" alt="Logo da Empresa" className="h-12" />
        <h1 className="text-4xl font-extrabold tracking-wider text-transparent bg-clip-text bg-gradient-to-r from-yellow-400 to-yellow-600">
          Império
        </h1>
      </div>
      <nav className="flex space-x-6 pr-20 text-lg">
        <Link href="/" legacyBehavior>
          <a className="hover:text-yellow-500 transition-colors duration-300">Início</a>
        </Link>
        <Link href="/about" legacyBehavior>
          <a className="hover:text-yellow-500 transition-colors duration-300">Nossa História</a>
        </Link>
        <a href="https://wa.me/5562996916206?text=Olá%20gostaria%20de%20falar%20com%20vocês!" target="_blank" className="hover:text-yellow-500 transition-colors duration-300">
          Fale Conosco
        </a>
      </nav>
      <div className="flex items-center space-x-6">
        {user ? (
          <>
            <Link href="/profile">
              <span className="hover:text-yellow-500 cursor-pointer">
                Bem-vindo, {user.name}
              </span>
            </Link>
            <button onClick={handleLogout} className="hover:text-yellow-500 transition-colors duration-300">Sair</button>
          </>
        ) : (
          <Link href="/login" legacyBehavior>
            <a className="hover:text-yellow-500 transition-colors duration-300">Login</a>
          </Link>
        )}
        {/* Ícone do carrinho com redirecionamento direto */}
        <div className="relative ml-6 cursor-pointer" onClick={handleCartClick}>
          <CartIcon />
          {totalCartItems > 0 && (
            <span className="absolute top-0 right-0 inline-flex items-center justify-center px-2 py-1 text-xs font-bold leading-none text-white bg-red-600 rounded-full">
              {totalCartItems}
            </span>
          )}
        </div>
      </div>
    </header>
  );
}
