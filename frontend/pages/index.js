import { useState, useEffect } from 'react';
import AgeVerification from '../components/AgeVerification';
import Carousel from '../components/Carousel';
import SearchBar from '../components/SearchBar';
import CartIcon from '../components/CartIcon';
import ProductCard from '../components/ProductCard';
import axios from 'axios';

export default function Home() {
  const [isVerified, setIsVerified] = useState(false);
  const [selectedCategory, setSelectedCategory] = useState(null);
  const [products, setProducts] = useState([]);
  const [searchResults, setSearchResults] = useState([]);

  const categories = [
    { name: 'Gaseificados', icon: '/images/Gasef..png', id: 1 },
    { name: 'Balas/Doces/Gomas', icon: '/images/Doce.png', id: 2 },
    { name: 'Destilados', icon: '/images/Whisky.png', id: 3 },
    { name: 'Fermentadas', icon: '/images/Beer.png', id: 4 },
    { name: 'Adega', icon: '/images/Vinho.png', id: 5 },
    { name: 'Tabacaria', icon: '/images/Tabacaria.png', id: 6 },
    { name: 'Drinks Prontos', icon: '/images/Drinks.png', id: 7 },
    { name: 'Outros', icon: '/images/Outros.png', id: 8 },
  ];

  useEffect(() => {
    if (selectedCategory !== null) {
      fetchProductsByCategory(selectedCategory);
    }
  }, [selectedCategory]);

  const handleVerification = () => {
    setIsVerified(true);
  };

  const handleSearch = (query) => {
    console.log('Buscando produtos com:', query);
    setSearchResults([]);
  };

  const fetchProductsByCategory = async (categoryId) => {
    try {
      const response = await axios.get(`http://localhost:5000/api/products?category=${categoryId}`);
      
      // Verificando o que está retornando da API
      console.log("Produtos carregados da API:", response.data);
      
      setProducts(response.data.data);
    } catch (error) {
      console.error('Erro ao buscar produtos:', error);
    }
  };

  const handleCategoryClick = (categoryName) => {
    const categoryId = categories.find((category) => category.name === categoryName).id;
    console.log('Categoria selecionada:', categoryId);
    setSelectedCategory(categoryId);
  };

  const addItemToCart = (item) => {
    console.log('Item adicionado ao carrinho:', item);
  };

  return (
    <div>
      {!isVerified ? (
        <AgeVerification onVerify={handleVerification} />
      ) : (
        <div>
          <h1
            className="text-4xl font-bold text-center mt-8 text-red-600"
            style={{ fontFamily: 'Impact, sans-serif' }}
          >
            Bem-vindo ao Império Virtual
          </h1>
          <Carousel />
          <SearchBar onSearch={handleSearch} />

          <div className="mt-8 flex justify-center space-x-4">
            {categories.map((category) => (
              <button
                key={category.id}
                onClick={() => handleCategoryClick(category.name)}
                className={`flex items-center px-4 py-2 border-b-4 ${
                  selectedCategory === category.id
                    ? 'border-blue-600 text-blue-600'
                    : 'border-transparent text-black'
                }`}
              >
                <img src={category.icon} alt={category.name} className="h-6 w-6 mr-2" />
                {category.name}
              </button>
            ))}
          </div>

          {selectedCategory !== null && products.length > 0 && (
            <div className="mt-8 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
              {products.map((product) => (
                <ProductCard
                  key={product.product_id}
                  product={product}
                  addItemToCart={addItemToCart}
                />
              ))}
            </div>
          )}

          {searchResults.length > 0 && (
            <div className="mt-8">
              <h2 className="text-2xl font-semibold text-black">Resultados da Busca</h2>
              <ul>
                {searchResults.map((product, index) => (
                  <li key={`${product.name}-${index}`} className="text-black">
                    {product.name}
                  </li>
                ))}
              </ul>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
