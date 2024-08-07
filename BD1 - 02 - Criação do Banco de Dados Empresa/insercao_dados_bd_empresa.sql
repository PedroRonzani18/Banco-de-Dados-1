delete from dependente;
delete from trabalha_em;
delete from localizacoes_departamento;
delete from projeto;
delete from funcionario;
delete from departamento;


insert into departamento (nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
values  ('Pesquisa', 5,null, '22-05-1988');
 insert into departamento(nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
values        ('Administração', 4, null,'01-01-1995');
 insert into departamento(nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
values        ('Matriz', 1, null,'19-06-1981');
        
select * from departamento;

insert into funcionario(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values  ('João', 'B', 'Silva', '12345678966', '09-01-1965', 'Rua das Flores, 751, São Paulo, SP', 'M', 30000, 5);
insert into funcionario(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('Fernando', 'T', 'Wong', '33344555587', '08-12-1955', 'Rua da Lapa, 34, São Paulo, SP', 'M', 40000, 5);
insert into funcionario(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('Alice', 'J', 'Zelaya', '99988777767', '19-01-1968', 'Rua Souza Lima, 35, Curitiba, PR', 'F', 25000, 4);
insert into funcionario(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('Jennifer', 'S', 'Souza', '98765432168', '20-06-1941', 'Av. Arthur de Lima, 54, Santo André, SP', 'F', 43000, 4);
insert into funcionario(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('Ronaldo', 'K', 'Lima', '66688444476', '15-09-1962', 'Rua Rebouças, 65, Piracicaba, SP', 'M', 38000, 5);
insert into funcionario(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('Joice', 'A', 'Leite', '45345345376', '31-07-1972', 'Av. Lucas Obes, 74, São Paulo, SP', 'F', 25000, 5);
insert into funcionario(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('André', 'V', 'Pereira', '98798798733', '29-03-1969', 'Rua Timbira, 35, São Paulo, SP', 'M', 25000, 4);
insert into funcionario(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values       ('Jorge', 'E', 'Brito', '88866555576', '10-11-1937', 'Rua do Horto, 35, São Paulo, SP', 'M', 55000, 1);
        
        
--ALTER TABLE public.departamento
--    ADD COLUMN cpf_gerente VARCHAR2(11) NOT NULL DEFAULT '88866555576';

update departamento set cpf_gerente = '33344555587' where numero_departamento = 5;
update departamento set cpf_gerente = '98765432168' where numero_departamento = 4;
update departamento set cpf_gerente = '88866555576' where numero_departamento = 1;

select * from departamento;

update funcionario set cpf_supervisor = '33344555587' 
where ultimo_nome in ('Silva', 'Lima', 'Leite');
update funcionario set cpf_supervisor = '88866555576' 
where ultimo_nome in ('Wong','Souza');
update funcionario set cpf_supervisor = '98765432168' 
where ultimo_nome in ('Zelaya','Pereira');

select * from funcionario;

insert into dependente(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values  ('33344555587', 'Alicia', 'F', '05-04-1986', 'Filha');
 insert into dependente(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values        ('33344555587', 'Tiago', 'M', '25-10-1983','Filho');
insert into dependente(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values         ('33344555587', 'Janaína', 'F', '03-05-1958', 'Esposa');
insert into dependente(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values         ('98765432168', 'Antonio', 'M', '28-02-1942', 'Marido');
insert into dependente(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values         ('12345678966', 'Michael', 'M', '04-01-1988', 'Filho');
insert into dependente(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values         ('12345678966', 'Alicia', 'F', '30-12-1988', 'Filha');
insert into dependente(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values         ('12345678966', 'Elizabeth', 'F', '05-05-1967', 'Esposa');
        
select * from dependente;

insert into localizacoes_departamento(numero_departamento, local)
values  (1, 'São Paulo');
insert into localizacoes_departamento(numero_departamento, local)
values        (4, 'Mauá');
insert into localizacoes_departamento(numero_departamento, local)
values        (5, 'Santo André');
insert into localizacoes_departamento(numero_departamento, local)
values        (5, 'Itu');
insert into localizacoes_departamento(numero_departamento, local)
values        (5, 'São Paulo');

select * from localizacoes_departamento;

desc trabalha_em
insert into PROJETO (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values  ('ProdutoX', 1, 'Santo André', 5);
insert into PROJETO (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values         ('ProdutoY', 2, 'Itu', 5);
insert into PROJETO (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values         ('ProdutoZ', 3, 'São Paulo', 5);
insert into PROJETO (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values         ('Informatização', 10, 'Mauá', 4);
insert into PROJETO (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values         ('Reorganização', 20, 'São Paulo', 1);
insert into PROJETO (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values         ('Novos benefícios', 30, 'Mauá', 4);
        
select * from projeto;
 
insert into trabalha_em(cpf_funcionario, numero_projeto, horas)
values  ('12345678966', 1, 32.5);
insert into trabalha_em(cpf_funcionario, numero_projeto, horas) values ('12345678966', 2, 7.5);
insert into trabalha_em(cpf_funcionario, numero_projeto, horas) values ('66688444476', 3, 40.0);
insert into trabalha_em(cpf_funcionario, numero_projeto, horas) values ('45345345376', 1, 20.0);
insert into trabalha_em(cpf_funcionario, numero_projeto, horas) values ('45345345376', 2, 20.0);
insert into trabalha_em(cpf_funcionario, numero_projeto, horas) values ('33344555587', 2, 10.0);
insert into trabalha_em(cpf_funcionario, numero_projeto, horas) values ('33344555587', 3, 10.0);
insert into trabalha_em(cpf_funcionario, numero_projeto, horas) values ('33344555587', 10, 10.0);
insert into trabalha_em(cpf_funcionario, numero_projeto, horas) values ('33344555587', 20, 10.0);
insert into trabalha_em(cpf_funcionario, numero_projeto, horas) values ('99988777767', 30, 30.0);
insert into trabalha_em(cpf_funcionario, numero_projeto, horas) values ('99988777767', 10, 10.0);
insert into trabalha_em(cpf_funcionario, numero_projeto, horas) values ('98798798733', 10, 35.0);
insert into trabalha_em(cpf_funcionario, numero_projeto, horas) values ('98798798733', 30, 5.0);
insert into trabalha_em(cpf_funcionario, numero_projeto, horas) values ('98765432168', 30, 20.0);
insert into trabalha_em(cpf_funcionario, numero_projeto, horas) values ('98765432168', 20, 15.0);
insert into trabalha_em(cpf_funcionario, numero_projeto, horas) values ('88866555576', 20, NULL);

select * from trabalha_em;

commit;


