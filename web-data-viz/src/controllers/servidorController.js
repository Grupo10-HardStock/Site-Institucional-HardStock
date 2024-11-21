var servidorModel = require("../models/servidorModel"); // Corrigir para o modelo de servidor

function cadastrarServidor(req, res) {
    console.log(req.body);  // Verifique o que está sendo enviado

    var nome = req.body.nomeServer;
    var rede = req.body.redeServer;
    var ram = req.body.ramServer;
    var disco = req.body.discoServer;
    var cpu = req.body.cpuServer;
    var empresa = req.body.empresaServer;

    // Validação dos campos
    if (nome == undefined) {
        return res.status(400).send("O nome do servidor está undefined!");
    } else if (rede == undefined) {
        return res.status(400).send("A rede do servidor está undefined!");
    } else if (ram == undefined) {
        return res.status(400).send("A memória RAM do servidor está undefined!");
    } else if (disco == undefined) {
        return res.status(400).send("O disco do servidor está undefined!");
    } else if (cpu == undefined) {
        return res.status(400).send("A CPU do servidor está undefined!");
    } else if (empresa == undefined) {
        return res.status(400).send("A empresa do servidor está undefined!");
    } else {
        // Passe os valores para o model
        servidorModel.cadastrarServidor(nome, rede, ram, disco, cpu, empresa)
            .then(function (resultado) {
                res.json(resultado);
            })
            .catch(function (erro) {
                console.log("Erro ao realizar o cadastro:", erro);
                res.status(500).json(erro.sqlMessage);
            });
    }
}


function editar(req, res) {
    
    var idServidor = req.params.idServidor;
    var novoNome = req.body.nome;
    var novaRede = req.body.rede;
    var novaRam = req.body.ram;
    var novoDisco = req.body.disco;
    var novaCpu = req.body.cpu_;
    var novoEstado = req.body.estado;

    if (novoNome == "") {
        alert("O campo nome está vazio")
    } else {

        servidorModel.editar(novoNome, novaRede, novaRam, novoDisco, novaCpu, novoEstado, idServidor)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            )
            .catch(
                function (erro) {
                    console.log(erro);
                    console.log("Houve um erro ao realizar o post: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );

    }
}


function deletar(req, res) {
    var idServidor = req.params.idServidor;

    servidorModel.deletar(idServidor)
        .then(
            function (resultado) {
                res.json(resultado);
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao deletar o post: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function porId(req, res) {
    servidorModel.porId(req.params.idServidor).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado[0]);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar os avisos: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function listar(req, res) {
    servidorModel.listar().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar os avisos: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}


module.exports = {
    cadastrarServidor,
    editar,
    deletar,
    listar,
    porId
};

