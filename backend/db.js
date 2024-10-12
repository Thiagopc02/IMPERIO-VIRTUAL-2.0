const { Sequelize } = require('sequelize');

// Configurações do banco de dados usando variáveis de ambiente
const sequelize = new Sequelize(
  process.env.DB_NAME || 'imperio_bebidas_e_tabacos', 
  process.env.DB_USER || 'postgres',                  
  process.env.DB_PASSWORD || process.env.DB_PASS, // Melhorando o uso da variável de senha               
  {
    host: process.env.DB_HOST || 'localhost',         
    dialect: 'postgres',                              
    logging: false,                                   
  }
);

// Função assíncrona para testar a conexão e sincronizar os modelos
(async () => {
  try {
    await sequelize.authenticate();
    console.log('Conexão estabelecida com sucesso.');

    // Sincronizar os modelos com o banco de dados sem apagar dados existentes
    await sequelize.sync({ alter: true });
    console.log('Banco de dados sincronizado com sucesso.');
  } catch (error) {
    console.error('Não foi possível conectar ao banco de dados:', error);
  }
})();

module.exports = sequelize;
