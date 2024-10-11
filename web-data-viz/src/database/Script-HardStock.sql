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
fkRepresentante int,
razaoSocial varchar (256),
cnpj char(14),
emailCorporativo varchar(256),
primary key (idEmpresa,fkRepresentante));

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

create table if not exists Componente (
idComponente int auto_increment,
fkServidor int,
foreign key (fkServidor) references Servidor(idServidor),
`cpu` float,
memoriaRam float,
disco float,
rede float,
primary key (idComponente,fkServidor));

create table if not exists Captura (
idCaptura int auto_increment,
fkComponenente int,
foreign key (fkComponenente) references Componente(idComponente),
unidadeMedida varchar (45),
`status` varchar (50),
primary key (idCaptura, fkComponenente)
);


create table if not exists Dados (
idDados int auto_increment,
fkCaptura int,
foreign key (fkCaptura) references Captura(idCaptura),
dados varchar(45),
horaData datetime,
primary key (idDados,fkCaptura));

create table if not exists Alertas (
idalerta int auto_increment,
fkComponente int,
foreign key (fkComponente) references Componente(idComponente),
gravidade enum('baixo', 'médio', 'alto', 'critico'),
descricao varchar(256),
data_criacao timestamp default current_timestamp,
primary key (idalerta,fkComponente));
