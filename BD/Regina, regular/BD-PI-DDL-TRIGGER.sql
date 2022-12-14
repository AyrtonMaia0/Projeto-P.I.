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

-- 4.  ERRO

delimiter //
create trigger before_venda_insert 
before insert on venda 
for each row
	begin 
		if new.valorTotal >= 8000 then
        set new.valorTotal = (new.valorTotal * 0.15);
        end if ;
	end //
delimiter ;

-- teste

insert into venda (dataVenda, valorTotal, obs, cliente_cnpj, Funcionario_CPF)
	value
		  ("2023.12.02", "8000", null, "4335917000106", "85215974155");

-- 5. ERRO

delimiter $$
create trigger after_itensVenda_insert 
after insert on itensVenda
for each row
	begin 
		declare valorProd decimal(8,2);
        select preco into valorProd from estoque 
			where codProduto = new.estoque_codProduto;
		update estoque set qnt = qnt - new.qntProduto
			where codProduto = new.estoque_codProduto;
		update venda set valorTotal = valorTotal + (valorProd * new.qntProduto)
			where idVenda = new.venda_idVenda;
	end $$
delimiter ;
    
drop trigger after_itensVenda_insert;
    
-- teste 

insert into venda (dataVenda, valorTotal, obs, cliente_cnpj, Funcionario_CPF)
	value
		  ("2023.12.02", "800.00", null, "4335917000106", "85215974155");

insert into itensvenda (Venda_idVenda, Estoque_codProduto, qntProduto)
	value 
		  ("11", "700821", "2");
          
-- 6. ERRO
delimiter $$
create trigger after_itensVenda_delete 
after delete on itensVenda
for each row
	begin 
		declare valorProd decimal(8,2);
        select preco into valorProd from estoque 
			where codProduto = old.estoque_codProduto;
		update estoque set qnt = qnt + old.qntProduto
			where codProduto = old.estoque_codProduto;
		update venda set valorTotal = valorTotal - (valorProd * old.qntProduto)
			where idVenda = old.venda_idVenda;
	end $$
delimiter ;

-- teste

delete from itensvenda
where venda_idvenda like 8;	