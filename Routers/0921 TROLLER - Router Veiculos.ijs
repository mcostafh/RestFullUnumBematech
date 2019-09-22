module.exports = {
    apiName: 'Engine Service File API',
    basePath: '/api/api-troller/v1/veiculos',
    requiresAuth: false,
    controller: 510460644,
    routes: [
          {
            method: 'GET',
            path: '',
            requiresAuth: false,
            action: 'getListaDeVeiculos( request)'
        },
        {
            method: 'GET',
             path: ':codigo<string>',
            requiresAuth: false,
            action: 'getVeiculo( request, codigo)'
        },
         {
            method: 'PATCH',
            path: ':codigo<string>',
            requiresAuth: false,
            action: 'updVeiculo( request, codigo)'
        }
    ]
};