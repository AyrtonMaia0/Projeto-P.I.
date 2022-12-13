# Avestruz Solutions - GL Refrigerações - Banco de Dados

---

**Projeto de BD para o PI:**

- [x]  Elabora os diagramas do seu PI (domínios de negócio):
    - [x]  o Modelagens de entidade relacionamento (MER)
    - [x]  o Modelagem relacional (MR)
- [x]  Crie um documento simples do seu projeto de Banco de Dados para o PI que
tenha as sessões (É OBRIGATÓRIO A CRIAÇÃO DESSE DOCUMENTO):
    - [ ]  o Descreva em mais detalhes o minimundo do seu PI;
    - [ ]  o Descreva o modelo lógico (Diagrama MER);
    - [ ]  o Descreva o modelo físico (Diagrama MR);
    - [ ]  o Anexe a esse documento os Scripts abaixo de uma forma organizada
    e bem documentada.
- [x]  Crie um script que irá conter todos dos scripts de criação
(DDL) das tabelas e views do seu banco de dados (Todos os
CREATES TABLE...);
- [ ]  Crie alguns scripts (no mínimo 5) para **alterar** (DDL) as
estruturas das tabelas;
- [ ]  Crie um script para destruir (DDL) todas as **tabelas**, **views**,
**procedimentos**, **funções** e **dependências** do seu banco de
dados;
- [ ]  Crie um script que irá realizar todos os **inserts** (DML) nas
tabelas do seu banco de dados. Cada tabela deve ter no
mínimo 10 registros, use o bom senso;
- [ ]  Crie scripts (no mínimo 10) para **deletar** ou **atualizar** (DML)
os dados inseridos nas tabelas.
- [ ]  Crie um script que irá realizar as suas
**consultas/perguntas/relatórios (DQL)**, é obrigatório uso
de **join** e **subselect** na maioria das consultas. Devem criar no
mínimo 20 scripts de SELECT. Descreva casa uma das
consultas para que foram elaboradas.
- [ ]  Crie um script para criar as **views (DDL)** (no mínimo 10) dos
principais relatórios do seu projeto.
- [ ]  Crie um script que irá criar e executar as procedures e
**funções** do seu banco de dados. Use o SP/SQL, como
colocado em sala de aula, e devem fazer no mínimo 10
**procedures/funçõe**s;
- [ ]  Crie um script que irá criar e executar corretamente as
triggers do seu banco de dados. Use o SP/SQL, como colocado
em sala de aula, e devem fazer no mínimo 6 **triggers**;

---

# Descrição

Nosso Banco de Dados foi criado com base no Projeto vinculado com a cadeira ‘Unidade de Extensão’, com o **Projeto Integrador.**

Obtivemos um contato com a empresa **GL Refrigeração.** Com base nas reuniões com a distribuidora, vimos que havia um problema interno de Gestão, tanto na parte de cadastro dos pedidos de compra e venda com os clientes, como também dos produtos que chegam dos carregamentos para abastecimento do estoque.

Pensando nisso partimos para fazer o mapeamento interno da empresa e como poderíamos melhorar esse sistema de gerenciamento.

---

# Modelo Conceitual

---

# Modelo Lógico (MER)

---

# Modelo Físico (MR)

---

## DDL - **Data Definition Language**

### **Criando Banco de dados e tabelas - DDL**

> Criação do Banco de Dados
> 

```sql
-- -----------------------------------------------------
-- Schema AZSolution
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `AZSolution` DEFAULT CHARACTER SET utf8 ;
USE `AZSolution` ;
```

> Criação da Tabela Funcionário
> 

