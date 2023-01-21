/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts )
VALUES ('Agumon', '2020-02-03', 10.23, true, 0);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts )
VALUES ('Gabumon', '2018-11-15', 8, true, 2);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts )
VALUES ('Pikachu', '2021-01-07', 15.04, false, 1);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts )
VALUES ('Devimon', '2017-05-12', 11, true, 0);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts )
VALUES ('Charmander', '2020-02-08', -11, false, 0);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Plantmon', '2021-11-15', -5.7, true, 2);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Squirtle', '1993-04-02', -12.13, false, 3);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Angemon', '2005-06-12', -45, true, 1);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Boarmon', '2005-06-07', 20.4, true, 7);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Blossom', '1998-10-13', 17, true, 3);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Ditto', '2022-05-14', 22, true, 4);

/* Populating owner table with data */

INSERT INTO owners(full_name, age) VALUES('Sam Smith', 34);
INSERT INTO owners(full_name, age) VALUES('Jennifer Orwell', 19);
INSERT INTO owners(full_name, age) VALUES('Bob', 45);
INSERT INTO owners(full_name, age) VALUES('Melody Pond', 77);
INSERT INTO owners(full_name, age) VALUES('Dean Winchester', 14);
INSERT INTO owners(full_name, age) VALUES('Jodie Whittaker', 38);

/* Populating species table with data */

INSERT INTO species(name) VALUES('Pokemon');
INSERT INTO species(name) VALUES('Digimon');

/* Modify animals table to include the species_id value */

UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE species_id IS NULL;

/* Modify animals table to include the owner_id value */

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name = 'Pikachu';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');

/* Populating Vets table with data */

INSERT INTO vets (name, age, data_of_graduation) VALUES ('William Tatcher', 45, '2000-04-23'),('Maisy Smith', 26, '2019-01-17'),('Stephanie Mendez',64, '1981-05-04'),('Jack Harkness', 38, '2008-06-08');
INSERT INTO specialization (species_id, vet_id) SELECT sp.id, ve.id FROM species sp, vets ve WHERE sp.name = 'Pokemon' AND ve.name = 'William Tatcher';
INSERT INTO specialization (species_id, vet_id) SELECT sp.id, ve.id FROM species sp, vets ve WHERE (sp.name = 'Digimon' OR sp.name = 'Pokemon') AND ve.name = 'Stephanie Mendez';
INSERT INTO specialization (species_id, vet_id) SELECT sp.id, ve.id FROM species sp, vets ve WHERE sp.name = 'Digimon' AND ve.name = 'Jack Harkness';

/* Populating visits table with data */ 

INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2020-05-24' FROM animals an, vets ve WHERE an.name = 'Agumon' AND ve.name = 'William Tatcher';
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2020-07-22' FROM animals an, vets ve WHERE an.name = 'Agumon' And ve.name = 'Stephanie Mendez';
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2021-02-02' FROM animals an, vets ve WHERE an.name = 'Gabumon' And ve.name = 'Jack Harkness';
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2020-01-05' FROM animals an, vets ve WHERE an.name = 'Pikachu' And ve.name = 'Maisy Smith';
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2020-03-08' FROM animals an, vets ve WHERE an.name = 'Pikachu' And ve.name = 'Maisy Smith';
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2020-05-14' FROM animals an, vets ve WHERE an.name = 'Pikachu' And ve.name = 'Maisy Smith';
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2021-05-04' FROM animals an, vets ve WHERE an.name = 'Devimon' And ve.name = 'Stephane Mendez';
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2021-02-24' FROM animals an, vets ve WHERE an.name = 'Charmander' And ve.name = 'Jack Harkness';
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2019-12-21' FROM animals an, vets ve WHERE an.name = 'Plantmon' And ve.name = 'Maisy Smith';
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2020-08-10' FROM animals an, vets ve WHERE an.name = 'Plantmon' And ve.name = 'William Tatcher';
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2021-04-07' FROM animals an, vets ve WHERE an.name = 'Plantmon' And ve.name = 'Maisy Smith';
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2019-09-29' FROM animals an, vets ve WHERE an.name = 'Squirtle' And ve.name = 'Stephanie Mendez';
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2020-10-03' FROM animals an, vets ve WHERE an.name = 'Angemon' And ve.name = 'Jack Harkness';
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2020-11-04' FROM animals an, vets ve WHERE an.name = 'Angemon' And ve.name = 'Jack Harkness';
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2019-01-24' FROM animals an, vets ve WHERE an.name = 'Boarmon' And ve.name = 'Maisy Smith';
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2019-05-15' FROM animals an, vets ve WHERE an.name = 'Boarmon' And ve.name = 'Maisy Smith';
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2020-02-27' FROM animals an, vets ve WHERE an.name = 'Boarmon' And ve.name = 'Maisy Smith';
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2020-08-03' FROM animals an, vets ve WHERE an.name = 'Boarmon' And ve.name = 'Maisy Smith';
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2020-05-24' FROM animals an, vets ve WHERE an.name = 'Blossom' And ve.name = 'Stephanie Mendez';
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT an.id, ve.id, '2021-01-11' FROM animals an, vets ve WHERE an.name = 'Blossom' And ve.name = 'William Tatcher';