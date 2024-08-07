select * from aluno.funcionario;
select  * from aluno.departamento;
select * 
from aluno.funcionario f 
join aluno.departamento d on f.numero_departamento=d.numero_departamento;
select d.nome_departamento, f.primeiro_nome, f.ultimo_nome
from aluno.funcionario f 
join aluno.departamento d on f.numero_departamento=d.numero_departamento;
select * from aluno.dependente;

select  d.nome_departamento, f.primeiro_nome, f.ultimo_nome, 
           depen.nome_dependente
from (aluno.funcionario f 
        join aluno.departamento d on f.numero_departamento=d.numero_departamento) 
        join aluno.dependente depen on f.cpf=depen.cpf_funcionario;
where d.numero_departamento=5;