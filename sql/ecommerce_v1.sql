-- Desafio: Construindo seu Primeiro Projeto Lógico de Banco de Dados
-- Banco de Dados: E-commerce Básico

CREATE DATABASE IF NOT EXISTS ecommerce_v1;
USE ecommerce_v1;

-- Criação das tabelas
-- Produto
CREATE TABLE product(
	SKU INT NOT NULL,
    title VARCHAR(25) NOT NULL,
    category VARCHAR(30),
    pDescription VARCHAR(100) NOT NULL,
    price FLOAT NOT NULL,
    CONSTRAINT pk_product PRIMARY KEY (SKU),
    CONSTRAINT unique_product UNIQUE (SKU)
);
DESC product;

-- Cliente
CREATE TABLE storeClient(
	clientID INT NOT NULL AUTO_INCREMENT,
    fName VARCHAR(15) NOT NULL,
    mName VARCHAR(45),
    lName VARCHAR(45) NOT NULL,
    cpf CHAR(11) NOT NULL,
    address VARCHAR(200) NOT NULL,
    zipCode INT NOT NULL,
    bDate DATE,
    clientEmail VARCHAR(45) NOT NULL,
    firstPhone VARCHAR(11) NOT NULL,
    secondPhone VARCHAR(11),
    CONSTRAINT pk_client PRIMARY KEY (clientID),
    CONSTRAINT unique_client UNIQUE (cpf)
);
DESC storeClient;

-- Pedido
CREATE TABLE storeOrder(
	orderID INT NOT NULL AUTO_INCREMENT,
    orderStatus ENUM('Novo', 'Pagamento aprovado', 'Faturado', 'Enviado', 'Entregue', 'Cancelado') NOT NULL DEFAULT 'Novo',
    creationDate DATE NOT NULL,
    freight FLOAT,
    payment ENUM('Débito', 'Crédito', 'PIX', 'Voucher', 'Boleto') NOT NULL,
    secondPayment ENUM('Débito', 'Crédito', 'PIX', 'Voucher', 'Boleto'),
    cardName VARCHAR(45),
    cardNumber INT,
    cardDate INT,
    cardValidation INT,
    paymentStatus ENUM('Processando', 'Aprovado', 'Recusado') NOT NULL DEFAULT 'Processando',
    clientIDOrder INT,
    CONSTRAINT pk_order PRIMARY KEY (orderID),
    CONSTRAINT unique_order UNIQUE (orderID),
    CONSTRAINT fk_orderClient FOREIGN KEY (clientIDOrder) REFERENCES storeClient(clientID)
);
DESC storeOrder;
ALTER TABLE storeOrder MODIFY cardNumber CHAR(16);

-- Produto x Pedido
CREATE TABLE productOrder(
	orderSKUp INT,
    orderIDc INT,
    quantity INT DEFAULT 1,
    PRIMARY KEY (orderSKUp, orderIDc),
    CONSTRAINT fk_orderSKU FOREIGN KEY (orderSKUp) REFERENCES product(SKU),
    CONSTRAINT fk_orderID FOREIGN KEY (orderIDc) REFERENCES storeOrder(orderID)
);
DROP TABLE productOrder;
DESC productOrder;

-- Estoque
CREATE TABLE stock(
	warehouseID VARCHAR(10) NOT NULL,
    address VARCHAR(200) NOT NULL,
    zipCode INT NOT NULL,
    stock INT DEFAULT 0,
    warehouseSKU INT,
    PRIMARY KEY (warehouseID, warehouseSKU),
    CONSTRAINT fk_productStock FOREIGN KEY (warehouseSKU) REFERENCES product(SKU)
);
DESC stock;
-- Para validar o drop, exclui a tabela stock e criei-a novamente
DROP TABLE stock;

