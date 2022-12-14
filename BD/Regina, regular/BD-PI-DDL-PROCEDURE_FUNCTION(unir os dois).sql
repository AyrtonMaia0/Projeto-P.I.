
-- ERRO Roda, mas não tras os dados
-- 1
delimiter //
create procedure relVendasData(in dataIni date, in dataFim date)
	begin
		select v.dataVenda "Data", est.nome "Produto", iv.qntProduto "Quantidade", 
			concat('R$ ', round(est.preco, 2)) "Valor do Produto", concat('R$ ', v.valorTotal) "Valor Total", 
			f.nome "Vendedor"
				from venda v
					left join funcionario f on f.CPF = v.funcionario_cpf
					left join itensvenda iv on iv.Venda_idVenda = v.idVenda
					left join estoque est on est.codProduto = iv.Estoque_codProduto
						where v.dataVenda between dataIni and dataFim 
							order by v.dataVenda;
    end //
delimiter ;

drop procedure relVendasData;

call relVendasData('2022-12-02', '2022-04-06');

-- 2
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

-- 3
delimiter //
create procedure preco(in cod int(13))
	begin 
		select e.codproduto"Código", e.nome"Produto", e.marca"Marca", e.preco"Preço", e.dimensoes"Dimensões", e.circunferencia"Circunferencia",
        f.nome"Fornecedor"
			from estoque e
				inner join compras c on c.estoque_codproduto = e.codproduto
                inner join fornecedor f on f.cnpj = c.fornecedor_cnpj
					where cod = e.codproduto;
	end //
delimiter //

call preco('10029');
    
    
-- tava pegando, não pega mais
-- 4
delimiter //
create procedure inserirProd(in cod varchar(30), in n varchar(180), in ma varchar(45), in p decimal(8,2), in d varchar(50))
	begin
		declare v_codigoProduto VARCHAR(30);
            select codProduto into v_codigoProduto from Estoque where codProduto = cod;
            if(isnull(codProduto)) then
				insert into estoque(codProduto, nome, marca, preco, dimensoes)
					value (cod, n, ma, p, d);
			else 
				update estoque set quantidade = quantidade + qnt, preco = p
					where v_codigoProduto = cod;
			end if;
		end //
delimiter  ;

drop procedure inserirProd;

call glrefrigeracao.inserirProd('123456789', 'garrfa', 'puma', 13.00, 'grande');

-- 5    
delimiter //
create procedure vendaFuncionario(in nomeFun varchar(120)) 
	begin 
		select v.dataVenda "Data", e.nome"Produto", iv.qntProduto"Quantidade", concat('R$ ', round(e.preco, 2))"Valor Produto", 
        concat('R$ ', v.valorTotal)"Valor Total", f.nome"Funcionario"
			from venda v
				inner join funcionario f on f.cpf = v.funcionario_cpf 
				inner join itensvenda iv on v.idvenda = iv.venda_idvenda
                inner join estoque e on e.codProduto = iv.estoque_codProduto
					where f.nome = nomeFun
						order by v.dataVenda;
	end //
delimiter ;

drop procedure vendaFuncionario;

call vendaFuncionario('Maria Lima');

-- erro
-- 6
delimiter //
create procedure reajusteSalarial(in taxa decimal(4,2))
		begin
			update funcionario set salario = (salario * taxa)
				where funcao like 'Vendedor';
		end // 
delimiter ;

drop procedure reajusteSalarial; 

call reajusteSalarial(0.5);
