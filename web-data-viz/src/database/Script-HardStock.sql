-- Criando a base de dados HardStock
CREATE DATABASE IF NOT EXISTS HardStock;

-- Usando a base de dados criada
USE HardStock;

CREATE TABLE IF NOT EXISTS Funcionario (
    idFuncionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    sobrenome VARCHAR(100),
    numeroTelefone char(16),
    email VARCHAR(256),
    senha VARCHAR(256),
    permissao VARCHAR(45),
    fkEmpresa INT,
    estado varchar(45) default "Ativo"
);

-- Tabela Empresa para armazenar informações da empresa
CREATE TABLE IF NOT EXISTS Empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    razaoSocial VARCHAR(256),
    cnpj CHAR(20),
    emailCorporativo VARCHAR(256),
    estado VARCHAR(45) DEFAULT 'Ativo'
);

-- Tabela Especificacoes para armazenar detalhes técnicos de servidores
CREATE TABLE IF NOT EXISTS Servidor (
    idServidor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    rede VARCHAR(50),
    ram VARCHAR(20),
    disco VARCHAR(20),
    `cpu` VARCHAR(20),
    fkEmpresa INT,
    estado varchar(45) default "Ativo",
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);


CREATE TABLE IF NOT EXISTS Componentes (
    idComponente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL, -- Nome do componente (e.g., CPU Uso, Memória RAM)
    unidadeMedida VARCHAR(20) NOT NULL, -- Unidade de medida (e.g., %, GB)
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE IF NOT EXISTS mensagem (
    idMensagem INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(128) not null,
    email VARCHAR(256) not null, 
    mensagem VARCHAR(512)
);

  CREATE TABLE site (
    id INT AUTO_INCREMENT PRIMARY KEY,
    btnNome VARCHAR(255) NOT NULL, 
    dataHora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tipoMobDes VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Capturas (
    idCaptura INT AUTO_INCREMENT PRIMARY KEY,
    dataHora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Data e hora da captura
    valor FLOAT NOT NULL, -- Valor capturado (e.g., 75.5)
    fkComponente INT, -- Referência ao componente capturado
    fkServidor INT, -- Referência ao servidor,
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    FOREIGN KEY (fkComponente) REFERENCES Componentes(idComponente),
    FOREIGN KEY (fkServidor) REFERENCES Servidor(idServidor)
);

ALTER TABLE Capturas
MODIFY COLUMN dataHora DATETIME NOT NULL;

-- Tabela Alertas para registrar alertas associados às capturas
CREATE TABLE IF NOT EXISTS Alertas (
    idAlerta INT AUTO_INCREMENT PRIMARY KEY,
    nomeAlerta varchar (250),
    alerta INT,
    parametro ENUM('normal', 'alerta', 'critico', 'severo'),
    componente ENUM('rede', 'ram', 'disco', 'cpu'),
    dataCriacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fkServidor INT,
    FOREIGN KEY (fkServidor) REFERENCES Servidor(idServidor)
);
 
 alter table Funcionario add constraint ligacao foreign key (fkEmpresa) references Empresa(idEmpresa);

CREATE
DEFINER=CURRENT_USER SQL SECURITY INVOKER
VIEW VizFunc AS
SELECT idFuncionario,nome,sobrenome,email,fkEmpresa,permissao,estado FROM Funcionario;

 CREATE
DEFINER=CURRENT_USER SQL SECURITY INVOKER
VIEW VizEdit AS
SELECT idFuncionario,nome,sobrenome,numeroTelefone,email,senha, permissao, estado FROM Funcionario; 

CREATE OR REPLACE VIEW capturasCpu AS
SELECT Capturas.valor
FROM Capturas
WHERE Capturas.fkComponente = 3 AND Capturas.fkServidor = 1 limit 1;

CREATE OR REPLACE VIEW capturasRam AS
SELECT Capturas.valor
FROM Capturas
WHERE Capturas.fkComponente = 14 AND Capturas.fkServidor = 1 limit 1;

 CREATE OR REPLACE VIEW capturasRede AS
SELECT Capturas.valor
FROM Capturas
WHERE Capturas.fkComponente = 1 AND Capturas.fkServidor = 1 limit 1;


CREATE OR REPLACE VIEW dadosGraficoCpu AS
SELECT 
    c1.dataHora,
    c1.valor AS usoCpu,
    c2.valor AS velocidadeCpu,
    c1.fkServidor
FROM Capturas c1
JOIN Capturas c2 ON c1.fkServidor = c2.fkServidor AND c2.fkComponente = 
(SELECT idComponente FROM Componentes WHERE nome = 'Velocidade da CPU')
WHERE c1.fkComponente = (SELECT idComponente FROM Componentes WHERE nome = 'Uso da CPU') ORDER BY c1.dataHora;

CREATE OR REPLACE VIEW dadosGraficoRede AS
SELECT 
    c1.dataHora,
    c1.valor AS bytesEnviados,
    c2.valor AS bytesRecebidos,
    c1.fkServidor
FROM Capturas c1
JOIN Capturas c2 ON c1.fkServidor = c2.fkServidor 
    AND c1.dataHora = c2.dataHora
WHERE c1.fkComponente = (SELECT idComponente FROM Componentes WHERE nome = 'Bytes Enviados')
  AND c2.fkComponente = (SELECT idComponente FROM Componentes WHERE nome = 'Bytes Recebidos')
ORDER BY c1.dataHora;

CREATE OR REPLACE VIEW dadosGraficoDisco AS
SELECT 
    c1.dataHora,
    ROUND(c1.valor) AS usoDiscoTotal, 
    ROUND(c2.valor) AS usoDiscoUsado,  
    c1.fkServidor
FROM Capturas c1
JOIN Capturas c2 ON c1.fkServidor = c2.fkServidor 
    AND c1.dataHora = c2.dataHora
WHERE c1.fkComponente = (SELECT idComponente FROM Componentes WHERE nome = 'Uso do Disco Total')
  AND c2.fkComponente = (SELECT idComponente FROM Componentes WHERE nome = 'Uso do Disco Usado')
ORDER BY c1.dataHora;

CREATE OR REPLACE VIEW dadosGraficoRam AS
SELECT 
    c1.dataHora,
    c1.valor AS porcMemoriaUsada,
    c2.valor AS numProcessos,
    c1.fkServidor
FROM Capturas c1
JOIN Capturas c2 ON c1.fkServidor = c2.fkServidor 
    AND c1.dataHora = c2.dataHora
WHERE c1.fkComponente = (SELECT idComponente FROM Componentes WHERE nome = 'Porcentagem de Memória Usada')
  AND c2.fkComponente = (SELECT idComponente FROM Componentes WHERE nome = 'Número de Processos')
ORDER BY c1.dataHora;

CREATE OR REPLACE VIEW selectAlerta AS
SELECT 
    idAlerta,
    nomeAlerta,
    parametro
FROM 
    Alertas;
    
INSERT INTO Componentes (nome, unidadeMedida) VALUES 
('Bytes Enviados', 'MB'),
('Bytes Recebidos', 'MB'),
('Uso da CPU', '%'),
('Uso do Disco Total', 'GB'),
('Uso do Disco Usado', 'GB'),
('Tempo de Leitura do Disco', 'ms'),
('Memória Total', 'GB'),
('Memória Usada', 'GB'),
('Velocidade da CPU', 'MHz'),
('Porcentagem de Memória Usada', '%'),
('Número de Threads', 'Num');

-- Inserindo um registro na tabela Empresa
INSERT INTO Empresa (razaoSocial, cnpj, emailCorporativo) VALUES 
('HardStock', '00.623.904/0001-73', 'contato.hardstock@hardstock.com'),
('B3', '00.623.904/0001-71', 'contato.b3@b3.com');

-- Inserindo um registro na tabela Funcionario
INSERT INTO Funcionario (nome, sobrenome, numeroTelefone, email, senha, permissao,fkEmpresa) VALUES 
('Felipe', 'Amorim', '(11) 91234-5678', 'felipe.amorim@hardstock.com', '123456789', 'Hardstock',1),
('Felipe', 'Amorim', '(11) 91234-5678', 'felipe@hardstock.com', '123456789', 'Gerente',1),
('Pedro', 'Souza', '(11) 91234-6789', 'pedro.sozua@b3.com', '123456789', 'Gerente',2),
('Pedro', 'Henrique', '(11) 91234-1234', 'pedro.henrique@b3.com', '123456789', 'Gerente',2),
('Eli', 'Rufino', '(11) 91234-4321', 'eli.rufino@b3.com', '123456789', 'Analista',2);

-- Inserindo um registro na tabela Servidor
insert into servidor(nome,rede,ram,disco,cpu,fkEmpresa) values ("Servidor 11° andar", "LAN","4GB","256GB","4 Núcleos",1);

INSERT INTO mensagem (nome, email, mensagem) VALUES
('Maria Silva', 'maria.silva@example.com', 'Gostaria de saber mais sobre os serviços oferecidos.'),
('João Santos', 'joao.santos@example.com', 'Qual o horário de atendimento da empresa?'),
('Ana Costa', 'ana.costa@example.com', 'Preciso de suporte para acessar minha conta.'),
('Carlos Almeida', 'carlos.almeida@example.com', 'Como faço para alterar meus dados cadastrais?'),
('Mariana Oliveira', 'mariana.oliveira@example.com', 'Estou interessada nos produtos da empresa.'),
('Pedro Souza', 'pedro.souza@example.com', 'Tenho uma dúvida sobre o funcionamento do sistema.'),
('Fernanda Lima', 'fernanda.lima@example.com', 'Gostaria de um orçamento personalizado.'),
('Lucas Pereira', 'lucas.pereira@example.com', 'Quais são as formas de pagamento disponíveis?'),
('Bruna Torres', 'bruna.torres@example.com', 'Existe algum tipo de treinamento oferecido pela empresa?'),
('Gabriel Martins', 'gabriel.martins@example.com', 'Estou enfrentando problemas com a plataforma.');

INSERT INTO site (btnnome, datahora, tipomobdes) VALUES
('home', '2024-11-12 08:45:00', 'desktop'),    -- Domingo
('solucao', '2024-11-13 10:30:00', 'desktop'), -- Segunda-feira
('sobre', '2024-11-14 14:50:00', 'desktop'),   -- Terça-feira
('mvv', '2024-11-15 09:15:00', 'desktop'),     -- Quarta-feira
('contato', '2024-11-16 16:00:00', 'desktop'), -- Quinta-feira
('login.html', '2024-11-17 19:05:00', 'desktop'), -- Sexta-feira
('home', '2024-11-18 11:30:00', 'desktop'),    -- Sábado
('home', '2024-11-12 08:45:00', 'desktop'),
('solucao', '2024-11-13 10:30:00', 'desktop'),
('sobre', '2024-11-14 14:50:00', 'desktop'),
('mvv', '2024-11-15 09:15:00', 'desktop'),
('contato', '2024-11-16 16:00:00', 'desktop'),
('login.html', '2024-11-17 19:05:00', 'desktop'),
('home', '2024-11-18 11:30:00', 'desktop'),
('solucao', '2024-11-12 13:10:00', 'mobile'),
('sobre', '2024-11-13 17:45:00', 'desktop'),
('mvv', '2024-11-14 09:30:00', 'mobile'),
('contato', '2024-11-15 20:05:00', 'desktop'),
('login.html', '2024-11-16 07:50:00', 'mobile'),
('home', '2024-11-17 18:20:00', 'desktop'),
('solucao', '2024-11-18 10:40:00', 'mobile'),
('sobre', '2024-11-12 15:00:00', 'desktop'),
('mvv', '2024-11-13 12:30:00', 'desktop'),
('contato', '2024-11-14 16:10:00', 'mobile'),
('login.html', '2024-11-15 08:55:00', 'desktop'),
('home', '2024-11-16 14:25:00', 'mobile'),
('solucao', '2024-11-17 17:30:00', 'desktop'),
('sobre', '2024-11-18 12:15:00', 'mobile'),
('mvv', '2024-11-12 09:00:00', 'desktop'),
('contato', '2024-11-13 18:05:00', 'desktop'),
('login.html', '2024-11-14 11:20:00', 'mobile'),
('home', '2024-11-15 14:45:00', 'desktop'),
('solucao', '2024-11-16 10:10:00', 'mobile'),
('sobre', '2024-11-17 13:40:00', 'desktop'),
('mvv', '2024-11-18 09:50:00', 'desktop'),
('contato', '2024-11-12 16:30:00', 'mobile'),
('login.html', '2024-11-13 14:15:00', 'desktop'),
('home', '2024-11-14 18:00:00', 'mobile'),
('solucao', '2024-11-15 12:25:00', 'desktop'),
('sobre', '2024-11-16 19:30:00', 'mobile'),
('mvv', '2024-11-17 10:50:00', 'desktop'),
('contato', '2024-11-18 15:00:00', 'desktop');

-- Exemplo de inserts para a tabela Capturas
INSERT INTO Capturas (dataHora, valor, fkComponente, fkServidor)
VALUES 
    -- Novembro de 2023
    ('2023-11-05 14:20:00', 102.5, 1, 1),
    ('2023-11-10 15:30:00', 97.3, 1, 1),
    ('2023-11-15 10:25:00', 110.2, 1, 1),
    ('2023-11-20 08:45:00', 95.8, 1, 1),
    ('2023-11-25 17:55:00', 101.7, 1, 1),
    
    ('2023-11-05 11:15:00', 210.5, 2, 1),
    ('2023-11-10 12:30:00', 205.7, 2, 1),
    ('2023-11-15 13:35:00', 220.9, 2, 1),
    ('2023-11-20 14:40:00', 215.4, 2, 1),
    ('2023-11-25 16:50:00', 219.6, 2, 1),

    -- Exemplo para uso da CPU (componente 3)
    ('2023-11-06 09:20:00', 40.5, 3, 1),
    ('2023-11-11 10:30:00', 42.7, 3, 1),
    ('2023-11-16 11:35:00', 38.6, 3, 1),
    ('2023-11-21 12:40:00', 45.3, 3, 1),
    ('2023-11-26 13:50:00', 39.9, 3, 1),

    -- Exemplo para uso do Disco Total (componente 4)
    ('2023-11-07 07:20:00', 800.5, 4, 1),
    ('2023-11-12 08:30:00', 810.3, 4, 1),
    ('2023-11-17 09:35:00', 805.2, 4, 1),
    ('2023-11-22 10:40:00', 798.4, 4, 1),
    ('2023-11-27 11:50:00', 815.6, 4, 1),

    -- Exemplo para uso do Disco Usado (componente 5)
    ('2023-11-08 06:20:00', 500.2, 5, 1),
    ('2023-11-13 07:30:00', 490.1, 5, 1),
    ('2023-11-18 08:35:00', 495.8, 5, 1),
    ('2023-11-23 09:40:00', 508.6, 5, 1),
    ('2023-11-28 10:50:00', 504.3, 5, 1),

    -- Exemplo para Memória Usada (componente 8)
    ('2023-11-09 05:20:00', 16.5, 8, 1),
    ('2023-11-14 06:30:00', 15.8, 8, 1),
    ('2023-11-19 07:35:00', 17.2, 8, 1),
    ('2023-11-24 08:40:00', 16.1, 8, 1),
    ('2023-11-29 09:50:00', 17.0, 8, 1),
    
    -- Dezembro
	('2023-12-05 14:20:00', 102.5, 1, 1),
    ('2023-12-10 15:30:00', 97.3, 1, 1),
    ('2023-12-15 10:25:00', 110.2, 1, 1),
    ('2023-12-20 08:45:00', 95.8, 1, 1),
    ('2023-12-25 17:55:00', 101.7, 1, 1),
    
    ('2023-12-05 11:15:00', 210.5, 2, 1),
    ('2023-12-10 12:30:00', 205.7, 2, 1),
    ('2023-12-15 13:35:00', 220.9, 2, 1),
    ('2023-12-20 14:40:00', 215.4, 2, 1),
    ('2023-12-25 16:50:00', 219.6, 2, 1),

    -- Exemplo para uso da CPU (componente 3)
    ('2023-12-06 09:20:00', 40.5, 3, 1),
    ('2023-12-11 10:30:00', 42.7, 3, 1),
    ('2023-12-16 11:35:00', 38.6, 3, 1),
    ('2023-12-21 12:40:00', 45.3, 3, 1),
    ('2023-12-26 13:50:00', 39.9, 3, 1),

    -- Exemplo para uso do Disco Total (componente 4)
    ('2023-12-07 07:20:00', 800.5, 4, 1),
    ('2023-12-12 08:30:00', 810.3, 4, 1),
    ('2023-12-17 09:35:00', 805.2, 4, 1),
    ('2023-12-22 10:40:00', 798.4, 4, 1),
    ('2023-12-27 11:50:00', 815.6, 4, 1),

    -- Exemplo para uso do Disco Usado (componente 5)
    ('2023-12-08 06:20:00', 500.2, 5, 1),
    ('2023-12-13 07:30:00', 490.1, 5, 1),
    ('2023-12-18 08:35:00', 495.8, 5, 1),
    ('2023-12-23 09:40:00', 508.6, 5, 1),
    ('2023-12-28 10:50:00', 504.3, 5, 1),
    
    -- Exemplo para Memória Usada (componente 8)
    ('2023-12-09 05:20:00', 16.5, 8, 1),
    ('2023-12-14 06:30:00', 15.8, 8, 1),
    ('2023-12-19 07:35:00', 17.2, 8, 1),
    ('2023-12-24 08:40:00', 16.1, 8, 1),
    ('2023-12-29 09:50:00', 17.0, 8, 1),
    
    -- janeiro
	('2024-01-05 14:20:00', 102.5, 1, 1),
    ('2024-01-10 15:30:00', 97.3, 1, 1),
    ('2024-01-15 10:25:00', 110.2, 1, 1),
    ('2024-01-20 08:45:00', 95.8, 1, 1),
    ('2024-01-25 17:55:00', 101.7, 1, 1),
    
    ('2024-01-05 11:15:00', 210.5, 2, 1),
    ('2024-01-10 12:30:00', 205.7, 2, 1),
    ('2024-01-15 13:35:00', 220.9, 2, 1),
    ('2024-01-20 14:40:00', 215.4, 2, 1),
    ('2024-01-25 16:50:00', 219.6, 2, 1),

    -- Exemplo para uso da CPU (componente 3)
    ('2024-01-06 09:20:00', 40.5, 3, 1),
    ('2024-01-11 10:30:00', 42.7, 3, 1),
    ('2024-01-16 11:35:00', 38.6, 3, 1),
    ('2024-01-21 12:40:00', 45.3, 3, 1),
    ('2024-01-26 13:50:00', 39.9, 3, 1),

    -- Exemplo para uso do Disco Total (componente 4)
    ('2024-01-07 07:20:00', 800.5, 4, 1),
    ('2024-01-12 08:30:00', 810.3, 4, 1),
    ('2024-01-17 09:35:00', 805.2, 4, 1),
    ('2024-01-22 10:40:00', 798.4, 4, 1),
    ('2024-01-27 11:50:00', 815.6, 4, 1),

    -- Exemplo para uso do Disco Usado (componente 5)
    ('2024-01-08 06:20:00', 500.2, 5, 1),
    ('2024-01-13 07:30:00', 490.1, 5, 1),
    ('2024-01-18 08:35:00', 495.8, 5, 1),
    ('2024-01-23 09:40:00', 508.6, 5, 1),
    ('2024-01-28 10:50:00', 504.3, 5, 1),
    
    -- Exemplo para Memória Usada (componente 8)
    ('2024-01-09 05:20:00', 16.5, 8, 1),
    ('2024-01-14 06:30:00', 15.8, 8, 1),
    ('2024-01-19 07:35:00', 17.2, 8, 1),
    ('2024-01-24 08:40:00', 16.1, 8, 1),
    ('2024-01-29 09:50:00', 17.0, 8, 1),
    
    -- Fevereiro
    ('2024-02-05 14:20:00', 102.5, 1, 1),
    ('2024-02-10 15:30:00', 97.3, 1, 1),
    ('2024-02-15 10:25:00', 110.2, 1, 1),
    ('2024-02-20 08:45:00', 95.8, 1, 1),
    ('2024-02-25 17:55:00', 101.7, 1, 1),
    
    ('2024-02-05 11:15:00', 210.5, 2, 1),
    ('2024-02-10 12:30:00', 205.7, 2, 1),
    ('2024-02-15 13:35:00', 220.9, 2, 1),
    ('2024-02-20 14:40:00', 215.4, 2, 1),
    ('2024-02-25 16:50:00', 219.6, 2, 1),

    -- Exemplo para uso da CPU (componente 3)
    ('2024-02-06 09:20:00', 40.5, 3, 1),
    ('2024-02-11 10:30:00', 42.7, 3, 1),
    ('2024-02-16 11:35:00', 38.6, 3, 1),
    ('2024-02-21 12:40:00', 45.3, 3, 1),
    ('2024-02-26 13:50:00', 39.9, 3, 1),

    -- Exemplo para uso do Disco Total (componente 4)
    ('2024-02-07 07:20:00', 800.5, 4, 1),
    ('2024-02-12 08:30:00', 810.3, 4, 1),
    ('2024-02-17 09:35:00', 805.2, 4, 1),
    ('2024-02-22 10:40:00', 798.4, 4, 1),
    ('2024-02-27 11:50:00', 815.6, 4, 1),

    -- Exemplo para uso do Disco Usado (componente 5)
    ('2024-02-08 06:20:00', 500.2, 5, 1),
    ('2024-02-13 07:30:00', 490.1, 5, 1),
    ('2024-02-18 08:35:00', 495.8, 5, 1),
    ('2024-02-23 09:40:00', 508.6, 5, 1),
    ('2024-02-28 10:50:00', 504.3, 5, 1),
    
    -- Exemplo para Memória Usada (componente 8)
    ('2024-02-09 05:20:00', 16.5, 8, 1),
    ('2024-02-14 06:30:00', 15.8, 8, 1),
    ('2024-02-19 07:35:00', 17.2, 8, 1),
    ('2024-02-24 08:40:00', 16.1, 8, 1),
    ('2024-02-29 09:50:00', 17.0, 8, 1),
	('2024-03-05 14:20:00', 102.5, 1, 1),
    ('2024-03-10 15:30:00', 97.3, 1, 1),
    ('2024-03-15 10:25:00', 110.2, 1, 1),
    ('2024-03-20 08:45:00', 95.8, 1, 1),
    ('2024-03-25 17:55:00', 101.7, 1, 1),
    
    ('2024-03-05 11:15:00', 210.5, 2, 1),
    ('2024-03-10 12:30:00', 205.7, 2, 1),
    ('2024-03-15 13:35:00', 220.9, 2, 1),
    ('2024-03-20 14:40:00', 215.4, 2, 1),
    ('2024-03-25 16:50:00', 219.6, 2, 1),

    -- Exemplo para uso da CPU (componente 3)
    ('2024-03-06 09:20:00', 40.5, 3, 1),
    ('2024-03-11 10:30:00', 42.7, 3, 1),
    ('2024-03-16 11:35:00', 38.6, 3, 1),
    ('2024-03-21 12:40:00', 45.3, 3, 1),
    ('2024-03-26 13:50:00', 39.9, 3, 1),

    -- Exemplo para uso do Disco Total (componente 4)
    ('2024-03-07 07:20:00', 800.5, 4, 1),
    ('2024-03-12 08:30:00', 810.3, 4, 1),
    ('2024-03-17 09:35:00', 805.2, 4, 1),
    ('2024-03-22 10:40:00', 798.4, 4, 1),
    ('2024-03-27 11:50:00', 815.6, 4, 1),

    -- Exemplo para uso do Disco Usado (componente 5)
    ('2024-03-08 06:20:00', 500.2, 5, 1),
    ('2024-03-13 07:30:00', 490.1, 5, 1),
    ('2024-03-18 08:35:00', 495.8, 5, 1),
    ('2024-03-23 09:40:00', 508.6, 5, 1),
    ('2024-03-28 10:50:00', 504.3, 5, 1),
    
    -- Exemplo para Memória Usada (componente 8)
    ('2024-03-09 05:20:00', 16.5, 8, 1),
    ('2024-03-14 06:30:00', 15.8, 8, 1),
    ('2024-03-19 07:35:00', 17.2, 8, 1),
    ('2024-03-24 08:40:00', 16.1, 8, 1),
    ('2024-03-29 09:50:00', 17.0, 8, 1),
	('2024-04-05 14:20:00', 102.5, 1, 1),
    ('2024-04-10 15:30:00', 97.3, 1, 1),
    ('2024-04-15 10:25:00', 110.2, 1, 1),
    ('2024-04-20 08:45:00', 95.8, 1, 1),
    ('2024-04-25 17:55:00', 101.7, 1, 1),
    
    ('2024-04-05 11:15:00', 210.5, 2, 1),
    ('2024-04-10 12:30:00', 205.7, 2, 1),
    ('2024-04-15 13:35:00', 220.9, 2, 1),
    ('2024-04-20 14:40:00', 215.4, 2, 1),
    ('2024-04-25 16:50:00', 219.6, 2, 1),

    -- Exemplo para uso da CPU (componente 3)
    ('2024-04-06 09:20:00', 40.5, 3, 1),
    ('2024-04-11 10:30:00', 42.7, 3, 1),
    ('2024-04-16 11:35:00', 38.6, 3, 1),
    ('2024-04-21 12:40:00', 45.3, 3, 1),
    ('2024-04-26 13:50:00', 39.9, 3, 1),

    -- Exemplo para uso do Disco Total (componente 4)
    ('2024-04-07 07:20:00', 800.5, 4, 1),
    ('2024-04-12 08:30:00', 810.3, 4, 1),
    ('2024-04-17 09:35:00', 805.2, 4, 1),
    ('2024-04-22 10:40:00', 798.4, 4, 1),
    ('2024-04-27 11:50:00', 815.6, 4, 1),

    -- Exemplo para uso do Disco Usado (componente 5)
    ('2024-04-08 06:20:00', 500.2, 5, 1),
    ('2024-04-13 07:30:00', 490.1, 5, 1),
    ('2024-04-18 08:35:00', 495.8, 5, 1),
    ('2024-04-23 09:40:00', 508.6, 5, 1),
    ('2024-04-28 10:50:00', 504.3, 5, 1),
    
    -- Exemplo para Memória Usada (componente 8)
    ('2024-04-09 05:20:00', 16.5, 8, 1),
    ('2024-04-14 06:30:00', 15.8, 8, 1),
    ('2024-04-19 07:35:00', 17.2, 8, 1),
    ('2024-04-24 08:40:00', 16.1, 8, 1),
    ('2024-04-29 09:50:00', 17.0, 8, 1),
    ('2024-05-05 14:20:00', 102.5, 1, 1),
    ('2024-05-10 15:30:00', 97.3, 1, 1),
    ('2024-05-15 10:25:00', 110.2, 1, 1),
    ('2024-05-20 08:45:00', 95.8, 1, 1),
    ('2024-05-25 17:55:00', 101.7, 1, 1),
    
    ('2024-05-05 11:15:00', 210.5, 2, 1),
    ('2024-05-10 12:30:00', 205.7, 2, 1),
    ('2024-05-15 13:35:00', 220.9, 2, 1),
    ('2024-05-20 14:40:00', 215.4, 2, 1),
    ('2024-05-25 16:50:00', 219.6, 2, 1),

    -- Exemplo para uso da CPU (componente 3)
    ('2024-05-06 09:20:00', 40.5, 3, 1),
    ('2024-05-11 10:30:00', 42.7, 3, 1),
    ('2024-05-16 11:35:00', 38.6, 3, 1),
    ('2024-05-21 12:40:00', 45.3, 3, 1),
    ('2024-05-26 13:50:00', 39.9, 3, 1),

    -- Exemplo para uso do Disco Total (componente 4)
    ('2024-05-07 07:20:00', 800.5, 4, 1),
    ('2024-05-12 08:30:00', 810.3, 4, 1),
    ('2024-05-17 09:35:00', 805.2, 4, 1),
    ('2024-05-22 10:40:00', 798.4, 4, 1),
    ('2024-05-27 11:50:00', 815.6, 4, 1),

    -- Exemplo para uso do Disco Usado (componente 5)
    ('2024-05-08 06:20:00', 500.2, 5, 1),
    ('2024-05-13 07:30:00', 490.1, 5, 1),
    ('2024-05-18 08:35:00', 495.8, 5, 1),
    ('2024-05-23 09:40:00', 508.6, 5, 1),
    ('2024-05-28 10:50:00', 504.3, 5, 1),
    
    -- Exemplo para Memória Usada (componente 8)
    ('2024-05-09 05:20:00', 16.5, 8, 1),
    ('2024-05-14 06:30:00', 15.8, 8, 1),
    ('2024-05-19 07:35:00', 17.2, 8, 1),
    ('2024-05-24 08:40:00', 16.1, 8, 1),
    ('2024-05-29 09:50:00', 17.0, 8, 1),
    ('2024-06-05 14:20:00', 102.5, 1, 1),
    ('2024-06-10 15:30:00', 97.3, 1, 1),
    ('2024-06-15 10:25:00', 110.2, 1, 1),
    ('2024-06-20 08:45:00', 95.8, 1, 1),
    ('2024-06-25 17:55:00', 101.7, 1, 1),
    
    ('2024-06-05 11:15:00', 210.5, 2, 1),
    ('2024-06-10 12:30:00', 205.7, 2, 1),
    ('2024-06-15 13:35:00', 220.9, 2, 1),
    ('2024-06-20 14:40:00', 215.4, 2, 1),
    ('2024-06-25 16:50:00', 219.6, 2, 1),

    -- Exemplo para uso da CPU (componente 3)
    ('2024-06-06 09:20:00', 40.5, 3, 1),
    ('2024-06-11 10:30:00', 42.7, 3, 1),
    ('2024-06-16 11:35:00', 38.6, 3, 1),
    ('2024-06-21 12:40:00', 45.3, 3, 1),
    ('2024-06-26 13:50:00', 39.9, 3, 1),

    -- Exemplo para uso do Disco Total (componente 4)
    ('2024-06-07 07:20:00', 800.5, 4, 1),
    ('2024-06-12 08:30:00', 810.3, 4, 1),
    ('2024-06-17 09:35:00', 805.2, 4, 1),
    ('2024-06-22 10:40:00', 798.4, 4, 1),
    ('2024-06-27 11:50:00', 815.6, 4, 1),

    -- Exemplo para uso do Disco Usado (componente 5)
    ('2024-06-08 06:20:00', 500.2, 5, 1),
    ('2024-06-13 07:30:00', 490.1, 5, 1),
    ('2024-06-18 08:35:00', 495.8, 5, 1),
    ('2024-06-23 09:40:00', 508.6, 5, 1),
    ('2024-06-28 10:50:00', 504.3, 5, 1),

    -- Exemplo para Memória Usada (componente 8)
    ('2024-06-09 05:20:00', 16.5, 8, 1),
    ('2024-06-14 06:30:00', 15.8, 8, 1),
    ('2024-06-19 07:35:00', 17.2, 8, 1),
    ('2024-06-24 08:40:00', 16.1, 8, 1),
    ('2024-06-29 09:50:00', 17.0, 8, 1),
    ('2024-07-05 14:20:00', 102.5, 1, 1),
    ('2024-07-10 15:30:00', 97.3, 1, 1),
    ('2024-07-15 10:25:00', 110.2, 1, 1),
    ('2024-07-20 08:45:00', 95.8, 1, 1),
    ('2024-07-25 17:55:00', 101.7, 1, 1),
    
    ('2024-07-05 11:15:00', 210.5, 2, 1),
    ('2024-07-10 12:30:00', 205.7, 2, 1),
    ('2024-07-15 13:35:00', 220.9, 2, 1),
    ('2024-07-20 14:40:00', 215.4, 2, 1),
    ('2024-07-25 16:50:00', 219.6, 2, 1),

    -- Exemplo para uso da CPU (componente 3)
    ('2024-07-06 09:20:00', 40.5, 3, 1),
    ('2024-07-11 10:30:00', 42.7, 3, 1),
    ('2024-07-16 11:35:00', 38.6, 3, 1),
    ('2024-07-21 12:40:00', 45.3, 3, 1),
    ('2024-07-26 13:50:00', 39.9, 3, 1),

    -- Exemplo para uso do Disco Total (componente 4)
    ('2024-07-07 07:20:00', 800.5, 4, 1),
    ('2024-07-12 08:30:00', 810.3, 4, 1),
    ('2024-07-17 09:35:00', 805.2, 4, 1),
    ('2024-07-22 10:40:00', 798.4, 4, 1),
    ('2024-07-27 11:50:00', 815.6, 4, 1),

    -- Exemplo para uso do Disco Usado (componente 5)
    ('2024-07-08 06:20:00', 500.2, 5, 1),
    ('2024-07-13 07:30:00', 490.1, 5, 1),
    ('2024-07-18 08:35:00', 495.8, 5, 1),
    ('2024-07-23 09:40:00', 508.6, 5, 1),
    ('2024-07-28 10:50:00', 504.3, 5, 1),
    
    -- Exemplo para Memória Usada (componente 8)
    ('2024-07-09 05:20:00', 16.5, 8, 1),
    ('2024-07-14 06:30:00', 15.8, 8, 1),
    ('2024-07-19 07:35:00', 17.2, 8, 1),
    ('2024-07-24 08:40:00', 16.1, 8, 1),
    ('2024-07-29 09:50:00', 17.0, 8, 1),
    ('2024-08-05 14:20:00', 102.5, 1, 1),
    ('2024-08-10 15:30:00', 97.3, 1, 1),
    ('2024-08-15 10:25:00', 110.2, 1, 1),
    ('2024-08-20 08:45:00', 95.8, 1, 1),
    ('2024-08-25 17:55:00', 101.7, 1, 1),
    
    ('2024-08-05 11:15:00', 210.5, 2, 1),
    ('2024-08-10 12:30:00', 205.7, 2, 1),
    ('2024-08-15 13:35:00', 220.9, 2, 1),
    ('2024-08-20 14:40:00', 215.4, 2, 1),
    ('2024-08-25 16:50:00', 219.6, 2, 1),

    -- Exemplo para uso da CPU (componente 3)
    ('2024-08-06 09:20:00', 40.5, 3, 1),
    ('2024-08-11 10:30:00', 42.7, 3, 1),
    ('2024-08-16 11:35:00', 38.6, 3, 1),
    ('2024-08-21 12:40:00', 45.3, 3, 1),
    ('2024-08-26 13:50:00', 39.9, 3, 1),
    -- Exemplo para uso do Disco Total (componente 4)
    ('2024-08-07 07:20:00', 800.5, 4, 1),
    ('2024-08-12 08:30:00', 810.3, 4, 1),
    ('2024-08-17 09:35:00', 805.2, 4, 1),
    ('2024-08-22 10:40:00', 798.4, 4, 1),
    ('2024-08-27 11:50:00', 815.6, 4, 1),

    -- Exemplo para uso do Disco Usado (componente 5)
    ('2024-08-08 06:20:00', 500.2, 5, 1),
    ('2024-08-13 07:30:00', 490.1, 5, 1),
    ('2024-08-18 08:35:00', 495.8, 5, 1),
    ('2024-08-23 09:40:00', 508.6, 5, 1),
    ('2024-08-28 10:50:00', 504.3, 5, 1),
    
    -- Exemplo para Memória Usada (componente 8)
    ('2024-08-09 05:20:00', 16.5, 8, 1),
    ('2024-08-14 06:30:00', 15.8, 8, 1),
    ('2024-08-19 07:35:00', 17.2, 8, 1),
    ('2024-08-24 08:40:00', 16.1, 8, 1),
    ('2024-08-29 09:50:00', 17.0, 8, 1),
    ('2024-09-05 14:20:00', 102.5, 1, 1),
    ('2024-09-10 15:30:00', 97.3, 1, 1),
    ('2024-09-15 10:25:00', 110.2, 1, 1),
    ('2024-09-20 08:45:00', 95.8, 1, 1),
    ('2024-09-25 17:55:00', 101.7, 1, 1),
    
    ('2024-09-05 11:15:00', 210.5, 2, 1),
    ('2024-09-10 12:30:00', 205.7, 2, 1),
    ('2024-09-15 13:35:00', 220.9, 2, 1),
    ('2024-09-20 14:40:00', 215.4, 2, 1),
    ('2024-09-25 16:50:00', 219.6, 2, 1),

    -- Exemplo para uso da CPU (componente 3)
    ('2024-09-06 09:20:00', 40.5, 3, 1),
    ('2024-09-11 10:30:00', 42.7, 3, 1),
    ('2024-09-16 11:35:00', 38.6, 3, 1),
    ('2024-09-21 12:40:00', 45.3, 3, 1),
    ('2024-09-26 13:50:00', 39.9, 3, 1),
    
    -- Exemplo para uso do Disco Total (componente 4)
    ('2024-09-07 07:20:00', 800.5, 4, 1),
    ('2024-09-12 08:30:00', 810.3, 4, 1),
    ('2024-09-17 09:35:00', 805.2, 4, 1),
    ('2024-09-22 10:40:00', 798.4, 4, 1),
    ('2024-09-27 11:50:00', 815.6, 4, 1),
    
    -- Exemplo para uso do Disco Usado (componente 5)
    ('2024-09-08 06:20:00', 500.2, 5, 1),
    ('2024-09-13 07:30:00', 490.1, 5, 1),
    ('2024-09-18 08:35:00', 495.8, 5, 1),
    ('2024-09-23 09:40:00', 508.6, 5, 1),
    ('2024-09-28 10:50:00', 504.3, 5, 1),
    
    -- Exemplo para Memória Usada (componente 8)
    ('2024-09-09 05:20:00', 16.5, 8, 1),
    ('2024-09-14 06:30:00', 15.8, 8, 1),
    ('2024-09-19 07:35:00', 17.2, 8, 1),
    ('2024-09-24 08:40:00', 16.1, 8, 1),
    ('2024-09-29 09:50:00', 17.0, 8, 1),
    ('2024-10-05 14:20:00', 102.5, 1, 1),
    ('2024-10-10 15:30:00', 97.3, 1, 1),
    ('2024-10-15 10:25:00', 110.2, 1, 1),
    ('2024-10-20 08:45:00', 95.8, 1, 1),
    ('2024-10-25 17:55:00', 101.7, 1, 1),
    
    ('2024-10-05 11:15:00', 210.5, 2, 1),
    ('2024-10-10 12:30:00', 205.7, 2, 1),
    ('2024-10-15 13:35:00', 220.9, 2, 1),
    ('2024-10-20 14:40:00', 215.4, 2, 1),
    ('2024-10-25 16:50:00', 219.6, 2, 1),

    -- Exemplo para uso da CPU (componente 3)
    ('2024-10-06 09:20:00', 40.5, 3, 1),
    ('2024-10-11 10:30:00', 42.7, 3, 1),
    ('2024-10-16 11:35:00', 38.6, 3, 1),
    ('2024-10-21 12:40:00', 45.3, 3, 1),
    ('2024-10-26 13:50:00', 39.9, 3, 1),

    -- Exemplo para uso do Disco Total (componente 4)
    ('2024-10-07 07:20:00', 800.5, 4, 1),
    ('2024-10-12 08:30:00', 810.3, 4, 1),
    ('2024-10-17 09:35:00', 805.2, 4, 1),
    ('2024-10-22 10:40:00', 798.4, 4, 1),
    ('2024-10-27 11:50:00', 815.6, 4, 1),

    -- Exemplo para uso do Disco Usado (componente 5)
    ('2024-10-08 06:20:00', 500.2, 5, 1),
    ('2024-10-13 07:30:00', 490.1, 5, 1),
    ('2024-10-18 08:35:00', 495.8, 5, 1),
    ('2024-10-23 09:40:00', 508.6, 5, 1),
    ('2024-10-28 10:50:00', 504.3, 5, 1),
    
    -- Exemplo para Memória Usada (componente 8)
    ('2024-10-09 05:20:00', 16.5, 8, 1),
    ('2024-10-14 06:30:00', 15.8, 8, 1),
    ('2024-10-19 07:35:00', 17.2, 8, 1),
    ('2024-10-24 08:40:00', 16.1, 8, 1),
    ('2024-10-29 09:50:00', 17.0, 8, 1),
    
    -- NOVEMBRO 
    
    ('2024-11-05 14:20:00', 102.5, 1, 1),
    ('2024-11-10 15:30:00', 97.3, 1, 1),
    ('2024-11-15 10:25:00', 110.2, 1, 1),
    ('2024-11-20 08:45:00', 95.8, 1, 1),
    ('2024-11-25 17:55:00', 101.7, 1, 1),
    
    ('2024-11-05 11:15:00', 210.5, 2, 1),
    ('2024-11-10 12:30:00', 205.7, 2, 1),
    ('2024-11-15 13:35:00', 220.9, 2, 1),
    ('2024-11-20 14:40:00', 215.4, 2, 1),
    ('2024-11-25 16:50:00', 219.6, 2, 1),

    -- Exemplo para uso da CPU (componente 3)
    ('2024-11-06 09:20:00', 40.5, 3, 1),
    ('2024-11-11 10:30:00', 42.7, 3, 1),
    ('2024-11-16 11:35:00', 38.6, 3, 1),
    ('2024-11-21 12:40:00', 45.3, 3, 1),
    ('2024-11-26 13:50:00', 39.9, 3, 1),

    -- Exemplo para uso do Disco Total (componente 4)
    ('2024-11-07 07:20:00', 800.5, 4, 1),
    ('2024-11-12 08:30:00', 810.3, 4, 1),
    ('2024-11-17 09:35:00', 805.2, 4, 1),
    ('2024-11-22 10:40:00', 798.4, 4, 1),
    ('2024-11-27 11:50:00', 815.6, 4, 1),

    -- Exemplo para uso do Disco Usado (componente 5)
    ('2024-11-08 06:20:00', 500.2, 5, 1),
    ('2024-11-13 07:30:00', 490.1, 5, 1),
    ('2024-11-18 08:35:00', 495.8, 5, 1),
    ('2024-11-23 09:40:00', 508.6, 5, 1),
    ('2024-11-28 10:50:00', 504.3, 5, 1),
    
    -- Exemplo para Memória Usada (componente 8)
    ('2024-11-09 05:20:00', 16.5, 8, 1),
    ('2024-11-14 06:30:00', 15.8, 8, 1),
    ('2024-11-19 07:35:00', 17.2, 8, 1),
    ('2024-11-24 08:40:00', 16.1, 8, 1),
    ('2024-11-29 09:50:00', 17.0, 8, 1);
    select * from site;

