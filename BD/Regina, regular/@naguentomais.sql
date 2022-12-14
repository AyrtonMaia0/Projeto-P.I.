-- -----------------------------------------------------
-- Consultas, Perguntas, Relatorios
-- -----------------------------------------------------

-- 1. Dados dos fornecedores que fornecem Condensadores, tazendo as colunas (CNPJ Fornecedor, Nome Fornecedor, Telefone Fornecedor, 
-- Preço Frete, Preço Produto, Status Fornecedor)

select f.cnpj"CNPJ Fornecedor", f.nome"Nome Fornecedor", t.numero"Telefone fornecedor", f.valorFrete"Valor Frete", 
e.nome"Produto", e.preco"Preço",
	case when f.status = 1 then 'Ativo'
		when f.status = 0 then 'Inativo' end "Status"
			from fornecedor f
				inner join compras c on f.cnpj = c.fornecedor_cnpj
                inner join estoque e on e.codProduto = c.estoque_codProduto
                inner join telefone t on f.cnpj = t.fornecedor_cnpj
					where e.nome like 'Condensador%'
						order by e.preco;
                
-- 2. Lista de vendedores ativos na empresa, trazendo as colunas (Nome Vendedor, CPF Vendedor, Função, Telefone Vendedor, Cidade Moradia)

select f.nome"Funcionário", f.cpf"CPF", f.funcao"Função", en.cidade"Cidade Moradia", t.numero"Telefone Funcionario", 
	case when f.status = 1 then 'Ativo'
		when f.status = 0 then 'Inativo' end "Status"
			from funcionario f
				inner join telefone t on f.cpf = t.funcionario_cpf
				left join endereco en on f.cpf = en.funcionario_cpf
					where f.funcao like 'Vendedor';

-- 3. Nome do Funcionário e do cliente que participaram da venda do id 2, trazendo as colunas (Nome Cliente, CNPJ Cliente, Telefone Cliente,
-- Nome Funcionario, CPF Funcionario, Data Venda, Valor Total) 

select c.nome"Nome Cliente", c.cnpj"CNPJ", t.numero"Telefone Cliente", f.nome"Vendedor", v.dataVenda"Data Venda", v.valorTotal"Valor Total"
	from venda v
		inner join funcionario f on f.cpf = v.funcionario_cpf
        inner join cliente c on c.cnpj = v.cliente_cnpj
        left join telefone t on c.cnpj = t.cliente_cnpj
			where v.idvenda like '3';

-- 4. Nome dos funcionários que realizaram mais de 5 vendas no mes 08.2022, trazendo as colunas (Nome Funcionário, Telefone Empregado, CPF Empregado, 
-- Total Valor Vendido) ordenado pela Data Venda.

select f.nome"Empregado", f.cpf"CPF", tel.numero "Numero", sum(v.valorTotal)"Valor Total", count(v.idVenda)"Vendas", v.dataVenda"Data"
	from funcionario f
		inner join venda v on f.cpf = v.funcionario_cpf
        inner join telefone tel on f.cpf = tel.funcionario_cpf
			having count(v.idVenda) >= 5
				group by v.idvenda
					order by v.dataVenda;

-- 5. Nome dos clientes cadastrados no banco de dados da empresa, trazendo as colunas (Nome Cliente, Número Telefone, CNPJ, Cidade Moradia)

select c.nome"Nome", c.cnpj"CNPJ", tel.numero, en.cidade"Cidade Fornecedor"
	from cliente c
		inner join telefone tel on c.cnpj = tel.cliente_cnpj
		left join endereco en on c.cnpj = en.cliente_cnpj
			order by tel.numero;

-- 6. Lista dos empregados com a quantidade total de vendas já realiza por cada Empregado, trazendo as colunas (Nome Empregado,
-- CPF Empregado, Sexo, Salário, Quantidade Vendas, Total Valor Vendido), ordenado por quantidade total de vendas realizadas;

select f.nome "Funcionário", f.cpf "CPF", f.salario "Salário", 
	count(v.idvenda) "Quantidade Vendas", sum(v.valorTotal) "Total Vendido"
		from venda v
			left join funcionario f on f.cpf = v.funcionario_cpf
				group by (v.funcionario_cpf)
					order by sum(v.valorTotal) desc;

-- 7. Lista dos Produtos mais vendidos, informando a quantidade (total) de vezes que cada produto participou em vendas, trazendo as colunas 
-- (Nome Produto, Quantidade (Total) Vendas), ordenado por quantidade de vezes que o produto participou em vendas;

