create database if not exists HardStock;
use HardStock;
create table if not exists funcionario (
idFuncionario int auto_increment,
nome varchar(50),
sobrenome varchar(100),
numeroTelefone Int,
email varchar (256),
senha varchar(256),
permissao varchar(45),
fkAdministrador int,
foreign key (fkAdministrador) references Funcionario(idFuncionario),
fkHardStock varchar(45) default "NP",
primary key (idFuncionario));


create table if not exists Empresa (
idEmpresa int auto_increment,
fkRepresentante int default null,
razaoSocial varchar (256),
cnpj char(14),
emailCorporativo varchar(256),
primary key (idEmpresa));

create table if not exists Especificacoes (
idEspecificacao int primary key auto_increment,
distribuicao varchar (70),
sistemaOperacional varchar(50),
processador varchar(100),
memoriaRam int,
qntDisco int,
placaRede varchar(50));

create table if not exists Servidor (
idServidor int auto_increment,
nome varchar (50),
fkEmpresa int,
foreign key (fkEmpresa) references Empresa(idEmpresa),
fkEspecificacao int,
foreign key (fkEspecificacao) references Especificacoes(idEspecificacao),
primary key (idServidor,fkEmpresa,fkEspecificacao));

create table if not exists CapturasPython  (
    idPython INT AUTO_INCREMENT,
    fkServidor int,
    foreign key (fkServidor) references Servidor(idServidor),
    data_hora DATETIME NOT NULL,
    cpu_uso_percentual FLOAT,
    cpu_velocidade FLOAT,
    cpu_tempo_ativo FLOAT,
    disco_total_gb FLOAT,
    disco_usado_gb FLOAT,
    disco_livre_gb FLOAT,
    disco_porcentagem_usada FLOAT,
    disco_tempo_leitura_ms FLOAT,
    disco_tempo_gravacao_ms FLOAT,
    memoria_total_gb FLOAT,
    memoria_disponivel_gb FLOAT,
    memoria_porcentagem_usada FLOAT,
    memoria_usada_gb FLOAT,
    primary key (idPython,fkServidor)
);

create table if not exists Alertas_pyhton (
idAlerta int auto_increment,
fkCaptura int,
foreign key (fkCaptura) references CapturasPython(idPython),
gravidade enum('baixo', 'médio', 'alto', 'critico'),
descricao varchar(256),
data_criacao timestamp default current_timestamp,
primary key (idAlerta, fkCaptura)
);

create table if not exists CapturasLooca (
idLooca int auto_increment,
fkServidor int,
foreign key (fkServidor) references Servidor(idServidor),
bytes_enviados float,
bytes_recebidos float,
data_hora timestamp DEFAULT CURRENT_TIMESTAMP,
primary key (idLooca, fkServidor)
);

create table if not exists Alertas_looca (
idAlerta int auto_increment,
fkCaptura int,
foreign key (fkCaptura) references CapturasLooca(idLooca),
gravidade enum('baixo', 'médio', 'alto', 'critico'),
descricao varchar(256),
data_criacao timestamp default current_timestamp,
primary key (idAlerta, fkCaptura)
);