```sql
-- -----------------------------------------------------
-- Table `AZSolution`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AZSolution`.`Funcionario` (
  `CPF` BIGINT(11) NOT NULL,
  `nome` VARCHAR(120) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `salario` DECIMAL(8,2) NOT NULL,
  `dataAdm` DATE NOT NULL,
  `dataDem` DATE NULL,
  `status` TINYINT NOT NULL,
  `Funcao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`CPF`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;
```

> Criação da Tabela Venda
> 

```sql
-- -----------------------------------------------------
-- Table `AZSolution`.`Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AZSolution`.`Venda` (
  `idVenda` INT NOT NULL AUTO_INCREMENT,
  `dataVenda` DATE NOT NULL,
  `valorTotal` DECIMAL(8,2) NOT NULL,
  `obs` VARCHAR(200) NULL,
  `Funcionario_CPF` BIGINT(11) NOT NULL,
  PRIMARY KEY (`idVenda`),
  UNIQUE INDEX `idVenda_UNIQUE` (`idVenda` ASC) VISIBLE,
  INDEX `fk_Venda_Funcionario_idx` (`Funcionario_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Venda_Funcionario`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `AZSolution`.`Funcionario` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
```

> Criação da Tabela Cliente
> 

```sql
-- -----------------------------------------------------
-- Table `AZSolution`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AZSolution`.`Cliente` (
  `CNPJ` BIGINT(14) NOT NULL,
  `nomeCliente` VARCHAR(120) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
	PRIMARY KEY (`CNPJ`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE)
ENGINE = InnoDB;
```

> Criação da Tabela Estoque
> 

```sql
-- -----------------------------------------------------
-- Table `AZSolution`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AZSolution`.`Estoque` (
  `codProduto` BIGINT(14) NOT NULL,
  `nomeProduto` VARCHAR(120) NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `preco` DECIMAL(8,2) NOT NULL,
  `codBarras` BIGINT(13) NULL,
  `largura` DECIMAL(6,2) NULL,
  `altura` DECIMAL(6,2) NULL,
  `comprimento` VARCHAR(45) NULL,
  `table1col` DECIMAL(6,2) NULL,
  `circunferencia` DECIMAL(6,2) NULL,
  PRIMARY KEY (`codProduto`),
  UNIQUE INDEX `codProduto_UNIQUE` (`codProduto` ASC) VISIBLE)
ENGINE = InnoDB;
```

> Criação da Tabela Itens de Venda
> 

```sql
-- -----------------------------------------------------
-- Table `AZSolution`.`itensVenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AZSolution`.`itensVenda` (
  `Venda_idVenda` INT NOT NULL,
  `Estoque_codProduto` BIGINT(14) NOT NULL,
  `qtdProduto` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`Venda_idVenda`, `Estoque_codProduto`),
  INDEX `fk_Venda_has_Estoque_Estoque1_idx` (`Estoque_codProduto` ASC) VISIBLE,
  INDEX `fk_Venda_has_Estoque_Venda1_idx` (`Venda_idVenda` ASC) VISIBLE,
  CONSTRAINT `fk_Venda_has_Estoque_Venda1`
    FOREIGN KEY (`Venda_idVenda`)
    REFERENCES `AZSolution`.`Venda` (`idVenda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_codProduto`)
    REFERENCES `AZSolution`.`Estoque` (`codProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
```

> Criação da Tabela Fornecedor
> 

```sql
-- -----------------------------------------------------
-- Table `AZSolution`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AZSolution`.`Fornecedor` (
  `CNPJ` BIGINT(13) NOT NULL,
  `nomeFornecedor` VARCHAR(120) NOT NULL,
  `valorFrete` DECIMAL(8,2) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `status` TINYINT NOT NULL,
  UNIQUE INDEX `CPF_UNIQUE` (`CNPJ` ASC) VISIBLE,
  PRIMARY KEY (`CNPJ`))
ENGINE = InnoDB;
```

> Criação da Tabela Telefone
> 

```sql
-- -----------------------------------------------------
-- Table `AZSolution`.`Telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AZSolution`.`Telefone` (
  `idTelefone` INT NOT NULL,
  `numero` BIGINT(11) NOT NULL,
  `Fornecedor_CNPJ` BIGINT(13) NOT NULL,
  `Cliente_CNPJ` BIGINT(14) NOT NULL,
  `Funcionario_CPF` BIGINT(11) NOT NULL,
  PRIMARY KEY (`idTelefone`),
  UNIQUE INDEX `numero_UNIQUE` (`numero` ASC) VISIBLE,
  INDEX `fk_Telefone_Fornecedor1_idx` (`Fornecedor_CNPJ` ASC) VISIBLE,
  INDEX `fk_Telefone_Cliente1_idx` (`Cliente_CNPJ` ASC) VISIBLE,
  INDEX `fk_Telefone_Funcionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Telefone_Fornecedor1`
    FOREIGN KEY (`Fornecedor_CNPJ`)
    REFERENCES `AZSolution`.`Fornecedor` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Telefone_Cliente1`
    FOREIGN KEY (`Cliente_CNPJ`)
    REFERENCES `AZSolution`.`Cliente` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Telefone_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `AZSolution`.`Funcionario` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
```

> Criação da Tabela Compras
> 

```sql
-- -----------------------------------------------------
-- Table `AZSolution`.`Compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AZSolution`.`Compras` (
  `idCompra` VARCHAR(45) NOT NULL,
  `Estoque_codProduto` BIGINT(14) NOT NULL,
  `Fornecedor_CNPJ` BIGINT(13) NOT NULL,
  `dataCompra` DATE NOT NULL,
  `qtdCompra` DATE NOT NULL,
  `valorCompra` DECIMAL(8,2) NOT NULL,
  `obs` VARCHAR(200) NULL,
  PRIMARY KEY (`idCompra`, `Estoque_codProduto`, `Fornecedor_CNPJ`),
  INDEX `fk_Estoque_has_Fornecer_Estoque1_idx` (`Estoque_codProduto` ASC) VISIBLE,
  UNIQUE INDEX `idCompra_UNIQUE` (`idCompra` ASC) VISIBLE,
  INDEX `fk_Compras_Fornecedor1_idx` (`Fornecedor_CNPJ` ASC) VISIBLE,
  CONSTRAINT `fk_Estoque_has_Fornecer_Estoque1`
    FOREIGN KEY (`Estoque_codProduto`)
    REFERENCES `AZSolution`.`Estoque` (`codProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compras_Fornecedor1`
    FOREIGN KEY (`Fornecedor_CNPJ`)
    REFERENCES `AZSolution`.`Fornecedor` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
```

### Alteração de Dados das Tabelas -DDL

```sql
alter table estoque add column dimensoes varchar(50) after codBarras;
alter table estoque change codProduto codProduto varchar(30);
alter table funcionario change Funcao funcao varchar(80);
alter table estoque add column dimensoes varchar(50) after codBarras;
alter table estoque add column qtd varchar(50) after circunferencia;

alter table estoque drop column altura;
alter table estoque drop column largura;
alter table estoque drop column comprimento;
alter table estoque drop column table1col;
alter table cliente drop column Venda_idVenda;

```

### Destruindo o Banco de Dados - DDL

```sql
-- -----------------------------------------------------
-- Destruir DDL
-- -----------------------------------------------------

drop schema azsolution;

```

### Views - DDL

---

---

## DML - Data **Manipulation Language**

### **Inserindo dados - DML**

> Inserindo Dados na Tabela Fornecedor
> 

```sql
-- -----------------------------------------------------
-- Insert into fornecedor
-- -----------------------------------------------------

INSERT INTO (fornecedor (CNPJ, nomeFornecedor, valorFrete, email, status)
	VALUE 
		("94006115000137", "Royce Connect", "600.00", "royceconect@gmail.com", "1"),
		("50053765000168", "Spin", "350.00", "spin@gmail.com", "1"),
	  ("46212572000135", "Delphi", "250.00", "delphi@gmail.com", "1"),
	  ("28881621000140", "SuperCool", "860.00", "supercool@gmail.com", "1"),
	  ("24891754000147", "Importado", "350.00", "importado@gmail.com", "1"),
	  ("30879724000118", "McQuay", "150.00", "mcquay@gmail.com", "1");
```

> Inserindo Dados na Tabela Funcionário
> 

```sql
-- -----------------------------------------------------
-- Insert into funcionario
-- -----------------------------------------------------

INSERT INTO funcionario (CPF, nome, email, salario, dataAdm, dataDem, status, funcao)
	VALUES 
		("85215974155", "Maria Lima", "marialima@gmail.com", "2000", "2022.11.29", null, "1", "Vendedor"),
    ("75365495111", "Gilmar Adrian", "gilmaradrian@gmail.com","2000", "2020.08.21", null, "1", "Vendedor"),
    ("12395175333", "Livia Vitoria", "liviavitoria@gmail.com",  "2000", "2020.09.05", null, "1", "Vendedor"),
    ("18039522293", "Ayrton Maia", "ayrtonmaia@gail.com",  "2000", "2018.07.01", null, "1", "Caixa"),
    ("75120273114", "Danilo Farias", "danilofarias@gmail.com",  "3500", "2010.01.02", null, "1", "Gerente"),
    ("78249824407", "Jaqueline Lins", "jaquelinelins@gmal.com", "8000", "2009.06.15", null, "1", "CEO");
```

> Inserindo Dados na Tabela Cliente
> 

```sql
-- -----------------------------------------------------
-- Insert cliente
-- -----------------------------------------------------

INSERT INTO cliente (CNPJ, nomeCliente, email)
	VALUE 
		("81583383000170", "OficinaA", "oficinaa@gmail.com"),
		("51451416000167", "OficinaB", "oficinab@gmail.com"),
    ("65778296000111", "OficinaC", "oficinac@gmail.com"),
    ("41437483000173", "OficinaD", "oficinad@gmail.com"),
    ("32354618000146", "OficinaE", "oficinae@gmail.com"),
    ("43945444000108", "OficinaF", "oficinaf@gmail.com"),
    ("43945444000102", "OficinaG", "oficinag@gmail.com"),
    ("57541425000125", "OficinaH", "oficinah@gmail.com"),
    ("04335917000106", "OficinaI", "oficinai@gmail.com"),
    ("27690818000130", "OficinaJ", "oficinaj@gmail.com"),
    ("39165274000176", "OficinaK", "oficinak@gmail.com"),
    ("86197624000166", "OficinaL", "oficinal@gmail.com"),
    ("11346108000157", "OficinaM", "oficinam@gmail.com"),
    ("48248458000190", "OficinaN", "oficinan@gmail.com"),
    ("30865274000104", "OficinaO", "oficinao@gmail.com"),
    ("85214715000108", "OficinaP", "oficinap@gmail.com"),
    ("32605925000152", "OficinaQ", "oficinaq@gmail.com"),
    ("77743700000109", "OficinaR", "oficinar@gmail.com"),
    ("73685215000167", "OficinaS", "oficinas@gmail.com"),
    ("78421344000161", "OficinaX", "oficinax@gmail.com");
```

> Inserindo Dados na Tabela Compras
> 

```sql
-- -----------------------------------------------------
-- Insert into Compras
-- -----------------------------------------------------
          
INSERT INTO compras (idCompra, Estoque_codProduto, Fornecedor_CNPJ, dataCompra, qtdCompra, valorCompra, obs)
	VALUE 
		("1", "700821", "94006115000137", "2022.12.02", "5", "500.00", null),
    ("2", "10029", "50053765000168", "2021.05.05", "5", "600.00", null),
    ("3", "250012", "46212572000135", "2022.08.21", "6", "700.00", null),
    ("4", "450210", "94006115000137", "2021.07.25", "50", "250.00", null),
    ("12", "824400", "24891754000147", "2022.01.15", "20", "400.00", null),
    ("6", "829900", "30879724000118", "2021.05.05", "15", "900.00", null),
    ("7", "740012", "24891754000147", "2022.10.10", "16", "650.00", null),
    ("8", "900002", "94006115000137", "2021.02.15", "20", "450.00", null),
    ("9", "850171", "28881621000140", "2022.02.15", "25", "300.00", null),
    ("10", "829900", "30879724000118", "2021.03.06", "30", "750.00", null);
```

> Inserindo Dados na Tabela Estoque
> 

```sql
-- -----------------------------------------------------
-- Insert into estoque
-- -----------------------------------------------------
          
INSERT INTO estoque (codProduto, nomeProduto, marca, preco, codBarras, dimensoes, circunferencia) 
	VALUE
		("700821", "Evaporador Palio Fire", "Royce Connect", "280.00", null, "800x370x140mm", null),
    ("10029", "Selo de Spin Original", "Spin", "35.00", null, "434mm total / 250mm refil / Ø 30mm", null),
    ("250012", "VENTILADOR DA CAIXA EVAPORADORA MÁQUINA CATERPILLAR ESTEIRA DG5 E RETROESCAVADEIRA 416E 12 VOLTS", "Delphi", "45.00", null, "eixo Ø78mm / turbina Ø177mm / comprimento 198mm", null),
		("600123", "Compressor Modelo 7H15 Scania", "Royce Connect", "890.00", null, "132MM ", null),
		("2189", "Evaporador Denso Original", "Denso", "690.00", null, "770x330x145mm", null),
    ("530100", "Ventilador da Caixa Evaporadora do Volvo 2015>", "Royce Connect", "350.00", null, "800x370x140mm", null),
		("829900", "CONDENSADOR CHEVROLET CORSA 1994 ATÉ 1998 A/A TUBO ALETAS", "McQuay", "450.00", null, "572x314x30mm", null),
		("850171", "Oleo Constraste PAG150", "SuperCool", "75.00", null, "946ML", null),
    ("900002", "Oleo HB30", "Royce Connect", "30.00", null, "946ML", null),
    ("460024", "Valvula", "Royce Connect", "70.00", null, null, null),  
    ("450210", "Emenda 8", "Royce Connect", "6.00", null, null, null),
    ("740019", "Caixa Evaporadora Universal 24 Volts 2 Motores 6 Difusores Com Painel 32000 BTUs", " Importado", "300.00", null, "800x370x140mm", null),
		("740050", "CAIXA EVAPORADORA UNIVERSAL COM VÁLVULA DE EXPANSÃO CAPILAR 12 VOLTS 4 DIFUSORES", "Importado", "550.00", null, "340x403x142mm", null),
    ("740014", "CAIXA EVAPORADORA UNIVERSAL MICRO-BUS COM VÁLVULA CAPILAR 6 DIFUSORES 2 MOTORES 3 VELOCIDADES 12 VOLTS", "Importado", "250.00", null, "770x330x145mm", null),
    ("740012", "CAIXA EVAPORADORA UNIVERSAL MINI-BUS COM VÁLVULA CAPILAR 2 MOTORES 4 VELOCIDADES 12 VOLTS", "Importado", "600.00", null, "555x355x17,8mm", null),
    ("824400", "Condensador Chevrolet D20 1985 Até 1996 A/A Tubo Aletas", "Importado", "150.00", null, "465x280x31mm", null),
    ("009100", "CONDENSADOR CHEVROLET VECTRA 1997 ATÉ 2005 A/A TUBO ALETAS", " Importado", "400.00", null, "605x285x27mm", null),
    ("120060", "Chicote do Compressor Denso Scroll SC06 / SC08", "Royce Connect", "50.00", null, null, null),
    ("600025", "COMPRESSOR MODELO 7H15 4627 TRATOR UNIPORT 2011> 8 ORELHAS 12 VOLTS POLIA 2A 132MM SAÍDA VERTICAL R134A", " Importado", "350.00", null, "630x370x22mm", null);
```

> Inserindo Dados na Tabela Telefone
> 

```sql
-- -----------------------------------------------------
-- Insert into telefone
-- -----------------------------------------------------

INSERT INTO telefone (numero, Fornecedor_CNPJ, cliente_CNPJ, Funcionario_CPF)
	VALUES
		("81921216838", "94006115000137", null, null), 
		("81921745843", "50053765000168", null, null),
    ("81937435782", "46212572000135", null, null),
    ("98927730805", "28881621000140", null, null),
    ("88938306443", "24891754000147", null, null),
    ("88938306443", "30879724000118", null, null),
    ("81938681812", null, "81583383000170", null),
    ("81925737616", null, "51451416000167", null),
    ("81932277607", null, "65778296000111", null),
    ("81925922611", null, "41437483000173", null),
    ("81939389366", null, "32354618000146", null),
    ("81932875488", null, "43945444000102", null),
    ("81933339128", null, "43945444000102", null),
    ("81938793128", null, "57541425000125", null),
    ("81925427897", null, "04335917000106", null),
    ("81925597814", null, "27690818000130", null),
    ("79922317373", null, "39165274000176", null),
    ("35927143293", null, "86197624000166", null),
    ("87929033148", null, "11346108000157", null),
    ("68936348182", null, "48248458000190", null),
    ("19927323243", null, "30865274000104", null),
    ("94930630597", null, "85214715000108", null),
    ("21932639738", null, "32605925000152", null),
    ("81929587142", null, "77743700000109", null),
    ("87920308075", null, "73685215000167", null),
    ("81939982501", null, "78421344000161", null),    
    ("81939882455", null, null, "85215974155"),
    ("81920843358", null, null, "75365495111"),
    ("81921468914", null, null, "12395175333"),
    ("81936676699", null, null, "18039522293"),
    ("81937476247", null, null, "75120273114"),
    ("81930406564", null, null, "78249824407");
```

> Inserindo Dados na Tabela Itens de Venda
> 

```sql
-- -----------------------------------------------------
-- Insert itensvenda
-- -----------------------------------------------------

INSERT INTO itensvenda (Venda_idVenda, Estoque_codProduto, qtdProduto)
	VALUE 
		("1", "700821", "2"),
    ("2", "850171", "5"),
    ("3", "740014", "3"),
    ("4", "600025", "3"),
    ("5", "530100", "2"),
    ("6", "740050", "3"),
    ("7", "600123", "2"),
    ("8", "250012", "2"),
    ("9", "740019", "3"),
    ("10", "700821", "2");
```

> Inserindo Dados na Tabela Venda
> 

```sql
-- -----------------------------------------------------
-- Insert into venda
-- -----------------------------------------------------

INSERT INTO venda (dataVenda, valorTotal, obs, Funcionario_CPF)
	VALUE
		("2022.12.02", "800.00", null, "85215974155"),
    ("2022.11.05", "700.00", null, "85215974155"),
    ("2022.10.03", "1200.00", null, "85215974155"),
    ("2022.09.04", "4000.00", null, "75365495111"),
    ("2022.08.10", "950.50", null, "75365495111"),
    ("2022.07.12", "3250.00", null, "75365495111"),
    ("2022.06.16", "250.35", null, "12395175333"),
    ("2022.05.18", "658.00", null, "12395175333"),
    ("2022.04.06", "980.00", null, "12395175333"),
    ("2022.03.25", "1200.00", null, "12395175333");
```

> Inserindo Dados na Tabela Endereço
> 

```sql
-- -----------------------------------------------------
-- Insert into endereco
-- -----------------------------------------------------

INSERT INTO endereco (funcionario_cpf, cliente_cnpj, fornecedor_cnpj, uf, cidade, bairro, rua, numero, comp, cep)
	VALUE
		("12395175333", null, null, "", "", "", "", "", "", ""),
    ("18039522293", null, null, "", "", "", "", "", "", ""),
    ("75120273114", null, null, "", "", "", "", "", "", ""),
    ("75365495111", null, null, "", "", "", "", "", "", ""),
    ("75365495111", null, null, "", "", "", "", "", "", ""),
    ("85215974155", null, null, "", "", "", "", "", "", ""),    
    (null, "41437483000173", null, "", "", "", "", "", "", ""),
    (null, "43945444000102", null, "", "", "", "", "", "", ""),
    (null, "43945444000108", null, "", "", "", "", "", "", ""),
    (null, "48248458000190", null, "", "", "", "", "", "", ""),
    (null, "51451416000167", null, "", "", "", "", "", "", ""),
    (null, null, "24891754000147", "", "", "", "", "", "", ""),
    (null, null, "28881621000140", "", "", "", "", "", "", ""),
    (null, null, "30879724000118", "", "", "", "", "", "", ""),
    (null, null, "46212572000135", "", "", "", "", "", "", ""),
    (null, null, "50053765000168", "", "", "", "", "", "", ""),
    (null, null, "94006115000137", "", "", "", "", "", "", "");
```

### Deletando Dados das Tabelas - DML

```sql
-- -----------------------------------------------------
-- Deletar ou atualizar DML
-- -----------------------------------------------------

DELETE FROM funcionario
	WHERE cpf = 12395175333;
    
DELETE FROM estoque 
	WHERE marca = importado;
    
DELETE FROM fornecedor
	WHERE STATUS = 1
    and frete = 350.00;
    
DELETE FROM estoque 
	WHERE nomeProduto like 'condensador%';
    
DELETE FROM estoque
	WHERE idVenda not in (
		SELECT nomeProduto
			FROM venda
				WHERE DATA >= 2022-12-02 - interval 1 month);
```

### **Atualizando dados nas tabelas - DML**

```sql
UPDATE funcionario 
	SET funcao = 'gerente'
		WHERE CPF = 18039522293;
        
UPDATE estoque 
	SET nomeProduto = 'CAIXA EVAPORADORA UNIVERSAL%'
    WHERE nomeProduto = 'CAIXA EVAPORADORA UNIVERSAL';

UPDATE funcionario 
	SET nome = 'Ayrton Maya Soares'
		WHERE cpf = 18039522293;
        
UPDATE telefone 
	SET numero = 81955694845
		WHERE cliente_CNPJ = 4335917000106;
        
UPDATE venda 
	SET obs = 'Revisar CNPJ deste cliente, pois está com suspeita de fraude. Frizar aos vendedores a necessidade de analisar se o CNPJ fornecedido é oriundo de oficinas ou afins.'
		WHERE idVenda = 3 and funcionarioCPF = 85215974155;
```

---

## DQL - **Data Query Language**

### Consultas

```sql
--01) Nome dos funcionários que realizaram mais de 5 vendas no mes 08.2022, trazendo as 
--colunas (Nome Funcionário, Telefone Empregado, CPF Empregado, Total Valor Vendido)
--ordenado pela Data Venda.

select f.nome"Empregado", f.cpf"CPF", tel.numero "Numero", sum(v.valorTotal)"Valor Total", count(v.idVenda)"Vendas", v.dataVenda"Data"
	from funcionario f
		inner join venda v on f.cpf = v.funcionario_cpf
        inner join telefone tel on f.cpf = tel.funcionario_cpf
			having count(v.idVenda) >= 5
				group by v.idvenda
<<<<<<< HEAD
					order by v.dataVenda;
=======
				order by v.dataVenda;
>>>>>>> 4ebf6d104a93558e515b3cf300fcdbfe03381b76
```

```sql
--02) Nome dos clientes cadastrados no banco de dados da empresa, trazendo as
--colunas (Nome Cliente, Número Telefone, CNPJ, Cidade Moradia)

select c.nomeCliente"Nome", c.cnpj"CNPJ", tel.numero, en.cidade
	from cliente c
		inner join telefone tel on c.cnpj = tel.cliente_cnpj
        inner join endereco en on c.cnpj = en.cliente_cnpj;
```

```sql
--03) Lista dos empregados com a quantidade total de vendas já realiza por cada Empregado, trazendo as
--colunas (Nome Empregado, CPF Empregado, Sexo, Salário, Quantidade Vendas, Total Valor Vendido),
--ordenado por quantidade total de vendas realizadas;

select f.nome "Funcionário", f.cpf "CPF", f.salario "Salário", 
	count(v.idvendas) "Quantidade Vendas", sum(v.valorTotal) "Total Vendido"
		from vendas v
			inner join funcionario f on f.cpf = v.funcionario_cpf
				group by (v.funcionario_cpf)
					order by sum(v.valorTotal) desc;
```

```sql
--04) Lista dos Produtos mais vendidos, informando a quantidade (total) de vezes que cada produto participou em vendas, trazendo as
--colunas (Nome Produto, Quantidade (Total) Vendas),
--ordenado por quantidade de vezes que o produto participou em vendas;

select est.nome "Nome Produto", count(iv.Estoque_codProduto) "Quantidade (Total) Vendas"
	from itensvenda iv
		inner join estoque est on iv.estoque_codProduto = est.codProduto
			group by est.codProduto
				order by count(iv.Estoque_codProduto) desc;
```

```sql
--05) Lista dos Produtos, informando qual Fornecedor de cada produto, trazendo as
--colunas (Nome Produto, Valor Produto, Categoria do Produto, Nome Fornecedor, Email Fornecedor, Telefone Fornecedor),
--ordenado por Nome Produto;

