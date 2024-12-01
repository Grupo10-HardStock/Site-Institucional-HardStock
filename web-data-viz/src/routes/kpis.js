var express = require("express");
var router = express.Router();

var kpiController = require("../controllers/kpiController");

router.get("/buscarTendencias/:periodo", function (req, res) {
    kpiController.buscarTendencias(req, res);
});

router.get("/buscarLimiarCritico/:periodo", function (req, res) {
    kpiController.buscarLimiarCritico(req, res);
});

router.get("/buscarAgregacao/:periodo", function (req, res) {
    kpiController.buscarAgregacao(req, res);
});

router.get("/buscarCorrelacao/:periodo", function (req, res) {
    kpiController.buscarCorrelacao(req, res);
});

module.exports = router;