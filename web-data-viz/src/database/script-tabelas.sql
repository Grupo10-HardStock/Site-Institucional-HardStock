-- Criando a base de dados HardStock
CREATE DATABASE IF NOT EXISTS HardStock;

-- Usando a base de dados criada
USE HardStock;

-- Tabela Funcionario para armazenar dados dos funcionários
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

-- Inserindo um registro na tabela Funcionario
INSERT INTO Funcionario (nome, sobrenome, numeroTelefone, email, senha, permissao,fkEmpresa)
VALUES ('João', 'Silva', '(11) 91234-5678', 'joao.silva@empresa.com', 'senhaSegura123', 'Analista',1);

INSERT INTO Funcionario (nome, sobrenome, numeroTelefone, email, senha, permissao)
VALUES ('Pedro', 'Henrique', '(11) 96275-2952', 'pedrohenrique@techsolutions.com', '123456789', 'Gerente',1);

select *from empresa;

-- Tabela Empresa para armazenar informações da empresa
CREATE TABLE IF NOT EXISTS Empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    razaoSocial VARCHAR(256),
    cnpj CHAR(20),
	estado varchar(45) default "Ativo",
    emailCorporativo VARCHAR(256)
);
select * from Empresa;
-- Inserindo um registro na tabela Empresa, relacionando com Funcionario
INSERT INTO Empresa (razaoSocial, cnpj, emailCorporativo)
VALUES ('Tech Solutions Ltda', '00.123.456/0001-23', 'contato@techsolutions.com');

-- Tabela Especificacoes para armazenar detalhes técnicos de servidores
CREATE TABLE IF NOT EXISTS Servidor (
    idServidor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    rede VARCHAR(50),
    ram VARCHAR(20),
    disco VARCHAR(20),
    cpu_ VARCHAR(20),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

insert into servidor(nome,rede,ram,disco,cpu_,fkEmpresa) values ("Servidor 11° andar", "LAN","4GB","256GB","4 Núcleos",1);

-- Tabela Componentes para definir o tipo de componente e unidade de medida
CREATE TABLE IF NOT EXISTS Componentes (
    idComponente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL, -- Nome do componente (e.g., CPU Uso, Memória RAM)
    unidadeMedida VARCHAR(20) NOT NULL, -- Unidade de medida (e.g., %, GB)
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Bytes Enviados', 'MB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Bytes Recebidos', 'MB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Uso da CPU', '%');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Uso do Disco Total', 'GB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Uso do Disco Usado', 'GB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Tempo de Leitura do Disco', 'ms');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Memória Total', 'GB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Memória Usada', 'GB');


-- Tabela Capturas para armazenar os valores capturados de componentes
CREATE TABLE IF NOT EXISTS Capturas (
    idCaptura INT AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Data e hora da captura
    valor FLOAT NOT NULL, -- Valor capturado (e.g., 75.5)
    fkComponente INT, -- Referência ao componente capturado
    fkServidor INT, -- Referência ao servidor,
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    FOREIGN KEY (fkComponente) REFERENCES Componentes(idComponente),
    FOREIGN KEY (fkServidor) REFERENCES Servidor(idServidor)
);

ALTER TABLE Capturas
MODIFY COLUMN data_hora DATETIME NOT NULL;

/*
-- Criando a stored procedure para inserir dados
DELIMITER $$

CREATE PROCEDURE InserirDadosCapturas()
BEGIN
    DECLARE data_inicial DATE DEFAULT '2023-01-01';
    DECLARE data_final DATE DEFAULT '2023-12-31';

    WHILE data_inicial <= data_final DO
        -- Loop para cada componente
        INSERT INTO Capturas (data_hora, valor, fkComponente, fkServidor)
        SELECT 
            DATE_ADD(data_inicial, INTERVAL RAND() * 86400 SECOND), -- Hora aleatória no dia
            ROUND(RAND() * 100 + 50, 2) AS valor, -- Valor aleatório entre 50 e 150
            idComponente, 
            Servidor.idServidor
        FROM 
            Componentes
        CROSS JOIN
            (SELECT idServidor FROM Servidor LIMIT 1) AS Servidor; -- Ajuste com base nos servidores disponíveis

        -- Incrementa a data para o próximo dia
        SET data_inicial = DATE_ADD(data_inicial, INTERVAL 1 DAY);
    END WHILE;
END $$

DELIMITER ;

-- Executando a stored procedure para inserir os dados
CALL InserirDadosCapturas();
*/

select * from capturas;

-- Exemplo de inserts para a tabela Capturas
INSERT INTO Capturas (data_hora, valor, fkComponente, fkServidor)
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

-- DEZEMBRO
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
    
    -- JANEIRO
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
    
    -- FEVEREIRO 
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

-- MARÇO
	
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
    
    -- ABRIL
    
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
    
    -- MAIO
    
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
    
    -- JUNHO
    
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
    
    -- JULHO
	
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

	-- AGOSTO
    
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
    
    -- SETEMBRO
    
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
    
    -- OUTUBRO    
    
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
    
    
    
select * from funcionario;    

-- Tabela Alertas para registrar alertas associados às capturas
CREATE TABLE IF NOT EXISTS Alertas (
    idAlerta INT AUTO_INCREMENT PRIMARY KEY,
    fkCaptura INT,
    gravidade ENUM('baixo', 'médio', 'alto', 'critico'),
    descricao VARCHAR(256),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    FOREIGN KEY (fkCaptura) REFERENCES Capturas(idCaptura)
);
 
CREATE TABLE IF NOT EXISTS mensagem (
idMensagem int primary key auto_increment,
nome varchar(128) not null,
email varchar(256), 
mensagem varchar(512)
);

select * from mensagem;
 
alter table Funcionario add constraint ligacao foreign key (fkEmpresa) references Empresa(idEmpresa);

 CREATE
DEFINER=CURRENT_USER SQL SECURITY INVOKER
VIEW VizFunc AS
SELECT idFuncionario,nome,sobrenome,email,fkEmpresa,permissao,estado FROM Funcionario;


 CREATE
DEFINER=CURRENT_USER SQL SECURITY INVOKER
VIEW VizEdit AS

SELECT idFuncionario,nome,sobrenome,numeroTelefone,email,senha, permissao, estado FROM Funcionario;	
	
SELECT 
    c.nome AS componente,
    DATE_FORMAT(cp.data_hora, '%Y-%m') AS mes_ano,
    AVG(cp.valor) AS media_valor
FROM 
    Capturas cp
JOIN 
    Componentes c ON cp.fkComponente = c.idComponente
WHERE 
c.nome IN ('Bytes Recebidos', 'Bytes Enviados', 'Uso do Disco Usado', 'Uso do Disco Total', 'Uso da CPU', 'Memória Usada')
    AND cp.data_hora >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)GROUP BY 
    c.nome, 
    DATE_FORMAT(cp.data_hora, '%Y-%m')
ORDER BY 
    c.nome, mes_ano;


SELECT
    c.nome AS componente,
	DATE_FORMAT(cp.data_hora, '%Y-%m') AS mes_ano,
    AVG(cp.valor) AS media_valor
FROM
    Capturas cp
JOIN
    Componentes c ON cp.fkComponente = c.idComponente
WHERE
    c.nome IN ('Bytes Recebidos', 'Bytes Enviados', 'Uso do Disco Usado', 'Uso do Disco Total', 'Uso da CPU', 'Memória Usada')
    AND cp.data_hora >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY
      c.nome, 
    DATE_FORMAT(cp.data_hora, '%Y-%m');
    
    select * from mensagem;