select est.nomeProduto "Produto", concat('R$ ', round(est.preco, 2)) "Valor Produto", 
	est.categoria "Categoria do Produto", f.nome "Nome Fornecedor", f.email "Email Fornecedor",
    tel.numero "Telefone Fornecedor"
    from compras c
		inner join estoque est on est.codProduto = c.Estoque_codProduto
        inner join fornecedor f on f.cnpj = c.Fornecedor_cnpj
        left join telefone tel on tel.Fornecedor_cnpj = f.cnpj
			order by est.nomeProduto;
```

```sql
--06) Balaço das Vendas, informando a soma dos valores vendidos por dia, trazendo as
--colunas (Data Venda, Quantidade de Vendas, Valor Total Venda),
-- ordenado por Data Venda;

select substring(v.dataVenda, 1, 10) "Data", count(v.idVendas) "Quantidade Vendas", 
	concat('R$ ', sum(v.valorTotal)) "Total Vendido"
	from vendas v
		group by substring(v.dataVenda, 1, 10)
			having count(v.idVendas) = (select max(total) from totalVendasData);
```

```sql
--07) Lista das formas de pagamentos mais utilizadas nas Vendas, informando quantas vendas cada forma de pagamento já foi relacionada, trazendo as
--colunas (Tipo Forma Pagamento, Quantidade Vendas, Total Valor Vendido),
--ordenado por quantidade total de vendas realizadas;

