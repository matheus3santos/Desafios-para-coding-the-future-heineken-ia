CREATE TABLE Cliente (
  idCliente INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  telefone VARCHAR(15),
  endereco VARCHAR(255)
);

CREATE TABLE Veiculo (
  idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
  placa VARCHAR(10) UNIQUE NOT NULL,
  modelo VARCHAR(45) NOT NULL,
  ano YEAR NOT NULL,
  Cliente_idCliente INT NOT NULL,
  FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE
);

CREATE TABLE Mecanico (
  idMecanico INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  endereco VARCHAR(255),
  especialidade VARCHAR(45)
);

CREATE TABLE OrdemServico (
  idOrdemServico INT AUTO_INCREMENT PRIMARY KEY,
  dataEmissao DATE NOT NULL,
  valorTotal DECIMAL(10,2) NOT NULL,
  status ENUM('Em Andamento', 'Concluída', 'Cancelada') NOT NULL,
  dataConclusao DATE,
  Veiculo_idVeiculo INT NOT NULL,
  Mecanico_idMecanico INT NOT NULL,
  FOREIGN KEY (Veiculo_idVeiculo) REFERENCES Veiculo(idVeiculo) ON DELETE CASCADE,
  FOREIGN KEY (Mecanico_idMecanico) REFERENCES Mecanico(idMecanico) ON DELETE CASCADE
);

CREATE TABLE Servico (
  idServico INT AUTO_INCREMENT PRIMARY KEY,
  descricao VARCHAR(255) NOT NULL,
  valorMaoDeObra DECIMAL(10,2) NOT NULL
);

CREATE TABLE Peca (
  idPeca INT AUTO_INCREMENT PRIMARY KEY,
  descricao VARCHAR(255) NOT NULL,
  valor DECIMAL(10,2) NOT NULL
);

CREATE TABLE OrdemServico_Servico (
  OrdemServico_id INT NOT NULL,
  Servico_id INT NOT NULL,
  PRIMARY KEY (OrdemServico_id, Servico_id),
  FOREIGN KEY (OrdemServico_id) REFERENCES OrdemServico(idOrdemServico) ON DELETE CASCADE,
  FOREIGN KEY (Servico_id) REFERENCES Servico(idServico) ON DELETE CASCADE
);

CREATE TABLE OrdemServico_Peca (
  OrdemServico_id INT NOT NULL,
  Peca_id INT NOT NULL,
  quantidade INT NOT NULL,
  PRIMARY KEY (OrdemServico_id, Peca_id),
  FOREIGN KEY (OrdemServico_id) REFERENCES OrdemServico(idOrdemServico) ON DELETE CASCADE,
  FOREIGN KEY (Peca_id) REFERENCES Peca(idPeca) ON DELETE CASCADE
);

CREATE TABLE Equipe (
  idEquipe INT AUTO_INCREMENT PRIMARY KEY,
  nomeEquipe VARCHAR(100) NOT NULL
);

CREATE TABLE Mecanico_Equipe (
  Mecanico_id INT NOT NULL,
  Equipe_id INT NOT NULL,
  PRIMARY KEY (Mecanico_id, Equipe_id),
  FOREIGN KEY (Mecanico_id) REFERENCES Mecanico(idMecanico) ON DELETE CASCADE,
  FOREIGN KEY (Equipe_id) REFERENCES Equipe(idEquipe) ON DELETE CASCADE
);

CREATE TABLE Equipe_OrdemServico (
  Equipe_id INT NOT NULL,
  OrdemServico_id INT NOT NULL,
  PRIMARY KEY (Equipe_id, OrdemServico_id),
  FOREIGN KEY (Equipe_id) REFERENCES Equipe(idEquipe) ON DELETE CASCADE,
  FOREIGN KEY (OrdemServico_id) REFERENCES OrdemServico(idOrdemServico) ON DELETE CASCADE
);

-- Inserindo clientes
INSERT INTO Cliente (nome, telefone, endereco) VALUES
('Carlos Silva', '11987654321', 'Rua das Flores, 123'),
('Mariana Souza', '21976543210', 'Av. Central, 456'),
('João Pereira', '31965432109', 'Praça da Paz, 789');

-- Inserindo veículos
INSERT INTO Veiculo (placa, modelo, ano, Cliente_idCliente) VALUES
('ABC1234', 'Honda Civic', 2020, 1),
('XYZ5678', 'Toyota Corolla', 2019, 2),
('LMN9876', 'Ford Focus', 2021, 3);

