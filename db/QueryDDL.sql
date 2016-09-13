-- TP0001 - OBRA - DESCRICAO DA OBRA, SEU CONTEUDO INTELECTUAL E IMATERIAL
OBRA_COD INT NOT NULL AUTOINCREMENT, 
TITULO CHAR(60) NOT NULL, 
SUBTITULO CHAR(60), 
TITULO_ORIGINAL CHAR(60), 
IDIOMA_ORIGINAL_COD INT NULL FK, 
GENERO_COD INT NULL FK, 
SUMARIO VARCHAR(2048), 
PRIMARY KEY OBRA_COD


-- TP002 - EXEMPLAR - DESCRICAO DO EXEMPLAR, CONTEUDO FISICO, OBJETO
EXEMPLAR_COD INT NOT NULL AUTOINCREMENT, 
OBRA_COD INT FK NOT NULL, 
EDITORA_COD INT FK NULL, 
DATA_EDICAO CHAR(8) NULL, 
EDICAO_NO INT NULL, 
EDICAO_ANO CHAR(4) NULL, 
EDICAO_CIDADE CHAR(30) NULL, 
QTD_PAGINAS INT NULL, 
PRECO_MOEDA CHAR(3) NULL,
PRECO_VALOR DECIMAL(5,2) NULL, 
CODIGO_BARRAS CHAR(13) NULL, 
ISBN CHAR(13) NULL, 
ISSN CHAR(13) NULL, 
CDD CHAR(10) NULL, 
COLECAO CHAR(30) NULL, 
COLECAO_NO CHAR(10) NULL, 
FORMATO_COD INT FK NULL, 
PRIMARY KEY IS (ELEMENTO_COD, OBRA_COD) 
