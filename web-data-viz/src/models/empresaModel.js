var database = require("../database/config");

function buscarPorId(id) {
  var instrucaoSql = `SELECT * FROM empresa WHERE id = '${id}'`;

  return database.executar(instrucaoSql);
}

function listar() {
  var instrucaoSql = `select idEmpresa, razaoSocial from Empresa;`;

  return database.executar(instrucaoSql);
}

function viewServidoresOrdenados() {
  var instrucaoSql = `select * from viewServidoresOrdenados;`;

  return database.executar(instrucaoSql);
}

function buscarPorCnpj(cnpj) {
  var instrucaoSql = `SELECT * FROM empresa WHERE cnpj = '${cnpj};'`;

  return database.executar(instrucaoSql);
}

function cadastrar(nome, cnpj, email) {
  var instrucaoSql = `insert into Empresa (razaoSocial,cnpj,emailCorporativo) values ('${nome}', '${cnpj}', '${email}');`;

  return database.executar(instrucaoSql);
}


function cadastrarGerente(nome, sobrenome, telefone, email, senha, permissao, empresa) {
  var instrucaoSql = `insert into Funcionario (nome, sobrenome, numerotelefone, email, senha, permissao, fkEmpresa) values ('${nome}', '${sobrenome}','${telefone}', '${email}', '${senha}', '${permissao}', '${empresa}');`;

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

function inativar(idEmpresa) {
  console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n inativar():", idEmpresa);
  var instrucaoSql = `update Empresa set estado = "Inativo" where idEmpresa = ${idEmpresa};`;
  
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function verificarStatusEmpresa(idEmpresa) {
  console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n inativar():", idEmpresa);
  var instrucaoSql = `select estado from Empresa where idEmpresa = ${idEmpresa};`;
  
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


function listarEmpresa(idEmpresa) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n listarFuncionario(): ",idEmpresa)
    var instrucaoSql = `SELECT estado,razaoSocial,cnpj,emailCorporativo FROM Empresa where idEmpresa = ${idEmpresa};`;
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}



function buscarUltimasMedidas() {

  var instrucaoSql = `
SELECT 
    e.razaoSocial AS Empresa,
    SUM(CASE WHEN f.permissao = 'Analista' THEN 1 ELSE 0 END) AS QuantidadeAnalistas,
    SUM(CASE WHEN f.permissao = 'Gerente' THEN 1 ELSE 0 END) AS QuantidadeGerentes
FROM 
    Empresa e
LEFT JOIN 
    Funcionario f ON e.idEmpresa = f.fkEmpresa
GROUP BY 
    e.razaoSocial;
;`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function clickbtn(btnnome, tipomobdes){
  var instrucaoSql = `INSERT INTO site (btnnome, tipomobdes) VALUES ('${btnnome}', '${tipomobdes}')`;
  return database.executar(instrucaoSql);
};

function sitegrafico4() {
  console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n sitegrafico4(): ")
  var instrucaoSql = 
  `SELECT tipomobdes AS tipo_dispositivo, COUNT(*) AS total_interacoes
FROM site
GROUP BY tipomobdes;`

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function sitegrafico1() {
  console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n sitegrafico1(): ")
  var instrucaoSql = 
  `SELECT btnnome, COUNT(*) AS total_cliques
    FROM site
    GROUP BY btnnome
    ORDER BY total_cliques DESC;
`
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function sitegrafico3() {
  console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n sitegrafico1(): ")
  var instrucaoSql = 
  `SELECT DAYOFWEEK(datahora) AS dia_da_semana, COUNT(*) AS total_cliques
FROM site
GROUP BY dia_da_semana
ORDER BY dia_da_semana;
`
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function sitegrafico2() {
  console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n sitegrafico1(): ")
  var instrucaoSql = 
  `SELECT 
    btnnome,
    COUNT(*) AS total_cliques,
    (COUNT(*) * 100.0 / total.total_cliques) AS percentual_cliques
FROM 
    site
CROSS JOIN 
    (SELECT COUNT(*) AS total_cliques FROM site) AS total
GROUP BY 
    btnnome, total.total_cliques;
`
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = { 
  verificarStatusEmpresa,
  buscarUltimasMedidas,
  cadastrarGerente,
  buscarEmpresa, 
  listarEmpresa,
  buscarPorCnpj, 
  sitegrafico4,
  sitegrafico3,
  sitegrafico2,
  sitegrafico1,
  buscarPorId, 
  cadastrar, 
  clickbtn,
  inativar,
  listar, 
  editar,
  viewServidoresOrdenados
 };
