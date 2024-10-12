import { useContext, useState } from 'react';
import { CartContext } from './context/CartContext';
import { FaShoppingCart } from 'react-icons/fa';

export default function ProductCard({ product }) {
  const [quantity, setQuantity] = useState(1);
  const [type, setType] = useState('unit');
  const { addItemToCart } = useContext(CartContext);

  const handleAddToCart = () => {
    const productWithType = {
      ...product,
      id: `${product.id}-${type}`, 
    };
    addItemToCart(productWithType, quantity, type);
  };

  const price = type === 'unit'
    ? (product.unit_price ? parseFloat(product.unit_price).toFixed(2) : '0.00')
    : (product.box_price ? parseFloat(product.box_price).toFixed(2) : '0.00');

  const increaseQuantity = () => {
    setQuantity((prevQuantity) => prevQuantity + 1);
  };

  const decreaseQuantity = () => {
    if (quantity > 1) {
      setQuantity((prevQuantity) => prevQuantity - 1);
    }
  };

  return (
    <div className="border rounded p-4 bg-gray-200" style={{ width: '250px', margin: '10px' }}>
      <img
        src={product.image_url || 'default.png'}
        alt={product.name}
        className="product-image w-full h-auto object-cover"
        style={{ height: '150px', width: '100%' }}
      />
      <h2 className="text-xl font-bold mt-4 text-black">{product.name}</h2>
      <p className="text-gray-800">{product.description}</p>
      <p className="text-lg font-bold text-blue-600 mt-2">Preço: R$ {price}</p>

      <div className="mt-4">
        <label className="text-black">Quantidade: </label>
        <select value={type} onChange={(e) => setType(e.target.value)} className="text-black">
          <option value="unit">Unidade</option>
          <option value="box">Caixa</option>
        </select>
        <div className="flex mt-2">
          <button onClick={increaseQuantity} className="px-2 py-1 bg-blue-500 text-white">+</button>
          <span className="px-2 py-1 text-black">{quantity}</span>
          <button onClick={decreaseQuantity} disabled={quantity === 1} className="px-2 py-1 bg-red-500 text-white">-</button>
        </div>
        <button onClick={handleAddToCart} className="add-to-cart-button mt-4 bg-green-600 text-white py-2 px-4 rounded hover:bg-green-700">
          <FaShoppingCart className="add-to-cart-icon" /> Adicionar ao Carrinho
        </button>
      </div>
    </div>
  );
}
