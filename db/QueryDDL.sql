-- Apaga o banco de dados anterior
DROP database EXLIBRIS; 

-- CRIA O BANCO DE DADOS
CREATE DATABASE EXLIBRIS;

-- UTILIZA O BD
USE EXLIBRIS;


-- TP PESSOA
CREATE TABLE EXLIBRIS.PESSOA(
  PESSOA_COD INT NOT NULL AUTO_INCREMENT,
  NOME CHAR(60) NOT NULL,
  SOBRENOME CHAR(60) NULL,
  ANO_NASC CHAR(4) NULL,
  BIO VARCHAR(2048) NULL,
  PRIMARY KEY(PESSOA_COD)
);

-- TT FORMATO
CREATE TABLE EXLIBRIS.FORMATO(
  FORMATO_COD INT NOT NULL AUTO_INCREMENT,
  FORMATO CHAR(25) NOT NULL,
  PRIMARY KEY(FORMATO_COD)
);

-- TT PAPEL
CREATE TABLE EXLIBRIS.PAPEL(
  PAPEL_COD INT NOT NULL AUTO_INCREMENT,
  PAPEL CHAR(30) NULL,
  PRIMARY KEY(PAPEL_COD)
);

-- TT PAIS - NOMES DE PAISES SEGUNDO A NORMA ISO-3166-1
CREATE TABLE EXLIBRIS.PAIS(
--  PAIS_COD INT NOT NULL AUTO_INCREMENT,
  PAIS_SG CHAR(3) NOT NULL UNIQUE,
  PAIS CHAR(30) NOT NULL,
  PRIMARY KEY(PAIS_SG)
);

-- TT IDIOMA
CREATE TABLE EXLIBRIS.IDIOMA(
  ISO639 CHAR(3) NOT NULL UNIQUE,
  IDIOMA CHAR(25) NOT NULL,
  IDIOMA_INGLES CHAR(25) NULL, 
  PRIMARY KEY(ISO639)
);

-- TT GENERO
CREATE TABLE EXLIBRIS.GENERO(
  GENERO_COD INT NOT NULL AUTO_INCREMENT,
  GENERO CHAR(30),
  PRIMARY KEY(GENERO_COD)
);

-- TT UF
CREATE TABLE EXLIBRIS.UF(
  -- UF_COD INT NOT NULL AUTO_INCREMENT,
  UF_SIGLA CHAR(2) NOT NULL UNIQUE,
  UF_NOME CHAR(30) NOT NULL,
  PRIMARY KEY(UF_SIGLA)
);

-- TT TIPO_ENDERECO
CREATE TABLE EXLIBRIS.TIPO_ENDERECO(
  TIPO_ENDERECO_SG CHAR(3) NOT NULL UNIQUE,
  TIPO_ENDERECO CHAR(30) NOT NULL,
  PRIMARY KEY(TIPO_ENDERECO_SG)
);

-- TT TIPO_TELEFONE
CREATE TABLE EXLIBRIS.TIPO_TELEFONE(
  TIPO_TELEFONE_SG CHAR(3) NOT NULL UNIQUE,
  TIPO_TELEFONE CHAR(30) UNIQUE,
  PRIMARY KEY(TIPO_TELEFONE_SG)
);

CREATE TABLE EXLIBRIS.TELEFONE(
  TELEFONE_COD INT NOT NULL AUTO_INCREMENT,
  PESSOA_COD INT NOT NULL,
  CODIGO_AREA CHAR(4) NOT NULL,
  TELEFONE_NUMERO CHAR(12) NOT NULL,
  TIPO_TELEFONE_SG CHAR(3) NOT NULL,
  PRIMARY KEY(TELEFONE_COD),
  CONSTRAINT FK_PESSOA
    FOREIGN KEY(PESSOA_COD)
    REFERENCES EXLIBRIS.PESSOA(PESSOA_COD)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT FK_TIPO_TELEFONE
    FOREIGN KEY(TIPO_TELEFONE_SG)
    REFERENCES EXLIBRIS.TIPO_TELEFONE(TIPO_TELEFONE_SG)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);

