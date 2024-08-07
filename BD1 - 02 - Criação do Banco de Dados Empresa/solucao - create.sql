drop table departamento cascade constraints;
drop table funcionario cascade constraints;
drop table trabalha_em cascade constraints;
drop table projeto cascade constraints;
drop table localizacoes_departamento cascade constraints;
drop table dependente cascade constraints;

--
-- DEPARTAMENTO(Numero_departamento(PK), Nome, cpf_gerente, InicioGer)
--   DEPARTAMENTO[cpf_gerente] --> b FUNCIONARIO[cpf]

create table departamento (
	numero_departamento number(5)
		constraint pk_departamento primary key,
	nome_departamento   varchar2(30) not null,
	cpf_gerente         varchar2(11)
		constraint uk_cpf_gerente unique,
	data_inicio_gerente date
);
  
--  LOCALIZACOES_DEPARTAMENTO (Numero_departamento, Localizacao) – PK composta: NUMDPEP e LOCALIZACAO
--  LOCALIZACOES_DEPARTAMENTO[Numero_departamento] --> p DEPARTAMENTO[Numero_Departamento]

create table localizacoes_departamento (
	numero_departamento number(5),
	local               varchar2(40),
	constraint pk_localizacoes_departamento primary key ( numero_departamento, local ),
	constraint 
              fk_localizacoes_departamento_departamento foreign key ( numero_departamento )
		references departamento ( numero_departamento ) on delete cascade
);

-- FUNCIONARIO(cpf, Primeiro_nome, Nome_meio, Ultimo_NOME, SEXO, ENDERECO, SALARIO, DATA_NASCIMENTO, NUMERO_DEPARTAMENTO, cpfSUPER)
-- FUNCIONARIO[NUMERO_DEPARTAMENTO]→ b DEPARTAMENTO[NUMERO_DEPARTAMENTO]
-- FUNCIONARIO[cpf_supervisor] →b FUNCIONARIO[cpf]

create table funcionario (
	cpf                 varchar2(11)
		constraint pk_funcionario primary key,
	primeiro_nome       varchar2(20) not null,
	nome_meio           varchar2(20),
	ultimo_nome         varchar2(20) not null,
	sexo                char(1),
	endereco            varchar2(40) not null,
	salario             number(10,2) not null,
	data_nascimento     date,
	numero_departamento number(5)
		constraint fk_funcionario_departamento
			references departamento ( numero_departamento )
	not null,
	cpf_supervisor      varchar2(11)
		constraint fk_funcionario_funcionario
			references funcionario ( cpf )
);
            
-- DEPENDENTE(cpf_funcionario, NOME, SEXO, DATA_NASCIMENTO,PARENTESCO)
-- DEPENDENTE[cpf_funcionario] --> p FUNCIONARIO[cpf]
create table dependente (
	cpf_funcionario varchar2(11)
		constraint fk_dependente_funcionario
			references funcionario ( cpf )
				on delete cascade,
	nome_dependente varchar2(50),
	sexo            char(1),
	data_nascimento date not null,
	parentesco      varchar2(20),
	constraint pk_dependente primary key ( cpf_funcionario, nome_dependente )
);
     
-- PROJETO (Numero(PK), Nome, Localizacao, Numero_departamento)
--   PROJETO[Numero_departamento] -->b DEPARTAMENTO[Numero]

create table projeto (
	nome_projeto        varchar2(30) not null,
	numero_projeto      number(5)
		constraint pk_projeto primary key,
	local_projeto       varchar2(30) not null,
	numero_departamento number(5) not null
		constraint fk_projeto_departamento
			references departamento ( numero_departamento )
);

-- TRABALHA_EM (cpf_funcionario, NUMERO_PROJETO, HORAS)
--    TRABALHA_EM[cpf_funcionario] --> FUNCIONARIO[cpf]
--    TRABALHA_EM[NUMERO_PROJETO] --> PROJETO[NUMERO]

create table trabalha_em (
	cpf_funcionario varchar2(11)
		constraint fk_trabalha_em_funcionario
			references funcionario ( cpf ),
	numero_projeto  number(5)
		constraint fk_trabalha_em_projeto
			references projeto ( numero_projeto ),
	horas           number(4),
	constraint pk_trabalha_em primary key ( cpf_funcionario,
	                                        numero_projeto )
);

alter table departamento
	add constraint fk_departamento_funcionario foreign key ( cpf_gerente )
		references funcionario ( cpf )
			on delete cascade;

grant select on funcionario to public;
grant select on departamento to public;
grant select on localizacoes_departamento to public;
grant select on trabalha_em to public;
grant select on dependente to public;
grant select on projeto to public;