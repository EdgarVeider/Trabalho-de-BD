drop table if exists COMPONENTES, VENDEDOR, CLIENTE, BOLETO, CARTORIO, NOTA_DUPLICATA, FUNCIONARIO, MODELISTA, PRODUCAO, PEDIDO, SAPATO, CLIENTE_TEM_SAPATO, SAPATO_TEM_COMPONENTES, FUN_PRODUCAO_PRODUZ_PEDIDO, PEDIDO_TEM_SAPATO;

create table COMPONENTES(
	referencia int primary key,
    nome varchar(80),
    quantidade int,
    preco int
);

create table FUNCIONARIO(
	telefone int,
    conta_bancaria int,
    cpf int primary key,
    nome varchar(80)
);

create table VENDEDOR(
	cpf int primary key,
	data_pagamento date,
    comissao int,
    combustivel_mensal float,
    cnpj_cliente int,
    foreign key (cpf) references FUNCIONARIO(cpf)
);

create table CLIENTE(
	nome varchar(80),
    cnpj int primary key,
    endereco varchar(80),
    telefone int,
    cpf_vendedor int,
    foreign key (cpf_vendedor) references VENDEDOR(cpf)
);
 
create table BOLETO(
	valor int,
    data_geraçao date,
    data_pagametno date,
    cod_pagamente int,
    n_boleto int primary key
);

create table CARTORIO(
	telefone int,
    nome varchar(80) primary key,
    endereco varchar(80)
);

create table NOTA_DUPLICATA(
	n_duplicata int primary key,
    data_pproteste date,
    banco varchar(80),
    nome_cartorio varchar(80),
    n_boleto int,
    foreign key (nome_cartorio) references CARTORIO(nome),
    foreign key (n_boleto) references BOLETO(n_boleto)
    
);


create table MODELISTA(
	n_registro int,
    salario_hora float,
    estilo_criacao varchar(80),
    cpf int primary key,
    foreign key (cpf) references FUNCIONARIO(cpf)
);

create table PRODUCAO(
	cpf int,
    funcao varchar(80),
    salario_mensal float,
    n_registro int,
	foreign key (cpf) references FUNCIONARIO(cpf)
); 


create table PEDIDO(
	data_entrega date,
    data_entrada date,
    n_pedido int primary key,
    n_duplicata int,
    cnpj_cliente int, 
    cpf_vendedor int,
    foreign key (n_duplicata) references NOTA_DUPLICATA(n_duplicata),
    foreign key (cnpj_cliente) references CLIENTE(cnpj),
    foreign key (cpf_vendedor) references VENDEDOR(cpf)
);

create table SAPATO(
	referencia int primary key,
    grade int,
    preco int,
    data_criacao date,
    cpf_modelista int,
    foreign key (cpf_modelista) references MODELISTA(cpf)
);

create table CLIENTE_TEM_SAPATO(
	n_pedido int,
    referencia_sapato int,
    foreign key (n_pedido) references PEDIDO(n_pedido),
    foreign key (referencia_sapato) references SAPATO(referencia),
    primary key(n_pedido, referencia_sapato)
);

create table SAPATO_TEM_COMPONENTES(
	referencia_sapato int,
    referencia_componentes int,
    foreign key (referencia_sapato) references SAPATO(referencia),
    foreign key (referencia_componentes) references COMPONENTES(referencia),
    primary key (referencia_sapato, referencia_componentes)
);

create table FUN_PRODUCAO_PRODUZ_PEDIDO(
	cpf_producao int,
    n_pedido int,
    foreign key (cpf_producao) references PRODUCAO(cpf),
    foreign key (n_pedido) references PEDIDO(n_pedido),
    primary key (cpf_producao, n_pedido)
);

create table PEDIDO_TEM_SAPATO(
	referencia_sapato int,
    n_pedido int,
    foreign key (referencia_sapato) references SAPATO(referencia),
    foreign key (n_pedido) references PEDIDO(n_pedido),
    primary key (n_pedido, referencia_sapato)
);