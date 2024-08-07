-- Solucao Exercicio 4 - Juncoes e Aninhamento de SQL

-- Questao 1) Apresente o nome dos departamentos que nao \
-- tem empregados. Faca isso com consulta aninhada. 
-- Utilize corretamente o operador NOT IN, evitando valores nulos.

select *
from DEPARTMENTS;

-- obtendo os departamento que tem empregados

select distinct DEPARTMENT_ID
from   aluno.EMPLOYEES;

-- para remover a duplicidade dos resultados

select distinct FIRST_NAME, LAST_NAME, DEPARTMENT_ID
from   EMPLOYEES;

select DEPARTMENT_NAME
from   aluno.DEPARTMENTS
where  DEPARTMENT_ID  not in (select distinct DEPARTMENT_ID
                              from   aluno.EMPLOYEES);
                              
select DEPARTMENT_ID
from   EMPLOYEES;                              
                              
-- not in: != all : departament_id != 50 and departament_id !=40 ...
--                  department_id != null ...
                              
select DEPARTMENT_ID
from   DEPARTMENTS
where  DEPARTMENT_ID != ALL (select distinct DEPARTMENT_ID
                              from   EMPLOYEES); 
                              
-- o conjunto de DEPARTMENTS inclui o conjunto de empregados com 
-- departamento.

select DEPARTMENT_NAME
from   DEPARTMENTS
where  DEPARTMENT_ID not in (select DEPARTMENT_ID
                             from EMPLOYEES);
                             
-- para se retirar o null do conjunto da sub-consulta anterior.,
-- usar o is not null

select distinct DEPARTMENT_ID
from EMPLOYEES
where DEPARTMENT_ID is not null;

select DEPARTMENT_NAME
from   aluno.DEPARTMENTS
where  DEPARTMENT_ID not in (select distinct DEPARTMENT_ID
                             from aluno.EMPLOYEES
                             where DEPARTMENT_ID is not null);
                             
select * from DEPARTMENTS;  
-- para DEPARTMENT_ID = 10 (1a. de DEPARTMENTS)
select * from EMPLOYEES where DEPARTMENT_ID=10;
-- para DEPARTMENT_ID = 20 (2a. de DEPARTMENTS)
select * from EMPLOYEES where DEPARTMENT_ID=20;
-- para DEPARTMENT_ID = 30 (3a. de DEPARTMENTS)
select * from EMPLOYEES where DEPARTMENT_ID=20;
-- ...
        
-- resolvendo com operadores de conjunto. Considerando que queremos tirar dos
-- departamentos aqueles que nao tem empregados, podemos usar o minus (diferenca)

select d.department_name
from   departments d
minus  
select d.department_name
from   departments d join employees e
       on d.department_id = e.department_id;
        
-- Questao 2) Apresente o nome de todos os empregados 
-- (nome completo: FIRST_NAME e LAST_NAME) com o nome dos 
-- seus departamentos.         
select E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
from   DEPARTMENTS D inner join EMPLOYEES E 
       on D.DEPARTMENT_ID=E.DEPARTMENT_ID; 
select * from employees;


-- Questao 3)	Agora, refaca o comando anterior para incluir 
-- também os empregados sem departamentos. 
-- Nesse caso, o nome do departamento deve ser nulo. Ou seja, faca isso com juncao externa. 
select E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
from   DEPARTMENTS D right outer join EMPLOYEES E 
       on D.DEPARTMENT_ID=E.DEPARTMENT_ID; 
       
-- Questao 4)	Se voce usou juncao externa à direita, 
-- refaca o comando anterior para usar a esquerda e vice-versa.  
select E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
from   EMPLOYEES E left outer join DEPARTMENTS D
       on D.DEPARTMENT_ID=E.DEPARTMENT_ID;
       
-- obtendo o mesmo resultado com dois SQL
select E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
from   EMPLOYEES E join DEPARTMENTS D
       on D.DEPARTMENT_ID=E.DEPARTMENT_ID
union  
select E.FIRST_NAME, E.LAST_NAME, NULL
from   EMPLOYEES E
where  E.DEPARTMENT_ID is NULL;
       
-- Questao 5) Apresente o nome dos empregados, o codigo dos cargos 
-- anteriores que ja ocuparam (esse codigo esta em JOB_HISTORY.JOB_ID) e data de ocupacao (inicio e fim). 
-- Faca isso para todos os empregados, inclusive os que nunca tiveram cargos anteriores. Use juncao externa.
-- Nao precisa colocar o titulo (JOB_TITLE) do cargo que esta em JOBS.

select * from JOB_HISTORY;
select E.FIRST_NAME, E.LAST_NAME, JH.START_DATE, 
       JH.END_DATE, JH.JOB_ID
from   EMPLOYEES E  left join JOB_HISTORY JH
       on E.EMPLOYEE_ID=JH.EMPLOYEE_ID; 

-- Questoes 6)	Agora, refaca o comando anterior para incluir o nome do cargo,
-- que, como foi dito, esta em JOBS.  Continue usando juncao externa. 
-- Observe agora que sao duas juncoes e que pode ser necessario estender 
-- a juncao externa para obter o resultado correto.


select E.FIRST_NAME, E.LAST_NAME, JH.START_DATE, JH.END_DATE, JH.JOB_ID, 
       J.JOB_TITLE
from   (aluno.EMPLOYEES E left outer join aluno.JOB_HISTORY JH
       on E.EMPLOYEE_ID=JH.EMPLOYEE_ID) left join aluno.JOBS J
       on JH.JOB_ID = J.JOB_ID;
       
-- Questao 7)	Apresente, distintamente, todos os cargos sendo ocupados atualmente na cidade de ‘Seattle’.
-- Utilize, para isso, somente consultas aninhadas. 
-- A palavra DISTINC pode ser usada no SELECT, diminuindo o espaco
-- de busca nas consultas externas. DISTINCT    

-- retorna o location_id de Seatle
select l.location_id 
from locations l 
where l.city='Seattle';  -- retorna 1700

select d.department_id 
from departments d 
where d.location_id = 1700;

select distinct e.job_id 
from   employees e 
where  e.department_id in (select d.department_id 
                          from departments d 
                           where d.location_id = 1700);
                           
select j.job_title 
from   JOBS j
where   j.job_id in (select distinct e.job_id 
                     from   employees e 
                     where  e.department_id in (select d.department_id 
                                                from departments d 
                                                where d.location_id = 1700));                           

select  j.job_title
from   jobs j
where  j.job_id in (select distinct e.job_id 
                    from   employees e 
                    where e.department_id in (select d.department_id 
                                              from departments d 
                                              where d.location_id in  (select l.location_id 
                                                                       from locations l 
                                                                       where l.city='Seattle')));
-- Questao 8) 
-- juncao na clausula where 
--	Resolva a consulta anterior, utilizando somente juncoes ao invés de consultas aninhadas.

-- juncao na clausula from com join (mais indicado, pela legibilidade)
select distinct j.job_title
from   locations l join departments d on l.location_id=d.location_id  join 
        employees e on d.department_id=e.department_id join jobs j
        on  e.job_id=j.job_id
where   l.city='Seattle';

select distinct j.job_title
from   locations l, departments d, employees e, jobs j
where  d.location_id  = l.location_id and 
       d.department_id=e.department_id and
       e.job_id=j.job_id
and    l.city='Seattle';


