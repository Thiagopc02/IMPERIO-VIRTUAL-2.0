import axios from 'axios';

export default async function handler(req, res) {
  if (req.method === 'GET') {
    try {
      const { category } = req.query;

      // Faz uma requisição HTTP para o endpoint da API do backend
      const response = await axios.get('http://localhost:5000/api/products', {
        params: { category },
      });

      // Verifica a resposta
      console.log(response.data);

      // Retorna a resposta da API para o frontend
      res.status(200).json(response.data);
    } catch (error) {
      console.error('Erro ao buscar produtos:', error);
      res.status(500).json({ error: 'Erro ao buscar produtos' });
    }
  } else {
    res.setHeader('Allow', ['GET']);
    res.status(405).end(`Método ${req.method} não permitido`);
  }
}
