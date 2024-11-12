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
  let empresa = req.body.empresaServer;

  empresaModel.cadastrarGerente(nome, sobrenome, telefone, email, senha, permissao, empresa).then((resultado) => {
    res.status(201).json(resultado);
  });
}


function buscarEmpresa(req, res) {

  empresaModel.buscarEmpresa()
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
          console.log("\nHouve um erro ao realizar o buscar Empresas! Erro: ", erro.sqlMessage);
          res.status(500).json({ error: "Houve um erro ao realizar o buscar Empresas!", details: erro.sqlMessage });
      });
}

function editar(req, res) {
  var novoEstado = req.body.Estado;
  var novoNome = req.body.Nome;
  var novoCNPJ = req.body.cnpj;
  var novaEmail = req.body.Email;


  var idEmpresa = req.params.idEmpresa;

  empresaModel.editar(novoEstado, novoNome, novoCNPJ, novaEmail,idEmpresa)
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
  var idEmpresa = req.params.idEmpresa;

  empresaModel.deletar(idEmpresa)
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


function listarEmpresa(req, res) {
  var idEmpresa = req.params.idEmpresa;

  empresaModel.listarEmpresa(idEmpresa)
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

function buscarUltimasMedidas(req, res) {

  console.log(`Recuperando as ultimas medidas`);

  empresaModel.buscarUltimasMedidas().then(function (resultado) {
      if (resultado.length > 0) {
          res.status(200).json(resultado);
      } else {
          res.status(204).send("Nenhum resultado encontrado!")
      }
  }).catch(function (erro) {
      console.log(erro);
      console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
      res.status(500).json(erro.sqlMessage);
  });
}


module.exports = {
  buscarPorCnpj,
  buscarPorId,
  cadastrar,
  listar,
  cadastrarGerente,
  buscarEmpresa,
  listarEmpresa,
  editar,
  deletar,
  buscarUltimasMedidas
};
