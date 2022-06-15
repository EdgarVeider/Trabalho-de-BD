-- https://github.com/EdgarVeider/Trabalho-de-BD/blob/main/sql%20squema.sql
-- GUILHERME LUIZ DE MATOS

drop table if exists COMPONENTES, VENDEDOR, CLIENTE, BOLETO, CARTORIO, NOTA_DUPLICATA, FUNCIONARIO, MODELISTA, PRODUCAO, PEDIDO, SAPATO, SAPATO_TEM_COMPONENTES, FUN_PRODUCAO_PRODUZ_PEDIDO, PEDIDO_TEM_SAPATO;

create table COMPONENTES(
	referencia int primary key,
    nome varchar(80),
    quantidade int,
    preco float
);

create table FUNCIONARIO(
	telefone varchar(30),
    conta_bancaria varchar(30),
    cpf varchar(30) primary key,
    nome varchar(80)
);

create table VENDEDOR(
	cpf varchar(30) primary key,
	data_pagamento varchar(30),
    comissao float,
    combustivel_mensal float,
    foreign key (cpf) references FUNCIONARIO(cpf) on delete cascade on update cascade
);

create table CLIENTE(
	nome varchar(80),
    cnpj varchar(30) primary key,
    endereco varchar(80),
    telefone varchar(30),
    cpf_vendedor varchar(30),
    foreign key (cpf_vendedor) references VENDEDOR(cpf)
);
 
create table BOLETO(
	valor float,
    data_geraçao varchar(30),
    data_pagametno varchar(30),
    cod_pagamente varchar(30),
    n_boleto varchar(30) primary key,
	cod_boleto varchar(30)
);

create table CARTORIO(
	telefone varchar(30),
    nome varchar(80) primary key,
    endereco varchar(80)
);

create table NOTA_DUPLICATA(
	n_duplicata int primary key,
    data_pproteste varchar(30),
    banco varchar(80),
    nome_cartorio varchar(80) not null,
    n_boleto varchar(30) not null,
    foreign key (nome_cartorio) references CARTORIO(nome),
    foreign key (n_boleto) references BOLETO(n_boleto)
);


create table MODELISTA(
	n_registro varchar(30),
    salario_hora float,
    estilo_criacao varchar(80),
    cpf varchar(30) primary key,
    foreign key (cpf) references FUNCIONARIO(cpf) on delete cascade on update cascade
);

create table PRODUCAO(
	cpf varchar(30),
    funcao varchar(80),
    salario_mensal float,
    n_registro varchar(30),
	foreign key (cpf) references FUNCIONARIO(cpf) on delete cascade on update cascade
); 


create table PEDIDO(
	data_entrega varchar(30),
    data_entrada varchar(30),
    n_pedido int primary key,
    n_duplicata int not null,
    cnpj_cliente varchar(30) not null, 
    cpf_vendedor varchar(30) not null,
    foreign key (n_duplicata) references NOTA_DUPLICATA(n_duplicata),
    foreign key (cnpj_cliente) references CLIENTE(cnpj),
    foreign key (cpf_vendedor) references VENDEDOR(cpf)
);

create table SAPATO(
	referencia int primary key,
    grade varchar(30),
    preco float,
    data_criacao varchar(30),
    cpf_modelista varchar(30) not null,
    foreign key (cpf_modelista) references MODELISTA(cpf)
);


create table SAPATO_TEM_COMPONENTES(
	referencia_sapato int,
    referencia_componentes int,
    foreign key (referencia_sapato) references SAPATO(referencia),
    foreign key (referencia_componentes) references COMPONENTES(referencia),
    primary key (referencia_sapato, referencia_componentes)
);

create table FUN_PRODUCAO_PRODUZ_PEDIDO(
	cpf_producao varchar(30) not null,
    n_pedido int,
    foreign key (cpf_producao) references PRODUCAO(cpf),
    foreign key (n_pedido) references PEDIDO(n_pedido),
    primary key (cpf_producao, n_pedido)
);

