require('dotenv').config();
const Hapi = require('@hapi/hapi');
const routes = require('../server/routes');
const loadModel = require('../services/loadModel');
const InputError = require('../exceptions/InputError');

(async () => {
    console.log(`Running on PORT: ${process.env.PORT}`);

    // Inisialisasi server
    const server = Hapi.server({
        port: process.env.PORT || 8080, // Default ke 8080 jika PORT tidak diatur
        host: '0.0.0.0',
        routes: {
            cors: {
                origin: ['*'],
            },
        },
    });

    try {
        console.log('Loading model...');
        const model = await loadModel();
        console.log('Model loaded successfully');
        server.app.model = model;
    } catch (error) {
        console.error('Failed to load model:', error.message);
        process.exit(1); // Keluar jika model gagal dimuat
    }

    // Tambahkan endpoint root untuk health check
    server.route({
        method: 'GET',
        path: '/',
        handler: () => {
            return { status: 'success', message: 'Server is running' };
        },
    });

    // Tambahkan routes lainnya
    server.route(routes);

    // Middleware untuk menangani error
    server.ext('onPreResponse', function (request, h) {
        const response = request.response;

        if (response instanceof InputError) {
            const newResponse = h.response({
                status: 'fail',
                message: `${response.message}`,
            });
            newResponse.code(response.statusCode);
            return newResponse;
        }

        if (response.isBoom) {
            const newResponse = h.response({
                status: 'fail',
                message: response.message,
            });
            newResponse.code(response.output.statusCode);
            return newResponse;
        }

        return h.continue;
    });

    await server.start();
    console.log(`Server started at: ${server.info.uri}`);
})();
