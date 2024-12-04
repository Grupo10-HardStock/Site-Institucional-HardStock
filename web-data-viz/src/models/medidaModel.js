var database = require("../database/config");

function buscarUltimasMedidas(idAquario, limite_linhas) {

    var instrucaoSql = `SELECT 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        momento,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico
                    FROM Medida
                    WHERE fk_aquario = ${idAquario}
                    ORDER BY id DESC LIMIT ${limite_linhas}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


function buscarMediasMensais(periodo) {

    var instrucaoSql = `SELECT
    c.nome AS componente,
    c.idComponente AS componente_id,
    DATE_FORMAT(cp.dataHora, '%Y-%m') AS mes_ano, -- Apenas mês e ano
    ROUND(AVG(cp.valor), 2) AS media_valor, -- Média arredondada para 2 casas decimais
    c.unidadeMedida AS unidade -- Adicionando a unidade de medida
FROM
    Capturas cp
JOIN
    Componentes c ON cp.fkComponente = c.idComponente
WHERE
    c.idComponente IN (1, 2, 6, 9, 11) -- IDs dos componentes
    AND cp.dataHora >= DATE_SUB(CURDATE(), INTERVAL ${periodo} MONTH) -- Intervalo dos meses
    AND cp.dataHora <= CURDATE() -- Garantir que os dados não ultrapassem a data atual
GROUP BY
    c.idComponente,
    mes_ano -- Agrupando por mês e ano (sem hora)
ORDER BY
    c.idComponente, mes_ano;

`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function graficoRede() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n graficoRede(): ")
    var instrucaoSql =
        `
    SELECT rede, count(rede) as 'Votos' FROM Servidor GROUP BY rede;

  `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function graficoRam() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n graficoRede(): ")
    var instrucaoSql =
        `
    SELECT ram, count(ram) as 'Votos' FROM Servidor GROUP BY ram;

  `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function graficoDisco() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n graficoRede(): ")
    var instrucaoSql =
        `
    SELECT disco, count(disco) as 'Votos' FROM Servidor GROUP BY disco;

  `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function graficocpu() {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n graficoRede(): ")
    var instrucaoSql =
        `
    SELECT cpu, count(cpu) as 'Votos' FROM Servidor GROUP BY cpu;

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


function graficoAlerta(selecao) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n graficoRede(): ")
    var instrucaoSql =
      `
  SELECT 
      componente AS 'alerta', 
      COUNT(componente) AS 'Votos'
  FROM 
      Alertas
  WHERE 
      dataCriacao >= DATE_SUB(CURDATE(), INTERVAL ${selecao} MONTH) 
  GROUP BY 
      componente
  ORDER BY 
      Votos DESC;
  
    `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
  }
  
  
  
  function dadosKpi(selecao) {
    console.log("Obtendo o servidor com mais alertas...");
  
    var instrucaoSqlServidor = `
  SELECT 
      s.nome AS 'NomeServidor',
      COUNT(a.idAlerta) AS 'QuantidadeTotalDeAlertas',
      (SELECT 
          a2.componente 
       FROM 
          Alertas a2 
       WHERE 
          a2.fkServidor = s.idServidor 
          AND a2.dataCriacao >= DATE_SUB(CURDATE(), INTERVAL ${selecao} MONTH)  -- Filtro de tempo (últimos 6 meses)
       GROUP BY 
          a2.componente 
       ORDER BY 
          COUNT(a2.idAlerta) DESC 
       LIMIT 1
      ) AS 'ComponenteMaisAfetado'
  FROM 
      Servidor s
  JOIN 
      Alertas a ON a.fkServidor = s.idServidor
  WHERE 
      a.dataCriacao >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)  -- Filtro de tempo (últimos 6 meses)
  GROUP BY 
      s.idServidor, s.nome
  ORDER BY 
      QuantidadeTotalDeAlertas DESC
  LIMIT 1;
  
    `;
  
    console.log("Executando SQL para servidor:\n" + instrucaoSqlServidor);
  
    return database.executar(instrucaoSqlServidor);
  }
  
  
  
  function graficoServidores(selecao) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n graficoRede(): ")
    var instrucaoSql =
      `
      SELECT 
      s.nome AS NomeServidor,
      COUNT(a.idAlerta) AS QuantidadeTotalDeAlertas
  FROM 
      Alertas a
  JOIN 
      Servidor s ON a.fkServidor = s.idServidor
  WHERE 
      a.dataCriacao >= DATE_SUB(CURDATE(), INTERVAL ${selecao} MONTH)
  GROUP BY 
      s.idServidor, s.nome
  ORDER BY 
      QuantidadeTotalDeAlertas DESC;
    `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
  }
  
  
  
  function graficoStatus(selecao) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n graficoRede(): ")
    var instrucaoSql =
      `
      SELECT 
      estado, 
      COUNT(estado) AS 'Votos'
  FROM 
      Servidor
  WHERE 
      dataCriacao >= DATE_SUB(CURDATE(), INTERVAL ${selecao} MONTH)  -- Supondo que exista o campo dataCriacao
  GROUP BY 
      estado
  ORDER BY 
      'Votos' DESC;
  
    `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
  }
  

module.exports = {
    buscarMediasMensais,
    graficoRede,
    graficoRam,
    graficoDisco,
    graficocpu,
    dados_kpi_cpu,
    dados_kpi_ram,
    dados_kpi_rede,
    obterGraficoCpu,
    obterGraficoRam,
    obterGraficoRede,
    obterDadoDisco,
    graficoStatus,
    graficoAlerta,
    graficoServidores,
    dadosKpi
}