create table PEDIDO_TEM_SAPATO(
	referencia_sapato int not null,
    n_pedido int,
    foreign key (referencia_sapato) references SAPATO(referencia),
    foreign key (n_pedido) references PEDIDO(n_pedido),
    primary key (n_pedido, referencia_sapato)
);
insert into FUNCIONARIO(telefone, conta_bancaria, cpf, nome) values ('(64) 3825-6144', '48458921-9', '17291916062', 'Marcio Roberto'), 
('(87) 3705-3719', '76174-4', '95381744021', 'Gasiron'), 
('(68) 2530-5476', '1035070-5', '66166322020', 'Igor Bencatel Veiga'), 
('(13) 3594-7812', '0957271-6', '72817766083','Breno Beiriz Dias'), 
('(86) 3335-8561','0705106-9','30136290027','Mafalda Leite Loureiro'), 
('(67) 3813-9937','132138-2','29746366084','Teófilo Passarinho Dorneles'), 
('(79) 3417-5818','07112904-4','33256475027','Kaya Barroso Anjos'), 
('(91) 3403-2471','1681938-7','35411890020','Zara Quintanilha Marcondes'), 
('(79) 2939-5513','25913-9','14640579071','Dara Vilaverde Lagos'), 
('(87) 2626-6254','37268971-4','21132045096','Enoque Marinho Sintra');

insert into VENDEDOR(cpf, data_pagamento, comissao, combustivel_mensal) values ('17291916062', '30', 408.02, 300.00), 
('95381744021','05', 203.72, 450.00),
('66166322020','15', 35.89, 300.00),
('72817766083','19', 1010.59, 450.00),
('30136290027','07', 596.47, 200.00),
('29746366084','06', 783.46, 100.00),
('33256475027','07', 963.4, 100.00),
('35411890020','49', 21.11, 110.00),
('14640579071','04', 44.11, 200.00),
('21132045096','22', 50.50, 230.00);

insert into CLIENTE(nome, cnpj, endereco, telefone, cpf_vendedor) values ('Radames', '35136731000143', 'Rua Barão de Vitória-Casa Grande', '(21) 2263-4354', '17291916062'), 
('TJ', '34426671000130', 'Rua Carlos Augusto Cornelsen-Bom Retiro', '(77) 3531-7413', '95381744021'),
('WindFour', '21098375000106', 'Avenida Esbertalina Barbosa Damiani-Guriri Norte','(68) 3758-6518','66166322020'), 
('PG4', '06313406000100', 'Rua Arlindo Nogueira-Centro', '(82) 3074-4173','72817766083'),
('FOTTON', '22666666000116', 'Rua Cristiano Olsen-Jardim Sumaré', '(53) 3605-0570','30136290027'),
('GOLFER', '62587278000164', 'Avenida Governador José Malcher-Nazaré', '(88) 2266-8450','29746366084'), 
('JJACOMET', '59998307000176', 'Avenida Almirante Maximiano Fonseca','(83) 3707-2666', '33256475027'),
('ZIZICAL', '58470925000186', 'Avenida Rio Branco', '(62) 2424-7385', '35411890020'),
('SHELTER', '93635639000124', 'Rua Carlos Augusto Cornelsen', '(69) 2226-2723', '21132045096'), 
('TUCSON', '11087943000110','Rua santa cruz-centro','(87) 2244-4832','17291916062');

insert into FUNCIONARIO(telefone, conta_bancaria, cpf, nome) values ('(54) 2854-0772', '69383-0', '94897259002', 'Dilnura'),
('(18) 3869-5561', '89773-0', '28785933082', 'Amira'),
('(62) 2078-5230', '47101-0', '49291812080', 'Tamára'),
('(77) 2914-7167', '60051815-6', '52551801060', 'Ânia'),
('(73) 2269-2584', '46581292-8', '50886246032', 'Israel'),
('(24) 2212-9313', '1160516-2', '70282516085', 'Maribel'),
('(65) 2656-9865', '1049228-3', '23508555038', 'Emma'),
('(67) 3491-6457', '1993472-1', '13926935006', 'Yangchen'),
('(79) 2326-0461', '07085923-8', '43256105025', 'Rafaela'),
('(67) 3422-4753', '27597921-8', '62996027086', 'Fausto');

insert into FUNCIONARIO(telefone, conta_bancaria, cpf, nome) values ('(54) 2854-0772', '69383-0', '84815541035', 'Adalberto'),
('(18) 3869-5561', '89773-0', '38264216048', 'Mila'),
('(62) 2078-5230', '47101-0', '86145032022', 'Ming'),
('(77) 2914-7167', '60051815-6', '34840655081', 'Helder'),
('(73) 2269-2584', '46581292-8', '96143977054', 'Mouhamed'),
('(24) 2212-9313', '1160516-2', '72184715018', 'Helder'),
('(65) 2656-9865', '1049228-3', '64226136012', 'Aicha'),
('(67) 3491-6457', '1993472-1', '60829567020', 'Vasco'),
('(79) 2326-0461', '07085923-8', '61049968093', 'Válter'),
('(67) 3422-4753', '27597921-8', '26716996036', 'Magda');

