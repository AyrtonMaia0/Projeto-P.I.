-- -----------------------------------------------------
-- Insert into
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Insert into fornecedor
-- -----------------------------------------------------

insert into fornecedor (CNPJ, nomeFornecedor, valorFrete, email, status)
	value ("94006115000137", "Royce Connect", "600.00", "royceconect@gmail.com", "1"),
		  ("50053765000168", "Spin", "350.00", "spin@gmail.com", "1"),
          ("46212572000135", "Delphi", "250.00", "delphi@gmail.com", "1"),
          ("28881621000140", "SuperCool", "860.00", "supercool@gmail.com", "1"),
          ("24891754000147", "Importado", "350.00", "importado@gmail.com", "1"),
          ("30879724000118", "McQuay", "150.00", "mcquay@gmail.com", "1");

-- -----------------------------------------------------
-- Insert into funcionario
-- -----------------------------------------------------

insert into funcionario (CPF, nome, email, salario, dataAdm, dataDem, status, funcao)
	value 
		  ("85215974155", "Maria Lima", "marialima@gmail.com", "2000", "2022.11.29", null, "1", "Vendedor"),
          ("75365495111", "Gilmar Adrian", "gilmaradrian@gmail.com","2000", "2020.08.21", null, "1", "Vendedor"),
          ("12395175333", "Livia Vitoria", "liviavitoria@gmail.com",  "2000", "2020.09.05", null, "1", "Vendedor"),
          ("18039522293", "Ayrton Maia", "ayrtonmaia@gail.com",  "2000", "2018.07.01", null, "1", "Caixa"),
          ("75120273114", "Danilo Farias", "danilofarias@gmail.com",  "3500", "2010.01.02", null, "1", "Gerente"),
          ("78249824407", "Jaqueline Lins", "jaquelinelins@gmal.com", "8000", "2009.06.15", null, "1", "CEO");

-- -----------------------------------------------------
-- Insert cliente
-- -----------------------------------------------------

insert into cliente (CNPJ, nomeCliente, email)
	value 
		  ("81583383000170", "OficinaA", "oficinaa@gmail.com"),
		  ("51451416000167", "OficinaB", "oficinab@gmail.com"),
          ("65778296000111", "OficinaC", "oficinac@gmail.com"),
          ("41437483000173", "OficinaD", "oficinad@gmail.com"),
          ("32354618000146", "OficinaE", "oficinae@gmail.com"),
          ("43945444000108", "OficinaF", "oficinaf@gmail.com"),
          ("43945444000102", "OficinaG", "oficinag@gmail.com"),
          ("57541425000125", "OficinaH", "oficinah@gmail.com"),
          ("04335917000106", "OficinaI", "oficinai@gmail.com"),
          ("27690818000130", "OficinaJ", "oficinaj@gmail.com"),
          ("39165274000176", "OficinaK", "oficinak@gmail.com"),
          ("86197624000166", "OficinaL", "oficinal@gmail.com"),
          ("11346108000157", "OficinaM", "oficinam@gmail.com"),
          ("48248458000190", "OficinaN", "oficinan@gmail.com"),
          ("30865274000104", "OficinaO", "oficinao@gmail.com"),
          ("85214715000108", "OficinaP", "oficinap@gmail.com"),
          ("32605925000152", "OficinaQ", "oficinaq@gmail.com"),
          ("77743700000109", "OficinaR", "oficinar@gmail.com"),
          ("73685215000167", "OficinaS", "oficinas@gmail.com"),
          ("78421344000161", "OficinaX", "oficinax@gmail.com");
          
-- -----------------------------------------------------
-- Insert into Compras
-- -----------------------------------------------------
          
insert into compras (idCompra, Estoque_codProduto, Fornecedor_CNPJ, dataCompra, qtdCompra, valorCompra, obs)
	value 
		  ("1", "700821", "94006115000137", "2022.12.02", "5", "500.00", null),
          ("2", "10029", "50053765000168", "2021.05.05", "5", "600.00", null),
          ("3", "250012", "46212572000135", "2022.08.21", "6", "700.00", null),
          ("4", "450210", "94006115000137", "2021.07.25", "50", "250.00", null),
          ("12", "824400", "24891754000147", "2022.01.15", "20", "400.00", null),
          ("6", "829900", "30879724000118", "2021.05.05", "15", "900.00", null),
          ("7", "740012", "24891754000147", "2022.10.10", "16", "650.00", null),
          ("8", "900002", "94006115000137", "2021.02.15", "20", "450.00", null),
          ("9", "850171", "28881621000140", "2022.02.15", "25", "300.00", null),
          ("10", "829900", "30879724000118", "2021.03.06", "30", "750.00", null);

alter table compras
change qtdCompra qtdCompra int;

