var database = require("../database/config");


function buscarTendencias(periodo) {

    var instrucaoSql =
        `
        SELECT 
        ROUND(((media_atual - media_anterior) / media_anterior) * 100, 2) AS variacao_percentual,
        'Bytes Recebidos' AS componente
          FROM (
        SELECT 
        AVG(CASE 
                WHEN WEEK(dataHora) = WEEK(NOW()) 
                     AND dataHora >= NOW() - INTERVAL ${periodo} MONTH 
                THEN valor 
                ELSE NULL 
            END) AS media_atual,
        AVG(CASE 
                WHEN WEEK(dataHora) = WEEK(NOW()) - 1 
                     AND dataHora >= NOW() - INTERVAL ${periodo} MONTH 
                THEN valor 
                ELSE NULL 
            END) AS media_anterior
          FROM Capturas
            WHERE fkComponente = 2 -- ID de Bytes Recebidos
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
    WHERE fkComponente = 1 -- ID de Bytes Enviados
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
    WHERE fkComponente IN (6, 9) -- IDs de Tempo de Leitura do Disco e Velocidade da CPU
    AND dataHora >= NOW() - INTERVAL ${periodo} MONTH
    GROUP BY fkComponente;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarTendencias, buscarLimiarCritico, buscarAgregacao, buscarCorrelacao

}
