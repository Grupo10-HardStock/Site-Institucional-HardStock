var express = require("express");
var router = express.Router();

var avisoController = require("../controllers/avisoController");

router.post("/cadastrar/", function (req, res) {
    avisoController.cadastrar(req, res);
});

router.get("/listarSelect/", function (req, res) {
    avisoController.listarSelect(req, res);
});


router.get("/editarAlerta/", function (req, res) {
    avisoController.editarAlerta(req, res);
});

// router.put("/bala/", function (req, res) {
//     avisoController.editarAlerta(req, res);
// });

router.delete("/inativar/:idAviso", function (req, res) {
    avisoController.inativar(req, res);
});

module.exports = router;