select fp.tipoPag "Tipo Forma Pagamento", count(v.idVendas) "Quantidade Vendas", 
	concat('R$ ', sum(v.valorTotal)) "Total Vendido"
		from vendas v
			inner join formapag fp on fp.Vendas_idVendas = v.idVendas
				group by fp.tipoPag
					order by count(v.idVendas) desc;
```

```sql
--08) Lista dos funcionarios admitidos entre 2020-01-01 e 2020-12-31, trazendo as
--colunas (Nome Empregado, CPF Empregado, Data Admissão,  Salário,  Número de Telefone),
--ordenado por data de admissão decrescente;

select f.nome "Empregado", f.cpf "CPF", f.dataAdm "Data Admissão", f.salario "Salário", 
	en.cidade "Cidade", tel.numero "Número de Telefone"
    from funcionario f
		inner join endereco en on en.funcionario_CPF = f.cpf
        left join telefone tel on tel.funcionario_CPF = f.cpf
			where f.dataAdm between '2020-01-01' and '2020-12-31'
				order by f.dataAdm desc;
```

```sql
--09) Lista dos funcionarios que ganham menos que a média salarial dos funcionários do Posto de Gasolina, trazendo as
--colunas (Nome Empregado, CPF Empregado, Data Admissão,  Salário),
--ordenado por nome do empregado;

