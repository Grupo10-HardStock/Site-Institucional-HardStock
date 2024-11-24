var express = require("express");
var router = express.Router();

var empresaController = require("../controllers/empresaController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrar", function (req, res) {
    empresaController.cadastrar(req, res);
})

router.post("/cadastrarGerente", function (req, res) {
    empresaController.cadastrarGerente(req, res);
})

router.get("/buscar", function (req, res) {
    empresaController.buscarPorCnpj(req, res);
});

router.get("/buscar/:id", function (req, res) {
  empresaController.buscarPorId(req, res);
});

router.get("/listar", function (req, res) {
  empresaController.listar(req, res);
});

router.get("/buscarEmpresa/", function (req, res) {
  empresaController.buscarEmpresa(req, res);
})

router.put("/editar/:idEmpresa", function (req, res) {
  empresaController.editar(req, res);
});

router.delete("/inativar/:idEmpresa", function (req, res) {
  empresaController.inativar(req, res);
});

router.get("/verificarStatusEmpresa/:idEmpresa", function (req, res) {
  empresaController.verificarStatusEmpresa(req, res);
});

router.get("/listarEmpresa/:idEmpresa", function (req, res) {
  empresaController.listarEmpresa(req, res);
})

router.get("/buscarUltimasMedidas/", function (req, res) {
  empresaController.buscarUltimasMedidas(req, res);
});

router.post("/clickbtn", function (req, res) {
  empresaController.clickbtn(req, res);
})

router.get("/sitegrafico4", function (req, res) {
  empresaController.sitegrafico4(req, res);
})

router.get("/sitegrafico3", function (req, res) {
  empresaController.sitegrafico3(req, res);
})

router.get("/sitegrafico2", function (req, res) {
  empresaController.sitegrafico2(req, res);
})

router.get("/sitegrafico1", function (req, res) {
  empresaController.sitegrafico1(req, res);
})


module.exports = router;
