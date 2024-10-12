import { useEffect, useState } from 'react';
import axios from 'axios';
import { useRouter } from 'next/router';

export default function Profile() {
  const [orders, setOrders] = useState([]);
  const router = useRouter();

  useEffect(() => {
    if (typeof window !== 'undefined') {
      const token = localStorage.getItem('token');
      const storedUser = JSON.parse(localStorage.getItem('user'));

      if (!token || !storedUser) {
        router.push('/login');
        return;
      }

      axios
        .get(`http://localhost:5000/api/orders/${storedUser.id}`, {
          headers: { Authorization: `Bearer ${token}` },
        })
        .then((response) => setOrders(response.data))
        .catch((error) => console.error('Erro ao buscar pedidos:', error));
    }
  }, [router]);

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gray-100">
      <div className="bg-white shadow-lg rounded-lg p-8 w-full max-w-4xl">
        <h1 className="text-3xl font-bold text-yellow-600 mb-6 text-center">Meus Pedidos</h1>
        {orders.length > 0 ? (
          <ul className="divide-y divide-gray-300">
            {orders.map((order) => (
              <li key={order.order_id} className="py-4">
                <div className="flex justify-between items-center">
                  <span className="font-semibold text-gray-700">ID Pedido: {order.order_id}</span>
                  <span className="text-yellow-500">R$ {order.total_price.toFixed(2)}</span>
                  <span className={`px-2 py-1 rounded-full text-sm ${order.status === 'pendente' ? 'bg-red-200 text-red-800' : 'bg-green-200 text-green-800'}`}>
                    {order.status}
                  </span>
                </div>
                <div className="text-sm text-gray-600 mt-2">
                  Data: {new Date(order.created_at).toLocaleDateString()} <br />
                  Endereço: {order.address}
                  <br />
                  Itens: {order.items.map((item) => `${item.quantity}x ${item.product_id}`).join(', ')}
                </div>
              </li>
            ))}
          </ul>
        ) : (
          <div className="text-center text-gray-500">Você ainda não fez nenhum pedido.</div>
        )}
      </div>
    </div>
  );
}