select f.nome "Empregado", f.CPF "CPF", f.dataAdm "Data Admissão", f.salario "Salário", 
	en.cidade "Cidade"
    from funcionario f
		inner join endereco en on en.funcionario_CPF = f.cpf
			where f.salario <= (select avg(salario) from funcionario)
				order by f.nome;
```

```sql
--09) Lista das Vendas, informando o detalhamento de cada venda quanto os seus itens, trazendo as
--colunas (Data Venda, Nome Produto, Quantidade ItensVenda, Valor Produto, Valor Total Venda, Nome Empregado, Nome do Departamento),
--ordenado por Data Venda;

select v.dataVenda "Data", est.nome "Produto", iv.qtdProduto "Quantidade", 
	concat('R$ ', round(est.preco, 2)) "Valor do Produto", concat('R$ ', v.valorTotal) "Valor Total", 
    f.nome "Funcionário"
		from vendas v
			inner join funcionario f on f.cpf = v.funcionario_cpf
            inner join itensvenda iv on iv.Vendas_idVendas = v.idVendas
            inner join estoque est on est.codProduto = iv.Estoque_codProduto
					order by v.dataVenda;
```

```sql
--10) Valor do frete de cada fornecedor, trazendo as 
--colunas (Nome Fornecedor, CNPJ, Numéro Telefone, Estado),
--ordenado pelo preço do frete.