-- -----------------------------------------------------
-- Insert into estoque
-- -----------------------------------------------------
          
insert into estoque (codProduto, nomeProduto, marca, preco, codBarras, dimensoes, circunferencia) 
	value
		  ("700821", "Evaporador Palio Fire", "Royce Connect", "280.00", null, "800x370x140mm", null),
          ("10029", "Selo de Spin Original", "Spin", "35.00", null, "434mm total / 250mm refil / Ø 30mm", null),
          ("250012", "VENTILADOR DA CAIXA EVAPORADORA MÁQUINA CATERPILLAR ESTEIRA DG5 E RETROESCAVADEIRA 416E 12 VOLTS", "Delphi", "45.00", null, "eixo Ø78mm / turbina Ø177mm / comprimento 198mm", null),
		  ("600123", "Compressor Modelo 7H15 Scania", "Royce Connect", "890.00", null, "132MM ", null),
		  ("2189", "Evaporador Denso Original", "Denso", "690.00", null, "770x330x145mm", null),
          ("530100", "Ventilador da Caixa Evaporadora do Volvo 2015>", "Royce Connect", "350.00", null, "800x370x140mm", null),
		  ("829900", "CONDENSADOR CHEVROLET CORSA 1994 ATÉ 1998 A/A TUBO ALETAS", "McQuay", "450.00", null, "572x314x30mm", null),
		  ("850171", "Oleo Constraste PAG150", "SuperCool", "75.00", null, "946ML", null),
          ("900002", "Oleo HB30", "Royce Connect", "30.00", null, "946ML", null),
          ("460024", "Valvula", "Royce Connect", "70.00", null, null, null),  
          ("450210", "Emenda 8", "Royce Connect", "6.00", null, null, null),
          ("740019", "Caixa Evaporadora Universal 24 Volts 2 Motores 6 Difusores Com Painel 32000 BTUs", " Importado", "300.00", null, "800x370x140mm", null),
		  ("740050", "CAIXA EVAPORADORA UNIVERSAL COM VÁLVULA DE EXPANSÃO CAPILAR 12 VOLTS 4 DIFUSORES", "Importado", "550.00", null, "340x403x142mm", null),
          ("740014", "CAIXA EVAPORADORA UNIVERSAL MICRO-BUS COM VÁLVULA CAPILAR 6 DIFUSORES 2 MOTORES 3 VELOCIDADES 12 VOLTS", "Importado", "250.00", null, "770x330x145mm", null),
          ("740012", "CAIXA EVAPORADORA UNIVERSAL MINI-BUS COM VÁLVULA CAPILAR 2 MOTORES 4 VELOCIDADES 12 VOLTS", "Importado", "600.00", null, "555x355x17,8mm", null),
          ("824400", "Condensador Chevrolet D20 1985 Até 1996 A/A Tubo Aletas", "Importado", "150.00", null, "465x280x31mm", null),
          ("009100", "CONDENSADOR CHEVROLET VECTRA 1997 ATÉ 2005 A/A TUBO ALETAS", " Importado", "400.00", null, "605x285x27mm", null),
          ("120060", "Chicote do Compressor Denso Scroll SC06 / SC08", "Royce Connect", "50.00", null, null, null),
          ("600025", "COMPRESSOR MODELO 7H15 4627 TRATOR UNIPORT 2011> 8 ORELHAS 12 VOLTS POLIA 2A 132MM SAÍDA VERTICAL R134A", " Importado", "350.00", null, "630x370x22mm", null);

-- -----------------------------------------------------
-- Insert into telefone
-- -----------------------------------------------------

insert into telefone (numero, Fornecedor_CNPJ, cliente_CNPJ, Funcionario_CPF)
	value
		  ("81921216838", "94006115000137", null, null), 
		  ("81921745843", "50053765000168", null, null),
          ("81937435782", "46212572000135", null, null),
          ("98927730805", "28881621000140", null, null),
          ("88938306443", "24891754000147", null, null),
          ("88938306443", "30879724000118", null, null),
          
          ("81938681812", null, "81583383000170", null),
          ("81925737616", null, "51451416000167", null),
          ("81932277607", null, "65778296000111", null),
          ("81925922611", null, "41437483000173", null),
          ("81939389366", null, "32354618000146", null),
          ("81932875488", null, "43945444000102", null),
          ("81933339128", null, "43945444000102", null),
          ("81938793128", null, "57541425000125", null),
          ("81925427897", null, "04335917000106", null),
          ("81925597814", null, "27690818000130", null),
          ("79922317373", null, "39165274000176", null),
          ("35927143293", null, "86197624000166", null),
          ("87929033148", null, "11346108000157", null),
          ("68936348182", null, "48248458000190", null),
          ("19927323243", null, "30865274000104", null),
          ("94930630597", null, "85214715000108", null),
          ("21932639738", null, "32605925000152", null),
          ("81929587142", null, "77743700000109", null),
          ("87920308075", null, "73685215000167", null),
          ("81939982501", null, "78421344000161", null),
          
          ("81939882455", null, null, "85215974155"),
          ("81920843358", null, null, "75365495111"),
          ("81921468914", null, null, "12395175333"),
          ("81936676699", null, null, "18039522293"),
          ("81937476247", null, null, "75120273114"),
          ("81930406564", null, null, "78249824407");

