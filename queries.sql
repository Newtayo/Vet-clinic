/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals  WHERE name LIKE '%mon%';
SELECT name FROM animals  WHERE date_of_birth BETWEEN '2016-01-01' AND  '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name,escape_attempts FROM animals WHERE  weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals  WHERE weight_kg >=10.4 AND  weight_kg <=17.3;


BEGIN;
UPDATE animals
SET species = 'unspecified'
ROLLBACK;



BEGIN;
UPDATE animals 
SET species = 'digimon'
WHERE name ILIKE '%mon%';


UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL ;

COMMIT;


BEGIN;
DELETE FROM animals;
ROLLBACK;


BEGIN;
DELETE FROM animals
WHERE
date_of_birth > '2022-01-01';

SAVEPOINT first;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO first;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT; 

-- QUERY

SELECT COUNT(*) FROM animals;


SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, avg(escape_attempts) from animals WHERE  EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000 GROUP BY species;


SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id 
WHERE full_name = 'Melody Pond';

SELECT name FROM animals JOIN species ON animals.species_id = species.id 
WHERE species.id = 1;

SELECT * FROM owners LEFT JOIN animals ON animals.owner_id = owners.id;

SELECT species.name, COUNT(species_id) FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name ='Jennifer Orwell';

SELECT * FROM animals JOIN owners ON animals.owner_id = owners.id WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

SELECT owners.full_name, COUNT(name)  FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY COUNT (name) DESC LIMIT 1;

-- The last animal seen by William Tatcher

SELECT animals.name, vets.name, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON visits.vet_id = vets.id WHERE vets.name ='William Tatcher' ORDER BY visits.date_of_visit DESC  LIMIT 1;

-- The  number of different animals seen by Stephanie Mendez 
SELECT COUNT(*) FROM animals JOIN visits ON animals.id = visits.animal_id JOIN
vets ON visits.vet_id = vets.id WHERE vets.name LIKE 'Stephanie Mendez';

-- List of all vets and their specialties, including vets with no specialties
SELECT vets.name, species.name FROM vets FULL JOIN specializations ON vets.id = specializations.vet_id FULL JOIN
species ON specializations.species_id = species.id;

-- List of all animals that visited Stephanie Mendez between April 1st and August 30th, 2020

SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id JOIN
vets ON visits.vet_id = vets.id WHERE vets.name LIKE 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- The  animal has the most visits to vets?

SELECT animals.name, COUNT (date_of_visit) FROM animals JOIN visits ON animals.id = visits.animal_id JOIN
vets ON visits.vet_id = vets.id GROUP BY animals.name ORDER BY COUNT DESC LIMIT 1;


-- Maisy Smith's first visit

SELECT animals.name, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id JOIN
vets ON visits.vet_id = vets.id WHERE vets.name LIKE 'Maisy Smith' ORDER BY visits.date_of_visit LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT animals.name, vets.name, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON visits.vet_id = vets.id  ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM animals JOIN visits ON animals.id = visits.animal_id JOIN
vets ON visits.vet_id = vets.id FULL JOIN specializations ON vets.id = specializations.vet_id FULL JOIN
species ON specializations.species_id = species.id WHERE specializations.species_id IS NULL;


-- specialty should Maisy Smith consider getting

SELECT species.name, COUNT(*) FROM animals JOIN visits ON animals.id = visits.animal_id JOIN
vets ON visits.vet_id = vets.id JOIN species on animals.species_id = species.id GROUP BY species.name;
