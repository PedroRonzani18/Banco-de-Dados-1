-- CEFET-MG
-- Eng. Computacao
-- Lab. BD I - 5o. Periodo
-- Prof. Evandrino Barros

-- Script da Aula prática sobre DDL e DML

--1) Criação de tabelas
create table DEPART 
(deptno number(2), 
 nome varchar2(20), 
 criacao date default sysdate);  

-- 2) Inclusão de uma chave primária
alter table DEPART 
add constraint pk_DEPART primary key (deptno);

--3) Inclusão de uma nova coluna (coluna local varchar2(20)).
alter table DEPART 
add local varchar2(20) not null;
describe DEPART

--3) Remoção de uma coluna. 
alter table DEPART 
drop  column criacao;

-- 4)	Remoção de uma coluna com chave estrangeira. 
Create table TESTE1 (	t1c1 number(5) primary key, 
		t1c2 number(5));
Create table TESTE2 (	t2c1 number(5) references TESTE1, 
		t2c2 number(5));
alter table TESTE1 drop column t1c1;   -- s/ cascade 
                             	    	    -- remoção proibida  
alter table TESTE1 drop column t1c1 CASCADE CONSTRAINTS;
desc TESTE1

-- 5)Remoção de chaves (constraints)

alter table DEPART 
drop  constraint pk_DEPART;
desc DEPART

--6) Criação de chave estrangeira
Create table  EMPREGADO 
(mat number(5) primary key,
 nome varchar2(20),
 deptno number(2));

alter table DEPART
add constraint pk_dept
primary key (deptno);

alter table EMPREGADO
add constraint fk_emp_dept
foreign key (deptno)
references DEPART(deptno);

--7) f)	Remoção de chave estrangeira
Create table teste3 (c1 number(5) primary key);
Create table teste4 (c2 number(5) constraint fk_teste4_teste3 
	                  references teste3);

alter table teste4 drop constraint fk_teste4_teste3;      
desc teste4;

-- 8)Alteração de nome de coluna

Alter table EMPREGADO
rename column mat to matricula;  
desc empregado

-- 9) Alteração do tamanho de uma coluna
Alter table EMPREGADO 
modify nome varchar2(30);
desc empregado 
             
-- 10) Alteração para NULL ou NOT NULL, deve ser feita com a ALTER ... MODIFY

Alter table EMPREGADO 
modify nome  not null;

-- O inverso também é feito com modify. 

Alter table EMPREGADO 
modify nome null;

-- 11) Adicionando uma chave única

alter table  EMPREGADO 
add constraint uk_nome unique (nome); 

-- 12) Remoção de Tabelas


-- Drop table <nome da tabela> [cascade constraints];

Create table teste5 (c1 number(5) primary key);
Create table teste6 (c2 number(5) references teste5);
Drop table   teste5;   -- sem cascade constraints 
                             -- não é possível a remoção
  
Drop table teste5 cascade constraints; -- remocao ok
desc teste6
Drop table teste1;
Drop table teste2;
Drop table teste3;
Drop table teste4;
Drop table teste6;


--13) Adicionando um regra de validação
alter table EMPREGADO add sexo char(1);

alter table EMPREGADO add constraint sexo_emp_ck 
      check (sexo in ('M', 'F'));

--14) Adicionando um valor default


Create table teste1 
(c1 number(5) primary key, 
 c2 number(5));
 
alter table teste1 modify c1 default 1;

-- 15) Removendo um valor default (nesse caso, o valor default é null, que é o padrão)

alter table teste1 modify c1 default (null);


