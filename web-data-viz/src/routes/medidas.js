var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:idAquario", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});


router.get("/tempo-real/:idAquario", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})

router.get("/buscarMediasMensais/:periodo", function (req, res) {
    medidaController.buscarMediasMensais(req, res);
});

router.get("/graficoRede", function (req, res) {
    medidaController.graficoRede(req, res);
})

router.get("/graficoRam", function (req, res) {
    medidaController.graficoRam(req, res);
})

router.get("/graficoDisco", function (req, res) {
    medidaController.graficoDisco(req, res);
})

router.get("/graficocpu", function (req, res) {
    medidaController.graficocpu(req, res);
})

router.get("/graficoStatus", function (req, res) {
    medidaController.graficoStatus(req, res);
})


router.get("/tempo-real/:idAquario", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})

router.get("/obterGraficoCpu/", function (req, res) {
    medidaController.obterGraficoCpu(req, res);
})

router.get("/obterGraficoRam/", function (req, res) {
    medidaController.obterGraficoRam(req, res);
})

router.get("/obterGraficoRede/", function (req, res) {
    medidaController.obterGraficoRede(req, res);
})

router.get("/dados_kpi_cpu/", function (req, res) {
    medidaController.dados_kpi_cpu(req, res);
})

router.get("/dados_kpi_ram/", function (req, res) {
    medidaController.dados_kpi_ram(req, res);
})

router.get("/dados_kpi_rede/", function (req, res) {
    medidaController.dados_kpi_rede(req, res);
})

router.get("/obterDadoDisco/", function (req, res) {
    medidaController.obterDadoDisco(req, res);
})
module.exports = router;