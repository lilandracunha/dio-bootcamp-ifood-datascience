-- Desafio: Construa um Projeto Lógico de Banco de Dados do Zero
-- Banco de Dados: Oficina mecânica

CREATE DATABASE IF NOT EXISTS oficina_v1;
USE oficina_v1;

CREATE TABLE cliente(
	idCliente INT NOT NULL AUTO_INCREMENT,
    nomeCompleto VARCHAR(200) NOT NULL,
    cpf CHAR(11) NOT NULL,
    dataNascimento DATE,
    email VARCHAR(50),
    telefonePrincipal VARCHAR(11) NOT NULL,
    telefoneSecundario VARCHAR(11),
    endereco VARCHAR(100) NOT NULL,
    cep INT NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado CHAR(2) NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (idCliente),
    CONSTRAINT unique_cliente UNIQUE (idCliente)
);
DESC cliente;

CREATE TABLE carro(
	idCarro INT NOT NULL AUTO_INCREMENT,
    modelo VARCHAR(50) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    anoFabricacao CHAR(4) NOT NULL,
    cor VARCHAR(30) NOT NULL,
    placa VARCHAR(7) NOT NULL,
    clienteCarro INT,
    CONSTRAINT pk_carro PRIMARY KEY (idCarro),
    CONSTRAINT unique_carro UNIQUE (idCarro),
    CONSTRAINT fk_clienteCarro FOREIGN KEY (clienteCarro) REFERENCES cliente(idCliente)
);
DESC carro;

CREATE TABLE colaborador(
	idMecanico INT NOT NULL AUTO_INCREMENT,
    mNomeCompleto VARCHAR(200) NOT NULL,
    mCpf CHAR(11) NOT NULL,
    mDataNascimento DATE NOT NULL,
    cargo VARCHAR(45) NOT NULL,
    especialidade VARCHAR(100) NOT NULL,
    salarioFixo FLOAT NOT NULL,
    mTelefonePrincipal VARCHAR(11) NOT NULL,
    mTelefoneSecundario VARCHAR(11),
    mEndereco VARCHAR(100) NOT NULL,
    mCep INT NOT NULL,
    mCidade VARCHAR(50) NOT NULL,
    mEstado CHAR(2) NOT NULL,
    CONSTRAINT pk_colaborador PRIMARY KEY (idMecanico),
    CONSTRAINT unique_colaborador UNIQUE (idMecanico)
);
DESC colaborador;

CREATE TABLE servico_prestado(
	ordemServico VARCHAR(10) NOT NULL,
    dataInicio DATE NOT NULL,
    dataTermino DATE NOT NULL DEFAULT '2100-12-31',
    resumo VARCHAR(100) NOT NULL,
    descricao VARCHAR(300) NOT NULL,
    statusServico ENUM('Em análise', 'Aguardando peças', 'Em andamento', 'Concluído') NOT NULL DEFAULT 'Em análise',
    trocouPecas ENUM('S','N') NOT NULL,
    servicosAdicionais ENUM('S','N') NOT NULL DEFAULT 'N',
    descricaoAdicional VARCHAR(200),
    osMecanico INT NOT NULL,
    osCarro INT NOT NULL,
    CONSTRAINT pk_ordemServico PRIMARY KEY (ordemServico),
    CONSTRAINT unique_ordemServico UNIQUE (ordemServico),
    CONSTRAINT fk_servicoMecanico FOREIGN KEY (osMecanico) REFERENCES colaborador(idMecanico),
    CONSTRAINT fk_servicoCarro FOREIGN KEY (osCarro) REFERENCES carro(idCarro)
);
DESC servico_prestado;

CREATE TABLE pecas(
	idPeca INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    quantidadeNecessaria INT NOT NULL,
    pcServico VARCHAR(10) NOT NULL,
    CONSTRAINT pk_pecas PRIMARY KEY (idPeca),
    CONSTRAINT unique_pecas UNIQUE (idPeca),
    CONSTRAINT fk_pecaServico FOREIGN KEY (pcServico) REFERENCES servico_prestado(ordemServico)
);
DESC pecas;

CREATE TABLE fornecedores(
	idFornecedor INT NOT NULL AUTO_INCREMENT,
    cnpj CHAR(14) NOT NULL,
    razaoSocial VARCHAR(100) NOT NULL,
    nomeFantasia VARCHAR(50),
    fEndereco VARCHAR(100) NOT NULL,
    fCep INT NOT NULL,
    fCidade VARCHAR(50) NOT NULL,
    fEstado CHAR(2) NOT NULL,
    fTelefone VARCHAR(11) NOT NULL,
    fEmail VARCHAR(45) NOT NULL,
    CONSTRAINT pk_fornecedores PRIMARY KEY (idFornecedor),
    CONSTRAINT unique_fornecedores UNIQUE (idFornecedor)
);
DESC fornecedores;

