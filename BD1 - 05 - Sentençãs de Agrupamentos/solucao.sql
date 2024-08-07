-- questão 1 

select custid,sum(o.total)
from   aluno.ORD o
group by custid;

select c.name, sum(o.total), count(*)
from  aluno.CUSTOMER c, aluno.ORD o 
where c.custid=o.custid
group by c.name;

select c.name, sum(o.total), count(*)
from  aluno.CUSTOMER c join aluno.ORD o on c.custid=o.custid
group by c.name;

select c.name, sum(o.total), count(*)
from  aluno.CUSTOMER c natural join aluno.ORD o
group by c.name;

-- questão 2 
select P.Descrip, sum(i.qty)soma 
from  aluno.PRODUCT P join  aluno.ITEM I on I.ProdId = P.ProdId
group by P.Descrip;

-- questao 3
-- quantidade em que cada produto foi pedido
select i.prodid, sum(i.qty)soma 
from  aluno.ITEM i
group by i.prodid;

-- obtendendo a máxima quantidade
select max(soma) 
from (select sum(i.qty)soma 
      from  aluno.ITEM i
      group by i.prodid);

-- para identificar o produto com a máxima quantidade
select i.prodid, sum(i.qty)
from    aluno.ITEM i
group by i.prodid
having sum(i.qty) = (select max(soma) 
       	              from (select sum(i.qty)soma 
             	 	          from  aluno.ITEM i
             		          group by i.prodid));

-- questão 4 

-- sem o nome do vendedor
select C.Repid, sum(o.total)
from aluno.ORD O join  aluno.CUSTOMER C on O.Custid = C.Custid
group by C.Repid;

-- com o nome do vendedor
select E.Ename, sum(o.total)
from aluno.ORD O join  aluno.CUSTOMER C on O.Custid = C.Custid join 
     aluno.EMP E on C.Repid=E.empno
group by e.Ename;

-- questão 5
select C.City, sum(o.total), round(avg(o.total),2)
from aluno.ORD O join  aluno.CUSTOMER C on O.Custid = C.Custid 
group by C.City;

-- Questão 6

-- total de vendas por vendedor
select E.Ename, sum(O.Total), avg(o.total)
from   aluno.Emp E join aluno.CUSTOMER C on E.Empno = C.Repid join 
       aluno.ORD O on C.Custid = O.Custid
group by E.Ename
order by E.Ename;

-- total de vendas por gerente (MGR) de vendedores
select G.Ename, sum(O.Total)
from   aluno.EMP  E join aluno.EMP  G on E.MGR = G.Empno join
        aluno.CUSTOMER C on E.Empno = C.Repid join 
       aluno.ORD O on C.Custid = O.Custid
group by G.Ename; 