-- Solução do Exercício 1 de BDI e LBD I - Funções SQL

-- 1) Apresente o primeiro e último nomes e o mês, por extenso, de admissão
-- (coluna Hire_Date de EMPLOYEES) de todos os empregados que começam com a 
-- letra ‘R’ no último nome. Não utilize LIKE, mas funções SQL. 
-- O formato de exibição por extenso das datas deve ser  ‘DD-Month-YYYY’. 
-- Exemplo: ‘01-Janeiro-2021’

select sysdate from sys.dual;

select first_name, last_name, hire_date, to_char(hire_date,'DD-Month-YYYY') 
from   employees
where  substr(last_name,1,1) =  'R';

-- 2) Apresente o nome completo (primeiro nome concatenado com o último nome, 
-- separados por branco (use a função concat)) de todos os empregados que trabalham 
-- no departamento que tem “executive” (em minúsculas) no nome. 
-- O nome do departamento deve aparecer no resultado em maiúsculas. 
-- Utilize funções SQL e junções. Não utilize o operador LIKE.

select 
       concat(concat(first_name,' '),last_name) as "Nome", 
       upper(department_name) as "Departamento"
from   
       employees e 
join 
       departments d 
on 
       e.department_id=d.department_id
where  
       lower(department_name) = 'executive';
-----------------------------------------------------
select 
       first_name || ' ' || last_name as "Nome", 
       upper(department_name) as "Departamento"
from   
       employees e 
join
       departments d 
on 
       e.department_id=d.department_id
where  
       lower(department_name) = 'executive';

-- 3)Apresente o nome completo e a data de admissão (coluna Hire_Date de Employees) de todos 
-- os empregados que foram admitidos no ano de 1999. 
-- Use a coluna HIRE_DATE com funções de data. 
-- O formato de exibição das datas deve ser ‘DD-Month-YYYY’. 
-- Exemplo: ‘01-janeiro-2021’.

select concat(concat(first_name,' '),last_name) "Nome", 
       to_char(hire_date,'DD-Month-YYYY')
from employees e
where to_char(hire_date,'YYYY') = '1999';

-- 4)Apresente o nome completo, o salário diário, arredondado,
-- e o anual de todos os empregados que ganham comissão (coluna Comission_Pct).
-- O salário (Salary) em EMPLOYEES é mensal para todos os empregados.

select * from EMPLOYEES;
select first_name || ' ' || last_name as "Nome completo", 
       round(salary/30) as "Salario Diario",
       salary*12 as "Salario Anual"
from   employees e
where  commission_pct is not NULL;

-- 5) Apresente o nome completo de todos empregados, com salário mensal e
-- salário mensal mais a comissão (que é um percentual mensal de 0 a 1). 
-- Caso não tenha comissão, o empregado tem a coluna Comission_Pct igual a NULL.
-- Empregados sem comissão devem ser incluídos no resultado, naturalmente a comissão deles é zero. 
-- Dê nomes adequados às colunas de resultado.

select first_name || ' ' || last_name as "Nome completo", 
       salary as "Salario Mensal", 
       commission_pct percentual_comissao,
       nvl(commission_pct,0)*salary comissao,
       salary*(1+commission_pct) salario_comissao
from   employees;

select concat(concat(first_name,' '),last_name) "Nome", Salary Salario, 
       nvl(commission_pct,0)*salary Comissão,
       salary*(1+nvl(commission_pct,0)) "Salario+Comissao"  
from   EMPLOYEES;

-- 6) Apresente somente a inicial de cada nome (primeiro e último nomes) de 
-- empregados que são gerentes de departamento. 
-- Incluir o nome do departamento. 
select SUBSTR(first_name,1,1), SUBSTR(last_name,1,1), d.department_name
from   EMPLOYEES E 
join DEPARTMENTS D 
on E.Department_id=D.Department_id
where  E.EMPLOYEE_ID=D.MANAGER_ID;

--7) Apresente o nome completo de todos os empregados, a quantidade de anos 
-- e meses trabalhando na empresa. Os resultados devem ser inteiros. 
-- A data atual do SGBD é fornecida pela função SYSDATE.
select SYSDATE from sys.DUAL;
select first_name||' '||last_name "Nome", round(months_between(SYSDATE,HIRE_DATE)) Meses,
        round(months_between(SYSDATE,HIRE_DATE)/12) Anos
from   EMPLOYEES;

-- 8) Apresente a média, arredondada, o máximo, o mínimo salário por departamento, 
-- incluindo o nome do departamento. Considere toda a tabela.
select e.department_id, department_name, round(avg(salary))
from   employees e join departments d 
       on e.department_id=d.department_id
group  by e.department_id, department_name;

-- 9) Apresente a quantidade de empregados por departamento. 
-- Faça somente isso para empregados que têm ‘clerk’ na coluna JOB_ID (código do cargo). 
-- O departamento deve aparecer. Utilize o operador LIKE ou a função SUBSTR, 
-- com o devido tratamento para as linhas existentes.
select department_name, count(*)
from   employees e 
join departments d on e.department_id=d.department_id
where  lower(e.job_id) like '%clerk%'
group  by department_name;