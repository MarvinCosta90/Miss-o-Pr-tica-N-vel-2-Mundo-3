CREATE TABLE Pessoa (
    idPessoa INT IDENTITY(1,1) PRIMARY KEY,
    nome NVARCHAR(255),
    logradouro NVARCHAR(255),
    cidade NVARCHAR(255),
    estado CHAR(2),
    telefone NVARCHAR(255),
    email NVARCHAR(255)
);

INSERT INTO Pessoa (nome, logradouro, cidade, estado, telefone, email) VALUES ('nome a', 'logradouro a', 'cidade a','es' ,'telefone a', 'email a');

SELECT * FROM Pessoa;

CREATE TABLE Produto (
    idProduto INT IDENTITY(1,1) PRIMARY KEY,
    nome NVARCHAR(255),
    quantidade INT,
    precoVenda NUMERIC
);

INSERT INTO Produto (nome, quantidade, precoVenda) VALUES ('nome produto', 50, 5000);

SELECT * FROM Produto;

CREATE TABLE Usuario (
    idUsuario INT IDENTITY(1,1) PRIMARY KEY,
    login NVARCHAR(255),
    senha NVARCHAR(255)
);

INSERT INTO Usuario (login, senha) VALUES ('login u', 'senhau');

SELECT * FROM Usuario;

CREATE TABLE PessoaFisica (
    cpf NVARCHAR(11) PRIMARY KEY,
    idPessoa INT FOREIGN KEY REFERENCES Pessoa(idPessoa)
);

CREATE TABLE PessoaJuridica (
    cnpj NVARCHAR(14) PRIMARY KEY,
    idPessoa INT FOREIGN KEY REFERENCES Pessoa(idPessoa)
);

INSERT INTO PessoaFisica (cpf, idPessoa) VALUES ('454516456', 1);

SELECT * FROM PessoaFisica;

INSERT INTO PessoaJuridica (cnpj, idPessoa) VALUES ('454516213456', 1);

SELECT * FROM PessoaJuridica;

CREATE TABLE Movimento (
    idMovimento INT IDENTITY(1,1) PRIMARY KEY,
    idUsuario INT FOREIGN KEY REFERENCES Usuario(idUsuario),
    idPessoa INT FOREIGN KEY REFERENCES Pessoa(idPessoa),
    idProduto INT FOREIGN KEY REFERENCES Produto(idProduto),
    quantidade INT,
    tipo CHAR(1),
    valorUnitario FLOAT
);

INSERT INTO Movimento (idUsuario, idPessoa, idProduto, quantidade, tipo, valorUnitario) VALUES (1, 1, 1, 2, 'E', 5000);

SELECT * FROM Movimento;