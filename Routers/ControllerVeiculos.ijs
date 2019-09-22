__includeOnce('ufs:/ngin/router/controller.js');
__includeOnce('ufs:/bdo/orm/entityset.js');
__includeOnce('ufs:/bdo/orm/entity.js');
__includeOnce('ufs:/goog/array/array.js');
__includeOnce('ufs:/goog/object/object.js');
__includeOnce('ufs:/ngin/router/controller.js');
__includeOnce('ufs:/ngin/keys/classes.js');
__includeOnce('ufs:/ngin/http/error.js');
__includeOnce('ufs:/ngin/http/status.js');

__includeOnce(-1898191188); /* /inteq/library/server/keysUtilities.js */;
__includeOnce(-1898191186); /* /inteq/library/server/queryUtilities.js */;
__includeOnce(-1898147512); /* /inteq/library/server/connection.js */;
__includeOnce(-1898146446); /* /inteq/library/server/session.js */;
__includeOnce(-1898145959); /* /products/INTEQengine/library/QueryAnalyzer.js */;
__includeOnce(-1898145408); /* /products/INTEQengine/library/ClassDefManager.ijs */;
__includeOnce(-1898145684) /* /products/INTEQengine/library/formatters/JSON.js */


var ServiceVeiculos = function () {
  ngin.router.Controller.call(this);
};

goog.inherits(ServiceVeiculos, ngin.router.Controller);

ServiceVeiculos.prototype.getListaDeVeiculos= function (request) {

    var arObj = []
    try{

        dsRecursos = classes.getCachedDataSet(-1895832581) //T4
        dsRecursos.indexFieldNames = 'codigo'

        for (dsRecursos.first(); !dsRecursos.eof; dsRecursos.next()) {

            var result = {}
            result.id     = dsRecursos.chave
            result.codigo = dsRecursos.codigo
            result.nome   = dsRecursos.nome
            result.nomeClasse = dsRecursos.classe.nome
            result.unidmedida = dsRecursos.unidmedida.codigo
            result.zstatus = dsRecursos.zstatus.codigo
            result.formaaquisicao = dsRecursos.zformaaquisicao.codigo
            result.clfiscal = dsRecursos.clfiscal.codigo
            result.fornecedor = dsRecursos.zforn01.codigo+' '+dsRecursos.zforn01.nome
            
            arObj.push( result )
        }



        return this.ok( JSON.stringify(arObj) ).as("text/x-json");

    } catch(e){
        result.error = "Não foi possivel ler registro"
        result.message = e.message
        result.partNumber = partNumber
        return this.badRequest(JSON.stringify(result)).as("text/x-json");
    }
};

ServiceVeiculos.prototype.getVeiculo = function (request, partNumber) {

    var result = {}
    try{

        dsRecursos = classes.getCachedDataSet(-1895832581) //T4
        dsRecursos.indexFieldNames = 'codigo'

        var found = dsRecursos.find(partNumber)
        if ( !found ){
            found = dsRecursos.findKey(partNumber)
        }

        if ( found ){
            result.id     = dsRecursos.chave
            result.codigo = dsRecursos.codigo
            result.nome   = dsRecursos.nome
            result.nomeClasse = dsRecursos.classe.nome
            result.unidmedida = dsRecursos.unidmedida.codigo
            result.zstatus = dsRecursos.zstatus.codigo
            result.formaaquisicao = dsRecursos.zformaaquisicao.codigo
            result.clfiscal = dsRecursos.clfiscal.codigo
            result.fornecedor = dsRecursos.zforn01.codigo+' '+dsRecursos.zforn01.nome

            return this.ok( JSON.stringify(result) ).as("text/x-json");
        } else {

            result.erro = 'Part Number não localizado'
            result.partNumber   = partNumber

            return this.notFound( JSON.stringify(result) ).as("text/x-json");
        }

    } catch(e){
        result.error = "Não foi possivel ler registro"
        result.message = e.message
        result.partNumber = partNumber
        return this.badRequest(JSON.stringify(result)).as("text/x-json");
    }
};


ServiceVeiculos.prototype.updRecurso = function (request, partNumber) {

    var result = {}
    try{

        var params = request.body.asJson()
        var logado = session.loginByAuthToken( params.token )
    }catch(e){
        result.error = "Não foi possível conectar o webservices porque o Token utilizado está inválido"
        result.message = e.message
        return this.badRequest(JSON.stringify(result)).as("text/x-json");
    }

    try{
        dsRecursos = connection.cloneLocalCacheByClass(-1895832581) //T4
        dsRecursos.indexFieldNames = 'codigo'


        var found = dsRecursos.find(partNumber)
        if ( !found ){
            found = dsRecursos.findKey(partNumber)
        }

        if ( found ){


            dsRecursos.nome = params.nome
            dsRecursos.post()

            result.id = dsRecursos.chave
            result.status = 'Atualização com sucesso'
            result.nome = dsRecursos.nome

            return this.ok( JSON.stringify(result) ).as("text/x-json");
        } else {

            result.erro = 'Part Number não localizado'
            result.partNumber   = partNumber

            return this.notFound( JSON.stringify(result) ).as("text/x-json");
        }


    } catch(e){
        result.error = 'Erro ao tentar atualizar registro'
        result.message = e.message
        result.partNumber = partNumber
        return this.badRequest(JSON.stringify(result)).as("text/x-json");
    }
};
module.exports = ServiceVeiculos;