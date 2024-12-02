var kpiModel = require("../models/kpiModel");


function buscarTendencias(req, res) {

  var periodo = req.params.periodo;
  
  kpiModel.buscarTendencias(periodo).then(function (resultado) {
    console.log(resultado)
      if (resultado.length > 0) {
          console.log(resultado)
          res.status(200).json(resultado);
      } else {
          res.status(204).send("Nenhum resultado encontrado!")
      }
  }).catch(function (erro) {
      console.log(erro);
      console.log("Houve um erro ao buscar as tendências.", erro.sqlMessage);
      res.status(500).json(erro.sqlMessage);
  });
}


function buscarLimiarCritico(req, res) {

  var periodo = req.params.periodo;
  
  kpiModel.buscarLimiarCritico(periodo).then(function (resultado) {
      if (resultado.length > 0) {
          console.log(resultado)
          res.status(200).json(resultado);
      } else {
          res.status(204).send("Nenhum resultado encontrado!")
      }
  }).catch(function (erro) {
      console.log(erro);
      console.log("Houve um erro ao buscar Limiares Críticos.", erro.sqlMessage);
      res.status(500).json(erro.sqlMessage);
  });
}


function buscarAgregacao(req, res) {

  var periodo = req.params.periodo;
  
  kpiModel.buscarAgregacao(periodo).then(function (resultado) {
      if (resultado.length > 0) {
          console.log(resultado)
          res.status(200).json(resultado);
      } else {
          res.status(204).send("Nenhum resultado encontrado!")
      }
  }).catch(function (erro) {
      console.log(erro);
      console.log("Houve um erro ao buscar Agregacao.", erro.sqlMessage);
      res.status(500).json(erro.sqlMessage);
  });
}


function buscarCorrelacao(req, res) {

  var periodo = req.params.periodo;
  
  kpiModel.buscarCorrelacao(periodo).then(function (resultado) {
      if (resultado.length > 0) {
          console.log(resultado)
          res.status(200).json(resultado);
      } else {
          res.status(204).send("Nenhum resultado encontrado!")
      }
  }).catch(function (erro) {
      console.log(erro);
      console.log("Houve um erro ao buscar correlação.", erro.sqlMessage);
      res.status(500).json(erro.sqlMessage);
  });
}

module.exports = {
  buscarTendencias,
  buscarLimiarCritico,
  buscarAgregacao,
  buscarCorrelacao
}