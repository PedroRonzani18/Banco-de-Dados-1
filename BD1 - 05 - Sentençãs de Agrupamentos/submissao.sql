-- Exercicio 05 - Setenças de Agrupamento
-- Dupla: Pedro Augusto de Portilho Ronzani
--        Ulisses Andrade Carvalho

-- 1
select 
    c.NAME, o.custid, SUM(o.TOTAL)
from 
    ALUNO.ORD o 
JOIN 
    ALUNO.CUSTOMER c 
on 
    o.custid = c.custid 
group by 
    c.name, o.custid;

-- 2

SELECT
    p.descrip, P.PRODID, sum(i.qty) as SOMA_TOTAL
FROM
    aluno.item i
JOIN
    aluno.product p
ON
    i.prodid = p.prodid
group BY
    p.descrip, P.PRODID;

-- 3

SELECT
    p.descrip, p.PRODID, SUM(i.qty) as total_qty
FROM
    aluno.item i
JOIN
    aluno.product p
ON
    i.prodid = p.prodid
GROUP BY
    p.descrip, P.PRODID
HAVING 
    SUM(i.QTY) = (
        SELECT 
            MAX(SOMA) 
        FROM (
            SELECT 
                SUM(I.QTY) SOMA
            FROM 
                ALUNO.ITEM I
            GROUP BY 
                I.PRODID
        )
);

-- 4

select 
    e.empno, sum(o.total) as TotalPedidos, e.ename as Vendedor
from
    aluno.ord o
JOIN
    aluno.customer c
ON 
    o.custid = c.custid
JOIN
    aluno.emp e
on 
    c.repid = e.empno
group by
    e.ename, e.empno;

-- 5

select
    sum(o.total), ROUND(avg(o.total), 02), c.city
from
    aluno.ord o
JOIN
    aluno.customer c
on
    o.custid = c.custid
group by
    c.city;

-- 6

SELECT
     Total, ee.ename 
FROM (SELECT
        sum(o.total) as Total, e.MGR as MGR
    from
        aluno.ord o
    JOIN
        aluno.customer c
    ON  
        o.custid = c.custid
    join
        aluno.emp e
    on
        e.empno = c.repid
    group by 
        e.MGR) g
JOIN 
    aluno.EMP ee
ON 
    ee.empno = g.MGR;