-- Fornecedor
CREATE TABLE supplier(
	supplierID INT NOT NULL,
    cnpj CHAR(14) NOT NULL,
    corporateName VARCHAR(50) NOT NULL,
    vendorName VARCHAR(30),
    address VARCHAR(200) NOT NULL,
    firstPhone VARCHAR(11) NOT NULL,
    secondPhone VARCHAR(11),
    email VARCHAR(45) NOT NULL,
    CONSTRAINT pk_supplier PRIMARY KEY (supplierID),
    CONSTRAINT unique_supplierId UNIQUE (supplierID),
    CONSTRAINT unique_supplierCNPJ UNIQUE (cnpj)
);
DESC supplier;

-- Produto x Fornecedor
CREATE TABLE productSupplier(
	productSKUsupplier INT,
    supplierProductID INT,
    quantity INT DEFAULT 0,
    PRIMARY KEY (productSKUsupplier, supplierProductID),
    CONSTRAINT fk_productSupplier FOREIGN KEY (productSKUsupplier) REFERENCES product(SKU),
    CONSTRAINT fk_supplierID FOREIGN KEY (supplierProductID) REFERENCES supplier(supplierID)
);
DESC productSupplier; 

-- Vendedor
CREATE TABLE seller(
	sellerID INT NOT NULL,
    cpfCnpj VARCHAR(14) NOT NULL,
    corporateName VARCHAR(50) NOT NULL,
    vendorName VARCHAR(30),
    address VARCHAR(200) NOT NULL,
    firstPhone VARCHAR(11) NOT NULL,
    secondPhone VARCHAR(11),
    email VARCHAR(45) NOT NULL,
    CONSTRAINT pk_seller PRIMARY KEY (sellerID),
    CONSTRAINT unique_sellerId UNIQUE (sellerID),
    CONSTRAINT unique_sellerCpfCnpj UNIQUE (cpfCnpj)
);
DESC seller;

-- Produto x Vendedor
CREATE TABLE productSeller(
	productSKUseller INT,
    sellerProductID INT,
    quantity INT DEFAULT 1,
    PRIMARY KEY (productSKUseller, sellerProductID),
    CONSTRAINT fk_productSeller FOREIGN KEY (productSKUseller) REFERENCES product(SKU),
    CONSTRAINT fk_sellerID FOREIGN KEY (sellerProductID) REFERENCES seller(sellerID)
);
DESC productSeller;

-- A seguir verifiquei se todas as tabelas que defini no meu modelo estavam devidamente criadas
SHOW TABLES;

-- O próximo passo foi fazer uma análise exploratória do meu esquema, a fim de validar as constraints
SHOW DATABASES;
USE information_schema;
DESC referential_constraints;

SELECT * FROM referential_constraints WHERE constraint_schema = 'ecommerce_v1';
    
-- Depois de conferir as constraints, voltei para o database ecommerce_v1;
USE ecommerce_v1;

-- Foram adicionados parâmetros para o auto increment presente nas tabelas de cliente e pedido
ALTER TABLE storeClient AUTO_INCREMENT = 1;
ALTER TABLE storeOrder AUTO_INCREMENT = 20;

-- Antes de começar a persistência dos dados, optei por alterar algumas informações nas tabelas criadas
-- product: Adicionar campos referemtes a dimensão e peso
ALTER TABLE product ADD weight FLOAT NOT NULL;
ALTER TABLE product ADD height FLOAT NOT NULL;
ALTER TABLE product ADD width FLOAT NOT NULL;
ALTER TABLE product ADD lenght FLOAT NOT NULL;
DESC product;

-- storeClient: Incluir o campo para identificação do sexo. Como trata-se de um teste, serão adicionadas apenas 2 opções
ALTER TABLE storeClient ADD sex ENUM('F','M');
DESC storeClient;

-- storeOrder: Alterar o tipo de dado para a colua cardDate
ALTER TABLE storeOrder MODIFY cardDate DATE;
DESC storeOrder;

-- Agora serão inseridos manualmente valores para as tabelas
-- Os dados dos clientes e fornecedores/vendedores foram gerados com auxílio da ferramenta www.4devs.com.br

