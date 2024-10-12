const { validationResult } = require('express-validator');

const validate = (req, res, next) => {
    const errors = validationResult(req);
    
    if (!errors.isEmpty()) {
        return res.status(400).json({
            success: false,
            message: 'Erros de validação encontrados.',
            errors: errors.array().map((err) => ({
                field: err.param, // O campo que falhou na validação
                message: err.msg, // A mensagem de erro associada
                value: err.value, // O valor incorreto que foi recebido
            }))
        });
    }
    
    next();
};

module.exports = { validate };
