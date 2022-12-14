-- -----------------------------------------------------
-- Alterar estrutura das tabelas
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