-- -----------------------------------------------------
-- Insert itensvenda
-- -----------------------------------------------------

insert into itensvenda (Venda_idVenda, Estoque_codProduto, qtdProduto)
	value 
		  ("1", "700821", "2"),
          ("2", "850171", "5"),
          ("3", "740014", "3"),
          ("4", "600025", "3"),
          ("5", "530100", "2"),
          ("6", "740050", "3"),
          ("7", "600123", "2"),
          ("8", "250012", "2"),
          ("9", "740019", "3"),
          ("10", "700821", "2");
         
-- -----------------------------------------------------
-- Insert into venda
-- -----------------------------------------------------

insert into venda (dataVenda, valorTotal, obs, Funcionario_CPF)
	value
		  ("2022.12.02", "800.00", null, "85215974155"),
          ("2022.11.05", "700.00", null, "85215974155"),
          ("2022.10.03", "1200.00", null, "85215974155"),
          ("2022.09.04", "4000.00", null, "75365495111"),
          ("2022.08.10", "950.50", null, "75365495111"),
          ("2022.07.12", "3250.00", null, "75365495111"),
          ("2022.06.16", "250.35", null, "12395175333"),
          ("2022.05.18", "658.00", null, "12395175333"),
          ("2022.04.06", "980.00", null, "12395175333"),
          ("2022.03.25", "1200.00", null, "12395175333");
          
insert into endereco (funcionario_cpf, cliente_cnpj, fornecedor_cnpj, uf, cidade, bairro, rua, numero, comp, cep)
	value
		  ("12395175333", null, null, "", "", "", "", "", "", ""),
          ("18039522293", null, null, "", "", "", "", "", "", ""),
          ("75120273114", null, null, "", "", "", "", "", "", ""),
          ("75365495111", null, null, "", "", "", "", "", "", ""),
          ("75365495111", null, null, "", "", "", "", "", "", ""),
          ("85215974155", null, null, "", "", "", "", "", "", ""),
          
          (null, "41437483000173", null, "", "", "", "", "", "", ""),
          (null, "43945444000102", null, "", "", "", "", "", "", ""),
          (null, "43945444000108", null, "", "", "", "", "", "", ""),
          (null, "48248458000190", null, "", "", "", "", "", "", ""),
          (null, "51451416000167", null, "", "", "", "", "", "", ""),
          
          (null, null, "24891754000147", "", "", "", "", "", "", ""),
          (null, null, "28881621000140", "", "", "", "", "", "", ""),
          (null, null, "30879724000118", "", "", "", "", "", "", ""),
          (null, null, "46212572000135", "", "", "", "", "", "", ""),
          (null, null, "50053765000168", "", "", "", "", "", "", ""),
          (null, null, "94006115000137", "", "", "", "", "", "", "");

-- -----------------------------------------------------
-- ALTERACOES 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Destruir DDL
-- -----------------------------------------------------

drop schema azsolution;

-- -----------------------------------------------------
-- Deletar ou atualizar DML
-- -----------------------------------------------------

delete from funcionario
	where cpf = 12395175333;
    
delete from estoque 
	where marca = importado;
    
delete from fornecedor
	where status = 1
    and frete = 350.00;
    
delete from estoque 
	where nomeProduto like 'condensador%';
    
delete from estoque
	where idVenda not in (
		select nomeProduto
			from venda
				where data >= 2022-12-02 - interval 1 month);
                
update funcionario 
	set funcao = 'gerente'
		where CPF = 18039522293;
        
update estoque 
	set nomeProduto = 'CAIXA EVAPORADORA UNIVERSAL%'
    where nomeProduto = 'CAIXA EVAPORADORA UNIVERSAL';

update funcionario 
	set nome = 'Ayrton Maya Soares'
		where cpf = 18039522293;
        
update telefone 
	set numero = 81955694845
		where cliente_CNPJ = 4335917000106;
        
update venda 
	set obs = 'Revisar CNPJ deste cliente, pois está com suspeita de fraude. Frizar aos vendedores a necessidade de analisar se o CNPJ fornecedido é oriundo de oficinas ou afins.'
		where idVenda = 3 and funcionarioCPF = 85215974155;
   