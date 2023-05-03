/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
 id  INT GENERATED ALWAYS AS IDENTITY,
 name varchar(50)  NOT NULL,
 date_of_birth date NOT NULL,
escape_attempts INT NOT NULL,
neutered bool NOT NULL,
 weight_kg float NOT NULL,
 PRIMARY KEY(id));

ALTER TABLE animals
ADD species varchar(150);