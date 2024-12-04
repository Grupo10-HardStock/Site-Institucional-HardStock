var database = require("../database/config");


function buscarTendencias(periodo) {

    var instrucaoSql =
        `
   SELECT 
    ROUND(((media_atual - media_anterior) / media_anterior) * 100, 2) AS variacao_percentual,
    'Bytes Recebidos' AS componente
FROM (
    SELECT 
        -- Última semana dentro do intervalo de tempo selecionado
        (SELECT AVG(valor)
         FROM Capturas
         WHERE fkComponente = 2
           AND YEARWEEK(dataHora, 1) = (
               SELECT MAX(YEARWEEK(dataHora, 1)) 
               FROM Capturas 
               WHERE fkComponente = 2
                 AND dataHora >= DATE_ADD(CURDATE(), INTERVAL -${periodo} MONTH)
           )
           AND dataHora >= DATE_ADD(CURDATE(), INTERVAL -${periodo} MONTH)) AS media_atual,

        -- Penúltima semana dentro do intervalo de tempo selecionado
        (SELECT AVG(valor)
         FROM Capturas
         WHERE fkComponente = 2
           AND YEARWEEK(dataHora, 1) = (
               SELECT MAX(YEARWEEK(dataHora, 1)) - 1
               FROM Capturas
               WHERE fkComponente = 2
                 AND dataHora >= DATE_ADD(CURDATE(), INTERVAL -${periodo} MONTH)
           )
           AND dataHora >= DATE_ADD(CURDATE(), INTERVAL -${periodo} MONTH)) AS media_anterior
) AS medias;

    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarLimiarCritico(periodo) {

    var instrucaoSql =
        `
        SELECT 
            COUNT(*) AS ocorrencias_criticas
        FROM Capturas
        WHERE fkComponente = 6 -- ID de Tempo de Leitura do Disco
        AND valor > 40 -- Limite crítico em ms
        AND dataHora >= NOW() - INTERVAL ${periodo} MONTH;    
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarAgregacao(periodo) {

    var instrucaoSql =
    `
        SELECT 
        SUM(valor) AS total_bytes_enviados
    FROM Capturas
    WHERE fkComponente = 1
    AND dataHora >= NOW() - INTERVAL ${periodo} MONTH;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarCorrelacao(periodo) {

    var instrucaoSql =
    `
        SELECT 
        AVG(valor) AS media_valor,
        fkComponente
    FROM Capturas
    WHERE fkComponente IN (6, 9) 
    AND dataHora >= NOW() - INTERVAL ${periodo} MONTH
    GROUP BY fkComponente;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarTendencias, buscarLimiarCritico, buscarAgregacao, buscarCorrelacao

}
