--ALUNO: PEDRO LUÍS BREDA
--TURMA: SI1N



-- Exclusão do Banco de Dados existente, se existir.

DROP DATABASE IF EXISTS uvv;

-- Apagar todos os objetos pertencentes ao usuário (pedro_luis) e excluir o próprio, se existir.

DROP USER IF EXISTS pedro_luis;

-- Criação do usuário com as permissões adequadas e senha.

create user pedro_luis with 
createdb createrole encrypted password '777';

-- Criação do banco de dados

CREATE DATABASE uvv
OWNER pedro_luis
TEMPLATE template0
ENCODING 'UTF8'
LC_COLLATE 'pt_BR.UTF-8'
LC_CTYPE 'pt_BR.UTF-8'
ALLOW_CONNECTIONS true;

--Comando para se conectar no banco de dados ''uvv'' como ''pedro_luis''

\c "dbname=uvv user=pedro_luis password=777"


-- Criação do esquema "lojas"

CREATE SCHEMA lojas;
SET SEARCH_PATH TO lojas, "$user", public;


-- Concessão de permissões ao usuário "pedro_luis"

GRANT ALL PRIVILEGES ON SCHEMA lojas TO pedro_luis;




--Criação da tabela Produtos


CREATE TABLE Produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produto_id PRIMARY KEY (produto_id)
);

COMMENT ON TABLE produtos IS 'Tabela que armazenda as informações dos produtos disponibilizados.';
COMMENT ON COLUMN produtos.produto_id IS 'Identificador único do Produto.';
COMMENT ON COLUMN produtos.nome IS 'Nome do produto registrado.';
COMMENT ON COLUMN produtos.detalhes IS 'Detalhes sobre o produto.';
COMMENT ON COLUMN produtos.imagem IS 'Imagens do produto';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'Identificação do tipo de formato do arquivo.';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'Arquivo da imagem do produto.';
COMMENT ON COLUMN produtos.imagem_charset IS 'Charset da imagem.';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'Data da última atualização da imagem do produto.';

--Criação da tabela Lojas

CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT loja_id PRIMARY KEY (loja_id)
);

COMMENT ON TABLE lojas IS 'Tabela responsável por armazenar as informações das lojas registradas.';
COMMENT ON COLUMN lojas.loja_id IS 'Identificador da loja.';
COMMENT ON COLUMN lojas.nome IS 'Nome da loja.';
COMMENT ON COLUMN lojas.endereco_web IS 'Endereço da Loja Online.';
COMMENT ON COLUMN lojas.endereco_fisico IS 'Endereço físico da loja.';
COMMENT ON COLUMN lojas.longitude IS 'Longitude loja.';
COMMENT ON COLUMN lojas.logo IS 'Logo da loja.';
COMMENT ON COLUMN lojas.logo_mime_type IS 'Identificação do tipo de formado do arquivo.';
COMMENT ON COLUMN lojas.logo_arquivo IS 'Arquivo da logo.';
COMMENT ON COLUMN lojas.logo_charset IS 'Charset da logo.';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'Data da última atualização da imagem do produto.';

--Criação da tabela Estoques

CREATE TABLE Estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);

COMMENT ON TABLE estoques IS 'Tabela responsável por armazenar as informações do estoque.';
COMMENT ON COLUMN estoques.estoque_id IS 'Identificador do estoque.';
COMMENT ON COLUMN estoques.loja_id IS 'Identificador da loja registrada.';
COMMENT ON COLUMN estoques.produto_id IS 'Identificador do produto.';
COMMENT ON COLUMN estoques.quantidade IS 'Quantidade de produtos em estoque.';

--Criação da tabela Clientes

CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT cliente_id PRIMARY KEY (cliente_id)
);

COMMENT ON TABLE clientes IS 'Tabela responsável por armazenar as informações dos Clientes.';
COMMENT ON COLUMN clientes.cliente_id IS 'Identificador do Cliente.';
COMMENT ON COLUMN clientes.email IS 'Email do Cliente.';
COMMENT ON COLUMN clientes.nome IS 'Nome do Cliente.';
COMMENT ON COLUMN clientes.telefone1 IS 'Número de telefone principal do cliente.';
COMMENT ON COLUMN clientes.telefone2 IS 'Número secundário de contato do cliente.';
COMMENT ON COLUMN clientes.telefone3 IS 'Número terciário de contato do cliente.';

--Criação da tabela Pedidos

CREATE TABLE Pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id)
);

COMMENT ON TABLE pedidos IS 'Tabela responsável por armazenar as informações dos pedidos.';
COMMENT ON COLUMN pedidos.pedido_id IS 'Identificador do pedido.';
COMMENT ON COLUMN pedidos.data_hora IS 'Data e hora do pedido realizado.';
COMMENT ON COLUMN pedidos.cliente_id IS 'Identificador do Cliente.';
COMMENT ON COLUMN pedidos.status IS 'Status do pedido.';
COMMENT ON COLUMN pedidos.loja_id IS 'Identificador da loja registrada.';

--Criação da tabela Envios

CREATE TABLE Envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id PRIMARY KEY (envio_id)
);

COMMENT ON TABLE envios IS 'Tabela responsável por armazenar as informações dos envios';
COMMENT ON COLUMN envios.envio_id IS 'Identificador do envio.';
COMMENT ON COLUMN envios.loja_id IS 'Identificador da loja registrada.';
COMMENT ON COLUMN envios.cliente_id IS 'Identificador do cliente.';
COMMENT ON COLUMN envios.endereco_entrega IS 'Endereço de entrega.';
COMMENT ON COLUMN envios.status IS 'Status do envio.';

--Criação da tabela dos Itens Pedidos

CREATE TABLE Pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pedido_id_ PRIMARY KEY (pedido_id, produto_id)
);

COMMENT ON TABLE pedidos_itens IS 'Tabela responsável por armazenar as informações dos itens pedidos.';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'Identificador do pedido.';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'Identificador do produto.';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'Número de linha dos itens do pedido.';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'Preço unitário do item pedido.';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'Quantidade de itens no pedido.';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'Identificador do envio.';

--Primary Key's e Foreign Key's

ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Constraints de checagem (Verificação do status)


ALTER TABLE Pedidos add constraint status_pedidos 
CHECK (status in ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

ALTER TABLE Envios add constraint envios_status
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

ALTER TABLE Lojas add constraint endereco_check
CHECK ((endereco_fisico IS NOT NULL AND endereco_web IS NULL) OR
       (endereco_fisico IS NULL AND endereco_web IS NOT NULL));

-- Constraint de checagem para garantir que o campo "X" na tabela "Y" seja um valor positivo ou igual a zero.

ALTER TABLE Produtos
add constraint check_preco
CHECK (preco_unitario >= 0);

ALTER TABLE Estoques
add constraint check_quantidade_estoque
CHECK (quantidade >= 0);

ALTER TABLE Pedidos_Itens
add constraint check_quantidade_pedidos
CHECK (quantidade >= 0);

ALTER TABLE Pedidos_Itens
add constraint check_preco_unitario
CHECK (preco_unitario >= 0);