insert into MODELISTA(n_registro, salario_hora, estilo_criacao, cpf) values ('2147', 9.45, 'Country-Feminino', '84815541035'),
('5721', 6.78, 'Classico-Masculino', '38264216048'),
('9777', 7.45, 'Casual-Feminio', '86145032022'),
('8345',9.10, 'Classico-Femino', '34840655081'),
('4467', 4.44, 'Esportivo-Unisex', '96143977054'),
('4558', 5.98, 'Country-Unisex', '72184715018'),
('4462', 11.21, 'Casual-Masculino', '64226136012'),
('7530', 6.78, 'Grife-Masculino', '60829567020'),
('5135', 6.36, 'Grife-Feminino', '61049968093'),
('2034', 4.10, 'Sadalias-Femininas', '26716996036');

insert into PRODUCAO(cpf, funcao, salario_mensal, n_registro) values ('94897259002', 'Lixador', 1350.00,'8247'),
('28785933082','Pintura' , 1560.00,'1010'),
('49291812080','Colacao de Vira' , 1290.00,'1913'),
('52551801060', 'Freza de Forma', 1450.00,'8377'),
('50886246032', 'Preparacao', 1300.00,'9185'),
('70282516085', 'Expedicao', 1200.00,'7315'),
('23508555038', 'Pintura',1580.00,'1329'),
('13926935006','Embonecador' , 1420.00,'9817'),
('43256105025', 'Lustrador', 1350.00,'1108'),
('62996027086','Cortador de Balancinho' , 1300.00,'6690');

insert into COMPONENTES(referencia, nome, quantidade, preco) values (587, 'Sola TS42', 22, 42.22),
(130,'Couro Stonado', 400, 23.00),
(268, 'Salto CL361', 399, 4.70),
(595, 'Vira Onda',280, 4.12),
(837, 'Cabedal MarcoP',410, 29.45),
(502, 'Estabilizador Sunset',350, 5.95),
(389, 'Cabedal Berlim', 32, 19.92),
(877, 'Cabedal 271-Antoni',199, 13.56),
(790, 'Sola Lion', 938, 24.25),
(767, 'Sola Vincent', 50, 12.99);

insert into BOLETO(valor, data_geraçao, data_pagametno, cod_pagamente, n_boleto) values (688.92, '30/06/2022', '08/07/2022', '34134310283501287026','919-2'),
(481.34, '24/06/2022', '08/08/2022', '86083893454912687353', '302-1'),
(1246.00, '14/06/2022', '20/07/2022', '82385144616822402030', '259-0'),
(786.10, '04/03/2022', '30/06/2022', '45856553882916542372', '113-0'),
(61.66, '06/04/2022', '07/06/2022', '27160155196750256368', '780-7'),
(5930.10, '15/05/2022', '09/11/2022', '42321665929093654704', '348-3'),
(726.60, '10/06/2022', '10/07/2022', '11906529942608758828','289-7'),
(184.02, '30/04/2022', '27/06/2022', '26595082238458636489', '327-9'),
(422.00, '23/06/2022', '25/07/2022', '15706430992030713753', '850-1'),
(7400.23, '01/05/2022', '20/08/2022', '70202853855945461049', '116-5');

insert into CARTORIO(telefone, nome, endereco) values ('(85) 2555-9777', 'Cartorio de Registro Civis', 'Avenida Rio Branco'),
('(47) 2834-1866', '1º Tabeliao de Franca', 'Rua Pereira Estéfano'),
('(86) 2356-1362', '2º Tabeliao de Franca', 'Rua Domingos Olímpio'),
('(61) 3783-2686', 'Cartorio de Registro Juridos de Franca', 'Rua Frederico Moura'),
('(19) 2382-6544', 'Cartório Viana', 'Rodovia Raposo Tavares'),
('(42) 3855-2258', '3º Tabelionato de Notas e Registro Civil', 'Avenida São João'),
('(85) 2793-6744', '1º Ofício de Protesto e Registro de Títulos e Documentos', 'Rua da Imprensa'),
('(68) 2484-8651', 'Cartório de Registro FAUSTINO', 'Praça da República'),
('(89) 3553-5767', 'Cartório da Vila Tibério', 'Rua Pereira Estéfano'),
('(63) 2721-4013', 'TD & PJ - Oficial de Registro de Títulos e Documentos', 'Rua Carlos Augusto Cornelsen');