select f.nome"Fornecedor", f.cnpj"CNPJ", tel.numero"Número", en.Estado"Estado", f.valorFrete"Frete"
	from fornecedor f
		inner join endereco en on f.cnpj = en.fornecedor_cnpj
        inner join telefone tel on f.cnpj = tel.fornecedor_cnpj
			order by f.valorFrete;
```

```sql
--11) Lista dos empregados que são da cidade do xxxx, trazendo as
--colunas (Nome Empregado, CPF Empregado, Data Admissão, Salário, Cidade Moradia, Numero de Telefone),
-- ordenado por nome do empregado;

select f.nome "Funcionário", f.cpf "CPF", f.dataAdm "Data Admissão", f.salario "Salário", 
	en.cidade "Cidade"
    from empregado e
		inner join endereco en on en.Empregado_CPF = e.cpf
        left join telefone tel on tel.funcionario_cpf = f.cpf
			where en.cidade like ""
				group by (f.cpf)
					order by f.nome;
```

---

---

## PROCEDURE

> 01
> 

```sql
delimiter //
create procedure relatorioVendas(in dataInicio date, in dataFim date)
	begin
		select v.dataVenda"Data", est.nome"Produto", iv.qtdProduto"Quantidade", 
        concat('RS ', round(est.preco, 2)), f.nome"Empregado"
			from venda v 
				inner join funcionario f on f.cpf = v.funcionario_cpf
                inner join itensvenda iv on v.idvenda = iv.venda_idvenda
                inner join estoque e on est.codproduto = iv.estoque_codproduto
					where date_formt (v.datavenda, '%y-%m-%d') between inicio and fim
						order by v.dataVenda;
	end //
