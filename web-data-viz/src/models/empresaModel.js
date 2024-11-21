var database = require("../database/config");

function buscarPorId(id) {
  var instrucaoSql = `SELECT * FROM empresa WHERE id = '${id}'`;

  return database.executar(instrucaoSql);
}

function listar() {
  var instrucaoSql = `SELECT razao_social FROM empresa`;

  return database.executar(instrucaoSql);
}

function buscarPorCnpj(cnpj) {
  var instrucaoSql = `SELECT * FROM empresa WHERE cnpj = '${cnpj};'`;

  return database.executar(instrucaoSql);
}

function cadastrar(nome, cnpj, email) {
  var instrucaoSql = `insert into Empresa (razaoSocial,cnpj,emailCorporativo) values ('${nome}', ${cnpj}, '${email}')`;

  return database.executar(instrucaoSql);
}


function cadastrarGerente(nome, sobrenome, telefone, email, senha, permissao, empresa) {
  var instrucaoSql = `insert into Funcionario (nome, sobrenome, numeroTelefone, email, senha, permissao, fkEmpresa) values ('${nome}', '${sobrenome}', ${telefone}, '${email}', '${senha}', '${permissao}', '${empresa}')`;

  return database.executar(instrucaoSql);
}


function buscarEmpresa() {
  console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n buscarEmpresa(): ")
  var instrucaoSql = 
  `SELECT 
  idEmpresa,
  razaoSocial,
  emailCorporativo,
  estado
FROM 
  Empresa;`

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function editar(novoEstado, novoNome, novoCNPJ, novaEmail,idEmpresa) {
  console.log("ACESSEI O AVISO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function editar(): ", novoEstado, novoNome, novoCNPJ, novaEmail,idEmpresa);
  var instrucaoSql = `
          UPDATE Empresa SET estado = '${novoEstado}', razaoSocial = '${novoNome}', cnpj = '${novoCNPJ}', emailCorporativo = '${novaEmail}' WHERE idEmpresa = ${idEmpresa};
            `;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function deletar(idEmpresa) {
  console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n deletar():", idEmpresa);
  var instrucaoSql = `update Empresa set estado = "Desativado" where idEmpresa = ${idEmpresa};`;
  
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function listarEmpresa(idEmpresa) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n listarFuncionario(): ",idEmpresa)
    var instrucaoSql = `SELECT estado,razaoSocial,cnpj,emailCorporativo FROM Empresa where idEmpresa = ${idEmpresa};`;
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = { buscarPorCnpj, buscarPorId, cadastrar, listar, cadastrarGerente,buscarEmpresa, listarEmpresa,editar, deletar };
