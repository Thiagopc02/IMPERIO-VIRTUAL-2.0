require('dotenv').config();
const express = require('express'); // Certifique-se de que este caminho esteja correto
const cors = require('cors');
const productRoutes = require('./routes/productRoutes'); // Certifique-se de que os caminhos estão corretos
const orderRoutes = require('./routes/orderRoutes'); // Certifique-se de que os caminhos estão corretos
const userRoutes = require('./routes/userRoutes'); // Certifique-se de que os caminhos estão corretos
const authRoutes = require('./routes/authRoutes'); // Certifique-se de que os caminhos estão corretos
const sequelize = require('./db'); // Certifique-se de que a conexão com o banco de dados está funcionando

const app = express();
app.use(express.json()); // Middleware para analisar requisições JSON

// Configuração do CORS
app.use(cors({
  origin: 'http://localhost:3000', // Se o front-end estiver hospedado em outro lugar, altere esta URL
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization'],
}));

// Definindo as rotas
app.use('/api/products', productRoutes); // Rotas de produtos
app.use('/api/orders', orderRoutes); // Rotas de ordem
app.use('/api/orders/retirarEstabelecimento', orderRoutes); // Rotas de ordem
app.use('/api/users', userRoutes); // Rotas de usuários
app.use('/api/auth', authRoutes); // Rotas de autenticação

const PORT = process.env.PORT || 5000; // Certifique-se de que a variável de ambiente PORT está definida corretamente

// Iniciar o servidor e sincronizar o banco de dados
sequelize.sync().then(() => {
  app.listen(PORT, () => {
    console.log(`Servidor rodando na porta ${PORT}`);
  });
}).catch(err => {
  console.error('Erro ao sincronizar o banco de dados:', err);
});
