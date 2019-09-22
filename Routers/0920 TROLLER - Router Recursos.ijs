module.exports = {
    apiName: 'Engine Service File API',
    basePath: '/api/api-troller/v2/produtos',
    requiresAuth: false,
    controller: 508050617,
    routes: [
        {
            method: 'GET',
            path: ':codigoProduto<string>',
            requiresAuth: false,
            action: 'getRecurso( request, codigoProduto)'
        },
         {
            method: 'PATCH',
            path: ':codigoProduto<string>',
            requiresAuth: false,
            action: 'updRecurso( request, codigoProduto)'
        }
    ]
};