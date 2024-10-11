var empresaModel = require("../models/empresaModel");

function buscarPorCnpj(req, res) {
  var cnpj = req.query.cnpj;

  empresaModel.buscarPorCnpj(cnpj).then((resultado) => {
    res.status(200).json(resultado);
  });
}

function listar(req, res) {
  empresaModel.listar().then((resultado) => {
    res.status(200).json(resultado);
  });
}

function buscarPorId(req, res) {
  var id = req.params.id;

  empresaModel.buscarPorId(id).then((resultado) => {
    res.status(200).json(resultado);
  });
}

function cadastrar(req, res) {
  let nome = req.body.nomeServer
  let cnpj = req.body.cnpjServer
  var email = req.body.emailServer;

  empresaModel.cadastrar(nome,cnpj,email).then((resultado) => {
    res.status(201).json(resultado);
  });
}


function cadastrarGerente(req, res) {
  let nome = req.body.nomeServer
  let sobrenome = req.body.sobrenomeServer
  let telefone = req.body.telefoneServer
  let email = req.body.emailServer;
  let senha = req.body.senhaServer;
  let permissao = req.body.permissaoServer;

  empresaModel.cadastrarGerente(nome, sobrenome, telefone, email, senha, permissao).then((resultado) => {
    res.status(201).json(resultado);
  });
}

module.exports = {
  buscarPorCnpj,
  buscarPorId,
  cadastrar,
  listar,
  cadastrarGerente
};