CREATE TABLE fornecedorPeca(
	idPecaCompra INT NOT NULL,
    idFornecedorVenda INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    valor FLOAT NOT NULL,
    PRIMARY KEY (idPecaCompra, idFornecedorVenda),
    CONSTRAINT fk_PecaCompra FOREIGN KEY (idPecaCompra) REFERENCES pecas(idPeca),
    CONSTRAINT fk_FornecedorVenda FOREIGN KEY (idFornecedorVenda) REFERENCES fornecedores(idFornecedor)
);
DESC fornecedorPeca;

-- Aqui foram definidas as regras para início do auto incremento nos IDs
ALTER TABLE cliente AUTO_INCREMENT = 001;
ALTER TABLE carro AUTO_INCREMENT = 110;
ALTER TABLE colaborador AUTO_INCREMENT = 1;
ALTER TABLE pecas AUTO_INCREMENT = 1;
ALTER TABLE fornecedores AUTO_INCREMENT = 2;

-- A seguir foram adicionados os dados para as tabelas (os dados utilizados foram gerados com auxílio do 4devs.com.br)

-- cliente: nomeCompleto, cpf, dataNascimento, email, telefonePrincipal, telefoneSecundario, endereco, cep, cidade, estado
INSERT INTO cliente(nomeCompleto, cpf, dataNascimento, email, telefonePrincipal, telefoneSecundario, endereco, cep, cidade, estado) 
	VALUES ('Luciana Alice Corte Real', '91090531745', '1991-06-08', 'luciana.alice.cortereal@email.com.br', '938356024', '9993147512', 'Rua Lindolpho Darróz, 970', 18145619, 'São Roque', 'SP'),
			('Bernardo Thales Yuri da Luz', '13243154820', '1967-03-10', 'bernardo.thales.daluz@seuemail.com.br', '1937592969', '19996402175', 'Jardim Quintas da Terracota, 747', 13332681, 'Indaiatuba', 'SP'),
            ('Luana Isabelle Heloise dos Santos', '77465282870', '1995-06-09', 'luana-dossantos74@emailbr.com.br', '1127818865', '1127818865', 'Rua Vicente Maurício Aricó, 873', 8210452, 'São Paulo', 'SP'),
            ('Osvaldo Nathan Cavalcanti', '66282916852', '1998-02-01', 'osvaldo.nathan.cavalcanti@emailbr.com.br', '11991364214', null, 'Rua Walter Bitran, 259', 4376050, 'São Paulo', 'SP'),
            ('Rayssa Regina Almeida', '60068630816', '1989-06-22', 'rayssa.regina.almeida@email.com', '11998897474', null, 'Rua Francisco de Barros Garcez', 8111450, 'São Paulo', 'SP'),
            ('Caio Augusto Brito', '53409723803', '1994-04-22', 'caio_brito@provedorbr.com.br', '1125563557', '11988986106', 'Rua Frei Oreste Girardi, 899', 8465040, 'São Paulo', 'SP'),
            ('Sérgio Lorenzo Rodrigo Nascimento', '50286398842', '2000-08-20', 'sergio-nascimento76@seuemail.com.br', '11984426520', null, 'Travessa Dora Lopes', 2356102, 'São Paulo', 'SP'),
            ('Kauê Renan Almeida', '12344860835', '1966-04-10', 'kauerenanalmeida@provedorbr.com.br', '11999041662', '1127951530', 'Rua Ezequiel Freire, 925, Ap 50', 2034001, 'São Paulo', 'SP'),
            ('Adriana Laura Sebastiana da Mata', '55758048879', '1985-02-12', 'adriana-damata94@seuemail.com.br', '11998066760', null, 'Rua Doutor Eduardo de Souza Aranha', 4543121, 'São Paulo', 'SP'),
            ('Emanuelly Bárbara Pires', '49737696816', '1978-02-04', 'emanuelly_barbara_pires@email.com', '11993201237', '1137879583', 'Rua dos Caetés, 90', 5016081, 'São Paulo', 'SP');