-- product: SKU, title, category, pDescription, price, weight (peso - kg), height (altura - cm), width (largura- cm), lenght (comprimento - cm)
INSERT INTO product VALUES ('1001', 'Mouse Gamer Wireless', 'Periféricos', 'Mouse com ótimo desempenho para jogos diversos.', '355.99', '0.200', '20', '16', '7'),
							('1002', 'Headset Gamer RGB', 'Periféricos', 'Fone de ouvido confortável, USB, com cores RGB.', '500.90', '0.270', '10', '22', '22'),
                            ('2001', 'Fita Led RGB Wi-Fi MarcaX', 'Casa Inteligente', 'Fita Led de 2m autocolante que pode ser conectada a assistentes (como Alexa).', '59.9', '2', '1', '9', '200'),
                            ('2002', 'Fita Led RGB Wi-Fi MarcaY', 'Casa Inteligente', 'Fita Led de 2m autocolante que pode ser conectada a assistentes (como Alexa).', '39.89', '2', '1', '15', '200'),
                            ('2003', 'Robô Aspirador', 'Casa Inteligente', 'Robô aspirador. Wi-Fi com conexão a assistentes (como Alexa e Google).', '700.9', '5.15', '8', '11', '11'),
                            ('3001', 'Smart TV 50 Polegadas', 'TV', 'TV com imagem nítida em 4K.', '2350.99', '14', '65', '112', '126');

-- storeClient: clientID (AUTO_INCREMENT), fName, mName, lName, cpf (11), address, zipCode (INT), bDate, clientEmail, firstPhone, secondPhone
INSERT INTO storeClient (fName, mName, lName, cpf, address, zipCode, bDate, clientEmail, firstPhone, secondPhone) VALUES 
						('Juliana', null, 'Silva', 92192804008, 'Quadra 611 Sul Alameda 15 600, Plano Diretor Sul, Palmas - TO', 77016531, '1988-09-27', 'silva_juliana@email.com', '6321274133', '6334046150'),
                        ('Gabriel', 'Santos', 'Pereira', 45838160063, 'Rua Corbélia 908, Champagnat, Londrina - PR', 86062620, '1977-01-11', 'gspereira@email.com.br', '4221663815', null),
                        ('Maria', 'Pimentel', 'Santos', 37405467008, 'Rua Santo Elói 232, Angelim, Teresina - PI', 64040225, '2001-02-22', 'pimentel_mary@meuemail.com.br', '8631189165', null),
                        ('Kauê', 'Rodrigues', 'Souza', 47053701042, 'Rua Pascoal Carlos Magno 11, Patronato, Santa Maria - RS', 97020610, '2003-11-06', 'ka_rosouza@email.com.br', '5327919109', '5333135641'),
                        ('Leonardo', null, 'França', 67964591053, 'Rua CGU 569, Rocas, Natal - RN', 59012148, '1973-05-13', 'franca_leo@email.com.br', '8438491866', null),
                        ('Carolina', 'Cruz', 'Assis', 06285008078, 'Travessa Maria Bonfim 11, São Marcos, Salvador - BA', 41250118, '1989-10-18', 'carol_cassis@meuemail.com.br', '7731684420', null),
                        ('Maria', 'Ribeiro', 'Pereira', 95577004080, 'Rua Três 44 AP 42, Santa Tereza, Porto Alegre - RS', 90840580, '1986-02-21', 'maria_ribeiro@emaildois.com.br', '5434695826', '5426888872'),
                        ('João', 'Ferreira', 'Cardoso', 72264651083, 'Rua Professora Anita Brasil 98, Urussanguinha, Araranguá - SC', 88905414, '1981-03-20', 'jo_ferreira@email.com', '4921473902', '4935584270'),
                        ('Roberta', 'Chaves', 'Bispo', 22449509054, 'Rua Minas Gerais 154, Alvarenga, São Bernardo do Campo - SP', 9856460, '1986-01-18', 'roberta.cbispo@email.com.br', '11957133314', '1123482338'),
                        ('José', null, 'Lacerda', 10402532023, 'Rua Onofre Pires 44, Scharlau, São Leopoldo - RS', 93120130, '1978-10-19', 'joselacerda@emaildois.com.br', '5520686333', null);

