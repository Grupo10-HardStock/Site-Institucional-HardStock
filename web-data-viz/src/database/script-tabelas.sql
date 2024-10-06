-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql server
*/

CREATE DATABASE HardStock;
USE HardStock;

CREATE TABLE empresa(
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
	cnpj CHAR(18) NOT NULL, 
    email VARCHAR(80) NOT NULL,
    Senha VARCHAR(50) NOT NULL
);

select * from empresa;


CREATE TABLE funcionario(
    idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    cargo VARCHAR(45) NOT NULL,
    fkEmpresa INT,
    CONSTRAINT fkFuncionarioEmpresa FOREIGN KEY(fkEmpresa)
        REFERENCES empresa(idEmpresa)
);

CREATE TABLE servidor(
    idServidor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    fkEmpresa INT,
    CONSTRAINT fkComputadorEmpresa FOREIGN KEY(fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE componente(
    idComponente INT PRIMARY KEY AUTO_INCREMENT,
    nomeComponente VARCHAR(45) NOT NULL,
    unidadeMedida VARCHAR(45) NOT NULL
);

CREATE TABLE captura (
    fkServidor INT,
    fkComponente INT,
    registro VARCHAR(255) NOT NULL,
    dtHora DATETIME NOT NULL,
    CONSTRAINT fkServidorComponente FOREIGN KEY (fkServidor) REFERENCES servidor (idServidor),
    CONSTRAINT fkComponenteServidor FOREIGN KEY (fkComponente) REFERENCES componente (idComponente),
    PRIMARY KEY (fkServidor, fkComponente, dtHora)
);

CREATE TABLE alerta (
    idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    fkComponente INT,
    fkServidor INT,
    CONSTRAINT fkServidorAlerta FOREIGN KEY (fkServidor) REFERENCES servidor (idServidor),
    CONSTRAINT fkComponenteAlerta FOREIGN KEY (fkComponente) REFERENCES componente (idComponente)
);

CREATE TABLE relatorio (
    idRelatorio INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(255) NOT NULL,
    destinatario VARCHAR(45) NOT NULL,
    fkServidor INT,
    fkComponente INT,
    dtHora DATETIME NOT NULL,
    CONSTRAINT fkServidorRelatorio FOREIGN KEY (fkServidor) REFERENCES servidor (idServidor),
    CONSTRAINT fkComponenteRelatorio FOREIGN KEY (fkComponente) REFERENCES componente (idComponente),
    CONSTRAINT fkCapturaRelatorio FOREIGN KEY (fkServidor, fkComponente, dtHora) REFERENCES captura (fkServidor, fkComponente, dtHora)
);

-- Inserção de componentes
INSERT INTO componente(nomeComponente, unidadeMedida)
VALUES ("CPU", "Porcentagem"), 
       ("Disco", "Porcentagem"), 
       ("Rede", "KB/s"), 
       ("Memória", "Porcentagem");

-- Verificação de componentes inseridos
SELECT * FROM componente;
