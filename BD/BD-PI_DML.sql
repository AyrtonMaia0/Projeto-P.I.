-----------------------------------------------------
-- Consultas, Perguntas, Relatorios
-- -----------------------------------------------------

-- 1. Dados dos fornecedores que fornecem Condensadores, tazendo as colunas (CNPJ Fornecedor, Nome Fornecedor, Telefone Fornecedor, 
-- Preço Frete, Preço Produto, Status Fornecedor)

select f.cnpj"CNPJ Fornecedor", f.nomeFornecedor"Nome Fornecedor", t.numero"Telefone fornecedor", f.valorFrete"Valor Frete", 
e.nomeProduto"Produto", e.preco"Preço",
	case when f.status = 1 then 'Ativo'
		when f.status = 0 then 'Inativo' end "Status"
			from compras 
				inner join fornecedor f on f.cnpj = c.fornecedor_cnpj
				inner join estoque e on e.codProduto = c.estoque_codProduto
                left join telefone t on f.cnpj = t.fornecedor_cnpj
					where e.nomeProduto like 'Condensador%'
						order by e.preco;

-- 2. Lista de vendedores ativos na empresa, trazendo as colunas (Nome Vendedor, CPF Vendedor, Função, Telefone Vendedor, Cidade Moradia)

select f.nomeFun"Funcionário", f.cpf"CPF", f.funcao"Função", en.cidade"Cidade Moradia", t.numero"Telefone Funcionario", 
	case when f.status = 1 then 'Ativo'
		when f.status = 0 then 'Inativo' end "Status"
			from funcionario f
				inner join telefone t on f.cpf = t.funcionario_cpf
				left join endereco en on f.cpf = en.funcionario_cpf
					where f.funcao like 'Vendedor';


-- 3. Nome do Funcionário e do cliente que participaram da venda do id 2, trazendo as colunas (Nome Cliente, CNPJ Cliente, Telefone Cliente,
-- Nome Funcionario, CPF Funcionario, Data Venda, Valor Total) 

select c.nomeCli"Nome Cliente", c.cnpj"CNPJ", t.numero"Telefone Cliente", f.nomeFun"Vendedor", v.dataVenda"Data Venda", v.valorTotal"Valor Total"
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

select c.nomeCli"Nome", c.cnpj"CNPJ", tel.numero
	from cliente c
		inner join telefone tel on c.cnpj = tel.cliente_cnpj
		inner join endereco en on c.cnpj = en.cliente_cnpj;

-- 6. Lista dos empregados com a quantidade total de vendas já realiza por cada Empregado, trazendo as colunas (Nome Empregado,
-- CPF Empregado, Sexo, Salário, Quantidade Vendas, Total Valor Vendido), ordenado por quantidade total de vendas realizadas;

select f.nome "Funcionário", f.cpf "CPF", f.salario "Salário", 
	count(v.idvendas) "Quantidade Vendas", sum(v.valorTotal) "Total Vendido"
		from vendas v
			inner join funcionario f on f.cpf = v.funcionario_cpf
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

select est.nomeProduto "Produto", concat('R$ ', round(est.preco, 2)) "Valor Produto", 
	est.categoria "Categoria do Produto", f.nome "Nome Fornecedor", f.email "Email Fornecedor",
    tel.numero "Telefone Fornecedor"
    from compras c
		inner join estoque est on est.codProduto = c.Estoque_codProduto
        inner join fornecedor f on f.cnpj = c.Fornecedor_cnpj
        left join telefone tel on tel.Fornecedor_cnpj = f.cnpj
			order by est.nomeProduto;

-- 8. Balaço das Vendas, informando a soma dos valores vendidos por dia, trazendo as colunas (Data Venda, Quantidade de Vendas, Valor Total Venda),
-- ordenado por Data Venda;

select substring(v.dataVenda, 1, 10) "Data", count(v.idVendas) "Quantidade Vendas", 
	concat('R$ ', sum(v.valorTotal)) "Total Vendido"
	from vendas v
		group by substring(v.dataVenda, 1, 10)
			having count(v.idVendas) = (select max(total) from totalVendasData);