UPDATE storeClient SET sex = 'F' WHERE fName = 'Juliana' 
									OR fName = 'Maria'
                                    OR fName = 'Carolina'
                                    OR fName = 'Roberta';

UPDATE storeClient SET sex = 'M' WHERE fName = 'Gabriel' 
									OR fName = 'Kauê'
                                    OR fName = 'Leonardo'
                                    OR fName = 'João'
                                    OR fName = 'José';
SELECT fName, lName, sex FROM storeClient;

-- storeOrder: orderID (AUTO_INCREMENT), orderStatus ('Novo', 'Pagamento aprovado', 'Faturado', 'Enviado', 'Entregue', 'Cancelado'); DEFAULT 'Novo', 
	-- creationDate, freight, payment ('Débito', 'Crédito', 'PIX', 'Voucher', 'Boleto'), 
    -- secondPayment (mesmos valores do primeiro, porém não é obrigatório), cardName, cardNumber, cardDate INT, cardValidation, 
    -- paymentStatus ENUM('Processando', 'Aprovado', 'Recusado'); DEFAULT 'Processando', clientIDOrder INT,
INSERT INTO storeOrder (orderStatus, creationDate, freight, payment, secondPayment, cardName, cardNumber, cardDate, cardValidation, paymentStatus, clientIDOrder) VALUES 
					('Faturado', '2023-08-22', 89.9, 'Crédito', 'Voucher', 'Juliana Silva', '5589580726344301', '2027-06-26', 459, 'Aprovado', 1),
                    ('Pagamento aprovado', '2023-08-26', 15.89, 'Débito', 'Voucher', 'Carolina C Assis', '6581179525184475', '2033-10-13', 245, 'Aprovado', 6),
                    ('Cancelado', '2023-08-15', null, 'PIX', null, null, null, null, null, 'Recusado', 6),
                    (DEFAULT, '2023-08-20', null, 'Boleto', null, null, null, null, null, 'Processando', 8),
                    ('Novo', '2023-08-28', null, 'Boleto', null, null, null, null, null, DEFAULT, 4);

-- productOrder: orderSKU, orderID, quantity DEFAULT 1
INSERT INTO productOrder VALUES ('2003', '20', 1),
								('2001', '21', 2),
                                ('1001', '22', 1),
                                ('1002', '23', 1),
                                ('2001', '24', 3);

-- stock: warehouseID, address, zipCode, stock, warehouseSKU
INSERT INTO stock VALUES ('SP1101', 'Rua Bahia 35, Jardim Novo Pantanal, São Paulo - SP', 4472180, 0, '1001'),
						('SP1101', 'Rua Bahia 35, Jardim Novo Pantanal, São Paulo - SP', 4472180, 5, '1002'),
                        ('SP1101', 'Rua Bahia 35, Jardim Novo Pantanal, São Paulo - SP', 4472180, 2, '2001'),
                        ('SP1101', 'Rua Bahia 35, Jardim Novo Pantanal, São Paulo - SP', 4472180, 10, '2002'),
                        ('SP1101', 'Rua Bahia 35, Jardim Novo Pantanal, São Paulo - SP', 4472180, 1, '2003'),
                        ('SP1101', 'Rua Bahia 35, Jardim Novo Pantanal, São Paulo - SP', 4472180, 0, '3001'),
                        ('RJ2101', 'Rua Santo Cristo 1000, Santo Cristo, Rio de Janeiro - RJ', 20220304, 0, '1001'),
                        ('RJ2101', 'Rua Santo Cristo 1000, Santo Cristo, Rio de Janeiro - RJ', 20220304, 2, '1002'),
                        ('RJ2101', 'Rua Santo Cristo 1000, Santo Cristo, Rio de Janeiro - RJ', 20220304, 1, '2001'),
                        ('RJ2101', 'Rua Santo Cristo 1000, Santo Cristo, Rio de Janeiro - RJ', 20220304, 1, '2002'),
                        ('RJ2101', 'Rua Santo Cristo 1000, Santo Cristo, Rio de Janeiro - RJ', 20220304, 3, '2003'),
                        ('RJ2101', 'Rua Santo Cristo 1000, Santo Cristo, Rio de Janeiro - RJ', 20220304, 15, '3001');