-- carro: modelo, marca, anoFabricacao, cor, placa, clienteCarro
INSERT INTO carro(modelo, marca, anoFabricacao, cor, placa, clienteCarro) VALUES 
			('Frontier AX CD 4x4 2.5 TB Interc. Diesel', 'Nissan', '2001', 'Vermelho', 'FED8088', 9),
            ('Gol 1.0 Trend/ Power 8V 2p', 'VW - VolksWagen', '2002', 'Verde', 'CTU1269', 5),
            ('MX-3 1.6 16V', 'Mazda', '1992', 'Bege', 'CBO7672', 1),
            ('Ranger XLS 3.0 PSE 163cv 4x2 CS TB Dies.', 'Ford', '2005', 'Marrom', 'EVI3073', 10),
            ('Palio ESSENCE Dualogic 1.6 Flex 16V 5p', 'Fiat', '2011', 'Preto', 'CYZ2106', 3),
            ('530 1.5 16V 103cv 4p', 'LIFAN', '2015', 'Azul', 'EUJ3530', 7),
            ('Forester XT 2.0 16V 4x4 Turbo Aut.', 'Subaru', '2014', 'Prata', 'BXX1242', 2),
            ('Brava HGT 1.8 mpi 16V  4p', 'Fiat', '2000', 'Laranja', 'CTC6798', 6),
            ('850 GLT 2.5 20V', 'Volvo', '1992', 'Azul', 'EKW4166', 5),
            ('Range R. Vogue 4.4 TDV8/SDV8 Diesel Aut.', 'Land Rover', '2011', 'Verde', 'CZS6155', 9),
            ('Sorento 3.3 V6 24V 270cv 4x2 Aut.', 'Kia Motors', '2016', 'Dourado', 'FEC3187', 8),
            ('135iA Coup', 'BMW', '2009', 'Azul', 'FLS5173', 4);

-- colaborador: mNomeCompleto, mCpf, mDataNascimento, cargo, especialidade, salarioFixo, mTelefonePrincipal, mTelefoneSecundario, mEndereco, mCep, mCidade, mEstado
INSERT INTO colaborador(mNomeCompleto, mCpf, mDataNascimento, cargo, especialidade, salarioFixo, mTelefonePrincipal, mTelefoneSecundario, mEndereco, mCep, mCidade, mEstado) VALUES
			('Agatha Elisa Isadora Barbosa', '31830287842', '1981-02-19', 'Gerente', 'Eletrônica', 7500, '11996221595', '1139454806', 'Alameda Jauaperi, 175, Moema', 4523011, 'São Paulo', 'SP'),
			('Stella Antonella Marcela Sales', '93015512846', '1994-02-06', 'Auxiliar', 'Funilaria', 2500, '11996891407', null, 'Rua Pedro de Ozeda, 651, Vila Marari', 4401190, 'São Paulo', 'SP'),
			('Raimunda Luzia Sandra Sales', '32011712882', '1985-02-16', 'Mecânica', 'Funilaria', 6300, '11988427841', '1139732274', 'Travessa Moisés, 217, Jardim Limoeiro', 8382682, 'São Paulo', 'SP'),
			('Clara Kamilly Melissa Ribeiro', '83818610800', '1997-01-07', 'Auxiliar', 'Pintura', 2900, '11989412498', '1125126770', 'Rua Engenheiro Fox, 701, Lapa de Baixo', 5069020, 'São Paulo', 'SP'),
			('Cecília Jennifer Rodrigues', '55749039897', '1991-03-15', 'Mecânica', 'Eletrônica', 6300, '11994184185', null, 'Rua Padre José Giannella, 523, Jardim São Jorge', 4432150, 'São Paulo', 'SP'),
			('Pietra Alice Cavalcanti', '52542202877', '1981-05-25', 'Mecânica', 'Pintura', 6300, '11983373870', '1127904733', 'Rua Estanislau Bonk Filho, 726, Parque Santo Eduardo', 3384030, 'São Paulo', 'SP');