-- 9. Lista das formas de pagamentos mais utilizadas nas Vendas, informando quantas vendas cada forma de pagamento já foi relacionada, 
-- trazendo as colunas (Tipo Forma Pagamento, Quantidade Vendas, Total Valor Vendido), ordenado por quantidade total de vendas realizadas;

select fp.tipoPag "Tipo Forma Pagamento", count(v.idVendas) "Quantidade Vendas", 
	concat('R$ ', sum(v.valorTotal)) "Total Vendido"
		from vendas v
			inner join formapag fp on fp.Vendas_idVendas = v.idVendas
				group by fp.tipoPag
					order by count(v.idVendas) desc;

-- 10. Lista dos funcionarios admitidos entre 2020-01-01 e 2020-12-31, trazendo as colunas (Nome Empregado, CPF Empregado, Data Admissão,  Salário, 
-- Número de Telefone), ordenado por data de admissão decrescente;

select f.nome "Empregado", f.cpf "CPF", f.dataAdm "Data Admissão", f.salario "Salário", 
	en.cidade "Cidade", tel.numero "Número de Telefone"
    from funcionario f
		inner join endereco en on en.funcionario_CPF = f.cpf
        left join telefone tel on tel.funcionario_CPF = f.cpf
			where f.dataAdm between '2020-01-01' and '2020-12-31'
				order by f.dataAdm desc;

-- 11. Lista dos funcionarios que ganham menos que a média salarial dos funcionários do Posto de Gasolina, trazendo as colunas (Nome Empregado, 
-- CPF Empregado, Data Admissão,  Salário), ordenado por nome do empregado;

select f.nome "Empregado", f.CPF "CPF", f.dataAdm "Data Admissão", f.salario "Salário", 
	en.cidade "Cidade"
    from funcionario f
		inner join endereco en on en.funcionario_CPF = f.cpf
			where f.salario <= (select avg(salario) from funcionario)
				order by f.nome;

-- 12. Lista das Vendas, informando o detalhamento de cada venda quanto os seus itens, trazendo as colunas (Data Venda, Nome Produto, 
-- Quantidade ItensVenda, Valor Produto, Valor Total Venda, Nome Empregado, Nome do Departamento), ordenado por Data Venda;

select v.dataVenda "Data", est.nome "Produto", iv.qtdProduto "Quantidade", 
	concat('R$ ', round(est.preco, 2)) "Valor do Produto", concat('R$ ', v.valorTotal) "Valor Total", 
    f.nome "Funcionário"
		from vendas v
			inner join funcionario f on f.cpf = v.funcionario_cpf
            inner join itensvenda iv on iv.Vendas_idVendas = v.idVendas
            inner join estoque est on est.codProduto = iv.Estoque_codProduto
					order by v.dataVenda;

-- 13. Valor do frete de cada fornecedor, trazendo as colunas (Nome Fornecedor, CNPJ, Numéro Telefone, Estado), ordenado pelo preço do frete.

select f.nomeFun"Fornecedor", f.cnpj"CNPJ", tel.numero"Número", en.Estado"Estado", f.valorFrete"Frete"
	from fornecedor f
		inner join endereco en on f.cnpj = en.fornecedor_cnpj
        inner join telefone tel on f.cnpj = tel.fornecedor_cnpj
			order by f.valorFrete;

-- 14. Lista dos empregados que são da cidade do xxxx, trazendo as colunas (Nome Empregado, CPF Empregado, Data Admissão,  
-- Salário, Cidade Moradia, Numero de Telefone), ordenado por nome do empregado;

select f.nome "Funcionário", f.cpf "CPF", f.dataAdm "Data Admissão", f.salario "Salário", 
	en.cidade "Cidade"
    from empregado e
		inner join endereco en on en.Empregado_CPF = e.cpf
        left join telefone tel on tel.funcionario_cpf = f.cpf
			where en.cidade like ""
				group by (f.cpf)
					order by f.nome;