select est.nome "Nome Produto", count(iv.Estoque_codProduto) "Quantidade (Total) Vendas"
	from itensvenda iv
		inner join estoque est on iv.estoque_codProduto = est.codProduto
			group by est.codProduto
				order by count(iv.Estoque_codProduto) desc;

-- 7. Lista dos Produtos, informando qual Fornecedor de cada produto, trazendo as colunas (Nome Produto, Valor Produto, Categoria do Produto, 
-- Nome Fornecedor, Email Fornecedor, Telefone Fornecedor), ordenado por Nome Produto;

select est.nome"Produto", concat('R$ ', round(est.preco, 2))"Valor Produto", f.nome"Nome Fornecedor", f.email"Email Fornecedor",
    tel.numero "Telefone Fornecedor"
    from compras c
		inner join estoque est on est.codProduto = c.Estoque_codProduto
        inner join fornecedor f on f.cnpj = c.Fornecedor_cnpj
        left join telefone tel on tel.Fornecedor_cnpj = f.cnpj
			order by est.nome;

-- 8. Balaço das Vendas, informando a soma dos valores vendidos por dia, trazendo as colunas (Data Venda, Quantidade de Vendas, Valor Total Venda),
-- ordenado por Data Venda;

select substring(v.dataVenda, 1, 10) "Data", count(v.idVenda) "Quantidade Vendas", 
	concat('R$ ', sum(v.valorTotal)) "Total Vendido"
	from venda v
		group by substring(v.dataVenda, 1, 10)
			having count(v.idVenda) = (select max(valortotal) from venda);

-- 9. Lista das formas de pagamentos mais utilizadas nas Vendas, informando quantas vendas cada forma de pagamento já foi relacionada, 
-- trazendo as colunas (Tipo Forma Pagamento, Quantidade Vendas, Total Valor Vendido), ordenado por quantidade total de vendas realizadas;

select fp.tipoPag "Tipo Forma Pagamento", count(v.idVenda) "Quantidade Vendas", 
	concat('R$ ', sum(v.valorTotal)) "Total Vendido"
		from venda v
			left join formapag fp on fp.Venda_idVenda = v.idVenda
				group by fp.tipoPag
					order by count(v.idVenda) desc;

-- 10. Lista dos funcionarios admitidos entre 2020-01-01 e 2020-12-31, trazendo as colunas (Nome Empregado, CPF Empregado, Data Admissão,  Salário, 
-- Número de Telefone), ordenado por data de admissão decrescente;

select f.nome "Empregado", f.cpf "CPF", f.dataAdm "Data Admissão", f.salario "Salário", 
	en.cidade "Cidade", tel.numero "Número de Telefone"
    from funcionario f
		left join endereco en on en.funcionario_CPF = f.cpf
        left join telefone tel on tel.funcionario_CPF = f.cpf
			where f.dataAdm between '2020-01-01' and '2020-12-31'
				order by f.dataAdm desc;

-- 11. Lista dos funcionarios que ganham menos que a média salarial dos funcionários do Posto de Gasolina, trazendo as colunas (Nome Empregado, 
-- CPF Empregado, Data Admissão,  Salário), ordenado por nome do empregado;

select f.nome "Empregado", f.CPF "CPF", f.dataAdm "Data Admissão", f.salario "Salário", f.funcao"Função",
	en.cidade "Cidade"
    from funcionario f
		left join endereco en on en.funcionario_CPF = f.cpf
			where f.salario <= (select avg(salario) from funcionario)
				order by f.nome;

-- 12. Lista das Vendas, informando o detalhamento de cada venda quanto os seus itens, trazendo as colunas (Data Venda, Nome Produto, 
-- Quantidade ItensVenda, Valor Produto, Valor Total Venda, Nome Empregado, Nome do Departamento), ordenado por Data Venda;

select v.dataVenda "Data", est.nome "Produto", iv.qntProduto "Quantidade", 
	concat('R$ ', round(est.preco, 2)) "Valor do Produto", concat('R$ ', v.valorTotal) "Valor Total", 
    f.nome "Funcionário"
		from venda v
			inner join funcionario f on f.cpf = v.funcionario_cpf
            inner join itensvenda iv on iv.Venda_idVenda = v.idVenda
            inner join estoque est on est.codProduto = iv.Estoque_codProduto
					order by v.dataVenda;

-- 13. Valor do frete de cada fornecedor, trazendo as colunas (Nome Fornecedor, CNPJ, Numéro Telefone, Estado), ordenado pelo preço do frete.

