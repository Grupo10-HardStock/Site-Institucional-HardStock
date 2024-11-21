var database = require("../database/config")

function autenticar(email, senha) {
    var instrucaoSql = `
      select idFuncionario, nome, email, permissao, fkEmpresa, estado from Funcionario where email = '${email}' AND senha = '${senha}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}
function cadastrar(nome, cnpj, email, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, cnpj, email, senha);
    
    var instrucaoSql = `
        INSERT INTO empresa (nome, cnpj, email, senha) VALUES ('${nome}', '${cnpj}','${email}', '${senha}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function cadastrarFuncionario(nome, sobrenome, telefone, email, senha, permissao, empresa) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, email, senha);

    var instrucaoSql = `insert into Funcionario (nome, sobrenome, numeroTelefone, email, senha, permissao, fkEmpresa) values ('${nome}', '${sobrenome}', '${telefone}', '${email}', '${senha}', '${permissao}', '${empresa}')`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
  }

function buscarFuncionario(fkEmpresa) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n buscarFuncionario(): ", fkEmpresa)
    var instrucaoSql = `SELECT * FROM VizFunc where fkEmpresa = ${fkEmpresa};`;
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarFuncionario(idFuncionario) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n listarFuncionario(): ",idFuncionario)
    var instrucaoSql = `SELECT * FROM VizEdit where idFuncionario = ${idFuncionario};`;
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function editar(nome,sobrenome,telefone,email,senha,permissao,estado, idFuncionario) {
    console.log("ACESSEI O AVISO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function editar(): ", nome,sobrenome,telefone,email,senha,permissao,estado, idFuncionario);
    var instrucaoSql = `
            UPDATE funcionario SET nome = '${nome}', sobrenome = '${sobrenome}',numeroTelefone = '${telefone}',email = '${email}', senha = '${senha}', permissao = '${permissao}', estado = '${estado}' WHERE idFuncionario = ${idFuncionario};`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


function deletar(idFuncionario) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n deletar():", idFuncionario);
    var instrucaoSql = `update funcionario set estado = "Inativo" where idFuncionario = ${idFuncionario};`;
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function verificarStatus(idFuncionario) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n verificarStatus():", idFuncionario);
    var instrucaoSql = `select estado from funcionario  where idFuncionario = ${idFuncionario};`;
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function enviarMensagem(nome, email, Mensagem) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function enviarMensagem():", email, nome, Mensagem);

    var instrucaoSql = `insert into mensagem (nome, email, mensagem) values ('${nome}', '${email}','${Mensagem}');`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    cadastrarFuncionario,
    buscarFuncionario,
    listarFuncionario,
    verificarStatus,
    enviarMensagem,
    autenticar,
    cadastrar,
    deletar,
    editar
};