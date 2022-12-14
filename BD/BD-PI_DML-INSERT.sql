-- -----------------------------------------------------
-- INSERT INTO
-- -----------------------------------------------------

-- -----------------------------------------------------
-- INSERT INTO fornecedor
-- -----------------------------------------------------
INSERT INTO Fornecedor (CNPJ, nome, valorFrete, email, `status`)
	VALUE ("94006115000137", "Royce Connect", "600.00", "royceconect@gmail.com", "1"),
		  ("50053765000168", "Spin", "350.00", "spin@gmail.com", "1"),
          ("46212572000135", "Delphi", "250.00", "delphi@gmail.com", "1"),
          ("28881621000140", "SuperCool", "860.00", "supercool@gmail.com", "1"),
          ("24891754000147", "Importado", "350.00", "importado@gmail.com", "1"),
          ("30879724000118", "McQuay", "150.00", "mcquay@gmail.com", "1");
-- -----------------------------------------------------
-- INSERT INTO funcionario
-- -----------------------------------------------------

INSERT INTO Funcionario (CPF, nome, email, salario, dataAdm, dataDem, `status`, funcao)
	VALUE 
		  ("85215974155", "Maria Lima", "marialima@gmail.com", "2000", "2022.11.29", NULL, "1", "Vendedor"),
          ("75365495111", "Gilmar Adrian", "gilmaradrian@gmail.com","2000", "2020.08.21", NULL, "1", "Vendedor"),
          ("12395175333", "Livia Vitoria", "liviavitoria@gmail.com",  "2000", "2020.09.05", NULL, "1", "Vendedor"),
          ("18039522293", "Ayrton Maia", "ayrtonmaia@gail.com",  "2000", "2018.07.01", NULL, "1", "Caixa"),
          ("75120273114", "Danilo Farias", "danilofarias@gmail.com",  "3500", "2010.01.02", NULL, "1", "Gerente"),
          ("78249824407", "Jaqueline Lins", "jaquelinelins@gmal.com", "8000", "2009.06.15", NULL, "1", "CEO");

-- -----------------------------------------------------
-- Insert cliente
-- -----------------------------------------------------
INSERT INTO Cliente (CNPJ, nome, email)
	VALUE 
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
-- INSERT INTO Estoque
-- -----------------------------------------------------
INSERT INTO Estoque (codProduto, nome, marca, preco, qnt, codBarras, dimensoes, circunferencia) 
	VALUE
		  ("700821", "Evaporador Palio Fire", "Royce Connect", "280.00", "5", NULL, "800x370x140mm", NULL),
          ("10029", "Selo de Spin Original", "Spin", "35.00", "5", NULL, "434mm total / 250mm refil / Ø 30mm", NULL),
          ("250012", "VENTILADOR DA CAIXA EVAPORADORA MÁQUINA CATERPILLAR ESTEIRA DG5 E RETROESCAVADEIRA 416E 12 VOLTS", "Delphi", "45.00", "5", NULL, "eixo Ø78mm / turbina Ø177mm / comprimento 198mm", NULL),
		  ("600123", "Compressor Modelo 7H15 Scania", "Royce Connect", "890.00", "5", NULL, "132MM ", NULL),
		  ("2189", "Evaporador Denso Original", "Denso", "690.00", "5", NULL, "770x330x145mm", NULL),
          ("530100", "Ventilador da Caixa Evaporadora do Volvo 2015>", "Royce Connect", "350.00", "5", NULL, "800x370x140mm", NULL),
		  ("829900", "CONDENSADOR CHEVROLET CORSA 1994 ATÉ 1998 A/A TUBO ALETAS", "McQuay", "450.00", "5", NULL, "572x314x30mm", NULL),
		  ("850171", "Oleo Constraste PAG150", "SuperCool", "75.00", "5", NULL, "946ML", NULL),
          ("900002", "Oleo HB30", "Royce Connect", "30.00", "5", NULL, "946ML", NULL),
          ("460024", "Valvula", "Royce Connect", "70.00", "5", NULL, NULL, NULL),  
          ("450210", "Emenda 8", "Royce Connect", "6.00", "5", NULL, NULL, NULL),
          ("740019", "Caixa Evaporadora Universal 24 Volts 2 Motores 6 Difusores Com Painel 32000 BTUs", " Importado", "300.00", "5", NULL, "800x370x140mm", NULL),
		  ("740050", "CAIXA EVAPORADORA UNIVERSAL COM VÁLVULA DE EXPANSÃO CAPILAR 12 VOLTS 4 DIFUSORES", "Importado", "550.00", "5", NULL, "340x403x142mm", NULL),
          ("740014", "CAIXA EVAPORADORA UNIVERSAL MICRO-BUS COM VÁLVULA CAPILAR 6 DIFUSORES 2 MOTORES 3 VELOCIDADES 12 VOLTS", "Importado", "250.00", "5", NULL, "770x330x145mm", NULL),
          ("740012", "CAIXA EVAPORADORA UNIVERSAL MINI-BUS COM VÁLVULA CAPILAR 2 MOTORES 4 VELOCIDADES 12 VOLTS", "Importado", "600.00", "5", NULL, "555x355x17,8mm", NULL),
          ("824400", "Condensador Chevrolet D20 1985 Até 1996 A/A Tubo Aletas", "Importado", "150.00", "5", NULL, "465x280x31mm", NULL),
          ("009100", "CONDENSADOR CHEVROLET VECTRA 1997 ATÉ 2005 A/A TUBO ALETAS", " Importado", "400.00", "5", NULL, "605x285x27mm", NULL),
          ("120060", "Chicote do Compressor Denso Scroll SC06 / SC08", "Royce Connect", "50.00", "5", NULL, NULL, NULL),
          ("600025", "COMPRESSOR MODELO 7H15 4627 TRATOR UNIPORT 2011> 8 ORELHAS 12 VOLTS POLIA 2A 132MM SAÍDA VERTICAL R134A", " Importado", "350.00", "5", NULL, "630x370x22mm", NULL);

