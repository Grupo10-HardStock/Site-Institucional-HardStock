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

module.exports = {
    buscarMediasMensais,
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
}
