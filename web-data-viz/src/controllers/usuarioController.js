var usuarioModel = require("../models/usuarioModel");

function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {
        usuarioModel.autenticar(email, senha)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); 

                    if (resultadoAutenticar.length == 1) {
                        console.log(resultadoAutenticar);

                        res.json({
                            id: resultadoAutenticar[0].idFuncionario,
                            nome: resultadoAutenticar[0].nome,
                            email: resultadoAutenticar[0].email,
                            permissao: resultadoAutenticar[0].permissao,
                            fkEmpresa: resultadoAutenticar[0].fkEmpresa,
                            status:  resultadoAutenticar[0].estado
                        });

                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function cadastrar(req, res) {
    var nome = req.body.nomeServer;
    var cnpj = req.body.cnpjServer
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } else if (cnpj == undefined) {
        res.status(400).send("Seu CNPJ está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    } else {

        
        usuarioModel.cadastrar(nome, cnpj, email, senha)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

function cadastrarFuncionario(req, res) {
    
    var nome = req.body.nomeServer
    var sobrenome = req.body.sobrenomeServer
    var telefone = req.body.telefoneServer
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;
    var permissao = req.body.permissaoServer;
    var empresa = req.body.empresaServer;
    

    
    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } else if (sobrenome == undefined) {
        res.status(400).send("Seu sobrenome está undefined!");
    } else if (telefone == undefined) {
        res.status(400).send("Seu telefone está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    } else if (permissao == undefined) {
        res.status(400).send("Sua permissao está undefined!");
    } else if (empresa == undefined) {
        res.status(400).send("Sua empresa está undefined!");
    } else {
        
        usuarioModel.cadastrarFuncionario(nome, sobrenome, telefone, email, senha, permissao, empresa)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}


function buscarFuncionario(req, res) {
    var fkEmpresa = req.params.fkEmpresa

    usuarioModel.buscarFuncionario(fkEmpresa)
        .then(resultadoAutenticar => {
            console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
            console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`);

            if (resultadoAutenticar.length > 0) {
                res.status(200).json(resultadoAutenticar);
            } else {
                res.status(200).json([]);
            }
        })
        .catch(erro => {
            console.log(erro);
            console.log("\nHouve um erro ao realizar o buscar Funcionarios! Erro: ", erro.sqlMessage);
            res.status(500).json({ error: "Houve um erro ao realizar o buscar Funcionarios!", details: erro.sqlMessage });
        });
}

function listarFuncionario(req, res) {
    var idFuncionario = req.params.idFuncionario;

    usuarioModel.listarFuncionario(idFuncionario)
        .then(resultadoAutenticar => {
            console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
            console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`);

            if (resultadoAutenticar.length > 0) {
                res.status(200).json(resultadoAutenticar);
            } else {
                res.status(200).json([]);
            }
        })
        .catch(erro => {
            console.log(erro);
            console.log("\nHouve um erro ao listar detalhes do Funcionario! Erro: ", erro.sqlMessage);
            res.status(500).json({ error: "Houve um erro ao realizar o buscar Funcionarios!", details: erro.sqlMessage });
        });
}

function editar(req, res) {
    var nome = req.body.nome;
    var sobrenome = req.body.sobrenome;
    var telefone = req.body.telefone;
    var email = req.body.email;
    var senha = req.body.senha;
    var permissao = req.body.permissao;
    var estado = req.body.estado;
    var idFuncionario = req.params.idFuncionario;


    usuarioModel.editar(nome,sobrenome,telefone,email,senha,permissao,estado, idFuncionario)
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


function deletar(req, res) {
    var idFuncionario = req.params.idFuncionario;

    usuarioModel.deletar(idFuncionario)
        .then(
            function (resultado) {
                res.json(resultado);
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao deletar o Funcionario: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function verificarStatus(req, res) {
    var idFuncionario = req.params.idFuncionario;

    usuarioModel.verificarStatus(idFuncionario)
        .then(
            function (resultado) {
                res.json(resultado);
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao buscar sobre o Funcionario: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function enviarMensagem(req, res) {
    var nome = req.body.nomeServer;
    var email = req.body.emailServer;
    var Mensagem = req.body.menssagemServer;

    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    }else if (email == undefined) {
        res.status(400).send("Seu Email está undefined!");
    }else if (Mensagem == undefined) {
        res.status(400).send("Sua menssagem está undefined!");
    } else {

        usuarioModel.enviarMensagem(nome, email, Mensagem)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar a redefinição! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
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
}