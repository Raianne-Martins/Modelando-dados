use ecommerce_entrega;

INSERT INTO Cliente (Fname, Mnint, Lname, CPF, CNPJ, Endereco, Tipo_Cliente) VALUES
	('João', 'A', 'Silva', '12345678901', NULL, 'Rua A, 123', 'Fisico'),
	('Maria', 'B', 'Souza', NULL, '12345678000190', 'Avenida B, 456', 'Empresa'),
	('Carlos', 'C', 'Pereira', '23456789012', NULL, 'Travessa C, 789', 'Fisico'),
	('Ana', 'D', 'Oliveira', NULL, '23456789000191', 'Rua D, 101', 'Empresa'),
	('Pedro', 'E', 'Lima', '34567890123', NULL, 'Avenida E, 202', 'Fisico'),
	('Beatriz', 'F', 'Gomes', NULL, '34567890000192', 'Rua F, 303', 'Empresa'),
	('Lucas', 'G', 'Santos', '45678901234', NULL, 'Travessa G, 404', 'Fisico'),
	('Fernanda', 'H', 'Ribeiro', NULL, '45678901000193', 'Avenida H, 505', 'Empresa'),
	('Gabriel', 'I', 'Fernandes', '56789012345', NULL, 'Rua I, 606', 'Fisico'),
	('Juliana', 'J', 'Almeida', NULL, '56789012000194', 'Travessa J, 707', 'Empresa');

INSERT INTO StatusPedido (Descricao_Status, Codigo_de_Rastreio) VALUES
	('Pedido Confirmado', 'BR1234567890'),
	('Pedido Cancelado', 'BR0987654321');


INSERT INTO Pedido (Status_do_Pedido, Descricao, Frete, Cliente_idCliente, Data_do_Pedido, Status_idStatus) VALUES
	('Confirmado', 'Pedido de eletrônicos', 10.50, 1, '2025-02-25 12:00:00', 1),
	('Cancelado', 'Pedido de roupas', 5.00, 2, '2025-02-24 15:30:00', 2),
	('Confirmado', 'Pedido de brinquedos', 8.00, 3, '2025-02-23 14:00:00', 1),
	('Em processamento', 'Pedido de alimentos', 7.00, 4, '2025-02-22 13:00:00', 1),
	('Cancelado', 'Pedido de móveis', 20.00, 5, '2025-02-21 11:00:00', 2);


INSERT INTO Produto (Categoria, Descricao, Valor) VALUES
	('Eletrônico', 'Smartphone', '1500.00'),
	('Vestuário', 'Camisa', '50.00'),
	('Alimentos', 'Chocolate', '10.00'),
    ('Brinquedos', 'Boneca', '25.00'),
	('Móveis', 'Mesa', '200.00');

INSERT INTO ItensdoPedido (Produto_idProduto, Pedido_idPedido, Quantidade) VALUES
	(1, 1, 2),
	(2, 2, 3),
    (3, 3, 1),
	(4, 4, 5),
	(5, 5, 6);

INSERT INTO Estoque (Local) VALUES
	('Armazém Central -MG'),
	('Armazém Secundário - SP');

INSERT INTO EstoqueProduto (Produto_idProduto, Estoque_idEstoque, Quantidade) VALUES
	(1, 1, 100),
	(2, 2, 50),
	(3, 1, 200);

INSERT INTO Fornecedor (Razao_Social, CNPJ) VALUES
	('Fornecedor A', '23456789000191'),
	('Fornecedor B', '34567890000192'),
    ('Fornecedor C', '45678900000193'),
	('Fornecedor D', '56789000000194'),
	('Fornecedor E', '67890000000195');

INSERT INTO TerceiroVendedor (CNPJ, CPF, Razao_Social) VALUES
	(NULL, '23456789012', 'Terceiro A'),
	('45678901000193', NULL, 'Terceiro B');

INSERT INTO ProdutoDisponivelFornecedor (Fornecedor_idFornecedor, Produto_idProduto) VALUES
	(1, 1),
	(2, 2);
    
INSERT INTO ProdutoDisponivelFornecedor (Fornecedor_idFornecedor, Produto_idProduto) VALUES
    (1, 3),
	(2, 4),
	(2, 5),
    (8, 3),
    (9, 1),
    (10,2);

INSERT INTO FormasdePagamento (Tipo_de_Pagamento, Pedido_Cliente_idCliente) VALUES
	('Boleto', 1),
	('Cartão de Crédito', 2),
    ('Pix', 3),
	('Boleto', 4),
	('Cartão de Crédito', 5);
    
INSERT INTO MetodoPagamentoCliente (Cliente_idCliente, FormasdePagamento_idFormaPagamento) VALUES
	(1, 1),
	(2, 2),
    (3, 3),
	(4, 4),
	(5, 5);


-- Query 1 - Pedidos confirmados

SELECT idPedido, Descricao, Frete, Data_do_Pedido, Status_do_Pedido
FROM Pedido
WHERE Status_do_Pedido = 'Confirmado';

-- Query 2 - Todos os produtos disponíveis em estoque

SELECT Produto.Descricao, Estoque.Local, EstoqueProduto.Quantidade
FROM Produto
JOIN EstoqueProduto ON Produto.idProduto = EstoqueProduto.Produto_idProduto
JOIN Estoque ON EstoqueProduto.Estoque_idEstoque = Estoque.idEstoque;

-- Query 3 - Todos os fornecedores cadastrados

SELECT Fornecedor.Razao_Social, Produto.Descricao
FROM Fornecedor
JOIN ProdutoDisponivelFornecedor ON Fornecedor.idFornecedor = ProdutoDisponivelFornecedor.Fornecedor_idFornecedor
JOIN Produto ON ProdutoDisponivelFornecedor.Produto_idProduto = Produto.idProduto;

-- Query 4 - Listar produtos por categoria

SELECT Categoria, Descricao, Valor
FROM Produto
ORDER BY Categoria;

-- Query 5 - Listar os vendedores de marketplace
SELECT idTerceiro_Vendedor, Razao_Social, CPF, CNPJ
FROM TerceiroVendedor;

-- Query 6 - Listar o que cada cliente pediu

SELECT Pedido.idPedido, Pedido.Descricao, Cliente.Fname, Cliente.Lname
FROM Pedido
JOIN Cliente ON Pedido.Cliente_idCliente = Cliente.idCliente;

-- Query 7 - Total de Clientes Fisicos e Empresas

SELECT Tipo_Cliente, COUNT(idCliente) AS TotalClientes
FROM Cliente
GROUP BY Tipo_Cliente
HAVING COUNT(idCliente) > 0
ORDER BY TotalClientes DESC;
