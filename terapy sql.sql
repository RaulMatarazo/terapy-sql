CREATE DATABASE dbterapy;

CREATE TYPE papel_enum AS ENUM ('psicologo', 'paciente', 'admin');

CREATE TABLE usuarios (
  id_usuario serial PRIMARY KEY,
  papel papel_enum NOT NULL,
  primeiro_nome varchar(45) NOT NULL,
  sobrenome varchar(45) NOT NULL,
  data_nascimento date NOT NULL,
  email varchar(60) UNIQUE NOT NULL,
  telefone varchar(20) UNIQUE NOT NULL,
  senha varchar(100) NOT NULL
);

CREATE TABLE pacientes (
  id_paciente serial PRIMARY KEY,
  id_usuario integer,
  id_psicologo integer
);

CREATE TABLE psicologos (
  id_psicologo serial PRIMARY KEY,
  id_usuario integer,
  crp integer UNIQUE NOT NULL
);

CREATE TABLE psicologo_notas (
	id_nota serial PRIMARY KEY,
	id_psicologo integer,
	id_paciente integer,
	anotacao text,
	data_criacao timestamp
);

CREATE TABLE medicamentos (
  id_medicamento serial PRIMARY KEY,
  nome varchar(45),
  descricao varchar(255)
);

CREATE TABLE paciente_medicamento (
  id_paciente_medicamento serial PRIMARY KEY,
  id_paciente integer,
  id_medicamento integer,
  prescricao varchar(255)
);

CREATE TABLE paciente_emocao (
  id_paciente_emocao serial PRIMARY KEY,
  id_paciente integer,
  id_emocao integer,
  qualidade boolean,
  id_intensidade integer,
  descricao text, 
  atividade text,
  hora timestamp 
);

CREATE TABLE emocoes (
  id_emocao serial PRIMARY KEY,
  nome varchar(45),
  descricao varchar(255)
);

CREATE TABLE emocoes_exemplos (
	id_emocao_exemplo serial PRIMARY KEY,
	id_emocao integer,
	nome varchar(45)
);

CREATE TABLE emocoes_intensidade (
	id_emocao_intensidade serial PRIMARY KEY,
	intensidade integer
);

INSERT INTO usuarios (papel, primeiro_nome, sobrenome, data_nascimento, email, telefone, senha) VALUES 
  ('admin', 'Raul', 'Silva', '2000-05-15', 'raul@gmail.com', '(11) 91234-5678', 'raul123'),
  ('admin', 'Lucas', 'Ferreira', '2001-08-22', 'lucas@gmail.com', '(21) 99876-5432', 'lucas123'),
  ('admin', 'Gabriel', 'Souza', '1999-12-05', 'gabriel@gmail.com', '(32) 98765-4321', 'gabriel123'),
  ('paciente', 'Fabiano', 'Zuin', '1999-12-05', 'fabiano@gmail.com', '(33) 98765-4321', 'fabiano123'),
  ('psicologo', 'Tânia', 'Teixeira', '1999-12-05', 'tania@gmail.com', '(34) 98765-4321', 'tania123');

INSERT INTO pacientes (id_usuario) VALUES (4);

INSERT INTO psicologos (id_usuario, crp) VALUES (5, 0612345);

INSERT INTO psicologo_notas (id_psicologo, id_paciente, anotacao, data_criacao) values (1, 1, 'Paciente chegou no horário, aparentando leve cansaço.', '2025-07-18 14:30:00');

INSERT INTO emocoes (nome, descricao) VALUES
('Alegria', 'Sentimento de prazer, entusiasmo e satisfação'),
('Surpresa', 'Reação emocional a algo inesperado ou inesperadamente positivo/negativo'),
('Tristeza', 'Sentimento de pesar, melancolia ou desapontamento'),
('Neutro', 'Estado emocional equilibrado, sem sentimentos fortes predominantes'),
('Repugnância', 'Sentimento de aversão ou desgosto intenso diante de algo desagradável'),
('Raiva', 'Emoção intensa de irritação ou indignação diante de injustiças ou frustrações'),
('Medo', 'Sentimento de apreensão ou ansiedade diante de perigo ou ameaça');

