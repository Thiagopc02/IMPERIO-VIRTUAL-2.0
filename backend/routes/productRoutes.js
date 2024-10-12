const express = require('express');
const router = express.Router();
const productController = require('../controllers/productController');
const jwt = require('jsonwebtoken');
const { body } = require('express-validator');

const JWT_SECRET = process.env.JWT_SECRET || 'seu_segredo_jwt';

// Middleware para verificar o token JWT
function verifyToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    return res.status(403).send({ auth: false, message: 'Nenhum token fornecido.' });
  }

  jwt.verify(token, JWT_SECRET, (err, decoded) => {
    if (err) {
      return res.status(403).json({ auth: false, message: 'Token inválido ou expirado' });
    }

    // Se tudo estiver ok, salva no request para uso posterior
    req.userId = decoded.id;
    next();
  });
}

// Validações de entrada usando express-validator
const validateProduct = [
  body('name').notEmpty().withMessage('O nome do produto é obrigatório'),
  body('price').isDecimal().withMessage('Preço deve ser um número válido'),
  body('stock').isInt({ min: 0 }).withMessage('Estoque deve ser um número inteiro não negativo')
];

// Rota para listar todos os produtos (Pública)
router.get('/', productController.getAllProducts);

// Rota para obter um produto específico pelo ID (Pública)
router.get('/:id', productController.getProductById);

// Middleware para proteger rotas a partir daqui
router.use(verifyToken);

// Rota para criar um novo produto (Protegida)
router.post('/', validateProduct, productController.createProduct);

// Rota para atualizar um produto existente (Protegida)
router.put('/:id', validateProduct, productController.updateProduct);

// Rota para deletar um produto (Protegida)
router.delete('/:id', productController.deleteProduct);

module.exports = router;
