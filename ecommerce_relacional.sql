create database ecommerce_entrega;
use ecommerce_entrega;

create table Cliente (
	idCliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(15),
    Mnint char(3),
    Lname varchar (15),
    CPF char(11) null UNIQUE,
    CNPJ char(14) null UNIQUE,
    Endereco VARCHAR(100),
    Tipo_Cliente enum ('Fisico','Empresa'),
    CONSTRAINT CK_Cliente_CPF_CNPJ CHECK (
		(CPF IS NOT NULL AND CNPJ IS NULL) OR 
		(CPF IS NULL AND CNPJ IS NOT NULL))
);

CREATE TABLE StatusPedido(
    idStatus INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Descricao_Status VARCHAR(45),
    Codigo_de_Rastreio VARCHAR(13) -- considerando envio pelos correios
);
    

CREATE TABLE Pedido (
    idPedido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Status_do_Pedido enum ('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    Descricao VARCHAR(45),
    Frete FLOAT,
    Cliente_idCliente INT,
    Data_do_Pedido DATETIME,
    Status_idStatus INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (Status_idStatus) REFERENCES StatusPedido(idStatus)
);

CREATE TABLE Produto (
    idProduto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Categoria enum('Eletrônico','Vestuário','Brinquedos','Alimentos','Móveis') not null,
    Descricao VARCHAR(45),
    Valor VARCHAR(45)
    );
    
CREATE TABLE ItensdoPedido (
    Produto_idProduto INT NOT NULL,
    Pedido_idPedido INT NOT NULL,
    Quantidade INT,
	PRIMARY KEY (Produto_idProduto, Pedido_idPedido),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido)
);

CREATE TABLE Estoque (
    idEstoque INT NOT NULL auto_increment primary key,
    Local VARCHAR(150)
);

CREATE TABLE EstoqueProduto (
    Produto_idProduto INT NOT NULL,
    Estoque_idEstoque INT NOT NULL,
    Quantidade INT,
    PRIMARY KEY( Produto_idProduto, Estoque_idEstoque),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (Estoque_idEstoque) REFERENCES Estoque(idEstoque)
);

CREATE TABLE Fornecedor (
    idFornecedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Razao_Social VARCHAR(45),
    CNPJ CHAR (14) UNIQUE
);

CREATE TABLE TerceiroVendedor (
    idTerceiro_Vendedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    CNPJ VARCHAR(14) NULL,
    CPF VARCHAR(11) NULL,
    Razao_Social VARCHAR(45)
);
DELIMITER //

CREATE TRIGGER validate_CPF_CNPJ_BEFORE_INSERT
BEFORE INSERT ON TerceiroVendedor
FOR EACH ROW
BEGIN
    IF (NEW.CPF IS NOT NULL AND NEW.CNPJ IS NOT NULL) OR
       (NEW.CPF IS NULL AND NEW.CNPJ IS NULL) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Erro: O CPF ou CNPJ devem ser inseridos para validar cadastro';
    END IF;
END //

DELIMITER ;

CREATE TABLE ProdutoDisponivelFornecedor (
    Fornecedor_idFornecedor INT NOT NULL,
    Produto_idProduto INT NOT NULL,
    PRIMARY KEY(Fornecedor_idFornecedor, Produto_idProduto),
    FOREIGN KEY (Fornecedor_idFornecedor) REFERENCES Fornecedor(idFornecedor),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
    );
    
CREATE TABLE FormasdePagamento (
    idFormaPagamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Tipo_de_Pagamento enum ('Boleto', 'Cartão de Crédito', 'Pix'),
    Pedido_Cliente_idCliente INT,
    FOREIGN KEY (Pedido_Cliente_idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE MetodoPagamentoCliente (
    Cliente_idCliente INT NOT NULL,
    FormasdePagamento_idFormaPagamento INT NOT NULL,
    PRIMARY KEY(Cliente_idCliente ,FormasdePagamento_idFormaPagamento),
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (FormasdePagamento_idFormaPagamento) REFERENCES FormasdePagamento(idFormaPagamento)
    );

