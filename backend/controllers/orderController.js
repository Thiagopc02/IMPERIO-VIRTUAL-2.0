const Order = require('../models/Order');
const OrderItem = require('../models/OrderItem');

// Função para buscar pedidos por usuário
exports.getOrdersByUser = async (req, res) => {
  const { userId } = req.params;

  // Validação básica do userId
  if (!userId || isNaN(userId)) {
    return res.status(400).json({ message: 'ID de usuário inválido ou não fornecido.' });
  }

  try {
    console.log(`Buscando pedidos para o usuário: ${userId}`); // Log para depuração
    const orders = await Order.findAll({
      where: { user_id: userId },
      include: [
        {
          model: OrderItem,
          as: 'items',
        },
      ],
    });

    // Verifica se há pedidos encontrados
    if (!orders || orders.length === 0) {
      return res.status(404).json({ message: 'Nenhum pedido encontrado para este usuário.' });
    }

    console.log(`Pedidos encontrados: ${orders.length}`); // Log para depuração
    res.status(200).json(orders);
  } catch (error) {
    console.error('Erro ao buscar pedidos:', error.message);
    
    // Tratamento mais específico do erro
    if (error.name === 'SequelizeConnectionError') {
      return res.status(503).json({ message: 'Serviço indisponível. Falha na conexão com o banco de dados.' });
    }
    
    res.status(500).json({ message: 'Erro interno ao buscar pedidos. Tente novamente mais tarde.' });
  }
};

// Função para criar um pedido
exports.createOrder = async (req, res) => {
  const { userId, items, total, address, paymentMethod } = req.body;

  console.log('Dados recebidos no backend:', req.body); // Log para depuração

  try {
    // Validação dos dados de entrada
    if (!userId || !items || items.length === 0 || !total || !paymentMethod) {
      return res.status(400).json({ message: 'Dados insuficientes para criar o pedido.' });
    }

    // Criação do novo pedido
    const newOrder = await Order.create({
      user_id: userId,
      total_price: total,
      status: 'pendente',
      payment_method: paymentMethod,
      address: address,
    });

    // Inserção dos itens do pedido
    const orderItems = items.map(item => ({
      order_id: newOrder.order_id,
      product_id: item.product_id,
      quantity: item.quantity,
      price: item.price,
    }));

    await OrderItem.bulkCreate(orderItems);

    res.status(201).json({ message: 'Pedido criado com sucesso', order: newOrder });
  } catch (error) {
    console.error('Erro ao criar pedido:', error.message);
    
    res.status(500).json({ message: 'Erro ao criar pedido. Tente novamente mais tarde.' });
  }
};