CREATE TABLE EXLIBRIS.ENDERECO(
  ENDERECO_COD INT NOT NULL AUTO_INCREMENT,
  ENDERECO CHAR(200) NOT NULL,
  CIDADE CHAR(30) NOT NULL,
  CODIGO_POSTAL CHAR(10) NULL,
  UF_SIGLA CHAR(2) NULL,
  PAIS_SG CHAR(3) NOT NULL,
  TIPO_ENDERECO_SG CHAR(3) NOT NULL,
  PRIMARY KEY(ENDERECO_COD),
  CONSTRAINT FK_UF
    FOREIGN KEY(UF_SIGLA)
    REFERENCES EXLIBRIS.UF(UF_SIGLA)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT FK_PAIS
    FOREIGN KEY(PAIS_SG)
    REFERENCES EXLIBRIS.PAIS(PAIS_SG)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT FK_TIPO_ENDERECO
    FOREIGN KEY(TIPO_ENDERECO_SG)
    REFERENCES EXLIBRIS.TIPO_ENDERECO(TIPO_ENDERECO_SG)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE EXLIBRIS.EDITORA(
  EDITORA_COD INT NOT NULL AUTO_INCREMENT,
  NOME CHAR(60) NOT NULL,
  ENDERECO_COD INT NOT NULL,
  SITE CHAR(60) NULL,
  EMAIL CHAR(60) NULL,
  PRIMARY KEY(EDITORA_COD),
  CONSTRAINT FK_ENDERECO
    FOREIGN KEY(ENDERECO_COD)
    REFERENCES EXLIBRIS.ENDERECO(ENDERECO_COD)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- TP000 OBRA
CREATE TABLE EXLIBRIS.OBRA(
  OBRA_COD INT NOT NULL AUTO_INCREMENT,
  TITULO CHAR(60) NOT NULL,
  SUBTITULO CHAR(60) NULL,
  TITULO_ORIGINAL CHAR(60) NULL,
  IDIOMA_ORIGINAL_COD CHAR(3) NULL,
  GENERO_COD INT NULL,
  SUMARIO VARCHAR(2048),
  PRIMARY KEY(OBRA_COD),
  CONSTRAINT FK_IDIOMA_ORIGINAL
    FOREIGN KEY (IDIOMA_ORIGINAL_COD)
    REFERENCES EXLIBRIS.IDIOMA(ISO639)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT FK_GENERO
    FOREIGN KEY (GENERO_COD)
    REFERENCES EXLIBRIS.GENERO(GENERO_COD)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- TP000 TAG
CREATE TABLE EXLIBRIS.TAG(
	TAG_COD INT NOT NULL AUTO_INCREMENT, 
    OBRA_COD INT NOT NULL, 
    TAG CHAR(30), 
    PRIMARY KEY(TAG_COD, OBRA_COD), 
    CONSTRAINT FK_OBRA
		FOREIGN KEY(OBRA_COD)
        REFERENCES EXLIBRIS.OBRA(OBRA_COD)
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION
);

-- TA000 AUTORES 
CREATE TABLE EXLIBRIS.AUTORES(
	OBRA_COD INT NOT NULL, 
    PESSOA_COD INT NOT NULL, 
    PRIMARY KEY(OBRA_COD, PESSOA_COD), 
    CONSTRAINT FK_OBRA_O1
		FOREIGN KEY(OBRA_COD) 
        REFERENCES EXLIBRIS.OBRA(OBRA_COD)
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION, 
	CONSTRAINT FK_PESSOA_P1 
		FOREIGN KEY(PESSOA_COD)
        REFERENCES EXLIBRIS.PESSOA(PESSOA_COD)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION 
); 

-- TA000 ENDERECO_PESSOA
CREATE TABLE EXLIBRIS.ENDERECO_PESSOA(
	PESSOA_COD INT NOT NULL, 
    ENDERECO_COD INT NOT NULL, 
    PRIMARY KEY(PESSOA_COD, ENDERECO_COD), 
    CONSTRAINT FK_PESSOA_P2
		FOREIGN KEY(PESSOA_COD) 
        REFERENCES EXLIBRIS.PESSOA(PESSOA_COD)
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION, 
	CONSTRAINT FK_ENDERECO_E2
		FOREIGN KEY(ENDERECO_COD) 
        REFERENCES EXLIBRIS.ENDERECO(ENDERECO_COD)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

-- TP000 EXEMPLAR
CREATE TABLE EXLIBRIS.EXEMPLAR(
	EXEMPLAR_COD INT NOT NULL AUTO_INCREMENT, 
    OBRA_COD INT NOT NULL, 
    EDITORA_COD INT NULL, 
    EDICAO_NO INT NULL, 
    EDICAO_ANO CHAR(4) NULL, 
    EDICAO_LOCAL CHAR(30) NULL, 
    QTE_PAGINAS INT NULL, 
    PRECO_MOEDA CHAR(3) NULL, 
    PRECO_VALOR DECIMAL(5,2) NULL, 
    CODIGO_BARRAS CHAR(13) NULL, 
    ISBN CHAR(13) NULL, 
    ISSN CHAR(13) NULL, 
    CDD CHAR(10) NULL, 
    COLECAO CHAR(30) NULL, 
    COLECAO_NO CHAR(10) NULL, 
    FORMATO_COD INT NULL, 
    PRIMARY KEY(EXEMPLAR_COD), 
    CONSTRAINT FK_OBRA_COD_O3
		FOREIGN KEY(OBRA_COD) 
        REFERENCES EXLIBRIS.OBRA(OBRA_COD)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	CONSTRAINT FK_EDITORA
		FOREIGN KEY(EDITORA_COD) 
        REFERENCES EXLIBRIS.EDITORA(EDITORA_COD) 
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION, 
	CONSTRAINT FK_FORMATO
		FOREIGN KEY(FORMATO_COD)
        REFERENCES EXLIBRIS.FORMATO(FORMATO_COD) 
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION
); 


-- TA000 IDIOMAS_EXEMPLAR
CREATE TABLE EXLIBRIS.IDIOMAS_EXEMPLAR(
	EXEMPLAR_COD INT NOT NULL, 
    IDIOMA_COD INT NOT NULL, 
    PRIMARY KEY(EXEMPLAR_COD, IDIOMA_COD), 
    CONSTRAINT FK_EXEMPLAR_E01 
		FOREIGN KEY(EXEMPLAR_COD) 
        REFERENCES EXLIBRIS.EXEMPLAR(EXEMPLAR_COD)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
); 

-- TA000 PRODUTORES 
CREATE TABLE EXLIBRIS.PRODUTORES(
	EXEMPLAR_COD INT NOT NULL, 
    PESSOA_COD INT NOT NULL, 
    PAPEL_COD INT NOT NULL, 
    PRIMARY KEY(EXEMPLAR_COD, PAPEL_COD, 
		PESSOA_COD), 	
    CONSTRAINT FK_EXEMPLAR_E03
		FOREIGN KEY(EXEMPLAR_COD)
        REFERENCES EXLIBRIS.EXEMPLAR(EXEMPLAR_COD)
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION,
    CONSTRAINT FK_PESSOA_P03
		FOREIGN KEY(PESSOA_COD)
        REFERENCES EXLIBRIS.PESSOA(PESSOA_COD)
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION, 
    CONSTRAINT FK_PAPEL_P03
		FOREIGN KEY(PAPEL_COD)
        REFERENCES EXLIBRIS.PAPEL(PAPEL_COD)
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION
); 

CREATE TABLE EXLIBRIS.IDX_CATLG(
	OBRA_COD INT NOT NULL, 
    IDX_CATLG_COD INT NOT NULL, 
    IDX_CATLG CHAR(30) NOT NULL, 
    PRIMARY KEY(OBRA_COD, IDX_CATLG_COD), 
    CONSTRAINT FK_OBRA_O3 
		FOREIGN KEY(OBRA_COD) 
        REFERENCES EXLIBRIS.OBRA(OBRA_COD)
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION
); 

-- TP AVALIACAO 

-- TA APRECIACAO 




-- *******************************************************************************************
--  DML - Data manipulation language 
--  Faz os inserts de registros de base no banco de dados - tabelas tradicionais
-- *******************************************************************************************


-- Insert valores na tabela PESSOA. Valor piloto: vanity value... :) 
INSERT INTO PESSOA (NOME, SOBRENOME, ANO_NASC, BIO) VALUES('JULIO CESAR', 'TORRES DOS SANTOS', '1976', 'AUTOR DESTE BANCO DE DADOS. CARA FODAO...');


-- Insert valores na tabela tradicional FORMATO
INSERT INTO EXLIBRIS.FORMATO(FORMATO) VALUES('Hardcover');
INSERT INTO EXLIBRIS.FORMATO(FORMATO) VALUES('Softcover');
INSERT INTO EXLIBRIS.FORMATO(FORMATO) VALUES('Partitura');
INSERT INTO EXLIBRIS.FORMATO(FORMATO) VALUES('Revista');
INSERT INTO EXLIBRIS.FORMATO(FORMATO) VALUES('Fasciculo'); 
INSERT INTO EXLIBRIS.FORMATO(FORMATO) VALUES('Journal');

-- Insert valores na tabela tradicional PAPEL 
INSERT INTO EXLIBRIS.PAPEL(PAPEL) VALUES ('Autor');
INSERT INTO EXLIBRIS.PAPEL(PAPEL) VALUES ('Tradutor'); 
INSERT INTO EXLIBRIS.PAPEL(PAPEL) VALUES ('Ilustrador'); 
INSERT INTO EXLIBRIS.PAPEL(PAPEL) VALUES ('Apresentador'); 
INSERT INTO EXLIBRIS.PAPEL(PAPEL) VALUES ('Organizador'); 
INSERT INTO EXLIBRIS.PAPEL(PAPEL) VALUES ('Editor'); 
INSERT INTO EXLIBRIS.PAPEL(PAPEL) VALUES ('Prefacio'); 
INSERT INTO EXLIBRIS.PAPEL(PAPEL) VALUES ('Avaliador'); 



INSERT INTO EXLIBRIS.IDIOMA(ISO639, IDIOMA, IDIOMA_INGLES) VALUES ('PT','Português', 'Portuguese');
INSERT INTO EXLIBRIS.IDIOMA(ISO639, IDIOMA, IDIOMA_INGLES) VALUES ('EN','Ingles', 'English');
INSERT INTO EXLIBRIS.IDIOMA(ISO639, IDIOMA, IDIOMA_INGLES) VALUES ('FR','Frances', 'French');
INSERT INTO EXLIBRIS.IDIOMA(ISO639, IDIOMA, IDIOMA_INGLES) VALUES ('DE','Alemao', 'German');
INSERT INTO EXLIBRIS.IDIOMA(ISO639, IDIOMA, IDIOMA_INGLES) VALUES ('EL','Grego', 'Greek');
INSERT INTO EXLIBRIS.IDIOMA(ISO639, IDIOMA, IDIOMA_INGLES) VALUES ('LA','Latim', 'Latin');

INSERT INTO TIPO_ENDERECO(TIPO_ENDERECO_SG, TIPO_ENDERECO) VALUES ('R', 'Residencial');
INSERT INTO TIPO_ENDERECO(TIPO_ENDERECO_SG, TIPO_ENDERECO) VALUES ('C', 'Comercial');

INSERT INTO TIPO_TELEFONE(TIPO_TELEFONE_SG, TIPO_TELEFONE) VALUES ('R','Residencial');
INSERT INTO TIPO_TELEFONE(TIPO_TELEFONE_SG, TIPO_TELEFONE) VALUES ('C','Comercial');
INSERT INTO TIPO_TELEFONE(TIPO_TELEFONE_SG, TIPO_TELEFONE) VALUES ('M','Movel');
