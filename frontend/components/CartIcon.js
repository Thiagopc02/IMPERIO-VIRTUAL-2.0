import { useContext } from 'react';
import { CartContext } from './context/CartContext';
import { useRouter } from 'next/router';

export default function CartIcon() {
  const { cartItems } = useContext(CartContext);
  const router = useRouter();

  const handleCartClick = () => {
    router.push('/checkout');
  };

  return (
    <div onClick={handleCartClick} className="relative cursor-pointer flex items-center justify-center w-12 h-12 bg-red-600 text-white rounded">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        fill="none"
        viewBox="0 0 24 24"
        strokeWidth={1.5}
        stroke="currentColor"
        className="w-6 h-6"
      >
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13l-4 8h18M7 13l4-8h6M10 21a1.5 1.5 0 100-3 1.5 1.5 0 000 3zm7 0a1.5 1.5 0 100-3 1.5 1.5 0 000 3z"
        />
      </svg>
      {cartItems.length > 0 && (
        <span className="absolute top-0 right-0 inline-flex items-center justify-center px-2 py-1 text-xs font-bold leading-none text-white bg-red-600 rounded-full">
          {cartItems.length}
        </span>
      )}
    </div>
  );
}
