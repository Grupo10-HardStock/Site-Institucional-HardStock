var medidaModel = require("../models/medidaModel");

function buscarUltimasMedidas(req, res) {

    const limite_linhas = 7;

    var idAquario = req.params.idAquario;

    console.log(`Recuperando as ultimas ${limite_linhas} medidas`);

    medidaModel.buscarUltimasMedidas(idAquario, limite_linhas).then(function (resultado) {
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



function buscarMediasMensais(req, res) {

    var periodo = req.params.periodo;
    
    medidaModel.buscarMediasMensais(periodo).then(function (resultado) {
        if (resultado.length > 0) {
            console.log(resultado)
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

function graficoRede( req , res) {
    medidaModel.graficoRede()
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

  function graficoRam( req , res) {
    medidaModel.graficoRam()
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

  function graficoDisco( req , res) {
    medidaModel.graficoDisco()
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

  function graficocpu( req , res) {
    medidaModel.graficocpu()
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

  
  function obterGraficoCpu(req, res) {
    const idServidor = req.query.idServidor;
    console.log(`Pegando dados em porcentagem de uso do CPU`);
    medidaModel.obterGraficoCpu(idServidor).then(function(resultado) {
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
function obterGraficoRam(req, res) {
    const idServidor = req.query.idServidor;
    console.log(`Pegando dados em porcentagem de uso de RAM`);
    medidaModel.obterGraficoRam(idServidor).then(function(resultado) {
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

function obterDadoDisco(req, res) {
    const idServidor = req.query.idServidor;
    console.log(`Pegando dados do disco`);
    medidaModel.obterDadoDisco(idServidor).then(function (resultado) {
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

function obterGraficoRede(req, res) {
    const idServidor = req.query.idServidor;
    console.log(`Pegando dados em porcentagem de uso de Rede`);
    medidaModel.obterGraficoRede(idServidor).then(function(resultado) {
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


function dados_kpi_cpu(req, res) {

    console.log(`Pegando dados em porcentagem de uso do CPU`);
    
    medidaModel.dados_kpi_cpu().then(function (resultado) {
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

function dados_kpi_ram(req, res) {

    console.log(`Pegando dados em porcentagem de uso de RAM`);

    medidaModel.dados_kpi_ram().then(function (resultado) {
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

function dados_kpi_rede(req, res) {
    
    console.log(`Pegando dados em porcentagem de uso do CPU`);
    
    medidaModel.dados_kpi_rede().then(function (resultado) {
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

function graficoAlerta( req , res) {
  var selecao = req.params.selecao;

  medidaModel.graficoAlerta(selecao)
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


  function graficoServidores(req, res) {
    var selecao = req.params.selecao;


    medidaModel.graficoServidores(selecao)
      .then(resultadoAutenticar => {
        console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
        console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`);
    
        if (resultadoAutenticar.length > 0) {
          res.status(200).json(resultadoAutenticar);
        } else {
          console.log("Nenhum dado encontrado no banco.");
          res.status(200).json([]);  
        }
      })
      .catch(erro => {
        console.log(erro);
        console.log("\nHouve um erro ao realizar a busca de servidores! Erro: ", erro.sqlMessage);
        res.status(500).json({ error: "Houve um erro ao realizar a busca de servidores!", details: erro.sqlMessage });
      });
  }
  



  function graficoStatus( req , res) {
    var selecao = req.params.selecao;


    medidaModel.graficoStatus(selecao)
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


  function dadosKpi(req, res) {

    var selecao = req.params.selecao;


    console.log(`Pegando dados em porcentagem de uso do CPU`);
    
    medidaModel.dadosKpi(selecao).then(function (resultado) {
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
    buscarUltimasMedidas,
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