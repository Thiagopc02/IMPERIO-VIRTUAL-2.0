const Product = require('../models/Product');
const { Op } = require('sequelize');

// Obter todos os produtos ou filtrar por categoria com paginação
exports.getAllProducts = async (req, res) => {
  try {
    const categoryId = req.query.category;
    const page = parseInt(req.query.page) || 1; // Paginação: Página atual
    const limit = req.query.limit ? parseInt(req.query.limit) : null; // Limite de itens por página (opcional)
    const offset = limit ? (page - 1) * limit : null; // Cálculo do offset para paginação
    let products;

    if (categoryId) {
      console.log(`Filtrando por categoria: ${categoryId}`);
      products = await Product.findAndCountAll({
        where: { category_id: categoryId },
        ...(limit && { limit, offset }), // Aplica paginação apenas se o limit for definido
      });
    } else {
      products = await Product.findAndCountAll({
        ...(limit && { limit, offset }), // Aplica paginação apenas se o limit for definido
      });
    }

    // Mapear os produtos para ajustar preços e URLs
    const mappedProducts = products.rows.map((product) => ({
      ...product.toJSON(),
      price: parseFloat(product.price) || 0,
      unit_price: parseFloat(product.unit_price) || 0,
      box_price: parseFloat(product.box_price) || 0,
      image_url: product.image_url || 'default.png',
    }));

    res.status(200).json({
      data: mappedProducts,
      totalItems: products.count,
      totalPages: limit ? Math.ceil(products.count / limit) : 1,
      currentPage: page,
    });
  } catch (error) {
    console.error('Erro ao buscar produtos:', error);
    res.status(500).json({ error: 'Erro ao buscar produtos' });
  }
};


// Obter um produto específico pelo ID
exports.getProductById = async (req, res) => {
  try {
    const product = await Product.findByPk(req.params.id);
    if (product) {
      const adjustedProduct = {
        ...product.toJSON(),
        price: parseFloat(product.price) || 0,
        unit_price: parseFloat(product.unit_price) || 0,
        box_price: parseFloat(product.box_price) || 0,
        image_url: product.image_url || 'default.png',
      };
      res.status(200).json(adjustedProduct);
    } else {
      res.status(404).json({ error: 'Produto não encontrado' });
    }
  } catch (error) {
    console.error('Erro ao buscar produto:', error);
    res.status(500).json({ error: 'Erro ao buscar produto' });
  }
};

// Criar um novo produto com validação básica de dados
exports.createProduct = async (req, res) => {
  try {
    const { name, price, stock, category_id, unit_price, box_price, image_url } = req.body;

    // Verificação de campos obrigatórios
    if (!name || price === undefined || stock === undefined || !category_id) {
      return res.status(400).json({ error: 'Todos os campos obrigatórios devem ser preenchidos.' });
    }

    const newProduct = await Product.create({
      name,
      price: parseFloat(price),
      stock,
      category_id,
      unit_price: unit_price ? parseFloat(unit_price) : 0,
      box_price: box_price ? parseFloat(box_price) : 0,
      image_url: image_url || 'default.png',
    });
    
    res.status(201).json(newProduct);
  } catch (error) {
    console.error('Erro ao criar produto:', error);
    res.status(500).json({ error: 'Erro ao criar produto' });
  }
};

// Atualizar um produto existente com validação de campos
exports.updateProduct = async (req, res) => {
  try {
    const product = await Product.findByPk(req.params.id);
    if (product) {
      await product.update({
        ...req.body,
        price: req.body.price !== undefined ? parseFloat(req.body.price) : product.price,
        unit_price: req.body.unit_price !== undefined ? parseFloat(req.body.unit_price) : product.unit_price,
        box_price: req.body.box_price !== undefined ? parseFloat(req.body.box_price) : product.box_price,
        image_url: req.body.image_url || product.image_url,
      });

      const updatedProduct = {
        ...product.toJSON(),
        price: product.price || 0,
        unit_price: product.unit_price || 0,
        box_price: product.box_price || 0,
        image_url: product.image_url || 'default.png',
      };

      res.status(200).json(updatedProduct);
    } else {
      res.status(404).json({ error: 'Produto não encontrado' });
    }
  } catch (error) {
    console.error('Erro ao atualizar produto:', error);
    res.status(500).json({ error: 'Erro ao atualizar produto' });
  }
};

// Deletar um produto
exports.deleteProduct = async (req, res) => {
  try {
    const product = await Product.findByPk(req.params.id);
    if (product) {
      await product.destroy();
      res.status(200).json({ message: 'Produto deletado com sucesso' });
    } else {
      res.status(404).json({ error: 'Produto não encontrado' });
    }
  } catch (error) {
    console.error('Erro ao deletar produto:', error);
    res.status(500).json({ error: 'Erro ao deletar produto' });
  }
};