-- -----------------------------------------------------
-- INSERT INTO Compras
-- -----------------------------------------------------
          
INSERT INTO Compras (Estoque_codProduto, Fornecedor_CNPJ, dataComp, qtdCompra, valorCompra, obs)
	VALUE 
		  ("700821", "94006115000137", "2022.12.02", "10", "500.00", NULL),
          ("10029", "50053765000168", "2021.05.05", "5", "600.00", NULL),
          ("250012", "46212572000135", "2022.08.21", "6", "700.00", NULL),
          ("450210", "94006115000137", "2021.07.25", "50", "250.00", NULL),
          ("824400", "24891754000147", "2022.01.15", "20", "400.00", NULL),
          ("829900", "30879724000118", "2021.05.05", "15", "900.00", NULL),
          ("740012", "24891754000147", "2022.10.10", "16", "650.00", NULL),
          ("900002", "94006115000137", "2021.02.15", "20", "450.00", NULL),
          ("850171", "28881621000140", "2022.02.15", "25", "300.00", NULL),
          ("829900", "30879724000118", "2021.03.06", "30", "750.00", NULL);

-- -----------------------------------------------------
-- INSERT INTO Telefone
-- -----------------------------------------------------

INSERT INTO Telefone (numero, Fornecedor_CNPJ, cliente_CNPJ, Funcionario_CPF)
	VALUE
		  ("81921216838", "94006115000137", NULL, NULL), 
		  ("81921745843", "50053765000168", NULL, NULL),
          ("81937435782", "46212572000135", NULL, NULL),
          ("98927730805", "28881621000140", NULL, NULL),
          ("88938306443", "24891754000147", NULL, NULL),
          ("88938306443", "30879724000118", NULL, NULL),
          
          ("81938681812", NULL, "81583383000170", NULL),
          ("81925737616", NULL, "51451416000167", NULL),
          ("81932277607", NULL, "65778296000111", NULL),
          ("81925922611", NULL, "41437483000173", NULL),
          ("81939389366", NULL, "32354618000146", NULL),
          ("81932875488", NULL, "43945444000102", NULL),
          ("81933339128", NULL, "43945444000102", NULL),
          ("81938793128", NULL, "57541425000125", NULL),
          ("81925427897", NULL, "04335917000106", NULL),
          ("81925597814", NULL, "27690818000130", NULL),
          ("79922317373", NULL, "39165274000176", NULL),
          ("35927143293", NULL, "86197624000166", NULL),
          ("87929033148", NULL, "11346108000157", NULL),
          ("68936348182", NULL, "48248458000190", NULL),
          ("19927323243", NULL, "30865274000104", NULL),
          ("94930630597", NULL, "85214715000108", NULL),
          ("21932639738", NULL, "32605925000152", NULL),
          ("81929587142", NULL, "77743700000109", NULL),
          ("87920308075", NULL, "73685215000167", NULL),
          ("81939982501", NULL, "78421344000161", NULL),
          
          ("81939882455", NULL, NULL, "85215974155"),
          ("81920843358", NULL, NULL, "75365495111"),
          ("81921468914", NULL, NULL, "12395175333"),
          ("81936676699", NULL, NULL, "18039522293"),
          ("81937476247", NULL, NULL, "75120273114"),
          ("81930406564", NULL, NULL, "78249824407");

-- -----------------------------------------------------
-- Insert into Venda
-- -----------------------------------------------------

