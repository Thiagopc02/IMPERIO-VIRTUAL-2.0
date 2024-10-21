const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController'); // Verifique o caminho correto
const orderController = require('../controllers/orderController'); // Verifique o caminho correto
const authenticate = require('../middleware/authenticate');  // Middleware de autenticação

// Rota para registro de usuário
router.post('/register', userController.register);

// Rota para login de usuário
router.post('/login', userController.login);

// Rota para buscar os pedidos de um usuário, protegida por autenticação
router.get('/orders/:userId', authenticate, orderController.getOrdersByUser);  // Nova rota para pedidos, protegida

// Rota para criar um pedido
router.post('/orders/retirarEstabelecimento',  async (req, res) => {
    try {
        const { items, total, address, paymentMethod } = req.body;

        // Crie a lógica para salvar o pedido no banco de dados aqui
        const newOrder = await Order.create({
            items,
            total,
            address,
            paymentMethod,
            // Outros campos conforme necessário
        });

        // Gere um novo JWT para o pedido
        const token =  jwt.sign({ orderId: newOrder.id }, JWT_SSECRET, { expiresIn: '12h' });
        // Retorne a resposta com o novo token
        res.status(201).json({
            message: 'Pedido criado com sucesso!',
            order: newOrder,
            token, // Retorne o novo token
        });
    } catch (error) {
        console.error('Erro ao criar pedido:', error);
        res.status(500).json({ message: 'Erro ao criar pedido.' });
    }
});


module.exports = router;
