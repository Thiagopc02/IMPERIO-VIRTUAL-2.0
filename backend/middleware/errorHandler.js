const errorHandler = (err, req, res, next) => {
    const statusCode = res.statusCode === 200 ? 500 : res.statusCode;
    
    // Loga o erro no console
    console.error(`[ErrorHandler] Erro: ${err.message} - ${new Date().toISOString()}`);
    
    res.status(statusCode);
    res.json({
        message: err.message || 'Ocorreu um erro inesperado.',
        stack: process.env.NODE_ENV === 'production' ? null : err.stack,
    });
};

module.exports = { errorHandler };
