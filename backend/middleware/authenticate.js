const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET;
console.log('JWT_SECRET:', process.env.JWT_SECRET); // Adicionar esta linha para verificar o valor de JWT_SECRET


if (!JWT_SECRET) {
  throw new Error('JWT_SECRET não está definido nas variáveis de ambiente');
}

const authenticate = (req, res, next) => {
  const token = req.header('Authorization')?.split(' ')[1];
  console.log('Token recebido:', token); // Log do token recebido

  if (!token) {
    return res.status(401).json({ message: 'Token de autenticação não fornecido.' });
  }

  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    req.user = decoded; // Adiciona os dados do usuário decodificados no req para uso posterior
    next(); // Prossegue com a requisição
  } catch (error) {
    if (error.name === 'TokenExpiredError') {
      return res.status(401).json({ message: 'Token expirado. Por favor, faça login novamente.' });
    }
    console.error('Erro na verificação do token:', error);
    res.status(401).json({ message: 'Token inválido.' });
  }
};

module.exports = authenticate;
