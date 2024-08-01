-- Inserir dados

INSERT INTO Pessoa (nome, logradouro, cidade, estado, telefone, email) VALUES ('nome a', 'logradouro a', 'cidade a','es' ,'telefone a', 'email a');
INSERT INTO Pessoa (nome, logradouro, cidade, estado, telefone, email) VALUES ('Marvin', 'Rua 12', 'Riacho do Sul','PA' ,'1111-1111', 'marvin@gmail.com');
INSERT INTO Pessoa (nome, logradouro, cidade, estado, telefone, email) VALUES ('Chantili', 'Rua 12', 'Riacho do Sul','PA' ,'1112-1111', 'chan@gmail.com');
INSERT INTO Pessoa (nome, logradouro, cidade, estado, telefone, email) VALUES ('Joao', 'Rua 13', 'RJ','PA' ,'1123-1111', 'JOAOaaa@gmail.com');
INSERT INTO Pessoa (nome, logradouro, cidade, estado, telefone, email) VALUES ('JJC', 'Rua 12', 'RJ','PA' ,'1233-1111', 'JJC@gmail.com');
INSERT INTO Pessoa (nome, logradouro, cidade, estado, telefone, email) VALUES ('Enterprise', 'logradouro', 'RJ','PA' ,'1523-1111', '1234566@gmail.com');

INSERT INTO Produto (nome, quantidade, precoVenda) VALUES ('nome produto', 50, 5000);
INSERT INTO Produto (nome, quantidade, precoVenda) VALUES ('Camiseta Azul', 564, 7000);
INSERT INTO Produto (nome, quantidade, precoVenda) VALUES ('Calça jeans', 15, 400);
INSERT INTO Produto (nome, quantidade, precoVenda) VALUES ('Tênis Esportivo', 55, 4000);

INSERT INTO Usuario (login, senha) VALUES ('login u', 'senhau');
INSERT INTO Usuario (login, senha) VALUES ('op1', 'op1');
INSERT INTO Usuario (login, senha) VALUES ('op2', 'op2');
INSERT INTO Usuario (login, senha) VALUES ('op3', 'op3');

INSERT INTO PessoaFisica (cpf, idPessoa) VALUES ('45451556', 1);
INSERT INTO PessoaFisica (cpf, idPessoa) VALUES ('11111111111', 2);
INSERT INTO PessoaFisica (cpf, idPessoa) VALUES ('11111111112', 3);
INSERT INTO PessoaFisica (cpf, idPessoa) VALUES ('11111111113', 4);
INSERT INTO PessoaFisica (cpf, idPessoa) VALUES ('11111111453', 5);

INSERT INTO PessoaJuridica (cnpj, idPessoa) VALUES ('454162533456', 1);
INSERT INTO PessoaJuridica (cnpj, idPessoa) VALUES ('22222222222222', 5);
INSERT INTO PessoaJuridica (cnpj, idPessoa) VALUES ('33333333333333', 6);

INSERT INTO Movimento (idUsuario, idPessoa, idProduto, quantidade, tipo, valorUnitario) VALUES (1, 1, 1, 2, 'E', 5000);
INSERT INTO Movimento (idUsuario, idPessoa, idProduto, quantidade, tipo, valorUnitario) VALUES (2, 2, 2, 1, 'E', 1000);
INSERT INTO Movimento (idUsuario, idPessoa, idProduto, quantidade, tipo, valorUnitario) VALUES (2, 2, 2, 1, 'E', 1000);
INSERT INTO Movimento (idUsuario, idPessoa, idProduto, quantidade, tipo, valorUnitario) VALUES (2, 2, 2, 1, 'S', 1000);
INSERT INTO Movimento (idUsuario, idPessoa, idProduto, quantidade, tipo, valorUnitario) VALUES (2, 2, 2, 1, 'S', 1000);
INSERT INTO Movimento (idUsuario, idPessoa, idProduto, quantidade, tipo, valorUnitario) VALUES (2, 2, 2, 1, 'S', 1000);
INSERT INTO Movimento (idUsuario, idPessoa, idProduto, quantidade, tipo, valorUnitario) VALUES (3, 3, 2, 1, 'E', 10000);
INSERT INTO Movimento (idUsuario, idPessoa, idProduto, quantidade, tipo, valorUnitario) VALUES (3, 3, 3, 10, 'E', 50000);
INSERT INTO Movimento (idUsuario, idPessoa, idProduto, quantidade, tipo, valorUnitario) VALUES (3, 3, 4, 10, 'E', 40000);
INSERT INTO Movimento (idUsuario, idPessoa, idProduto, quantidade, tipo, valorUnitario) VALUES (2, 2, 3, 2, 'S', 4000);
INSERT INTO Movimento (idUsuario, idPessoa, idProduto, quantidade, tipo, valorUnitario) VALUES (2, 2, 3, 2, 'S', 4000);
INSERT INTO Movimento (idUsuario, idPessoa, idProduto, quantidade, tipo, valorUnitario) VALUES (2, 2, 4, 2, 'S', 4000);
INSERT INTO Movimento (idUsuario, idPessoa, idProduto, quantidade, tipo, valorUnitario) VALUES (3, 3, 4, 2, 'S', 4000);