INSERT INTO Venda (dataVenda, valorTotal, obs, cliente_cnpj, Funcionario_CPF)
	VALUE
		  ("2022.12.02", "800.00", NULL, "4335917000106", "85215974155"),
          ("2022.11.05", "700.00", NULL, "11346108000157", "85215974155"),
          ("2022.10.03", "1200.00", NULL, "27690818000130", "85215974155"),
          ("2022.09.04", "4000.00", NULL, "30865274000104", "75365495111"),
          ("2022.08.10", "950.50", NULL, "32354618000146", "75365495111"),
          ("2022.07.12", "3250.00", NULL, "39165274000176", "75365495111"),
          ("2022.06.16", "250.35", NULL, "39165274000176", "12395175333"),
          ("2022.05.18", "658.00", NULL, "39165274000176", "12395175333"),
          ("2022.04.06", "980.00", NULL, "57541425000125", "12395175333"),
          ("2022.03.25", "1200.00", NULL, "57541425000125", "12395175333");

-- -----------------------------------------------------
-- Insert itensVenda
-- -----------------------------------------------------

INSERT INTO itensVenda (Venda_idVenda, Estoque_codProduto, qntProduto)
	VALUE 
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
-- Insert into Endereco
-- -----------------------------------------------------
INSERT INTO Endereco (funcionario_cpf, cliente_cnpj, fornecedor_cnpj, uf, bairro, cidade, rua, comp, numero, cep)
	VALUE
		   ("12395175333", NULL, NULL, "AL", "gruta de lourdes", "Maceio", "Rua Sucupira", NULL, "125", "50690754"),
           ("18039522293", NULL, NULL, "AL", "gruta de lourdes", "Maceio", "Doutor Vicente de Costa", NULL, "365", "50690752"),
           ("75120273114", NULL, NULL, "AL", "pinheiro", "Maceio", "Serafim Costa", NULL, "86", "50690753"),
           ("75365495111", NULL, NULL, "AL", "pinheiro", "Maceio", "Aurelio Calvacante", NULL, "57", "50690755"),
           ("75365495111", NULL, NULL, "AL", "santa lúcia", "Maceio", "Lices Brado Junior", NULL, "32", "50690756"),
           ("85215974155", NULL, NULL, "AL", "santa lúcia", "Maceio", "Rua Entra Aoulso", NULL, "15", "50690757"),
          
           (NULL, "41437483000173", NULL, "AL", "Bairro A", "Distande", "Rua 1", NULL, "12", "10690754"),
           (NULL, "43945444000102", NULL, "AL", "Bairro B", "Longe", "Rua 2", NULL, "13", "24690754"),
           (NULL, "43945444000108", NULL, "AL", "Bairro C", "Um Pouco Distante", "Rua 3", NULL, "16", "69690754"),
           (NULL, "48248458000190", NULL, "AL", "Bairro D", "Longe Que Só", "Rua 4", NULL, "15", "36690754"),
           (NULL, "51451416000167", NULL, "AL", "Bairro E", "Distante Para KCT", "Rua 5", NULL, "14", "15690754"),
          
           (NULL, NULL, "24891754000147", "PE", "Bairro L", "Ali", "Rua 6", NULL, "35", "15698754"),
           (NULL, NULL, "28881621000140", "MG", "Bairro P", "Logo Ali", "Rua 7", NULL, "17", "15690794"),
          (NULL, NULL, "30879724000118", "PE", "Bairro N", "Virando a Esquerda", "Rua 8", NULL, "18", "15490754"),
          (NULL, NULL, "46212572000135", "SP", "Bairro M", "Virando a Direita", "Rua 9", NULL, "19", "13690754"),
          (NULL, NULL, "50053765000168", "RJ", "Bairro V", "Mais a Frente", "Rua 10", NULL, "20", "15648754"),
          (NULL, NULL, "94006115000137", "SP", "Bairro S", "Caminhando Reto", "Rua 11", NULL, "21", "15470754");

-- -----------------------------------------------------
-- Insert into FormaPag
-- -----------------------------------------------------
INSERT INTO FormaPag (tipoPag, valorPag, qtdParcelas, venda_idVenda)
	VALUE
		  ("A vista", "800", NULL, "1"),        
          ("A vista", "700", NULL, "2"),
          ("A vista", "1200", NULL, "3"),
          ("A vista", "4000", NULL, "4"),
          ("A vista", "950", NULL, "5"),
          ("A vista", "3250", NULL, "6"),
          ("A vista", "250.35", NULL, "7"),
          ("A vista", "658", NULL, "8"),
          ("A vista", "980", NULL, "9"),
          ("A vista", "1200", NULL, "10");
