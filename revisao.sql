-- Revis�o de BDI - 08/07/24
-- Modelo de dados Relacional
-- Estrutura de dados: tabelas (linhas, ou tuplas, e colunas, ou atributos)
-- As colunas s�o monovaloradas (s� um valor) e s�o at�micas(indivis�veis)
-- Restri��es de Integridade: Chave (PK), Referencial (FK), Dom�nio (tipo),
--                            entidade(PK != null)
-- Opera��es:
--         DML (Data Manipulation Language): insert, update, delete
--         Consulta: Select ... From ... where ... order by 
--         DDL (Data Definition Language): create, alter e drop

--  Exemplo de um banco de dados relacinoal
--  Departamento (Num(pk), Nome, Local)

create table departamento2 (
	num   number(5) primary key,
	nome  varchar2(30) not null,
	local varchar2(20) not null
);

insert into departamento2 values (
	100,
	'Vendas',
	'Belo Horionzonte'
);

select *
  from departamento2;
-- EMPREGADO2 (Mat,Nome, Salario, Dt_Admissao, NumDep)
--      EMPREGADO2[NumDep] -->b DEPARTAMENTO2 [Num]
create table empregado2 (
	mat         number(5) primary key,
	nome        varchar2(80) not null,
	salario     number(10,2) not null check ( salario >= 0 ),
	dt_admissao date default sysdate,
	numdep      number(5)
		references departamento2 ( num )
);

desc EMPREGADO2

insert into empregado2 values (
	1000,
	'Antonio Silva',
	5000,
	'01/01/2024',
	100
);
select *
  from empregado2;

-- tentativa de viola��o de PK
insert into empregado2 values (
	1000,
	'Antonio Silva',
	5000,
	'01/01/2024',
	100
);

-- tentativa de viola��o de FK
insert into empregado2 values (
	2000,
	'Maria Silva',
	5000,
	'01/01/2024',
	200
);

-- novos dados v�lidos
insert into empregado2 values (
	2000,
	'Maria Silva',
	5000,
	'01/01/2024',
	100
);

insert into departamento2 values (
	200,
	'TI',
	'Belo Horizonte'
);

insert into empregado2 values (
	3000,
	'Ana Silva',
	5000,
	'01/01/2024',
	200
);

select *
  from departamento2;
select *
  from empregado2;

insert into empregado2 values (
	4000,
	'Jos� Silva',
	5000,
	'01/01/2024',
	null
);

select *
  from empregado2;

insert into departamento2 values (
	300,
	'RH',
	'Belo Horizonte'
);

select *
  from departamento2;
select *
  from empregado2;

-- Comando SELECT
-- Consultar todas as linhas e colunas:
select *
  from empregado2;
-- projetar colunas espec�ficas, renomeando-as
select nome,
       salario,
       salario * 12 as "salario_anual"
  from empregado2;

-- Consulta com filtro (sele��o) de linhas: Cl�usua Where
select nome,
       salario
  from empregado2
 where substr(
	nome,
	1,
	1
) = 'A';

select nome,
       salario
  from empregado2
 where nome like 'A%';

select nome,
       salario
  from empregado2
 where nome like 'A%'
   and numdep = 100;

select nome,
       salario,
       numdep
  from empregado2
 where nome like 'A%'
    or numdep = 100;

-- produto cartesiano
select e.nome,
       d.nome,
       e.numdep,
       d.num
  from empregado2 e,
       departamento2 d;

-- jun��o interna

select e.nome,
       d.nome,
       e.numdep,
       d.num
  from empregado2 e
  join departamento2 d
on e.numdep = d.num;

select e.nome,
       d.nome,
       e.numdep,
       d.num
  from empregado2 e
 inner join departamento2 d
on e.numdep = d.num;

-- jun��o externa: esquerda (left), direita(right), completa (esq e dir):full
-- jun��o externa � esquerda

select e.nome,
       d.nome,
       e.numdep,
       d.num
  from empregado2 e
  left outer join departamento2 d
on e.numdep = d.num;

select e.nome,
       d.nome,
       e.numdep,
       d.num
  from empregado2 e
 right outer join departamento2 d
on e.numdep = d.num;

select e.nome,
       d.nome,
       e.numdep,
       d.num
  from empregado2 e
  full outer join departamento2 d
on e.numdep = d.num;

-- opera��es de conjunto: union, intersect, cartesian product, minus
-- and
select nome,
       salario
  from empregado2
 where nome like 'A%'
intersect
select nome,
       salario
  from empregado2
 where numdep = 100;

-- or
select nome,
       salario
  from empregado2
 where nome like 'A%'
union
select nome,
       salario
  from empregado2
 where numdep = 100;

-- consulta aninhada
-- Trazer os empragdos de vendas
select num
  from departamento2
 where nome = 'Vendas';
select numdep,
       nome
  from empregado2
 where numdep = 100;
-- aninhamento

select numdep,
       nome
  from empregado2
 where numdep = (
	select num
	  from departamento2
	 where nome = 'Vendas'
);

select numdep,
       nome
  from empregado2
 where numdep in (
	select num
	  from departamento2
	 where nome = 'Vendas'
);