var express = require("express");
var router = express.Router();

var servidorController = require("../controllers/servidorController");

// Recebendo os dados do html e direcionando para a função cadastrar de servidorController.js
router.post("/cadastrarServidor", function (req, res) {
    servidorController.cadastrarServidor(req, res);
});

router.delete("/inativar/:idServidor", function (req, res) {
    servidorController.inativar(req, res);
});

router.get("/verificarStatusServidor/:idServidor", function (req, res) {
    servidorController.verificarStatusServidor(req, res);
});

router.put("/editar/:idServidor", function (req, res) {
    servidorController.editar(req, res);
});

router.get("/listar", function (req, res) {
    servidorController.listar(req, res);
});

router.get("/porId/:idServidor", (req, res) => {
    servidorController.porId(req, res);
})

module.exports = router;
