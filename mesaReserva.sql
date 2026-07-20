create database gestaoReserva
go
use gestaoReserva
go
create table pessoas
(
	codigo	int			not null primary key identity,
	nome	varchar(50) not null, 
	cpf		varchar(20) not null unique
)
go

create table clientes
(
	pessoa_codigo int		  not null primary key,
	fone		  varchar(20) not null unique,
	--------Restrições---------
	constraint  fk_cliente_codigo
	foreign key (pessoa_codigo) references pessoas(codigo)
)
go

create table funcionarios
(
	pessoa_codigo int		  not null primary key,
	usuario		  varchar(50) not null,
	senha		  varchar(20) not null,
	---------Restrições---------
	constraint  fk_funcionario_codigo
	foreign key (pessoa_codigo) references pessoas(codigo) 
)
go

create table ambientes
(
	codigo		int			not null primary key,
	nome		varchar(50) not null
)
go

create table status
(
	id		int					check(id in(0,1,2))   primary key,
	nome	varchar(20) not null
)
go

create table mesas
(
	nr						int not null primary key,
	qtd_cadeiras			int not null, 
	numero_reservas			int not null,
	id_status				int not null,
	codigo_ambientes		int not null
	---Restrições----------
	constraint fk_id_status 
	foreign key(id_status)		 references status(id),
	constraint fk_codigo_ambientes
	foreign key(codigo_ambientes) references ambientes(codigo)

)
go

create table reservas
(
	numero		int  not null primary key,
	nr_mesas	int not null,
	horario		time not null default cast(current_timestamp as time),
	dia			date not null,
	status		int		     check(status in(0,1,2)),
	cliente_codigo int not null,
	funcionario_codigo int not null
	----Restrições-----
	foreign key(cliente_codigo) references clientes(pessoa_codigo),
	foreign key(funcionario_codigo) references funcionarios(pessoa_codigo)
)
go

create table Reservas_Mesas
(	
	numero_reservas int not null, 
	nr_mesas		int not null
	
		-----Restrições------
	constraint pk_reservas_mesas primary key(numero_reservas, nr_mesas)
	constraint fk_numero_reservas 
	foreign key(numero_reservas) references reservas(numero),
	constraint fk_nr_mesas
	foreign key(nr_mesas) references mesas(nr)
)
go

-- Tabela Pessoas --
Insert into pessoas values ('Aline', '101.000.000-00');
Insert into pessoas values ('Julia', '202.000.000-00');
Insert into pessoas values ('Ronaldo', '303.000.000-00');

-- Tabela Clientes --
Insert into clientes values ('1234-5678');
Insert into clientes values ('0101-9999');
Insert into clientes values ('2468-1357');

-- Tabela Funcionarios --
Insert into funcionarios values ('t.gouvea', '@43Uli' );
Insert into funcionarios values ('r.yukio', '%Ftc707');
Insert into funcionarios values ('a.silva', 'A#3lu');

-- Tabela Ambientes --
Insert into ambientes values (11, 'Interno');
Insert into ambientes values (12, 'Externo');
Insert into ambientes values (13, 'Sacada');

-- Tabela Status --
Insert into status values (0, 'Livre');
Insert into status values (1 , 'Reservada');
Insert into status values (2, 'Ocupada');

-- Tabela Mesas --
Insert into mesas values (8, 2, 4, 2, 3 );
Insert into mesas values (10, 4, 2, 0, 2);
Insert into mesas values (16, 8, 1, 1, 1);

-- Tabela Reservas --
Insert into reservas values (3, 17, '12:30:00', '01/08/2026', 0, 21, 13);
Insert into reservas values (15, 8, '18:40:00', '29/07/2026', 2, 420, 24);
Insert into reservas values (7, 14, '20:00:00', '11/06/2026', 1, 45, 16);



-- Tabela Reservas_Mesas –-
Insert into reservas_mesas values (3, 19);
Insert into reservas_mesas values (2, 10);
Insert into reservas_mesas values (8, 2);

