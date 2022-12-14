-- -----------------------------------------------------
-- Deletar ou atualizar DML
-- -----------------------------------------------------
DELETE FROM `Funcionario`
	WHERE `cpf` = 12395175333;

DELETE FROM `GLRefrigeracao`.`Estoque`
	WHERE `marca` like 'importado';

DELETE FROM `Fornecedor`
	WHERE `status` = 1
		AND `valorFrete`= 350.00;
    
DELETE FROM `Estoque`
	WHERE `nome` LIKE 'condensador%';

-- Deletando de Estoque o produto mais barato que não foi vendido no último mês
DELETE FROM Estoque
	WHERE codProduto NOT IN (
		SELECT Compras.Estoque_codProduto
			FROM Compras
				WHERE dataComp <= CURRENT_DATE - INTERVAL 1 MONTH)
                ORDER BY preco;
                
UPDATE Funcionario 
	SET funcao = 'gerente'
		WHERE CPF = 18039522293;
        
UPDATE Estoque 
	SET nome = 'CAIXA EVAPORADORA UNIVERSAL%'
		WHERE nome = 'CAIXA EVAPORADORA UNIVERSAL';

UPDATE Funcionario 
	SET nome = 'Ayrton Maya Soares'
		WHERE cpf = 18039522293;
        
UPDATE Telefone 
	SET numero = 81955694845
		WHERE cliente_CNPJ = 4335917000106;
        
UPDATE Venda
	SET obs = 'Revisar CNPJ deste cliente, pois está com suspeita de fraude. Frizar aos vendedores a necessidade de analisar se o CNPJ fornecedido é oriundo de oficinas ou afins.'
		WhERE idVenda = 3 AND Funcionario_CPF = 85215974155;
