import { useContext, useState } from 'react';
import { CartContext } from '../components/context/CartContext';
import { FaTrash } from 'react-icons/fa'; // Importar o ícone de lixeira
import axios from 'axios';

export default function Checkout() {
  const { cartItems, removeItemFromCart, clearCart } = useContext(CartContext);
  const [showModal, setShowModal] = useState(false);
  const [confirmationModal, setConfirmationModal] = useState(false);
  const [isPickup, setIsPickup] = useState(false);
  const [loading, setLoading] = useState(false);
  const [formValues, setFormValues] = useState({
    name: '',
    email: '',
    phone: '',
    street: '',
    number: '',
    sector: '',
    complement: '',
    paymentMethod: 'pix',
  });

  const handleInputChange = (e) => {
    const { id, value } = e.target;
    setFormValues((prev) => ({
      ...prev,
      [id]: value,
    }));
  };

  const handleCheckout = () => {
    setShowModal(true);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);

    const items = cartItems.map((item) => ({
      product_id: item.id,
      name: item.name,
      quantity: item.quantity,
      price: item.type === 'unit' ? item.unit_price : item.box_price,
      type: item.type,
    }));

    let address = 'Retirada no estabelecimento';
    if (!isPickup) {
      address = `${formValues.street}, Número: ${formValues.number}, Setor: ${formValues.sector}, Complemento: ${formValues.complement}`;
    }

    const orderData = {
      items,
      total: cartItems.reduce(
        (total, item) =>
          total + (item.type === 'unit' ? item.unit_price * item.quantity : item.box_price * item.quantity),
        0
      ),
      address,
      paymentMethod: formValues.paymentMethod,
    };

    try {
      const response = await axios.post('http://localhost:5000/api/orders', orderData);

      if (response.status === 201) {
        setLoading(false);
        setShowModal(false);
        setConfirmationModal(true);
        clearCart();
      } else {
        throw new Error('Falha ao criar o pedido');
      }
    } catch (error) {
      console.error('Erro ao finalizar o pedido:', error);
      setLoading(false);
      alert('Erro ao finalizar o pedido, tente novamente.');
    }
  };

  const sendWhatsAppMessage = () => {
    const items = cartItems.map((item) => `${item.quantity}x ${item.name}`).join(', ');
    const total = cartItems
      .reduce(
        (total, item) =>
          total + (item.type === 'unit' ? parseFloat(item.unit_price) : parseFloat(item.box_price)) * item.quantity,
        0
      )
      .toFixed(2);
    const address = isPickup ? 'Retirada no estabelecimento' : formValues.street;
    const whatsappMessage = `Olá, gostaria de fazer um pedido.\nProdutos: ${items}\nTotal: R$${total}\nEndereço: ${address}`;

    const whatsappLink = `https://wa.me/5562996916206?text=${encodeURIComponent(whatsappMessage)}`;
    window.location.href = whatsappLink;
  };

  const totalAmount = cartItems
    .reduce(
      (total, item) =>
        total + (item.type === 'unit' ? item.unit_price * item.quantity : item.box_price * item.quantity),
      0
    )
    .toFixed(2);

  return (
    <div className="max-w-4xl mx-auto mt-8">
      <h1 className="text-3xl font-bold mb-4">Carrinho de Compras</h1>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
        <div>
          {cartItems.length === 0 ? (
            <p>Seu carrinho está vazio.</p>
          ) : (
            cartItems.map((item, index) => (
              <div key={index} className="border rounded p-4 mb-4 flex justify-between items-center">
                <div>
                  <h2 className="font-bold text-white">{item.name}</h2>
                  <p className="text-gray-600">
                    {item.quantity} x {item.type === 'unit' ? 'Unidade' : 'Caixa'}
                  </p>
                </div>
                <div className="text-right flex items-center">
                  <p className="text-lg font-semibold text-yellow-500 mr-4">
                    R$ {(item.type === 'unit' ? parseFloat(item.unit_price) : parseFloat(item.box_price)).toFixed(2)}
                  </p>
                  <button
                    onClick={() => removeItemFromCart(item.id, item.type)}
                    className="bg-red-500 text-white flex items-center px-3 py-2 rounded hover:bg-red-600 transition-colors"
                  >
                    <FaTrash className="mr-2" />
                    Remover
                  </button>
                </div>
              </div>
            ))
          )}
        </div>

        <div className="border rounded p-4 bg-gradient-to-r from-yellow-400 to-yellow-600 shadow-md text-white">
          <h2 className="text-2xl font-semibold mb-4">Resumo da Compra</h2>
          <p>Total de Itens: {cartItems.length}</p>
          <p>Total: R$ {totalAmount}</p>
          <button
            onClick={handleCheckout}
            className="w-full bg-blue-600 text-white py-2 mt-4 rounded hover:bg-blue-700 transition-colors"
          >
            Finalizar Compra
          </button>
        </div>
      </div>

      {showModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center">
          <div className="bg-gray-800 p-4 rounded shadow-lg text-white max-w-md w-full"> {/* Ajuste no tamanho do modal */}
            <h2 className="text-xl font-bold mb-4">Finalizar Compra</h2>
            <form onSubmit={handleSubmit}>
              <div className="mb-4">
                <label htmlFor="name" className="block text-sm">
                  Nome:
                </label>
                <input
                  type="text"
                  id="name"
                  className="w-full p-2 border border-gray-500 rounded bg-gray-700 text-white"
                  value={formValues.name}
                  onChange={handleInputChange}
                  required
                />
              </div>
              <div className="mb-4">
                <label htmlFor="email" className="block text-sm">
                  Email:
                </label>
                <input
                  type="email"
                  id="email"
                  className="w-full p-2 border border-gray-500 rounded bg-gray-700 text-white"
                  value={formValues.email}
                  onChange={handleInputChange}
                  required
                />
              </div>
              <div className="mb-4">
                <label htmlFor="phone" className="block text-sm">
                  Número Celular:
                </label>
                <input
                  type="tel"
                  id="phone"
                  className="w-full p-2 border border-gray-500 rounded bg-gray-700 text-white"
                  value={formValues.phone}
                  onChange={handleInputChange}
                  required
                />
              </div>

              <div className="mb-4">
                <h3 className="text-lg font-semibold mb-2">Formas de Pagamento</h3>
                <select
                  className="w-full p-2 border border-gray-500 rounded bg-gray-700 text-white"
                  id="paymentMethod"
                  value={formValues.paymentMethod}
                  onChange={handleInputChange}
                >
                  <option value="pix">Pix</option>
                  <option value="dinheiro">Dinheiro</option>
                  <option value="debito">Cartão de Débito</option>
                  <option value="credito">Cartão de Crédito</option>
                </select>
              </div>

              <div className="flex items-center mb-4">
                <input
                  type="checkbox"
                  id="pickup"
                  className="mr-2"
                  checked={isPickup}
                  onChange={(e) => setIsPickup(e.target.checked)}
                />
                <label htmlFor="pickup">Retirar no estabelecimento</label>
              </div>

              {!isPickup && (
                <div id="addressFields">
                  <div className="mb-4">
                    <label htmlFor="street" className="block text-sm">
                      Rua:
                    </label>
                    <input
                      type="text"
                      id="street"
                      className="w-full p-2 border border-gray-500 rounded bg-gray-700 text-white"
                      value={formValues.street}
                      onChange={handleInputChange}
                      required
                    />
                  </div>
                  <div className="mb-4">
                    <label htmlFor="complement" className="block text-sm">
                      Complemento:
                    </label>
                    <input
                      type="text"
                      id="complement"
                      className="w-full p-2 border border-gray-500 rounded bg-gray-700 text-white"
                      value={formValues.complement}
                      onChange={handleInputChange}
                    />
                  </div>
                  <div className="flex space-x-4 mb-4">
                    <div>
                      <label htmlFor="number" className="block text-sm">
                        Número:
                      </label>
                      <input
                        type="text"
                        id="number"
                        className="w-full p-2 border border-gray-500 rounded bg-gray-700 text-white"
                        value={formValues.number}
                        onChange={handleInputChange}
                        required
                      />
                    </div>
                    <div>
                      <label htmlFor="sector" className="block text-sm">
                        Setor:
                      </label>
                      <input
                        type="text"
                        id="sector"
                        className="w-full p-2 border border-gray-500 rounded bg-gray-700 text-white"
                        value={formValues.sector}
                        onChange={handleInputChange}
                        required
                      />
                    </div>
                  </div>
                </div>
              )}

              <button
                type="submit"
                className="w-full bg-green-600 text-white py-2 mt-4 rounded hover:bg-green-700 transition-colors"
                style={{ fontFamily: 'Impact, sans-serif' }} // Estilo Impact aplicado
              >
                {loading ? 'Carregando...' : 'Concluir'}
              </button>
            </form>
            <button
              onClick={sendWhatsAppMessage}
              className="w-full bg-blue-600 text-white py-2 mt-2 rounded hover:bg-blue-700 transition-colors"
            >
              Confirme Seu Pedido Por WhatsApp
            </button>
            <button onClick={() => setShowModal(false)} className="mt-4 text-red-500">
              Cancelar
            </button>
          </div>
        </div>
      )}

      {confirmationModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center">
          <div className="bg-white p-6 rounded shadow-lg max-w-lg w-full">
            <h2 className="text-xl font-bold mb-4">Pedido confirmado!</h2>
            <p className="mb-4">Seu pedido foi registrado com sucesso.</p>
            <button onClick={sendWhatsAppMessage} className="mt-4 px-4 py-2 bg-green-600 text-white">
              Enviar pedido no WhatsApp
            </button>
            <button onClick={() => setConfirmationModal(false)} className="mt-4 px-4 py-2 bg-gray-600 text-white">
              Fechar
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