select f.nome"Fornecedor", f.cnpj"CNPJ", tel.numero"Número", en.uf"Estado", f.valorFrete"Frete"
	from fornecedor f
		left join endereco en on f.cnpj = en.fornecedor_cnpj
        inner join telefone tel on f.cnpj = tel.fornecedor_cnpj
			order by f.valorFrete;

-- 14. Lista dos empregados que são da cidade do xxxx, trazendo as colunas (Nome Empregado, CPF Empregado, Data Admissão,  
-- Salário, Cidade Moradia, Numero de Telefone), ordenado por nome do empregado;

-- ERRO

select f.nome "Funcionário", f.cpf "CPF", f.dataAdm "Data Admissão", f.salario "Salário", 
	en.cidade "Cidade"
    from funcionario f
		left join endereco en on en.funcionario_CPF = f.cpf
        inner join telefone tel on tel.funcionario_cpf = f.cpf
			where en.cidade like 'Maceio'
				 group by f.cpf
					order by f.nome;
					
-- 15. Lista dos cliente que mais realizaram compras na loja, trazendo as colunas (Nome Cliente, Quantidade Compras, Valor Compras, 
-- Numero Telefone, Cidade Cliente).

select c.nome"Cliente", count(v.idvenda)"Quantidade de Compras", sum(v.valorTotal)"Valor Compras", t.numero"Telefone Cliente", e.cidade"Cidade Cliente"
	from venda v
		inner join cliente c on c.cnpj = v.cliente_cnpj
        left join endereco e on c.cnpj = e.cliente_cnpj
        inner join telefone t on c.cnpj = t.cliente_cnpj
			where v.idvenda
				order by v.valorTotal;

-- 16. Relatório das vendas que foram pagas a vista entre as datas 2022-05-18 - 2022-11-05, trazendo as colunas (ID Venda, Funcionário, Data Venda, Valor Total, Cliente, CNPJ Cliente e Tipo de pagamento) 

select v.idvenda"ID Venda", f.nome "Funcionário",  v.dataVenda "Data Venda", v.valorTotal "Valor Total", c.nome "Cliente", v.cliente_cnpj "CNPJ Cliente", fp.tipoPag "Tipo de pagamento"
	from venda v
		left join funcionario f on f.cpf = v.funcionario_cpf
		inner join cliente c on c.cnpj = v.cliente_cnpj
        inner join formapag fp on fp.Venda_idVenda = v.idVenda
			WHERE fp.tipoPag like 'a vista'
            and
            v.dataVenda between '2022-05-18' and '2022-11-05';

-- 17. Liste os produtos que possuem um preço acima da média e quantas vezes esse produto participou de uma venda, trazendo as colunas(
-- Código Produto, Nome Produto, Preço Produto, Número De Vendas)

select e.codproduto"Código Produto", e.nome"Nome Produto", e.preco"Preco"
	from estoque e
		where e.preco >= (select avg(preco) from estoque) in
			(select count(iv.venda_idvenda)"Numero de Vendas"
				from itensVenda iv
					where count(iv.venda_idvenda));
                    
-- 18. Relatório dos produtos cadastrados no estoque cujo preço estão acima da média, trazendo as colunas (Código Produto,
-- Nome Produto, Marca Produto, Preço, Quantidade Disponivel) 

select codProduto"Código Produto", nome"Produto", marca"Marca", qnt"Quantidade Disponivel", preco"Preço"
	from estoque
		where preco > (select avg(preco) from estoque)
			order by preco;
            
-- 19. Lista dos fornecedores que fornecem 

-- -----------------------------------------------------
-- procedures
-- -----------------------------------------------------

-- 1
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

-- -----------------------------------------------------
-- functions
-- -----------------------------------------------------

-- 1
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

-- -----------------------------------------------------
-- triggers
-- -----------------------------------------------------

-- 1. Trigger para controlar as alterações realizadas da coluna salario da tabela funcionário 

-- Criar uma tabela para armezenar os dados da alteração
create table auditoriaSalario (
	idAuditoria int not null auto_increment primary key,
	CPFFun bigint(11) not null not null,
	nomeFun varchar(120) not null,
	salarioAn decimal(8,2) not null,
	salarioNovo decimal(8,2) not null,
	user varchar(120) not null,
	dataHr datetime not null
);

drop table auditoriaSalario;

delimiter $$
create trigger after_funcionario_update
	after update on funcionario
	for each row
		begin
			if old.salario != new.salario then
				insert into auditoriaSalario (CPFFun, nomeFun, salarioAn, salarioNovo, USER, dataHr)
					value (new.CPF, new.nome, old.salario, new.salario, user(), now());
			end if;
		end $$
delimiter ;

