CREATE DATABASE dbterapy;

-- CODE  

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
  id_usuario integer
);

CREATE TABLE psicologos (
  id_psicologo serial PRIMARY KEY,
  id_usuario integer,
  crp integer UNIQUE NOT NULL
);

CREATE TABLE emocoes (
  id_emocao serial PRIMARY KEY,
  nome varchar(45),
  descricao varchar(255)
);

CREATE TABLE medicamentos (
  id_medicamento serial PRIMARY KEY,
  nome varchar(45),
  descricao varchar(255)
);

CREATE TABLE paciente_emocao (
  id_paciente_emocao serial PRIMARY KEY,
  id_paciente integer,
  id_emocao integer,
  hora timestamp 
);

CREATE TABLE paciente_medicamento (
  id_paciente_medicamento serial PRIMARY KEY,
  id_paciente integer,
  id_medicamento integer,
  prescricao varchar(255)
);

CREATE TABLE psicologo_notas (
	id_nota serial PRIMARY KEY,
	id_psicologo integer,
	id_paciente integer,
	anotacao text,
	data_criacao timestamp
)

INSERT INTO usuarios (papel, primeiro_nome, sobrenome, data_nascimento, email, telefone, senha) VALUES 
  ('admin', 'Raul', 'Silva', '2000-05-15', 'raul@gmail.com', '(11) 91234-5678', 'raul123'),
  ('admin', 'Lucas', 'Ferreira', '2001-08-22', 'lucas@gmail.com', '(21) 99876-5432', 'lucas123'),
  ('admin', 'Gabriel', 'Souza', '1999-12-05', 'gabriel@gmail.com', '(32) 98765-4321', 'gabriel123'),
  ('paciente', 'Fabiano', 'Zuin', '1999-12-05', 'fabiano@gmail.com', '(33) 98765-4321', 'fabiano123'),
  ('psicologo', 'Tânia', 'Teixeira', '1999-12-05', 'tania@gmail.com', '(34) 98765-4321', 'tania123');

INSERT INTO pacientes (id_usuario) VALUES (4);

INSERT INTO psicologos (id_usuario, crp) VALUES (5, 0612345);

INSERT INTO psicologo_notas (id_psicologo, id_paciente, anotacao, data_criacao) values (1, 1, 'Paciente chegou no horário, aparentando leve cansaço.', '2025-07-18 14:30:00');

ALTER TABLE pacientes ADD FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario);
ALTER TABLE psicologos ADD FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario);
ALTER TABLE paciente_emocao ADD FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente);
ALTER TABLE paciente_emocao ADD FOREIGN KEY (id_emocao) REFERENCES emocoes (id_emocao);
ALTER TABLE paciente_medicamento ADD FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente);
ALTER TABLE paciente_medicamento ADD FOREIGN KEY (id_medicamento) REFERENCES medicamentos (id_medicamento);
ALTER TABLE psicologo_notas ADD FOREIGN KEY (id_psicologo) REFERENCES psicologos (id_psicologo);
ALTER TABLE psicologo_notas ADD FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente);

-- select * from usuarios;
-- select * from psicologos;
-- select * from pacientes;
-- select * from paciente_medicamento;
-- select * from paciente_emocao;
-- select * from psicologo_notas;

-- DROPS
drop table paciente_medicamento;
drop table paciente_emocao;
drop table pacientes;
drop table psicologos;
drop table usuarios;
drop type papel_enum;
drop table emocoes;
drop table medicamentos;
drop database dbterapy;
