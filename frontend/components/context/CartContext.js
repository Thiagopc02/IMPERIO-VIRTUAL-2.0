import { createContext, useState, useEffect } from 'react';

export const CartContext = createContext();

export function CartProvider({ children }) {
  const [cartItems, setCartItems] = useState(() => {
    if (typeof window !== 'undefined') {
      const storedCart = localStorage.getItem('cartItems');
      return storedCart ? JSON.parse(storedCart) : [];
    }
    return [];
  });

  useEffect(() => {
    if (typeof window !== 'undefined') {
      localStorage.setItem('cartItems', JSON.stringify(cartItems));
    }
  }, [cartItems]);

  const addItemToCart = (item, quantity = 1, type = 'unit') => {
    setCartItems((prevItems) => {
      debugger;
      const existingItemIndex = prevItems.findIndex(
        (cartItem) => cartItem.product_id === item.product_id && cartItem.type === type // Comparar ID do produto e tipo
      );
  
      if (existingItemIndex !== -1) {
        // Se o item já existe no carrinho, atualiza a quantidade
        const updatedItems = [...prevItems];
        updatedItems[existingItemIndex].quantity += quantity; // Adiciona a quantidade
        return updatedItems;
      }
  
      // Se não existe, adicionar novo item ao carrinho
      return [...prevItems, { ...item, quantity, type }]; // Adiciona item ao carrinho
    });
  };

  const removeItemFromCart = (itemId, type = 'unit') => {
    setCartItems((prevItems) =>
      prevItems
        .map((item) =>
          item.id === itemId && item.type === type
            ? { ...item, quantity: item.quantity - 1 } // Decrementa a quantidade
            : item
        )
        .filter((item) => item.quantity > 0) // Remove itens com quantidade zero
    );
  };

  const clearCart = () => {
    setCartItems([]);
    if (typeof window !== 'undefined') {
      localStorage.removeItem('cartItems');
    }
  };

  return (
    <CartContext.Provider value={{ cartItems, addItemToCart, removeItemFromCart, clearCart }}>
      {children}
    </CartContext.Provider>
  );
}
