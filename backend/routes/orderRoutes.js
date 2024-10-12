const express = require('express');
const Order = require('../models/Order');
const OrderItem = require('../models/OrderItem');
const authenticate = require('../middleware/authenticate');

const router = express.Router();

// Rota para criar um pedido
router.post('/', authenticate, async (req, res) => {
  const { userId, items, total, address, paymentMethod } = req.body;

  try {
    // Validação de dados de entrada
    if (!userId || !items || items.length === 0 || !total || !paymentMethod) {
      return res.status(400).json({ message: 'Dados insuficientes para criar o pedido.' });
    }

    // Criação do pedido no banco de dados
    const newOrder = await Order.create({
      user_id: userId,
      total_price: total,
      status: 'pendente',
      payment_method: paymentMethod,
      address: address,
    });

    // Inserir os itens do pedido
    const orderItems = items.map(item => ({
      order_id: newOrder.order_id,
      product_id: item.product_id,
      quantity: item.quantity,
      price: item.price,
    }));

    await OrderItem.bulkCreate(orderItems);

    res.status(201).json({ message: 'Pedido criado com sucesso', order: newOrder });
  } catch (error) {
    console.error('Erro ao criar pedido:', error);
    res.status(500).json({ message: 'Erro ao criar pedido' });
  }
});

// Rota para buscar pedidos por usuário
router.get('/:userId', authenticate, async (req, res) => {
  const { userId } = req.params;

  try {
    const orders = await Order.findAll({
      where: { user_id: userId },
      include: [
        {
          model: OrderItem,
          as: 'items',
        },
      ],
    });

    if (!orders || orders.length === 0) {
      return res.status(404).json({ message: 'Nenhum pedido encontrado.' });
    }

    res.status(200).json(orders);
  } catch (error) {
    console.error('Erro ao buscar pedidos:', error);
    res.status(500).json({ message: 'Erro ao buscar pedidos.' });
  }
});

module.exports = router;
