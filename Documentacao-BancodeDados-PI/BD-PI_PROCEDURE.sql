-- -----------------------------------------------------
-- procedures
-- -----------------------------------------------------

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

delimiter //
create procedure reajuteSal(in taxa decimal(4,2))
		begin
			update empregato set salario = salario * taxa;
		end // 
delimiter ;

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


        