-- Dados Completos de Pessoas Físicas
SELECT * FROM PessoaFisica pf
JOIN Pessoa p ON pf.idPessoa = p.idPessoa;


-- Dados Completos de Pessoas Jurídicas
SELECT * FROM PessoaJuridica pj
JOIN Pessoa p ON pj.idPessoa = p.idPessoa;


-- Movimentações de entrada, com produto, fornecedor, quantidade, preço unitário e valor total.
SELECT m.idMovimento, p.nome AS Produto, u.login AS Fornecedor, m.quantidade, m.valorUnitario, (m.quantidade * m.valorUnitario) AS ValorTotal
FROM Movimento m
JOIN Produto p ON m.idProduto = p.idProduto
JOIN Usuario u ON m.idUsuario = u.idUsuario
WHERE m.tipo = 'E';


-- Movimentações de saída, com produto, comprador, quantidade, preço unitário e valor total.
SELECT m.idMovimento, p.nome AS Produto, c.nome AS Comprador, m.quantidade, m.valorUnitario, (m.quantidade * m.valorUnitario) AS ValorTotal
FROM Movimento m
JOIN Produto p ON m.idProduto = p.idProduto
JOIN Pessoa c ON m.idPessoa = c.idPessoa
WHERE m.tipo = 'S';


-- Valor total das entradas agrupadas por produto.
SELECT p.nome AS Produto, SUM((m.quantidade * m.valorUnitario)) AS ValorTotalEntrada
FROM Movimento m
JOIN Produto p ON m.idProduto = p.idProduto
WHERE m.tipo = 'E'
GROUP BY p.nome;


-- Valor total das saídas agrupadas por produto.
SELECT p.nome AS Produto, SUM((m.quantidade * m.valorUnitario)) AS ValorTotalSaida
FROM Movimento m
JOIN Produto p ON m.idProduto = p.idProduto
WHERE m.tipo = 'S'
GROUP BY p.nome;


-- Operadores que não efetuaram movimentações de entrada (compra).
SELECT u.login
FROM Usuario u
LEFT JOIN Movimento m ON u.idUsuario = m.idUsuario AND m.tipo = 'E'
WHERE m.idMovimento IS NULL;


-- Valor total de entrada, agrupado por operador.
SELECT u.login, SUM((m.quantidade * m.valorUnitario)) AS ValorTotalEntrada
FROM Movimento m
JOIN Usuario u ON m.idUsuario = u.idUsuario
WHERE m.tipo = 'E'
GROUP BY u.login;


-- Valor total de saída, agrupado por operador.
SELECT u.login, SUM((m.quantidade * m.valorUnitario)) AS ValorTotalSaida
FROM Movimento m
JOIN Usuario u ON m.idUsuario = u.idUsuario
WHERE m.tipo = 'S'
GROUP BY u.login;


-- Valor médio de venda por produto, utilizando média ponderada.
SELECT p.nome AS Produto, AVG(m.quantidade * p.precoVenda) AS MediaPonderada
FROM Movimento m
JOIN Produto p ON m.idProduto = p.idProduto
WHERE m.tipo = 'S'
GROUP BY p.nome;