delimiter ;
```

> 02
> 

```sql
delimiter //
	create procedure funcionario(in nome varchar (120))
		begin
			select f.nome"Empregado", f.cpf"CPF", f.dataAdm"Data Admissão", f.salario"Salário", t.numero
				from funcionario f
					left join telefone t on f.cpf = t.funcionario_cpf
						where nome = f.nome;
	    end //
delimiter ;

call funcionario('Livia Vitoria');
```

> 03
> 

```sql
delimiter //
create procedure precoProduto(in cod int(13))
	begin 
		select e.codproduto"Código", e.nomeProduto"Produto", e.marca"Marca", e.preco"Preço", e.dimensoes"Dimensões", e.circunferencia"Circunferencia",
        f.nomeFornecedor"Fornecedor"
			from estoque e
				inner join compras c on c.estoque_codproduto = e.codproduto
                inner join fornecedor f on f.cnpj = c.fornecedor_cnpj
					where cod = e.codproduto;
	end //
delimiter //

call precoProduto('10029');
```

> 04
> 

```sql
delimiter //
create procedure inserirProd(in cod bigint(13), in n varchar(120), in ma varchar(45), in p decimal(8,2), in d varchar(50))
	begin
		declare codProduto bigint(45);
			select codigoProduto into codProduto from estoque where codigoProduto = cod;
            if(isnull(codProduto)) then
				insert into estoque (codProduto, nome, marca, preco, dimensoes)
					value (cod, n, ma, p, d);
			else 
				update estoque set quantidade = quantidade + qtd, preco = p
					where codigoProduto = cod;
			end if;
		end //
