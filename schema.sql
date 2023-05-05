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


CREATE TABLE owners (
   id INT GENERATED ALWAYS AS IDENTITY,
   full_name VARCHAR(150) NOT NULL, 
   age INT,
   PRIMARY KEY (id)
);


CREATE TABLE species (
   id INT GENERATED ALWAYS AS IDENTITY,
   name VARCHAR(150) NOT NULL, 
   PRIMARY KEY (id)
);

 ALTER TABLE animals DROP COLUMN species;

 ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id);

 ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners(id);