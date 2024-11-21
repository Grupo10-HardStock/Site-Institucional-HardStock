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
  var cnpj = req.body.cnpj;
  var razaoSocial = req.body.razaoSocial;

  empresaModel.buscarPorCnpj(cnpj).then((resultado) => {
    if (resultado.length > 0) {
      res
        .status(401)
        .json({ mensagem: `a empresa com o cnpj ${cnpj} já existe` });
    } else {
      empresaModel.cadastrar(razaoSocial, cnpj).then((resultado) => {
        res.status(201).json(resultado);
      });
    }
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


module.exports = {
  buscarPorCnpj,
  buscarPorId,
  cadastrar,
  listar,
  // cadastrarGerente,
  buscarEmpresa,
  listarEmpresa,
  editar,
  deletar
};
