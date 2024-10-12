const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = require('../models/User');

const router = express.Router();

// Carregar o segredo JWT do arquivo .env
const JWT_SECRET = process.env.JWT_SECRET || 'seu_segredo_jwt';

// Rota de registro
router.post('/register', async (req, res) => {
  try {
    const { name, email, phone, password } = req.body;

    // Verifica se o e-mail já está registrado
    const existingUser = await User.findOne({ where: { email } });
    if (existingUser) {
      return res.status(400).json({ message: 'Usuário já cadastrado com esse e-mail.' });
    }

    // Criptografa a senha
    const hashedPassword = await bcrypt.hash(password, 10);

    // Cria um novo usuário
    const newUser = await User.create({ name, email, phone, password: hashedPassword });
    
    // Remove a senha antes de enviar a resposta
    const userWithoutPassword = newUser.toJSON();
    delete userWithoutPassword.password;

    // Envia a resposta com o usuário registrado
    res.status(201).json({ message: 'Usuário registrado com sucesso!', user: userWithoutPassword });
  } catch (error) {
    console.error('Erro ao registrar o usuário:', error);
    res.status(500).json({ message: 'Erro ao registrar o usuário.' });
  }
});

// Rota de login
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    // Verifica se o usuário existe
    const user = await User.findOne({ where: { email } });
    if (!user) {
      return res.status(401).json({ message: 'Credenciais inválidas.' });
    }

    // Compara a senha fornecida com a armazenada
    const match = await bcrypt.compare(password, user.password);
    if (!match) {
      return res.status(401).json({ message: 'Credenciais inválidas.' });
    }

    // Gera o token JWT com expiração de 12 horas
    const token = jwt.sign({ id: user.id, email: user.email }, JWT_SECRET, { expiresIn: '12h' });

    // Remove a senha dos dados do usuário antes de enviar a resposta
    const userWithoutPassword = user.toJSON();
    delete userWithoutPassword.password;

    // Retorna o token e as informações do usuário
    res.status(200).json({ message: 'Login realizado com sucesso!', token, user: userWithoutPassword });
  } catch (error) {
    console.error('Erro ao fazer login:', error);
    res.status(500).json({ message: 'Erro ao fazer login.' });
  }
});

module.exports = router;