INSERT INTO emocoes_exemplos (id_emocao, nome) VALUES (1, 'bem-humorado'), (1, 'excitado'), (1, 'contente'), (1, 'satisfeito'), (1, 'feliz'), (1, 'extasiado'), (1, 'eufórico'), (1, 'prazeroso'), (1, 'animado'), (1, 'sereno'),
(2, 'admirado'), (2, 'perplexo'), (2, 'embasbacado'), (2, 'atônito'), (2, 'chocado'), (2, 'pasmo'), (2, 'maravilhado'), (2, 'abobado'), (2, 'desnorteado'), (2, 'incrédulo'), (2, 'confuso'), (2, 'estupefeto'),
(3, 'entediado'), (3, 'decepcionado'), (3, 'depressivo'), (3, 'descontente'), (3, 'infeliz'), (3, 'acanhado'), (3, 'abalado'), (3, 'aborrecido'), (3, 'desanimado'), (3, 'moribundo'), (3, 'consternado'), (3, 'ignorado'),
(4, 'calma'), (4, 'serenidade'),(4, 'indeferença'),(4, 'atenção plena'),(4, 'estabilidade'),(4, 'objetividade'),
(5, 'nojo'),(5, 'incompatível'),(5, 'desdém'),(5, 'aversão'),(5, 'rejeição'),(5, 'desprezo'),(5, 'preconceituoso'),(5, 'vergonha'),
(6, 'nervoso'),(6, 'magoado'),(6, 'irritado'),(6, 'furioso'),(6, 'descontrolado'),(6, 'arrependido'),(6, 'selvagem'),(6, 'rancoroso'),(6, 'enfesado'),(6, 'irado'),(6, 'ódio'),
(7, 'apreensivo'),(7, 'aterrorizado'),(7, 'espantado'),(7, 'tremor'),(7, 'pânico'),(7, 'receoso'),(7, 'arrepiado'),(7, 'aflito'),(7, 'assustado'),(7, 'temeroso'),(7, 'desesperado'),(7, 'apavorado');

INSERT INTO emocoes_intensidade (intensidade) VALUES (-3),(-2), (-1), (0), (1), (2), (3);

ALTER TABLE pacientes ADD FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario);
ALTER TABLE psicologos ADD FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario);
ALTER TABLE pacientes ADD FOREIGN KEY (id_psicologo) REFERENCES psicologos (id_psicologo);
ALTER TABLE paciente_emocao ADD FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente);
ALTER TABLE paciente_emocao ADD FOREIGN KEY (id_emocao) REFERENCES emocoes (id_emocao);
ALTER TABLE paciente_emocao ADD FOREIGN KEY (id_intensidade) REFERENCES emocoes_intensidade(id_emocao_intensidade);
ALTER TABLE paciente_medicamento ADD FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente);
ALTER TABLE paciente_medicamento ADD FOREIGN KEY (id_medicamento) REFERENCES medicamentos (id_medicamento);
ALTER TABLE psicologo_notas ADD FOREIGN KEY (id_psicologo) REFERENCES psicologos (id_psicologo);
ALTER TABLE psicologo_notas ADD FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente);
ALTER TABLE emocoes_exemplos ADD FOREIGN KEY (id_emocao) REFERENCES emocoes (id_emocao);

-- select * from usuarios;
-- select * from psicologos;
-- select * from pacientes;
-- select * from paciente_medicamento;
-- select * from paciente_emocao;
-- select * from psicologo_notas;
-- select * from emocoes;
-- select * from emocoes_exemplos
-- select * from emocoes_intensidade;

-- DROPS
-- drop table paciente_medicamento;
-- drop table paciente_emocao;
-- drop table pacientes;
-- drop table psicologos;
-- drop table usuarios;
-- drop type papel_enum;
-- drop table emocoes;
-- drop table medicamentos;
-- drop database dbterapy;