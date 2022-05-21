const errorHandler = (err, req, res, next) => {
    let statusCode = 500;
    let data = {
        message: 'Internal server error',
        description: err.message,
    }

    return res.status(statusCode).json(data);
}

export default errorHandler;