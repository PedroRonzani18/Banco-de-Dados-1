-- Q01 

create table auditoria (
	data             date,
	cpf              varchar2(11),
	salario_anterior number(10,2),
	salario_atual    number(10,2),
	usuario          varchar2(40),
	primary key ( cpf,
	              data )
);

select *
  from funcionario;

select current_timestamp;

drop trigger alterar_salario_funcionario;

create trigger alterar_salario_funcionario after
	update of salario on funcionario
	for each row
begin
	insert into auditoria (
		data,
		cpf,
		salario_anterior,
		salario_atual,
		usuario
	) values (
		sysdate(),
		:new.cpf,
		:old.salario,
		:new.salario,
		user()
	);
end;
/

update funcionario
   set
	salario = 60000
 where primeiro_nome = 'Jorge';
select *
  from auditoria;

update funcionario
   set
	salario = 600000
 where primeiro_nome = 'Jorge';
select *
  from auditoria; 
 
-- Q02 

create trigger limite_salario_funcionario before
	update of salario on funcionario
	for each row
begin
	if :new.salario > 50000 then
		:new.salario := 50000;
	elsif :new.salario < 20000 then
		:new.salario := 20000;
	end if;
end;
/

update funcionario
   set
	salario = 981387432
 where primeiro_nome = 'Jorge';
select *
  from funcionario
 where primeiro_nome = 'Jorge';

update funcionario
   set
	salario = 1
 where primeiro_nome = 'Jorge';
select *
  from funcionario
 where primeiro_nome = 'Jorge';

update funcionario
   set
	salario = 40000
 where primeiro_nome = 'Jorge';
select *
  from funcionario
 where primeiro_nome = 'Jorge'; 
 
-- Q03 

alter table departamento add quantidade_funcionarios number(5);

update departamento d
   set
	quantidade_funcionarios = (
		select count(*)
		  from funcionario f
		 where d.numero_departamento = f.numero_departamento
	);

create trigger quantidade_funcionarios before
	insert or delete on funcionario
	for each row
begin
	if deleting then
		update departamento d
		   set
			quantidade_funcionarios = quantidade_funcionarios - 1
		 where d.numero_departamento = :old.numero_departamento;
	elsif inserting then
		update departamento d
		   set
			quantidade_funcionarios = quantidade_funcionarios + 1
		 where d.numero_departamento = :new.numero_departamento;
	end if;
end;
/

select *
  from departamento;
select *
  from funcionario;

insert into funcionario values (
	'Pedro',
	'p',
	'Ronzani',
	'02020202020',
	'08-03-1024',
	'Rua General Andrade Neves, 901, Belo Horizonte',
	'F',
	1,
	null,
	4
);
select *
  from departamento;
select *
  from funcionario;

delete from funcionario
 where cpf = '02020202020';
select *
  from departamento;
select *
  from funcionario;