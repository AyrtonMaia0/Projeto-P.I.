SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema GLRefrigeracao
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `GLRefrigeracao` DEFAULT CHARACTER SET utf8 ;
USE `GLRefrigeracao` ;

-- -----------------------------------------------------
-- Table `GLRefrigeracao`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLRefrigeracao`.`Funcionario` (
  `CPF` BIGINT(11) NOT NULL,
  `nome` VARCHAR(120) NOT NULL,
  `email` VARCHAR(120) NOT NULL,
  `salario` DECIMAL(8,2) NOT NULL,
  `dataAdm` DATE NOT NULL,
  `dataDem` DATE,
  `status` TINYINT NOT NULL,
  `funcao` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`CPF`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `GLRefrigeracao`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLRefrigeracao`.`Cliente` (
  `CNPJ` BIGINT(14) NOT NULL,
  `nome` VARCHAR(120) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`CNPJ`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `GLRefrigeracao`.`Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLRefrigeracao`.`Venda` (
  `idVenda` INT NOT NULL AUTO_INCREMENT,
  `dataVenda` DATE NOT NULL,
  `valorTotal` DECIMAL(8,2) NOT NULL,
  `obs` VARCHAR(200) NULL,
  `Funcionario_CPF` BIGINT(11) NOT NULL,
  `Cliente_CNPJ` BIGINT(14) NOT NULL,
  PRIMARY KEY (`idVenda`),
  UNIQUE INDEX `idVenda_UNIQUE` (`idVenda` ASC) VISIBLE,
  INDEX `fk_Venda_Funcionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  INDEX `fk_Venda_Cliente1_idx` (`Cliente_CNPJ` ASC) VISIBLE,
  CONSTRAINT `fk_Venda_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `GLRefrigeracao`.`Funcionario` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_Cliente1`
    FOREIGN KEY (`Cliente_CNPJ`)
    REFERENCES `GLRefrigeracao`.`Cliente` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `GLRefrigeracao`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLRefrigeracao`.`Fornecedor` (
  `CNPJ` BIGINT(14) NOT NULL,
  `nome` VARCHAR(120) NOT NULL,
  `valorFrete` DECIMAL(6,2) NOT NULL,
  `status` TINYINT NOT NULL,
  PRIMARY KEY (`CNPJ`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `GLRefrigeracao`.`Telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLRefrigeracao`.`Telefone` (
  `idTelefone` INT NOT NULL AUTO_INCREMENT,
  `numero` BIGINT(13) NULL,
  `Fornecedor_CNPJ` BIGINT(14),
  `Cliente_CNPJ` BIGINT(14),
  `Funcionario_CPF` BIGINT(11),
  PRIMARY KEY (`idTelefone`),
  UNIQUE INDEX `idTelefone_UNIQUE` (`idTelefone` ASC) VISIBLE,
  INDEX `fk_Telefone_Funcionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  INDEX `fk_Telefone_Cliente1_idx` (`Cliente_CNPJ` ASC) VISIBLE,
  INDEX `fk_Telefone_Fornecedor1_idx` (`Fornecedor_CNPJ` ASC) VISIBLE,
  CONSTRAINT `fk_Telefone_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `GLRefrigeracao`.`Funcionario` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Telefone_Cliente1`
    FOREIGN KEY (`Cliente_CNPJ`)
    REFERENCES `GLRefrigeracao`.`Cliente` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Telefone_Fornecedor1`
    FOREIGN KEY (`Fornecedor_CNPJ`)
    REFERENCES `GLRefrigeracao`.`Fornecedor` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `GLRefrigeracao`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLRefrigeracao`.`Estoque` (
  `codProduto` VARCHAR(30) NOT NULL,
  `nome` VARCHAR(180) NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `preco` DECIMAL(8,2) NOT NULL,
  `qnt` INT NOT NULL,
  `codBarras` BIGINT(13) NULL,
  `dimensoes` VARCHAR(100) NULL,
  `circunferencia` DECIMAL(5,2) NULL,
  PRIMARY KEY (`codProduto`),
  UNIQUE INDEX `codProduto_UNIQUE` (`codProduto` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `GLRefrigeracao`.`Compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLRefrigeracao`.`Compras` (
  `idCompras` INT NOT NULL AUTO_INCREMENT,
  `Fornecedor_CNPJ` BIGINT(14) NOT NULL,
  `Estoque_codProduto` VARCHAR(30) NOT NULL,
  `dataComp` DATE NOT NULL,
  `qtdCompra` INT NOT NULL,
  `valorCompra` DECIMAL(8,2) NOT NULL,
  `obs` VARCHAR(280) NULL,
  PRIMARY KEY (`idCompras`, `Fornecedor_CNPJ`, `Estoque_codProduto`),
  INDEX `fk_Estoque_has_Fornecedor_Fornecedor1_idx` (`Fornecedor_CNPJ` ASC) VISIBLE,
  INDEX `fk_Estoque_has_Fornecedor_Estoque1_idx` (`Estoque_codProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Estoque_has_Fornecedor_Estoque1`
    FOREIGN KEY (`Estoque_codProduto`)
    REFERENCES `GLRefrigeracao`.`Estoque` (`codProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Estoque_has_Fornecedor_Fornecedor1`
    FOREIGN KEY (`Fornecedor_CNPJ`)
    REFERENCES `GLRefrigeracao`.`Fornecedor` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `GLRefrigeracao`.`itensVenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLRefrigeracao`.`itensVenda` (
  `Venda_idVenda` INT NOT NULL,
  `Estoque_codProduto` VARCHAR(30) NOT NULL,
  `qntProduto` INT NOT NULL,
  PRIMARY KEY (`Venda_idVenda`, `Estoque_codProduto`),
  INDEX `fk_Venda_has_Estoque_Estoque1_idx` (`Estoque_codProduto` ASC) VISIBLE,
  INDEX `fk_Venda_has_Estoque_Venda1_idx` (`Venda_idVenda` ASC) VISIBLE,
  CONSTRAINT `fk_Venda_has_Estoque_Venda1`
    FOREIGN KEY (`Venda_idVenda`)
    REFERENCES `GLRefrigeracao`.`Venda` (`idVenda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_codProduto`)
    REFERENCES `GLRefrigeracao`.`Estoque` (`codProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `GLRefrigeracao`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLRefrigeracao`.`Endereco` (
  `Funcionario_CPF` BIGINT(11),
  `Cliente_CNPJ` BIGINT(14),
  `Fornecedor_CNPJ` BIGINT(14),
  `uf` VARCHAR(3),
  `cidade` VARCHAR(80),
  `bairro` VARCHAR(80),
  `rua` VARCHAR(120),
  `comp` VARCHAR(120),
  `numero` INT, 
  `cep` BIGINT(8),
  PRIMARY KEY (`Funcionario_CPF`, `Cliente_CNPJ`, `Fornecedor_CNPJ`) VISIBLE,
  INDEX `fk_Endereco_Funcionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  INDEX `fk_Endereco_Cliente1_idx` (`Cliente_CNPJ` ASC) VISIBLE,
  INDEX `fk_Endereco_Fornecedor1_idx` (`Fornecedor_CNPJ` ASC) VISIBLE,
  CONSTRAINT `fk_Endereco_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `GLRefrigeracao`.`Funcionario` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Endereco_Cliente1`
    FOREIGN KEY (`Cliente_CNPJ`)
    REFERENCES `GLRefrigeracao`.`Cliente` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Endereco_Fornecedor1`
    FOREIGN KEY (`Fornecedor_CNPJ`)
    REFERENCES `GLRefrigeracao`.`Fornecedor` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `GLRefrigeracao`.`FormaPag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLRefrigeracao`.`FormaPag` (
  `idFormaPag` INT NOT NULL AUTO_INCREMENT,
  `tipoPag` VARCHAR(45) NOT NULL,
  `valorPag` DECIMAL(8,2) NOT NULL,
  `qtdParcelas` INT NULL,
  `Venda_idVenda` INT NOT NULL,
  PRIMARY KEY (`idFormaPag`),
  INDEX `fk_FormaPag_Venda1_idx` (`Venda_idVenda` ASC) VISIBLE,
  CONSTRAINT `fk_FormaPag_Venda1`
    FOREIGN KEY (`Venda_idVenda`)
    REFERENCES `GLRefrigeracao`.`Venda` (`idVenda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `GLRefrigeracao`.`FormaPagComp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLRefrigeracao`.`FormaPagComp` (
  `idFormaPag` INT NOT NULL AUTO_INCREMENT,
  `tipoPag` VARCHAR(45) NOT NULL,
  `valorPag` DECIMAL(8,2) NOT NULL,
  `Compras_idCompras` int NOT NULL,
  `Compras_Fornecedor_CNPJ` BIGINT(14) NOT NULL,
  `Compras_Estoque_codProduto` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`idFormaPag`),
  INDEX `fk_FormaPag_copy1_Compras1_idx` (`Compras_idCompras` ASC, `Compras_Fornecedor_CNPJ` ASC, `Compras_Estoque_codProduto` ASC) VISIBLE,
  CONSTRAINT `fk_FormaPag_copy1_Compras1`
    FOREIGN KEY (`Compras_idCompras` , `Compras_Fornecedor_CNPJ` , `Compras_Estoque_codProduto`)
    REFERENCES `AZsolution`.`Compras` (`idCompras` , `Fornecedor_CNPJ` , `Estoque_codProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Alterar estrutura das tabelas (os mesmos comandos estão no arquivo BD-PI-DDL-ALTER.sql)
-- -----------------------------------------------------
ALTER TABLE `GLRefrigeracao`.`Fornecedor` ADD COLUMN `email` VARCHAR(256) NULL AFTER `valorFrete`,
	ADD UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE;
;

ALTER TABLE Funcionario DROP COLUMN dataDem;

ALTER TABLE Funcionario ADD COLUMN dataDem DATE AFTER dataAdm;

ALTER TABLE Estoque CHANGE dimensoes dimensoes VARCHAR(120);

ALTER TABLE `GLRefrigeracao`.`Endereco` ADD COLUMN `id` INT NOT NULL AUTO_INCREMENT FIRST,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`id`);
;

ALTER TABLE `GLRefrigeracao`.`Endereco` 
DROP FOREIGN KEY `fk_Endereco_Cliente1`,
DROP FOREIGN KEY `fk_Endereco_Fornecedor1`,
DROP FOREIGN KEY `fk_Endereco_Funcionario1`;

ALTER TABLE `GLRefrigeracao`.`Endereco` 
CHANGE COLUMN `Funcionario_CPF` `Funcionario_CPF` BIGINT(11) NULL ,
CHANGE COLUMN `Cliente_CNPJ` `Cliente_CNPJ` BIGINT(14) NULL ,
CHANGE COLUMN `Fornecedor_CNPJ` `Fornecedor_CNPJ` BIGINT(14) NULL ;

ALTER TABLE `GLRefrigeracao`.`Endereco` 
ADD CONSTRAINT `fk_Endereco_Cliente1`
  FOREIGN KEY (`Cliente_CNPJ`)
  REFERENCES `GLRefrigeracao`.`Cliente` (`CNPJ`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Endereco_Fornecedor1`
  FOREIGN KEY (`Fornecedor_CNPJ`)
  REFERENCES `GLRefrigeracao`.`Fornecedor` (`CNPJ`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Endereco_Funcionario1`
  FOREIGN KEY (`Funcionario_CPF`)
  REFERENCES `GLRefrigeracao`.`Funcionario` (`CPF`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- -----------------------------------------------------
-- ALTER TABLES NÃO MAIS USADOS NO PROCESSO DE CRIAÇÃO
-- -----------------------------------------------------
/*
ALTER TABLE `GLRefrigeracao`.`Estoque` DROP COLUMN `altura`;
ALTER TABLE `GLRefrigeracao`.`Estoque` DROP COLUMN `largura`;
ALTER TABLE `GLRefrigeracao`.`Estoque` DROP COLUMN `comprimento`;
ALTER TABLE `GLRefrigeracao`.`Estoque` DROP COLUMN `table1col`;
ALTER TABLE `GLRefrigeracao`.`Estoque` ADD COLUMN `dimensoes` VARCHAR(50) AFTER `codBarras`;
ALTER TABLE `GLRefrigeracao`.`Estoque` ADD COLUMN `qtd` VARCHAR(50) AFTER `circunferencia`;
ALTER TABLE `GLRefrigeracao`.`Funcionario` CHANGE `Funcao` `funcao` VARCHAR(80);
ALTER TABLE `GLRefrigeracao`.`Compras` CHANGE COLUMN `qtdCompra` `qtdCompra` INT NULL DEFAULT NULL;
ALTER TABLE `GLRefrigeracao`.`Compras` MODIFY COLUMN `qtdCompra` INT;
ALTER TABLE `GLRefrigeracao`.`Compras` CHANGE COLUMN `idCompra` `idCompra` INT NOT NULL AUTO_INCREMENT ;
ALTER TABLE `GLRefrigeracao`.`Telefone` CHANGE COLUMN `idTelefone` `idTelefone` INT(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `GLRefrigeracao`.`Telefone` 
DROP FOREIGN KEY `fk_Telefone_Cliente1`,
DROP FOREIGN KEY `fk_Telefone_Fornecedor1`,
DROP FOREIGN KEY `fk_Telefone_Funcionario1`;
ALTER TABLE `GLRefrigeracao`.`Telefone` 
CHANGE COLUMN `Fornecedor_CNPJ` `Fornecedor_CNPJ` BIGINT(13) NULL ,
CHANGE COLUMN `Cliente_CNPJ` `Cliente_CNPJ` BIGINT(14) NULL ,
CHANGE COLUMN `Funcionario_CPF` `Funcionario_CPF` BIGINT(11) NULL ;
ALTER TABLE `GLRefrigeracao`.`Telefone` 
ADD CONSTRAINT `fk_Telefone_Cliente1`
  FOREIGN KEY (`Cliente_CNPJ`)
  REFERENCES `GLRefrigeracao`.`Cliente` (`CNPJ`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Telefone_Fornecedor1`
  FOREIGN KEY (`Fornecedor_CNPJ`)
  REFERENCES `GLRefrigeracao`.`Fornecedor` (`CNPJ`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Telefone_Funcionario1`
  FOREIGN KEY (`Funcionario_CPF`)
  REFERENCES `GLRefrigeracao`.`Funcionario` (`CPF`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
ALTER TABLE `GLRefrigeracao`.`Endereco` 
DROP FOREIGN KEY `fk_Endereco_Cliente1`,
DROP FOREIGN KEY `fk_Endereco_Fornecedor1`,
DROP FOREIGN KEY `fk_Endereco_Funcionario1`;

ALTER TABLE `GLRefrigeracao`.`Endereco` 
ADD COLUMN `id` INT NOT NULL AUTO_INCREMENT AFTER `cep`,
CHANGE COLUMN `Funcionario_CPF` `Funcionario_CPF` BIGINT(11) NULL ,
CHANGE COLUMN `Cliente_CNPJ` `Cliente_CNPJ` BIGINT(14) NULL ,
CHANGE COLUMN `Fornecedor_CNPJ` `Fornecedor_CNPJ` BIGINT(14) NULL ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`);
ALTER TABLE `GLRefrigeracao`.`Endereco` 
ADD CONSTRAINT `fk_Endereco_Cliente1`
  FOREIGN KEY (`Cliente_CNPJ`)
  REFERENCES `GLRefrigeracao`.`Cliente` (`CNPJ`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Endereco_Fornecedor1`
  FOREIGN KEY (`Fornecedor_CNPJ`)
  REFERENCES `GLRefrigeracao`.`Fornecedor` (`CNPJ`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Endereco_Funcionario1`
  FOREIGN KEY (`Funcionario_CPF`)
  REFERENCES `GLRefrigeracao`.`Funcionario` (`CPF`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
*/
