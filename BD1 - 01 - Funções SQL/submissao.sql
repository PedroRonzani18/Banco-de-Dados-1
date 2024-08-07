-- Funções SQL ---
-- Dupla: Pedro Augusto de Portilho Ronzani,
-- Ulisses Andrade Carvalho

-- Questao 1 ------------------------------------------------------
select first_name,
       last_name,
       to_char(
	       hire_date,
	       'DD-Month-YYYY'
       ) dataadmissao
  from aluno.employees
 where substr(
	last_name,
	1,
	1
) = 'R';

-- Questao 2 -----------------------------------------------------

select concat(
	concat(
		first_name,
		' '
	),
	last_name
) "Nome Completo"
  from aluno.employees e
  join aluno.departments d
on e.department_id = d.department_id
   and lower(
	d.department_name
) = 'executive';

-- Questao 3 -----------------------------------------------------

select concat(
	concat(
		first_name,
		' '
	),
	last_name
) "Nome Completo",
       to_char(
	       hire_date,
	       'DD-Month-YYYY'
       ) "Data de Admissao"
  from aluno.employees
 where to_char(
	hire_date,
	'YYYY'
) = '1999';

-- Questao 4 -----------------------------------------------------

select concat(
	concat(
		first_name,
		' '
	),
	last_name
) "Nome Completo",
       round(salary / 30) "Salário Diário",
       salary * 12 "Salário Anual"
  from aluno.employees
 where commission_pct is not null;

-- Questao 5 -----------------------------------------------------

select concat(
	concat(
		first_name,
		' '
	),
	last_name
) "Nome Completo",
       salary "Salário Mensal",
       salary + salary * nvl(
	       commission_pct,
	       0
       ) "Salário + Comissão"
  from aluno.employees;

-- Questao 6 -----------------------------------------------------

select substr(
	first_name,
	1,
	1
) "Inicial Primeiro Nome",
       substr(
	       last_name,
	       1,
	       1
       ) "Inicial Segundo Nome",
       d.department_name
  from aluno.employees e
  join aluno.departments d
on e.manager_id = d.manager_id;

-- Questao 7 -----------------------------------------------------

select concat(
	concat(
		first_name,
		' '
	),
	last_name
) "Nome Completo",
       floor(floor(
	       months_between(
		       sysdate,
		       hire_date
	       )
       ) / 12) "Anos Trabalhados",
       mod(
	       floor(
		       months_between(
			       sysdate,
			       hire_date
		       )
	       ),
	       12
       ) "Meses Trabalhados"
  from aluno.employees;

-- Questao 8 -----------------------------------------------------

select d.department_name "Nome departamento",
       round(
	       avg(salary)
       ) "Salário médio",
       max(salary) "Salário máximo",
       min(salary) "Salário mínimo"
  from aluno.employees e
  join aluno.departments d
on e.department_id = d.department_id
 group by d.department_name;

-- Questao 9 -----------------------------------------------------

select d.department_name "Nome Departamento",
       count(e.employee_id) "Qtd de Emp"
  from aluno.employees e
  join aluno.departments d
on e.department_id = d.department_id
 where e.job_id like '%CLERK%'
 group by d.department_name;