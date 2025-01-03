---- 1 ---------------------

---------------------------
-- CRIAÇÃO DE TABELAS -----
---------------------------

create TABLE instituicao (
    nome VARCHAR(100) 
        constraint pk_nome_instituicao primary key,
    endereco VARCHAR(100)
);

create table departamento (
    cod_dep int 
        constraint pk_cod_dep_departamento PRIMARY KEY,
    nome VARCHAR(100),
    NOME_INSTITUICAO VARCHAR(100) 
        CONSTRAINT fk_NOME_INSTITUICAO_departamento
        references instituicao ( nome )
        on delete cascade,
    QUANT_PESQUISADORES int
);

create table PESQUISADOR (
    COD_DEP int 
        constraint fk_COD_DEP_pesquisador
        references departamento ( cod_dep )
        on delete cascade,
    nome VARCHAR(100),
    DATA_NASCIMENTO DATE,
    CONSTRAINT pf_COD_DEP_nome_pesquisador 
        PRIMARY KEY (COD_DEP, nome)
);

---------------------------
-- INSERINDO VALORES ------
---------------------------

INSERT INTO INSTITUICAO VALUES ('CEFET', 'Amazonas');
INSERT INTO INSTITUICAO VALUES ('IFMG', 'Carmesia');

INSERT INTO DEPARTAMENTO VALUES (1, 'Informatica', 'CEFET', 1);
INSERT INTO DEPARTAMENTO VALUES (2, 'Computacao', 'IFMG', 1);

INSERT INTO PESQUISADOR VALUES (1, 'Joao', '01/01/1990');
INSERT INTO PESQUISADOR VALUES (2, 'Maria', '01/01/2000');

--- 2 --------------------------------

-- a -----

ALTER TABLE DEPARTAMENTO DROP CONSTRAINT fk_NOME_INSTITUICAO_departamento;

ALTER TABLE instituicao DROP CONSTRAINT pk_nome_instituicao;

-- B ------

alter table INSTITUICAO add COD_INSTITUICAO INT;

UPDATE INSTITUICAO SET COD_INSTITUICAO = 1 WHERE NOME = 'CEFET';
COMMIT;

UPDATE INSTITUICAO SET COD_INSTITUICAO = 2 WHERE NOME = 'IFMG';
COMMIT;

ALTER TABLE INSTITUICAO ADD CONSTRAINT PK_COD_INSTITUICAO_INSTITUICAO PRIMARY KEY (COD_INSTITUICAO);

--- C ----

ALTER TABLE DEPARTAMENTO ADD COD_INSTITUICAO INT;

UPDATE DEPARTAMENTO SET COD_INSTITUICAO = (
    SELECT COD_INSTITUICAO 
    FROM INSTITUICAO 
    WHERE DEPARTAMENTO.NOME_INSTITUICAO = INSTITUICAO.NOME
);

ALTER TABLE DEPARTAMENTO DROP COLUMN NOME_INSTITUICAO;

ALTER TABLE DEPARTAMENTO ADD CONSTRAINT fk_COD_INSTITUICAO_departamento
    FOREIGN KEY (COD_INSTITUICAO)
    REFERENCES INSTITUICAO (COD_INSTITUICAO)
    ON DELETE CASCADE;

---- 3 ---------------------

CREATE OR REPLACE TRIGGER update_quant_pesquisadores
AFTER INSERT OR UPDATE OR DELETE ON PESQUISADOR
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE DEPARTAMENTO
        SET QUANT_PESQUISADORES = QUANT_PESQUISADORES + 1
        WHERE COD_DEP = :NEW.COD_DEP;
    ELSIF UPDATING THEN
        IF :OLD.COD_DEP <> :NEW.COD_DEP THEN
            UPDATE DEPARTAMENTO
            SET QUANT_PESQUISADORES = QUANT_PESQUISADORES - 1
            WHERE COD_DEP = :OLD.COD_DEP;
            
            UPDATE DEPARTAMENTO
            SET QUANT_PESQUISADORES = QUANT_PESQUISADORES + 1
            WHERE COD_DEP = :NEW.COD_DEP;
        END IF;
    ELSIF DELETING THEN
        UPDATE DEPARTAMENTO
        SET QUANT_PESQUISADORES = QUANT_PESQUISADORES - 1
        WHERE COD_DEP = :OLD.COD_DEP;
    END IF;
END;
/

-- ADICIONANDO PESQUISADOR ---
SELECT * FROM DEPARTAMENTO;

INSERT INTO PESQUISADOR VALUES (1, 'Ulisses', '01/02/2003');

-- REMOVENDO PESQUISADOR --- 
SELECT * FROM DEPARTAMENTO;

DELETE FROM PESQUISADOR WHERE COD_DEP = 1 AND NOME = 'Ulisses';

-- ALTERANDO DEPARTAMENTO DO PESQUISADOR ---
SELECT * FROM DEPARTAMENTO;

UPDATE PESQUISADOR SET COD_DEP = 1 WHERE COD_DEP = 2 AND NOME = 'Maria';

SELECT * FROM DEPARTAMENTO;