-- supplier: supplierID, cnpj, corporateName, vendorName , address, firstPhone, secondPhone, email
INSERT INTO supplier VALUES (110010, '39697244000100', 'Bento e Adriana Eletrônicos Ltda', 'B&A Eletrônicos', 'Rua Tipuana 55, Pestana, Osasco - SP', '1129239391', '11996717608', 'estoque@bentoeadrianaltda.com.br'),
							(110011, '43860184000172', 'Milena e Murilo Informática ME', 'MM Info', 'Rua 22, Jardim Itapuã 1000, Rio Claro - SP', '1929840629', '19986489223', 'venda@milenaemuriloinformaticame.com.br'),
                            (210010, '37830764000114', 'Novo Rio Marcenaria e Eletrônica Ltda', 'Novo Rio Eletrônica', 'Travessa do Canal 673, Barra da Tijuca - RJ', '2125513516', null, 'qualidade@nrmarcenaria.com.br');

-- productSupplier: productSKUsupplier, supplierProductID, quantity DEFAULT 0,
INSERT INTO productSupplier VALUES (1001, 110010, DEFAULT),
								(1001, 110011, 2),
                                (1001, 210010, 1),
                                (1002, 110010, 3),
                                (1002, 210010, 2),
                                (2001, 110010, 2),
                                (2001, 110011, DEFAULT),
                                (2001, 210010, 5),
                                (2002, 110010, 15),
                                (2002, 110011, 2),
                                (2002, 210010, 5),
                                (2003, 210010, 2),
                                (3001, 110010, 1),
                                (3001, 110011, 1),
                                (3001, 210010, DEFAULT);

-- seller: sellerID, cpfCnpj, corporateName, vendorName, address, firstPhone, secondPhone, email
INSERT INTO seller VALUES (901, '52670087000108', 'Clara e Sebastião Tecnologia Ltda', 'CS Tech', 'Rua Felipe Portinho 153, Jardim Colorado, Campo Grande - MS', '6728618520', '67984303121', 'vendas@cstech.com.br'),
						(902, '9806893000131', 'Luciana Souza Telecomunicações ME', 'Luciana Tecnologia', 'Rua Toledo 850, Bethânia, Ipatinga - MG', '3129663560', null, 'atendimento@email.com'),
                        (903, '46269995000191', 'Josefa Produtos Eletrônicos Ltda', 'JOS Eletrônicos', 'Rua Carlos Ângelo Casara 887, Nossa Senhora do Rosário, Caxias do Sul - RS', '5427681550', '54989121967', 'compras@joseletronicos.com.br'),
                        (904, '80937876000106', 'Stefany e Isaac Tech ME', null, 'Caminho D-3 796, Piaçaveira, Camaçari - BA', '7127278830', null, 'sti.tech@email.com'),
                        (905, '37341216000120', 'MV & MP Tecnologia Ltda', null, 'Travessa Olívia Aldeia 204, Barro Vermelho, São Gonçalo - RJ', '2125700801', '21984059974', 'contato@mvp.com.br'),
                        (906, '51176505000142', 'Rafaela e Betina Ltda', 'RB Informática', 'Rua Valter 173, Vila do Tinguá, Queimados - RJ', '2127154357', '21995241258', 'sac@rbinformatica.com.br'),
                        (907, '79435500000106', 'Thomas Tech Ltda', null, 'Rua Professor Antônio Sidney Borba 879, Jardim Bom Jesus, Jaboticabal - SP', '1635920436', '16983065672', 'atendimento_thomastech@email.com');