delimiter  //
```

> 05
> 

```sql
delimiter //
create procedure vendaFuncionario(in nomeFun varchar(120)) 
	begin 
		select v.dataVenda "Data", e.nomeProduto"Produto", iv.qtdProduto"Quantidade", concat('R$ ', roun(e.preco, 2))"Valor Produto", 
        concat('R$ ', v.valorTotal)"Valor Total", f.nome"Funcionario"
			from venda v
				inner join funcionario f on f.cpf = v.funcionario_cpf 
				inner join itensvenda iv on v.idvenda = iv.venda_idvenda
                inner join estoque e on e.codProduto = iv.estoque_codProduto
					where f.nome = nomeFun
						order by v.dataVenda;
	end //
delimiter ;

```

> 06
> 

```sql
delimiter //
create procedure reajuteSal(in taxa decimal(4,2))
		begin
			update empregato set salario = salario * taxa;
		end // 
delimiter ;
```

> 07
> 

```sql
delimiter //
create procedure reajuteSal(in taxa decimal(4,2))
		begin
			update empregato set salario = salario * taxa;
		end // 
delimiter ;
```

> 08
> 

```sql
delimiter //
create function tempoServ(c varchar(14), dataIni datetime)
	returns int
    DETERMINISTIC
    begin
		declare se tinyint;
        declare tempo int;
        select statusEmp into se from funcionario where cpf like c;
        if (se = 1) then
			select timestampdiff(year, dataAdm, now()) into tempo from funcionario where cpf like c;
			return tempo;
		else 
			select timestampdiff(year, dataAdm, dataDem) into tempo from empregado where cpf like c;
			return tempo;
		end if;
    end //
delimiter ;
```

> 09
> 

> 10
> 

---

## FUNCTION

---

## VIEW

---

### Squad 01 - Avestruz Solutions

Apolo Nicolas

Ayrton Maia

Gilmar Adrian

Jaqueline Lins

Júlio Gabriel

Lívia Vitória

M. Regina Lima