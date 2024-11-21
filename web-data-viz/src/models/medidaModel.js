var database = require("../database/config");

function buscarUltimasMedidas(idAquario, limite_linhas) {

    var instrucaoSql = `SELECT 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        momento,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico
                    FROM medida
                    WHERE fk_aquario = ${idAquario}
                    ORDER BY id DESC LIMIT ${limite_linhas}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idAquario) {

    var instrucaoSql = `SELECT 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico, 
                        fk_aquario 
                        FROM medida WHERE fk_aquario = ${idAquario} 
                    ORDER BY id DESC LIMIT 1`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMediasMensais(periodo) {

    var instrucaoSql = `SELECT 
    c.nome AS componente,
    DATE_FORMAT(cp.dataHora, '%Y-%m') AS mes_ano,
    AVG(cp.valor) AS media_valor
FROM 
    Capturas cp
JOIN 
    Componentes c ON cp.fkComponente = c.idComponente
WHERE 
    c.nome IN ('Bytes Recebidos', 'Bytes Enviados', 'Uso do Disco Usado', 'Uso do Disco Total', 'Uso da CPU', 'Memória Usada')
    AND cp.dataHora >= DATE_SUB(CURDATE(), INTERVAL ${periodo} MONTH)
GROUP BY 
    c.nome, 
    DATE_FORMAT(cp.dataHora, '%Y-%m')
ORDER BY 
    c.nome, mes_ano;
`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function graficoRede() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n graficoRede(): ")
    var instrucaoSql =
        `
    SELECT rede, count(rede) as 'Votos' FROM servidor GROUP BY rede;

  `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function graficoRam() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n graficoRede(): ")
    var instrucaoSql =
        `
    SELECT ram, count(ram) as 'Votos' FROM servidor GROUP BY ram;

  `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function graficoDisco() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n graficoRede(): ")
    var instrucaoSql =
        `
    SELECT disco, count(disco) as 'Votos' FROM servidor GROUP BY disco;

  `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function graficocpu() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n graficoRede(): ")
    var instrucaoSql =
        `
    SELECT cpu, count(cpu) as 'Votos' FROM servidor GROUP BY cpu;

  `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function graficoStatus() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n graficoRede(): ")
    var instrucaoSql =
        `
    SELECT estado, count(estado) as 'Votos' FROM servidor GROUP BY estado;

  `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function obterGraficoCpu(idServidor) {
    var instrucaoSql = `SELECT * FROM dadosGraficoCpu WHERE fkServidor = ${idServidor} limit 10;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function obterGraficoRam(idServidor) {
    var instrucaoSql = `select * from dadosGraficoRam WHERE fkServidor = ${idServidor} limit 10;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function obterGraficoRede(idServidor) {
    var instrucaoSql = `select * from dadosGraficoRede where fkServidor = ${idServidor} limit 10;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function obterDadoDisco(idServidor) {
    var instrucaoSql = `select * from dadosGraficoDisco where fkServidor = ${idServidor} limit 1;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function dados_kpi_cpu() {
    var instrucaoSql = 'select * from capturasCpu;';
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}
function dados_kpi_ram() {
    var instrucaoSql = 'select * from capturasRam;';
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}
function dados_kpi_rede() {
    var instrucaoSql = 'select * from capturasRede;';
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarMediasMensais,
    buscarUltimasMedidas,
    graficoRede,
    graficoRam,
    graficoDisco,
    graficocpu,
    graficoStatus,
    dados_kpi_cpu,
    dados_kpi_ram,
    dados_kpi_rede,
    obterGraficoCpu,
    obterGraficoRam,
    obterGraficoRede,
    obterDadoDisco
}