/* servico_prestado: ordemServico, dataInicio, dataTermino DEFAULT 2100-12-31, resumo, descricao, 
statusServico ENUM(Em análise, Aguardando peças, Em andamento, Concluído) DEFAULT 'Em análise', trocouPecas ENUM(S,N), 
servicosAdicionais ENUM(S,N), descricaoAdicional, idMecanico, idCarro
Para a inclusão da ordem de serviço foram definidos alguns valores para padronização:
1 - Pintura
2 - Funilaria
3 - Elétrica
4 - Manutenção Preventiva */
INSERT INTO servico_prestado VALUES
			('1-001', '2023-08-12', '2023-08-17', 'Pintura completa', 'Cliente optou por mudar a cor do carro inteiro.', 'Concluído', 'N', 'N', null, 6, 110),
			('4-001', '2023-08-12', '2023-08-15', 'Manutenção', 'Veículo apresentou falhas no câmbio há alguns meses.', 'Concluído', 'S', 'S', 'Foi preciso solicitar compra de peça.', 5, 111),
            ('4-002', '2023-08-15', '2023-08-16', 'Manutenção', 'Família irá viajar no feriado de setembro e solicitou análise do veículo.', 'Concluído', 'N', 'N', null, 1, 112),
            ('2-001', '2023-08-17', '2023-08-23', 'Batida de carro', 'Cliente bateu o carro ao estacionar.', 'Concluído', 'S', 'N', null, 2, 113),
            ('1-002', '2023-08-19', DEFAULT, 'Pintura das portas', 'Cliente deseja mudar apenas a cor das portas do carro. Será preciso aguardar a chegada da tinta escolhida.', 'Aguardando peças', 'N', 'N', null, 4, 114),
            ('3-001', '2023-08-19', '2023-08-21', 'Falha eletrônica', 'Troca de bateria.', 'Concluído', 'S', 'N', null, 1, 115),
            ('4-003', '2023-08-20', DEFAULT, 'Manutenção', 'Embreagem apresentando resistência ao ser acionada.', 'Aguardando peças', 'S', 'N', 'N/A', 5, 116),
            ('1-003', '2023-08-20', '2023-08-30', 'Pintura completa', 'Pintura completa do carro.', 'Concluído', 'N', 'N', 'N/A', 4, 117),
            ('1-004', '2023-08-23', DEFAULT, 'Pintura completa', 'Pintura exterior completa.', DEFAULT, 'N', 'N', null, 6, 118),
            ('4-004', '2023-08-25', '2023-08-28', 'Orçamento', 'Cliente solicita orçamento para manutenção completa.', 'Concluído', 'N', 'N', null, 1, 119),
            ('2-002', '2023-08-27', DEFAULT, 'Lateral avariada', 'Lateral direita do veículo está seriamente danificada devido a uma batida.', 'Em andamento', 'N', 'N', 'Ainda estamos avaliando todos os danos', 3, 120),
            ('3-002', '2023-08-28', DEFAULT, 'Alternador', 'Cliente reclamou de problemas elétricos com o carro em movimento. O alternador está danificado.', 'Aguardando peças', 'S', 'S', 'Manutenção preventiva de todo o sistema elétrico.', 5, 121);
UPDATE servico_prestado SET trocouPecas = 'S' WHERE ordemServico = '1-002';
SELECT * FROM servico_prestado WHERE trocouPecas = 'S';

