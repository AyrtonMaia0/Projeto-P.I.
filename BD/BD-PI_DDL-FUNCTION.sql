-- -----------------------------------------------------
-- Function
-- -----------------------------------------------------

-- 1.
delimiter //
create function CalcularAumento(IDFuncionario bigint, PercentualReajuste decimal) 
	returns decimal
    DETERMINISTIC
		begin 
			declare SalarioAtual, Reajuste decimal;
				select salario into SalarioAtual from funcionario where idFuncionario = CPF;
					set reajuste = salarioAtual + (salarioAtual * PercentualReajuste / 100);
						return reajuste;
		end //
delimiter ;

-- teste (Function 1)
select CalcularAumento(18039522293, 10);

-- 2.
delimiter //
create function FormatarCPF(formtCPF varchar(11)) 
	returns varchar(14)
    DETERMINISTIC
		begin 
			declare parte1, parte2, parte3, digito, CPF_Formatado varchar(14);
				set parte1 = substring(formtCPF, 1, 3);
                set parte2 = substring(formtCPF, 4, 3);
                set parte3 = substring(formtCPF, 7, 3);
                set digito = substring(formtCPF, 10);
                
                set CPF_Formatado = concat(parte1,'.',parte2,'.',parte3,'-',digito);
						return CPF_Formatado;
		end //
delimiter ;

-- teste (Function 2)
select FormatarCPF('75120273114');

drop function TempTrab;

-- 3.
delimiter //
create function TempTrab(IDfuncionario bigint) 
	returns int
    DETERMINISTIC
		begin 
			declare temp, retorno int;
				select year(curdate()) - year(dataAdm) into temp
                 from funcionario
                 where cpf = IDfuncionario;
						return temp;
		end //
delimiter ;

-- teste (Function 3)
select TempTrab('75120273114');

-- 4.
delimiter //
create function conversorDolar(valor decimal(8,2))  
	returns decimal(8,2)
    DETERMINISTIC
		begin 
			declare cotacao, valorReal decimal(8,2);
            set Cotacao = 5.15;
            set valorReal = round(valor * cotacao, 2);
						return valorReal;
		end //
delimiter ;

-- teste (Function 4)
select conversorDolar('500.00');

-- 5.
delimiter //
create function calcularDesconto(codvenda int, PercentualDesc int)  
	returns decimal(8,2)
    DETERMINISTIC
		begin 
			declare valor, desco decimal(8,2);
            select valorTotal into valor from venda where codvenda = idvenda;
				set desco = valor - valor * (PercentualDesc / 100);
						return desco;
		end //
delimiter ;

-- teste (Function 5)
drop function calcularDesconto;

select calcularDesconto('2', '10');

