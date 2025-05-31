CREATE DATABASE dbterapy;

-- CODE  

CREATE TYPE papel_enum AS ENUM ('psicologo', 'paciente', 'admin');

CREATE TABLE usuarios (
  id_usuario serial PRIMARY KEY,
  papel papel_enum not null,
  primeiro_nome varchar(45) not null,
  sobrenome varchar(45) not null,
  data_nascimento date not null,
  email varchar(60) not null,
  telefone varchar(20) not null,
  senha varchar(100) not null
);

INSERT INTO usuarios (papel, primeiro_nome, sobrenome, data_nascimento, email, telefone, senha) VALUES 
  ('admin', 'Raul', 'Silva', '2000-05-15', 'raul@gmail.com', '(11) 91234-5678', 'raul123'),
  ('admin', 'Lucas', 'Ferreira', '2001-08-22', 'lucas@gmail.com', '(21) 99876-5432', 'lucas123'),
  ('admin', 'Gabriel', 'Souza', '1999-12-05', 'gabriel@gmail.com', '(31) 98765-4321', 'gabriel123'),
  ('paciente', 'Fabiano', 'Zuin', '1999-12-05', 'fabiano@gmail.com', '(31) 98765-4321', 'fabiano123'),
  ('psicologo', 'Tânia', 'Teixeira', '1999-12-05', 'tania@gmail.com', '(31) 98765-4321', 'tania123');

SELECT * FROM usuarios


CREATE TABLE pacientes (
  id_paciente serial PRIMARY KEY,
  id_usuario integer
);

insert into pacientes (id_usuario) values (4)

ALTER TABLE pacientes ADD FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario);

CREATE TABLE psicologos (
  id_psicologo serial PRIMARY KEY,
  id_usuario integer,
  crp integer
);

insert into psicologos (id_usuario, crp) values (5, 0612345)

ALTER TABLE psicologos ADD FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario);

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

ALTER TABLE paciente_emocao ADD FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente);
ALTER TABLE paciente_emocao ADD FOREIGN KEY (id_emocao) REFERENCES emocoes (id_emocao);

CREATE TABLE paciente_medicamento (
  id_paciente_medicamento serial PRIMARY KEY,
  id_paciente integer,
  id_medicamento integer,
  prescricao varchar(255)
);

ALTER TABLE paciente_medicamento ADD FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente);
ALTER TABLE paciente_medicamento ADD FOREIGN KEY (id_medicamento) REFERENCES medicamentos (id_medicamento);

-- DROPS

drop table paciente_medicamento;
drop table paciente_emocao;
drop table pacientes;
drop table psicologos;
drop table usuarios;
drop type papel_enum;
drop table emocoes;
drop table medicamentos;