drop trigger after_funcionario_update;

-- Teste 
select cpf, nome, salario
	from funcionario;
    
update funcionario 
	set salario = 2800
		where cpf = 18039522293;

-- 2.
delimiter $$
create trigger before_fucionario_insert
before insert on funcionario
	for each row
		begin 
			if new.salario > 2000 then 
				signal sqlstate '45000' set message_text = 'Salário não pode ultrapassar 2000. Por favor, entrar com um valor válido';
			end if;
		end $$
delimiter ;

-- teste
insert into funcionario (CPF, nome, email, salario, dataAdm, dataDem, status, funcao)
	value 
		  ("12345678912", "Mhel Lima", "mhellima@gmail.com", "2500", "2022.11.29", null, "1", "Vendedor");
          
-- 3. Trigger para converter os dados inseridos na coluna Tipo Pagamento da tabela Forma de Pagamento 
delimiter $$
create trigger before_formpag_insert
before insert on formapag
	for each row
		begin 
			if (new.tipoPag = '1') then
			    set new.tipoPag = 'Crétido';
			elseif (new.tipoPag = '2') then
				set new.tipoPag = 'Dinheiro';
			elseif (new.tipoPag = '3') then
				set new.tipoPag = 'Pix';
			elseif (new.tipoPag not in ('Crétido', 'Dinheiro', 'Pix')) then
				signal sqlstate '45000' set message_text = 'Caracter inválido para o atributo Forma de Pagamento. Informe Crédito, Dinheiro, pix ou 1, 2, 3 respectivamente';
			end if;
		end $$
delimiter ;

-- teste

insert into venda (dataVenda, valorTotal, obs, cliente_cnpj, Funcionario_CPF)
	value
		  ("2023.12.08", "800.00", null, "4335917000106", "85215974155"),
          ("2023.11.05", "700.00", null, "11346108000157", "85215974155"),
          ("2023.10.10", "1200.00", null, "27690818000130", "85215974155");

insert into formapag (tipoPag, valorPag, qtdParcelas, venda_idVenda)
	values 
		  ("1", "800", null, "11");
                
insert into formapag (tipoPag, valorPag, qtdParcelas, venda_idVenda)
	values 
		  ("2", "700", null, "12");
          
insert into formapag (tipoPag, valorPag, qtdParcelas, venda_idVenda)
	values 
		  ("4", "1200", null, "13");

-- 4.  





-- 1
delimiter // 
create trigger tgr_ItensVenda_Insert_Af after insert 
	on itensvenda 
    for each row
		begin 
			declare valorProduto decimal(8,2);
            select preco into valorProduto from estoque
				where codProduto = new.estoque_codproduto;
			update estoque set qnt = qnt - new.qnt.Produto
				where codProduto = new.estoque_codProduto;
			update venda set valorTotal = valorTotal + (valorProduto * new.qntProduto)
				where idVenda = new.venda_idVenda;
		end //
delimiter ;

insert into itensvenda (Venda_idVenda, Estoque_codProduto, qntProduto)
	value 
		  ("123", "009100", "3");

-- 2
delimiter //
create trigger tgr_comptras_insert_af after insert
	on estoque
    for each row
		begin 
        
			
            
			
            
-- 3
delimiter //
create trigger tgr_ItensVenda_Delete_Af after delete
on itensVenda
for each row
	begin 
		declare valorProduto decimal(7,2);
        select preco into valorProduto from estoque
			where codProduto = old.estoque_codProduto;
		update estoque set qtd = qtd + old.qtdProduto 
			where codProduto  = old.estoque_codProduto;
		update vendas set valorTotal = valorTotal - (valorProd * old.qtdProduto)
			where idvenda = old.venda_idvenda;
	end //
delimiter ;

-- 4 ERRO
delimiter //
create trigger tgr_Venda_Insert_Be before insert
on venda 
for each row
	begin 
		if new.valorTotal >= 8000 then
        update venda 
        set new.valorTotal = (valorTotal * 0.15) - valorTotal
        where valorTotal = new.valorTotal;
        end if ;
	end //
delimiter ;

insert into venda (dataVenda, valorTotal, obs, cliente_cnpj, Funcionario_CPF)
	value
		  ("2023.12.02", "8000", null, "4335917000106", "85215974155");

-- 5 ERRO
create trigger trg_Salario_insert_bf before insert
on funcionario 
for each row
	begin
		if new.salario > 2000 then
			SIGNAL SQLSTATE '50001'set message_text = 'Valor acima do permitido para vendedor.'
				where new.funcao like 'caixa';
		and if ;
	end //
delimiter ;