-- Inserindo mecânicos
INSERT INTO Mecanico (nome, endereco, especialidade) VALUES
('Roberto Lima', 'Rua dos Mecânicos, 11', 'Suspensão'),
('Fernanda Castro', 'Av. dos Reparos, 22', 'Motor'),
('Lucas Oliveira', 'Travessa das Engrenagens, 33', 'Elétrica');

-- Inserindo ordens de serviço
INSERT INTO OrdemServico (dataEmissao, valorTotal, status, dataConclusao, Veiculo_idVeiculo, Mecanico_idMecanico) VALUES
('2024-03-01', 1200.00, 'Concluída', '2024-03-03', 1, 1),
('2024-03-05', 800.50, 'Em Andamento', NULL, 2, 2),
('2024-03-10', 950.75, 'Concluída', '2024-03-12', 3, 3);

-- Inserindo serviços
INSERT INTO Servico (descricao, valorMaoDeObra) VALUES
('Troca de óleo', 150.00),
('Alinhamento e balanceamento', 200.00),
('Revisão completa', 500.00);

-- Inserindo peças
INSERT INTO Peca (descricao, valor) VALUES
('Filtro de óleo', 50.00),
('Pastilha de freio', 250.00),
('Amortecedor dianteiro', 600.00);

-- Vinculando serviços às ordens de serviço
INSERT INTO OrdemServico_Servico (OrdemServico_id, Servico_id) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Vinculando peças às ordens de serviço
INSERT INTO OrdemServico_Peca (OrdemServico_id, Peca_id, quantidade) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 1);

-- Inserindo equipes
INSERT INTO Equipe (nomeEquipe) VALUES
('Equipe A'),
('Equipe B'),
('Equipe C');

-- Associando mecânicos às equipes
INSERT INTO Mecanico_Equipe (Mecanico_id, Equipe_id) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Associando equipes às ordens de serviço
INSERT INTO Equipe_OrdemServico (Equipe_id, OrdemServico_id) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Recuperar todos os clientes
SELECT * FROM cliente;

-- Recuperar todos os veículos cadastrados
SELECT * FROM veiculo;

-- Recuperar todas as ordens de serviço
SELECT * FROM ordemservico;

-- Recuperar clientes que moram em São Paulo
SELECT * FROM cliente;

-- Recuperar veículos de determinada marca
SELECT * FROM veiculo WHERE modelo = 'Toyota Corolla';

-- Recuperar ordens de serviço com valor maior que R$ 500,00
SELECT * FROM ordemservico WHERE valorTotal > 500;

-- Recuperar ordens de serviço com status 'Em Andamento'
SELECT * FROM OrdemServico WHERE status = 'Em Andamento';

-- Calcular a idade do veículo com base no ano de fabricação
SELECT modelo, ano, (YEAR(CURDATE()) - ano) AS idade_veiculo
FROM Veiculo;

-- Calcular o valor total da ordem de serviço com acréscimo de 10% de imposto
SELECT idOrdemServico, valorTotal, (valorTotal * 1.1) AS valor_com_imposto
FROM OrdemServico;

-- Calcular o total de peças utilizadas em uma ordem de serviço
SELECT os.idOrdemServico, SUM(op.quantidade * p.valor) AS valor_total_pecas
FROM OrdemServico_Peca op
JOIN Peca p ON op.Peca_id = p.idPeca
JOIN OrdemServico os ON op.OrdemServico_id = os.idOrdemServico
GROUP BY os.idOrdemServico;

-- Listar as ordens de serviço junto com os clientes e veículos
SELECT os.idOrdemServico, os.dataEmissao, c.nome AS cliente_nome, v.modelo AS veiculo_modelo
FROM OrdemServico os
JOIN Veiculo v ON os.Veiculo_idVeiculo = v.idVeiculo
JOIN Cliente c ON v.Cliente_idCliente = c.idCliente;

-- Listar os mecânicos e as equipes com as ordens de serviço a que estão associados
SELECT m.nome AS mecanico_nome, e.nomeEquipe, os.idOrdemServico, os.status
FROM Mecanico m
JOIN Mecanico_Equipe me ON m.idMecanico = me.Mecanico_id
JOIN Equipe e ON me.Equipe_id = e.idEquipe
JOIN Equipe_OrdemServico eo ON e.idEquipe = eo.Equipe_id
JOIN OrdemServico os ON eo.OrdemServico_id = os.idOrdemServico;