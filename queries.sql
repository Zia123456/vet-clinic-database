/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* Transaction */
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;

/* Tansaction */
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT species FROM animals;

/* Tansaction */
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/* Tansaction */
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT first_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO first_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/* Queries */
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, COUNT(*) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg) as min_weight, MAX(weight_kg) as max_weight FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/* Queries uing JOIN */
SELECT * FROM animals JOIN owners ON animals.owner_id = owner_id WHERE owners.full_name = 'Melody Pond';
SELECT * FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;
SELECT sp.name, COUNT(an.species_id) FROM animals an JOIN species sp ON an.species_id = sp.id GROUP BY sp.name;
SELECT an.* FROM animals an JOIN species sp ON an.species_id = sp.id JOIN owners ow ON an.owner_id = ow.id WHERE sp.name = 'Digimon' AND ow.full_name = 'Jennifer Orwell';
SELECT an.* FROM animals an JOIN owners ow ON an.owner_id = ow.id WHERE ow.full_name = 'Dean Winchester' AND an.escape_attempts = 0;
SELECT ow.full_name, COUNT(an.owner_id) as count FROM animals an JOIN owners ow ON an.owner_id = ow.id GROUP BY ow.full_name ORDER BY count DESC LIMIT 1; 

/* Queries for joining tables */

SELECT an.name FROM animals an JOIN visits vi ON an.id = vi.animal_id JOIN vets ve ON vi.vet_id = ve.id WHERE ve.name = 'William Tatcher' ORDER BY vi.visit_date DESC LIMIT 1;
SELECT COUNT(DISTINCT an.id) FROM animals an JOIN visits vi ON an.id = vi.animal_id JOIN vets ve ON vi.vet_id = ve.id WHERE ve.name = 'Stephanie Mendez';
SELECT ve.name, sp.name FROM vets ve LEFT JOIN specialization spe ON ve.id = spe.vet_id LEFT JOIN species sp ON spe.species_id = sp.id;
SELECT an.name FROM animals an JOIN visits vi ON an.id = vi.animal_id JOIN vets ve ON vi.vet_id = ve.id WHERE ve.name = 'Stephanie Mendez' AND vi.visit_date BETWEEN '2020-04-01' AND '2020-08-30';
SELECT an.name, COUNT(vi.animal_id) AS visits FROM animals an JOIN visits vi ON an.id = vi.animal_id GROUP BY an.name ORDER BY visits DESC LIMIT 1;
SELECT an.name FROM animals an JOIN visits vi ON an.id = vi.animal_id JOIN vets ve ON vi.vet_id = ve.id WHERE ve.name = 'Maisy Smith' ORDER BY vi.visit_date ASC LIMIT 1;
SELECT an.name, ve.name, vi.visit_date FROM animals an JOIN visits vi ON an.id = vi.animal_id JOIN vets ve ON vi.vet_id = ve.id ORDER BY vi.visit_date DESC LIMIT 1;
SELECT COUNT(*) FROM visits WHERE NOT EXISTS (SELECT 1 FROM specialization WHERE species_id =(SELECT species_id FROM animals WHERE id = visits.animal_id) AND specialization.vet_id = visits.vet_id);
WITH animal_species AS (SELECT species_id, COUNT(species_id) as count FROM visits JOIN animals ON animals.id = visits.animal_id WHERE vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith') GROUP BY species_id ORDER BY count DESC LIMIT 1) SELECT name FROM species JOIN animal_species ON species_id = animal_species.species_id;