/* modeloLogico: */

CREATE DATABASE [IF NOT EXISTS] pgp;

USE 'pgp'; 

CREATE TABLE estabelecimento (
    id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    email TEXT NOT NULL,
    telefone TEXT NOT NULL,
    nome TEXT NOT NULL,
    rua TEXT NOT NULL,
    numero TEXT NOT NULL,
    cidade TEXT NOT NULL,
    estado TEXT NOT NULL,
    cep TEXT NOT NULL
);

CREATE TABLE usuario (
  	id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
  	senha TEXT NOT NULL,
    telefone VARCHAR(13) NOT NULL UNIQUE,
    nome TEXT NOT NULL,
);

CREATE TABLE cupom (
    id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    data_criacao DATE NOT NULL,
    data_termino DATE NOT NULL,
    descricao TEXT NOT NULL,
    porcentagem_desconto FLOAT NOT NULL,
    preco_do_produto FLOAT,
    nome_produto TEXT NOT NULL,
    contagem_cupons int NOT NULL,
    link_imagem TEXT NOT NULL,
    fk_estabelecimento_id int NOT NULL,
    FOREIGN KEY (fk_estabelecimento_id) REFERENCES estabelecimento(id)
);

CREATE TABLE tarefa (
    id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    descricao TEXT NOT NULL,
    fk_cupom_id int  NOT NULL,
    FOREIGN KEY (fk_cupom_id) REFERENCES cupom(id)
);

CREATE TABLE avaliacao (
    id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    estrelas SMALLINT NOT NULL,
    comentario TEXT ,
    fk_estabelecimento_id int NOT NULL,
    fk_usuario_id int NOT NULL,
    FOREIGN KEY (fk_estabelecimento_id) REFERENCES estabelecimento(id),
    FOREIGN KEY (fk_usuario_id) REFERENCES usuario(id)
);

CREATE TABLE links (
    id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    link TEXT NOT NULL,
    descricao TEXT NOT NULL,
    fk_estabelecimento_id int NOT NULL,
    FOREIGN KEY (fk_estabelecimento_id) REFERENCES estabelecimento(id)
);

CREATE TABLE cupons_usados (
    fk_cupom_id int NOT NULL,
    fk_usuario_id int  NOT NULL,
    data_pego DATE NOT NULL,
    data_usado DATE,
    status_cupom SMALLINT NOT NULL,
    qr_code TEXT NOT NULL, 
    PRIMARY KEY (fk_cupom_id, fk_usuario_id),
    FOREIGN KEY (fk_cupom_id) REFERENCES cupom(id),
    FOREIGN KEY (fk_usuario_id) REFERENCES usuario(id)
);
 
/*
ALTER TABLE cupom ADD CONSTRAINT FK_cupom_2
    FOREIGN KEY (fk_estabelecimento_id)
    REFERENCES estabelecimento (id)
    ON DELETE CASCADE;
 
ALTER TABLE tarefa ADD CONSTRAINT FK_tarefa_2
    FOREIGN KEY (fk_cupom_id)
    REFERENCES cupom (id)
    ON DELETE CASCADE;
 
ALTER TABLE avaliacao ADD CONSTRAINT FK_avaliacao_2
    FOREIGN KEY (fk_estabelecimento_id)
    REFERENCES estabelecimento (id)
    ON DELETE CASCADE;
 
ALTER TABLE avaliacao ADD CONSTRAINT FK_avaliacao_3
    FOREIGN KEY (fk_usuario_id)
    REFERENCES usuario (id)
    ON DELETE CASCADE;
 
ALTER TABLE links ADD CONSTRAINT FK_links_2
    FOREIGN KEY (fk_estabelecimento_id)
    REFERENCES estabelecimento (id)
    ON DELETE CASCADE;
 
ALTER TABLE usuario ADD CONSTRAINT FK_usuario_2
    FOREIGN KEY (fk_cupom_id)
    REFERENCES cupom (id)
    ON DELETE SET NULL;

ALTER TABLE cupons_usados ADD CONSTRAINT FK_cupons_usados_1
    FOREIGN KEY (fk_cupom_id)
    REFERENCES cupom (id)
    ON DELETE SET NULL;
    
ALTER TABLE cupons_usados ADD CONSTRAINT FK_cupons_usados_2
    FOREIGN KEY (fk_usuario_id)
    REFERENCES usuario (id)
    ON DELETE SET NULL;

*/