-- pecas: (titulo, quantidadeNecessaria, pcServico
INSERT INTO pecas(titulo, quantidadeNecessaria, pcServico) VALUES('Tinta azul perolado', '2', '1-002'),
																('Par de Amortecedor Original', '1', '2-001'),
                                                                ('Bateria 60ah', '1', '3-001'),
                                                                ('Alternador', '1', '3-002'),
                                                                ('Câmbio Manual VW', '1', '4-001'),
                                                                ('Kit de Embreagem 2006-2014', '1', '4-003');

-- fornecedores: cnpj, razaoSocial, nomeFantasia, fEndereco, fCep, fCidade, fEstado, fTelefone, fEmail
INSERT INTO fornecedores(cnpj, razaoSocial, nomeFantasia, fEndereco, fCep, fCidade, fEstado, fTelefone, fEmail) VALUES
			('60411672000111', 'Maurício Sousa Peças de Carros Ltda', 'MaxPeças', 'Travessa Êxodo, 821, Jardim Tarumãs', 11669198, 'Caraguatatuba', 'SP', '1236085997', 'vendas@maxpecas.com.br'),
            ('32241211000102', 'Henry e Severino Auto Ltda', 'Rep Veículos', 'Rua Rui Barbosa, 375, Vila Ana Rosa', 2997140, 'São Paulo', 'SP', '1128151840', 'atendimento@repveiculos.com.br'),
            ('30610416000192', 'Gabrielle Santos Veículos Ltda', 'GAuto Reparos Técnicos', 'Rua Affonso da Silva Pinheiro Júnior, 344, Bosque da Saúde', 4151070, 'São Paulo', 'SP', '11989757162', 'vendas@gauto.com.br');

-- fornecedorPeca: idPecaCompra, idFornecedorVenda, quantity, valor
INSERT INTO fornecedorPeca VALUES(1, 4, 4, 60.85),
								(2, 4, 2, 1380.90),
                                (3, 2, 2, 699.89),
                                (4, 3, 1, 315.90),
                                (5, 2, 4, 2350.90),
                                (6, 3, 2, 924.15);

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Após a inserção de dados em todas as tabelas, foram realizadas algumas consultas que podem ser visualizadas a seguir:

-- 1. Visualizar todos os dados de todas as tabelas.
SELECT * FROM cliente;
SELECT * FROM carro;
SELECT * FROM colaborador;
SELECT * FROM servico_prestado;
SELECT * FROM pecas;
SELECT * FROM fornecedores;
SELECT * FROM fornecedorPeca;

-- 2. Quais serviços do tipo 'Manutenção' (ordem de serviço iniciada em '4') foram realizados?
SELECT
	*
FROM
	servico_prestado
WHERE
	ordemServico like '4%';
    
-- 3. Verificar quais serviços foram realizados pela gerente (ao consultar os dados de colaboradores, vemos que a gerente possui o código 1).
SELECT 
	idMecanico AS ID_Colaborador,
	mNomeCompleto AS Nome_Gerente,
    ordemServico AS ID_Servico,
    dataInicio AS Inicio,
    dataTermino AS Termino,
    statusServico AS Servico
FROM 
	(servico_prestado JOIN colaborador ON osMecanico = idMecanico) 
WHERE 
	osMecanico = 1;

-- 4. Consultar informações sobre os serviços para os quais foi necessário solicitar peças.
SELECT
	sp.ordemServico AS Ordem_Servico,
    sp.dataInicio AS Inicio,
    sp.dataTermino AS Termino,
    cl.nomeCompleto AS Cliente,
    ca.idCarro AS ID_Carro,
    ca.modelo AS Modelo,
    sp.resumo AS Resumo,
    sp.descricao AS Detalhes
FROM
	servico_prestado sp
INNER JOIN carro ca ON osCarro = idCarro
INNER JOIN pecas pe ON pcServico = ordemServico
INNER JOIN cliente cl ON idCliente = clienteCarro
WHERE
	trocouPecas = 'S';
    
/* O valor pago pelo serviço é calculado através da aplicação. O total é composto por:
	- Mão de obra do funcionário (sendo 15% do salário fixo do colaborador);
	- Valor de espaço ocupado pelo veículo na oficina;
	- Peça comprada, quando necessário; 
*/ 

-- 5. Com base nos detalhes fornecidos acima, vamos calcular quanto foi cobrado por cada serviço
SELECT 
	sp.ordemServico,
    cl.nomeCompleto AS Cliente,
    TIMESTAMPDIFF(DAY, dataInicio, dataTermino) AS Dias_Garagem,
    (TIMESTAMPDIFF(DAY, dataInicio, dataTermino)) * 75 AS Valor_Garagem,
    co.salarioFixo * 0.15 AS Comissao,
    pe.titulo AS Peca_Comprada,
    pe.quantidadeNecessaria AS Quantidade,
    fp.valor AS Valor_Peca,
    round(pe.quantidadeNecessaria * fp.valor) AS Total_Peca,
    co.mNomeCompleto AS Mecanico_Responsavel
FROM 
	servico_prestado sp
		LEFT JOIN (SELECT * FROM pecas) pe ON sp.ordemServico = pe.pcServico
        LEFT JOIN (SELECT * FROM fornecedorPeca) fp ON pe.idPeca = fp.idPecaCompra
INNER JOIN carro ca ON osCarro = idCarro
INNER JOIN colaborador co ON osMecanico = idMecanico
INNER JOIN cliente cl ON idCliente = clienteCarro
WHERE
	statusServico = 'Concluído';
    
SELECT 
	sp.ordemServico,
    (TIMESTAMPDIFF(DAY, dataInicio, dataTermino)) * 75 AS Valor_Garagem,
    co.salarioFixo * 0.15 AS Comissao,
    round(pe.quantidadeNecessaria * fp.valor) AS Total_Peca
FROM 
	servico_prestado sp
		LEFT JOIN (SELECT * FROM pecas) pe ON sp.ordemServico = pe.pcServico
        LEFT JOIN (SELECT * FROM fornecedorPeca) fp ON pe.idPeca = fp.idPecaCompra
INNER JOIN carro ca ON osCarro = idCarro
INNER JOIN colaborador co ON osMecanico = idMecanico
INNER JOIN cliente cl ON idCliente = clienteCarro
WHERE
	statusServico = 'Concluído';