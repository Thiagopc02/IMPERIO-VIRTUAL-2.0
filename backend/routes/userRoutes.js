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

module.exports = router;
