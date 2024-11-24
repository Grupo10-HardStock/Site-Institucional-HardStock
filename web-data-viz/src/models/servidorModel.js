var database = require("../database/config"); // Conexão com o banco de dados

// Função para cadastrar o servidor no banco de dados


function cadastrarServidor(nome, rede, ram, disco, cpu, empresa) {
    console.log("Tentando cadastrar servidor com os seguintes dados:", nome, rede, ram, disco, cpu, empresa);
    
    var instrucaoSql = `
        INSERT INTO Servidor (nome, rede, ram, disco, cpu, fkEmpresa)
        VALUES ('${nome}', '${rede}', '${ram}', '${disco}', '${cpu}', ${empresa});
    `;
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    
    return database.executar(instrucaoSql)
        .then(function (resultado) {
            console.log("Servidor cadastrado com sucesso:", resultado);
            return resultado;
        })
        .catch(function (erro) {
            console.log("Erro ao executar a query:", erro);
            throw erro;
        });
}

function inativar(idServidor) {
    console.log("ACESSEI O AVISO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function inativar():", idServidor);
    var instrucaoSql = `
        update servidor set estado = "Inativo" WHERE idServidor = ${idServidor};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function verificarStatusServidor(idServidor) {
    console.log("Verificando status dos servidor...");
    
    var instrucaoSql = ` SELECT estado FROM Servidor where idServidor = ${idServidor}; `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function editar(novoNome, novaRede, novaRam, novoDisco, novaCpu, novoEstado, idServidor) {
    console.log("ACESSEI O AVISO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function editar(): ");
    var instrucaoSql = `
    UPDATE servidor SET 
        nome = '${novoNome}', 
        rede = '${novaRede}', 
        ram = '${novaRam}', 
        disco = '${novoDisco}', 
        cpu = '${novaCpu}' ,
        estado = '${novoEstado}' 
    WHERE idServidor = ${idServidor};

    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function porId (idServidor){
    console.log("Buscando servidores...");
    var instrucaoSql = `
        SELECT * FROM servidor WHERE idServidor = ${idServidor};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listar() {
    console.log("Buscando servidores...");
    var instrucaoSql = `
        SELECT 
            s.idServidor,
            s.nome AS nomeServidor,
            s.rede,
            s.ram,
            s.disco,
            s.cpu,
            s.estado,
            e.idEmpresa,
            e.razaoSocial AS nomeEmpresa
        FROM Servidor s
        INNER JOIN Empresa e ON s.fkEmpresa = e.idEmpresa;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    verificarStatusServidor,
    cadastrarServidor,
    inativar,
    editar,
    listar,
    porId
};