-- productSeller: productSKUseller, sellerProductID, quantity DEFAULT 1,
INSERT INTO productSeller VALUES ('1001', 907, 3),
								('1001', 902, 1),
                                ('1002', 901, 2),
                                ('2001', 907, 3),
                                ('2001', 904, 5),
                                ('2001', 906, 1),
                                ('2002', 903, 3),
                                ('2002', 901, 3),
                                ('2003', 905, 3),
                                ('2003', 907, 1);
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Após a inserção de dados em todas as tabelas, foram realizadas algumas consultas que podem ser visualizadas a seguir:

-- 1. Visualizar todos os dados de todas as tabelas.
SHOW TABLES;
SELECT * FROM product;
SELECT * FROM storeClient;
SELECT * FROM storeOrder;
SELECT * FROM productOrder;
SELECT * FROM stock;
SELECT * FROM supplier; 
SELECT * FROM productSupplier;
SELECT * FROM seller;
SELECT * FROM productSeller;

-- 2. Quais foram os produtos comprados por cada cliente.
SELECT 
	CONCAT(fName, ' ', lName) AS Nome,
    title AS Título
FROM 
	storeClient c, 
    storeOrder o,
    productOrder po,
    product pr
WHERE 
	(c.clientID = o.clientIDOrder)
    AND (o.orderID = po.orderIDc)
    AND (po.orderSKUp = pr.SKU);

-- 3. Quantos pedidos foram feitos por cada cliente.
SELECT
	clientID AS ID_Cliente,
	CONCAT(fName, ' ', lName) AS Nome,
    count(*) AS Pedidos_Realizados
FROM 
	storeClient c, 
    storeOrder o,
    productOrder po,
    product pr
WHERE 
	(c.clientID = o.clientIDOrder)
    AND (o.orderID = po.orderIDc)
    AND (po.orderSKUp = pr.SKU)
GROUP BY
	ID_Cliente, Nome;

-- 4. Quais pedidos cujos pagamentos estão em processamento. Para estes pedidos será apresentado o item escolhido pelo cliente.
SELECT 
	orderID AS ID_Pedido,
    orderStatus AS Status_Pedido,
    creationDate AS Data_Criacao,
    paymentStatus AS Status_Pagamento,
    SKU,
    title AS Item
FROM 
	storeClient c, 
    storeOrder o,
    productOrder po,
    product pr
WHERE 
	(c.clientID = o.clientIDOrder)
    AND (o.orderID = po.orderIDc)
    AND (po.orderSKUp = pr.SKU)
    AND paymentStatus = 'Processando'
ORDER BY creationDate DESC;

-- 5. Quais fornecedores possuem estoque para o SKU 2003 (Robô Aspirador).
SELECT
	supplierID AS ID_Fornecedor,
    corporateName AS Razao_Social,
    ps.quantity AS Estoque
FROM
	supplier s,
    productSupplier ps
WHERE
	(s.supplierID = ps.supplierProductID)
    AND ps.productSKUsupplier = 2003;
    
-- 6. Quais vendedores possuem mais de dois itens em estoque para o SKU 2001.
SELECT
	s.sellerID,
    s.corporateName AS Razao_Social,
    pse.quantity
FROM
	productSeller pse,
    seller s
WHERE
	pse.sellerProductID = s.sellerID
    AND pse.quantity >= 2
    AND pse.productSKUseller = 2001;

-- 7. Qual o estoque do SKU 2002 em todos os centros de distribuição (warehouses).
SELECT
    p.SKU,
    sum(stock) AS Total
FROM
	stock st,
    product p
WHERE
	st.warehouseSKU = 2002
    AND (p.SKU = st.warehouseSKU);
    
-- 8. Todos os clientes do estado do Rio Grande do Sul (RS).
SELECT
	clientID AS ID_Cliente,
	CONCAT(fName, ' ', lName) AS Nome,
    address AS Endereco,
    zipCode AS CEP,
    clientEmail AS Email,
    firstPhone AS Telefone
FROM
	storeClient
WHERE
	address like '%RS';
