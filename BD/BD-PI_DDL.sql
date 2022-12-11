
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema AZSolution
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema AZSolution
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `AZSolution` DEFAULT CHARACTER SET utf8 ;
USE `AZSolution` ;

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

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Alterar estrutura de tabela
-- -----------------------------------------------------

ALTER TABLE `AZSolution`.`Estoque` DROP COLUMN `altura`;
ALTER TABLE `AZSolution`.`Estoque` DROP COLUMN `largura`;
ALTER TABLE `AZSolution`.`Estoque` DROP COLUMN `comprimento`;
ALTER TABLE `AZSolution`.`Estoque` DROP COLUMN `table1col`;
ALTER TABLE `AZSolution`.`Estoque` ADD COLUMN `dimensoes` VARCHAR(50) AFTER `codBarras`;
ALTER TABLE `AZSolution`.`Estoque` CHANGE COLUMN `codProduto` `codProduto` VARCHAR(30) NOT NULL ; -- mudei
ALTER TABLE `AZSolution`.`Compras` CHANGE COLUMN `qtdCompra` `qtdCompra` INT NULL DEFAULT NULL; -- adicionei
ALTER TABLE `AZSolution`.`Compras` MODIFY COLUMN `qtdCompra` INT;
ALTER TABLE `AZSolution`.`Estoque` DROP COLUMN `table1col`;
ALTER TABLE `AZSolution`.`Funcionario` CHANGE `Funcao` `funcao` VARCHAR(80);
ALTER TABLE `AZSolution`.`Estoque` DROP COLUMN `largura`;
ALTER TABLE `AZSolution`.`Estoque` DROP COLUMN `altura`;
ALTER TABLE `AZSolution`.`Estoque` DROP COLUMN `comprimento`;
ALTER TABLE `AZSolution`.`Estoque` ADD COLUMN `dimensoes` VARCHAR(50) AFTER `codBarras`;
ALTER TABLE `AZSolution`.`Estoque` ADD COLUMN `qtd` VARCHAR(50) AFTER `circunferencia`;
ALTER TABLE `AZSolution`.`Cliente` DROP COLUMN `Venda_idVenda`;
ALTER TABLE `AZSolution`.`Telefone` CHANGE COLUMN `idTelefone` `idTelefone` INT(11) NOT NULL AUTO_INCREMENT; -- adicionei
-- GRANDE ALTERAÇÃO EM TELEFONE:
ALTER TABLE `AZSolution`.`Telefone` 
DROP FOREIGN KEY `fk_Telefone_Cliente1`,
DROP FOREIGN KEY `fk_Telefone_Fornecedor1`,
DROP FOREIGN KEY `fk_Telefone_Funcionario1`;
ALTER TABLE `AZSolution`.`Telefone` 
CHANGE COLUMN `Fornecedor_CNPJ` `Fornecedor_CNPJ` BIGINT(13) NULL ,
CHANGE COLUMN `Cliente_CNPJ` `Cliente_CNPJ` BIGINT(14) NULL ,
CHANGE COLUMN `Funcionario_CPF` `Funcionario_CPF` BIGINT(11) NULL ;
ALTER TABLE `AZSolution`.`Telefone` 
ADD CONSTRAINT `fk_Telefone_Cliente1`
  FOREIGN KEY (`Cliente_CNPJ`)
  REFERENCES `AZSolution`.`Cliente` (`CNPJ`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Telefone_Fornecedor1`
  FOREIGN KEY (`Fornecedor_CNPJ`)
  REFERENCES `AZSolution`.`Fornecedor` (`CNPJ`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Telefone_Funcionario1`
  FOREIGN KEY (`Funcionario_CPF`)
  REFERENCES `AZSolution`.`Funcionario` (`CPF`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  