insert into NOTA_DUPLICATA(n_duplicata, data_pproteste, banco, nome_cartorio, n_boleto) values (51707, '09/07/2022', 'ITAÚ', 'Cartorio de Registro Civis', '919-2'),
(18090, '09/08/2022', 'SANTANDER', '3º Tabelionato de Notas e Registro Civil', '302-1'),
(76244, '21/07/2022', 'BANCO DE BRASIL', '1º Tabeliao de Franca', '259-0'),
(75131, '01/07/2022', 'BANCO DE BRASIL', '2º Tabeliao de Franca', '113-0'),
(13446, '08/06/2022', 'BRADESCO', 'Cartório da Vila Tibério', '780-7'),
(87527, '10/11/2022', 'ITAÚ', '2º Tabeliao de Franca', '348-3'),
(74400, '11/07/2022', 'BANCO DE BRASIL', '1º Tabeliao de Franca','289-7'),
(19236, '28/06/2022', 'BANCO DE BRASIL', '2º Tabeliao de Franca', '327-9'),
(43844, '26/07/2022', 'SANTANDER', '3º Tabelionato de Notas e Registro Civil', '850-1'),
(27040, '21/08/2022', 'ITAÚ', 'Cartorio de Registro Civis', '116-5');

insert into PEDIDO(data_entrega, data_entrada, n_pedido, n_duplicata, cnpj_cliente, cpf_vendedor) values('14/05/2022', '04/06/2022', 584, 18090, '35136731000143', '17291916062'),
('16/10/2022', '06/11/2022', 834, 51707, '93635639000124', '95381744021'),
('13/08/2022', '23/08/2022', 377, 76244, '22666666000116', '14640579071'),
('07/03/2022', '27/03/2022', 251, 75131, '93635639000124', '21132045096'),
('04/05/2022', '24/05/2022', 121, 13446, '22666666000116', '66166322020'),
('08/05/2022', '28/05/2022', 250, 87527, '59998307000176', '30136290027'),
('19/04/2022', '09/05/2022', 448, 74400, '59998307000176', '95381744021'),
('22/06/2022', '12/07/2022', 218, 19236, '21098375000106', '30136290027'),
('27/07/2022', '05/08/2022', 527, 43844, '35136731000143', '17291916062'),
('30/04/2022', '15/04/2022', 281, 27040, '21098375000106', '66166322020');

insert into SAPATO(referencia, grade, preco, data_criacao, cpf_modelista) values (527, '39-40-41-42', 250.00, '10/11/2021', '84815541035'),
(869, '36-37-38-39-40-41', 310.00, '03/01/2022', '38264216048'),
(444, '36-37-38-39-40-41-42-43', 425.00, '09/12/2021', '86145032022'),
(282, '40-41-42', 120.00, '14/05/2022', '34840655081'),
(94, '39-40-41-42', 183.12, '13/04/2022', '72184715018'),
(481, '34-35-36-37-38-39', 253.00, '04/11/2021', '26716996036'),
(470, '34-35-36-37', 410.00, '07/10/2021', '86145032022'),
(340, '39-41-42', 156.50, '05/05/2022', '34840655081'),
(263, '40-41-42', 142.00, '14/04/2022', '38264216048'),
(206, '35-36-37-38-39-40',220.00, '20/04/2021', '84815541035');

insert into SAPATO_TEM_COMPONENTES(referencia_sapato, referencia_componentes) values (869, 877),
(869, 790),
(527, 837),
(527, 502),
(444, 767),
(94, 877),
(481, 268),
(481, 130),
(340, 790),
(263, 130),
(444, 595),
(444, 389),
(94, 790);

insert into FUN_PRODUCAO_PRODUZ_PEDIDO(cpf_producao, n_pedido) values('94897259002', 584),
('62996027086', 584),
('23508555038', 584),
('62996027086', 834),
('52551801060', 834),
('62996027086', 377),
('52551801060', 377),
('49291812080', 377),
('28785933082', 251),
('13926935006', 251);

insert into PEDIDO_TEM_SAPATO(referencia_sapato, n_pedido) values(527, 584),
(869, 834),
(444, 377),
(444, 251),
(282, 121),
(94, 250),
(481, 448),
(470, 218),
(340, 527),
(263, 281);