
-- nao testei
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