CREATE TABLE IF NOT EXISTS `Pagamento` (
  `idPagamento` INT AUTO_INCREMENT PRIMARY KEY,
  `tipoPagamento` VARCHAR(45) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Cliente` (
  `idCliente` INT AUTO_INCREMENT PRIMARY KEY,
  `nome` VARCHAR(100) NOT NULL,
  `cpf` VARCHAR(14) UNIQUE,
  `cnpj` VARCHAR(18) UNIQUE,
  `endereco` VARCHAR(255) NOT NULL,
  `idPagamento` INT,
  FOREIGN KEY (`idPagamento`) REFERENCES `Pagamento`(`idPagamento`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Entrega` (
  `idEntrega` INT AUTO_INCREMENT PRIMARY KEY,
  `status` VARCHAR(45) NOT NULL,
  `codigoRastreio` VARCHAR(45) NOT NULL UNIQUE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Pedido` (
  `idPedido` INT AUTO_INCREMENT PRIMARY KEY,
  `statusPedido` VARCHAR(45) NOT NULL,
  `descricao` TEXT NOT NULL,
  `frete` FLOAT DEFAULT 0.0,
  `idCliente` INT NOT NULL,
  `idEntrega` INT NOT NULL,
  FOREIGN KEY (`idCliente`) REFERENCES `Cliente`(`idCliente`),
  FOREIGN KEY (`idEntrega`) REFERENCES `Entrega`(`idEntrega`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Produto` (
  `idProduto` INT AUTO_INCREMENT PRIMARY KEY,
  `categoria` VARCHAR(45) NOT NULL,
  `descricao` TEXT NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Fornecedor` (
  `idFornecedor` INT AUTO_INCREMENT PRIMARY KEY,
  `razaoSocial` VARCHAR(100) NOT NULL,
  `cnpj` VARCHAR(18) NOT NULL UNIQUE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Fornecedor_Produto` (
  `idFornecedor` INT NOT NULL,
  `idProduto` INT NOT NULL,
  PRIMARY KEY (`idFornecedor`, `idProduto`),
  FOREIGN KEY (`idFornecedor`) REFERENCES `Fornecedor`(`idFornecedor`),
  FOREIGN KEY (`idProduto`) REFERENCES `Produto`(`idProduto`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Estoque` (
  `idEstoque` INT AUTO_INCREMENT PRIMARY KEY,
  `localizacao` VARCHAR(255) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `ProdutoEstoque` (
  `idProduto` INT NOT NULL,
  `idEstoque` INT NOT NULL,
  `quantidade` INT DEFAULT 0,
  PRIMARY KEY (`idProduto`, `idEstoque`),
  FOREIGN KEY (`idProduto`) REFERENCES `Produto`(`idProduto`),
  FOREIGN KEY (`idEstoque`) REFERENCES `Estoque`(`idEstoque`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `PedidoProduto` (
  `idPedido` INT NOT NULL,
  `idProduto` INT NOT NULL,
  `quantidade` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`idPedido`, `idProduto`),
  FOREIGN KEY (`idPedido`) REFERENCES `Pedido`(`idPedido`),
  FOREIGN KEY (`idProduto`) REFERENCES `Produto`(`idProduto`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `VendedorTerceiro` (
  `idVendedor` INT AUTO_INCREMENT PRIMARY KEY,
  `razaoSocial` VARCHAR(100) NOT NULL,
  `localizacao` VARCHAR(255) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Vendedor_Produto` (
  `idVendedor` INT NOT NULL,
  `idProduto` INT NOT NULL,
  `quantidade` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idVendedor`, `idProduto`),
  FOREIGN KEY (`idVendedor`) REFERENCES `VendedorTerceiro`(`idVendedor`),
  FOREIGN KEY (`idProduto`) REFERENCES `Produto`(`idProduto`)
) ENGINE = InnoDB;

-- Inserindo tipos de pagamento
INSERT INTO Pagamento (tipoPagamento) VALUES 
('Cartão de Crédito'),
('Boleto Bancário'),
('Pix');

-- Inserindo clientes
INSERT INTO Cliente (nome, cpf, cnpj, endereco, idPagamento) VALUES 
('Carlos Silva', '123.456.789-00', NULL, 'Rua das Flores, 100 - São Paulo', 1),
('Ana Souza', NULL, '12.345.678/0001-99', 'Avenida Paulista, 200 - São Paulo', 2),
('Mariana Rocha', '987.654.321-00', NULL, 'Rua Minas Gerais, 50 - Belo Horizonte', 3),
('João Pereira', '111.222.333-44', NULL, 'Rua Curitiba, 150 - Curitiba', 1),
('Fernanda Lima', NULL, '98.765.432/0001-88', 'Rua Porto Alegre, 300 - Porto Alegre', 2);

-- Inserindo status de entrega
INSERT INTO Entrega (status, codigoRastreio) VALUES 
('Enviado', 'BR1234567890BR'),
('A caminho', 'BR0987654321BR'),
('Entregue', 'BR5678901234BR'),
('Pendente', 'BR4321098765BR');

-- Inserindo pedidos
INSERT INTO Pedido (statusPedido, descricao, frete, idCliente, idEntrega) VALUES 
('Confirmado', 'Pedido de eletrônicos', 20.00, 1, 1),
('Enviado', 'Pedido de móveis', 50.00, 2, 2),
('Pendente', 'Pedido de periféricos', 30.00, 3, 3),
('Entregue', 'Pedido de informática', 25.00, 4, 4),
('Confirmado', 'Pedido de acessórios', 15.00, 5, 1);

-- Inserindo produtos
INSERT INTO Produto (categoria, descricao, valor) VALUES 
('Eletrônicos', 'Notebook Dell XPS 13', 8500.00),
('Periféricos', 'Mouse sem fio Logitech', 250.00),
('Móveis', 'Cadeira Gamer RGB', 1200.00),
('Eletrônicos', 'Monitor 27" Samsung', 1500.00),
('Acessórios', 'Teclado Mecânico Redragon', 500.00);

-- Inserindo fornecedores
INSERT INTO Fornecedor (razaoSocial, cnpj) VALUES 
('Tech Eletrônicos Ltda', '11.222.333/0001-44'),
('Moveis & Cia', '22.333.444/0001-55'),
('Gamer Store', '33.444.555/0001-66');

-- Relacionando fornecedores e produtos
INSERT INTO Fornecedor_Produto (idFornecedor, idProduto) VALUES 
(1, 1),
(1, 4),
(2, 3),
(3, 2),
(3, 5);

-- Inserindo estoques
INSERT INTO Estoque (localizacao) VALUES 
('São Paulo - Central'),
('Rio de Janeiro - Sul'),
('Curitiba - Norte');

-- Relacionando produtos ao estoque
INSERT INTO ProdutoEstoque (idProduto, idEstoque, quantidade) VALUES 
(1, 1, 10),
(2, 2, 30),
(3, 1, 5),
(4, 3, 20),
(5, 2, 15);

-- Relacionando produtos aos pedidos
INSERT INTO PedidoProduto (idPedido, idProduto, quantidade) VALUES 
(1, 1, 1),
(1, 4, 1),
(2, 3, 2),
(3, 2, 3),
(4, 5, 1),
(5, 2, 2);

-- Inserindo vendedores terceiros
INSERT INTO VendedorTerceiro (razaoSocial, localizacao) VALUES 
('Loja Tech Plus', 'São Paulo - Centro'),
('Gamer World', 'Belo Horizonte - Savassi'),
('Eletrônicos Prime', 'Curitiba - Batel');

-- Relacionando vendedores terceiros e produtos
INSERT INTO Vendedor_Produto (idVendedor, idProduto, quantidade) VALUES 
(1, 1, 5),
(1, 2, 10),
(2, 3, 8),
(2, 4, 4),
(3, 5, 12);

-- 1. Recuperações simples com SELECT Statement
-- Exemplo: Listar todos os clientes cadastrados.

SELECT * FROM Cliente;

-- 2. Filtros com WHERE Statement
-- Exemplo: Buscar pedidos com status "Confirmado".

SELECT * FROM Pedido WHERE statusPedido = 'Confirmado';

-- Exemplo: Buscar produtos da categoria "Eletrônicos" com preço acima de R$ 1.000,00.

SELECT * FROM Produto WHERE categoria = 'Eletrônicos' AND valor > 1000.00;

-- 3. Criar expressões para gerar atributos derivados
-- Exemplo: Exibir o valor total dos produtos em cada pedido (quantidade * valor).

SELECT 
    pp.idPedido,
    p.descricao AS produto,
    pp.quantidade,
    p.valor,
    (pp.quantidade * p.valor) AS valor_total
FROM PedidoProduto pp
JOIN Produto p ON pp.idProduto = p.idProduto;

-- Exemplo: Criar um campo derivado para exibir um status mais legível para o cliente.

SELECT 
    idEntrega,
    status,
    CASE 
        WHEN status = 'Enviado' THEN 'Em trânsito'
        WHEN status = 'A caminho' THEN 'Próximo da entrega'
        WHEN status = 'Entregue' THEN 'Finalizado'
        ELSE 'Pendente'
    END AS descricao_status
    
FROM Entrega;
-- 4. Definir ordenações dos dados com ORDER BY
-- Exemplo: Listar produtos em ordem decrescente de valor.

SELECT * FROM Produto ORDER BY valor DESC;
-- Exemplo: Listar clientes em ordem alfabética.

SELECT * FROM Cliente ORDER BY nome ASC;

-- 5. Condições de filtros aos grupos – HAVING Statement
-- Exemplo: Exibir o total de pedidos por cliente, mas apenas para clientes que fizeram mais de um pedido.


SELECT 
    c.idCliente, 
    c.nome, 
    COUNT(p.idPedido) AS total_pedidos
FROM Cliente c
JOIN Pedido p ON c.idCliente = p.idCliente
GROUP BY c.idCliente, c.nome
HAVING COUNT(p.idPedido) > 1;
-- Exemplo: Exibir categorias de produtos com preço médio superior a R$ 1.000,00.

SELECT 
    categoria, 
    AVG(valor) AS preco_medio
FROM Produto
GROUP BY categoria
HAVING AVG(valor) > 1000.00;

-- 6. Criar junções entre tabelas para fornecer uma perspectiva mais complexa dos dados
-- Exemplo: Listar todos os pedidos junto com os nomes dos clientes e o status da entrega.

SELECT 
    p.idPedido,
    c.nome AS cliente,
    p.statusPedido,
    e.status AS status_entrega
FROM Pedido p
JOIN Cliente c ON p.idCliente = c.idCliente
JOIN Entrega e ON p.idEntrega = e.idEntrega;

-- Exemplo: Exibir quais fornecedores fornecem quais produtos e seus valores.

SELECT 
    f.razaoSocial AS fornecedor,
    p.descricao AS produto,
    p.valor
FROM Fornecedor_Produto fp
JOIN Fornecedor f ON fp.idFornecedor = f.idFornecedor
JOIN Produto p ON fp.idProduto = p.idProduto;


-- Exemplo: Mostrar a quantidade de produtos disponíveis em cada estoque.

SELECT 
    e.localizacao AS estoque,
    p.descricao AS produto,
    pe.quantidade
FROM ProdutoEstoque pe
JOIN Estoque e ON pe.idEstoque = e.idEstoque
JOIN Produto p ON pe.idProduto = p.idProduto
ORDER BY e.localizacao;



