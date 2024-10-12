const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = require('../models/User');

const JWT_SECRET = process.env.JWT_SECRET || 'seu_segredo_jwt';

// Registrar um novo usuário
exports.register = async (req, res) => {
  let { name, email, phone, password } = req.body;

  try {
    // Verifica se todos os campos obrigatórios foram fornecidos
    if (!name || !email || !phone || !password) {
      return res.status(400).json({
        error: 'Preencha todos os campos obrigatórios: nome, e-mail, número de celular e senha.',
      });
    }

    // Sanitização do e-mail
    email = email.toLowerCase().trim();

    // Verifica se o e-mail já está em uso
    const existingUserByEmail = await User.findOne({ where: { email } });
    if (existingUserByEmail) {
      return res.status(400).json({ error: 'O e-mail já está em uso.' });
    }

    // Verifica se o número de celular já está em uso
    const existingUserByPhone = await User.findOne({ where: { phone } });
    if (existingUserByPhone) {
      return res.status(400).json({ error: 'O número de celular já está em uso.' });
    }

    // Gera o hash da senha
    const hashedPassword = await bcrypt.hash(password, 10);

    // Cria o novo usuário
    const newUser = await User.create({
      name,
      email,
      phone,
      password: hashedPassword,
    });

    // Remove a senha antes de enviar a resposta
    const userWithoutPassword = newUser.toJSON();
    delete userWithoutPassword.password;

    res.status(201).json(userWithoutPassword);
  } catch (error) {
    console.error('Erro ao registrar o usuário:', error);
    res.status(500).json({
      error: 'Erro ao registrar o usuário. Tente novamente mais tarde.',
    });
  }
};

// Login do usuário
exports.login = async (req, res) => {
  let { email, password } = req.body;

  try {
    // Verifica se o e-mail e a senha foram fornecidos
    if (!email || !password) {
      return res.status(400).json({
        error: 'E-mail e senha são obrigatórios.',
      });
    }

    // Sanitização do e-mail
    email = email.toLowerCase().trim();

    // Verifica se o usuário existe
    const user = await User.findOne({ where: { email } });
    if (user && (await bcrypt.compare(password, user.password))) {
      // Gera o token JWT com expiração de 1 hora
      const token = jwt.sign(
        { id: user.id, email: user.email },
        JWT_SECRET,
        { expiresIn: '1h' }
      );

      // Retorna o token e as informações do usuário
      return res.status(200).json({
        message: 'Login realizado com sucesso',
        token,
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          phone: user.phone,
        },
      });
    } else {
      // Se as credenciais forem inválidas
      return res.status(400).json({
        error: 'E-mail ou senha inválidos.',
      });
    }
  } catch (error) {
    console.error('Erro ao fazer login:', error);
    res.status(500).json({
      error: 'Erro ao fazer login. Por favor, tente novamente mais tarde.',
    });
  }
};
