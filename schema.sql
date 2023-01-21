/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT PRIMARY KEY ,
    name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INTEGER NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL(10, 2) NOT NULL
);

ALTER TABLE animals ADD COLUMN species VARCHAR(50); 

/* New Tables */

CREATE TABLE owners(
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    age INTEGER NOT NULL
);

CREATE TABLE species(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

/* Modify Table */

ALTER TABLE animals ADD PRIMARY KEY id;
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD species_id INTEGER REFERENCES species(id);
ALTER TABLE animals ADD owner_id INTEGER REFERENCES owners(id);

/* Vets Table */

CREATE TABLE vets(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INTEGER,
    data_of_graduation DATE
);

/* SPECIALIZATION JOIN TABLE */

CREATE TABLE specialization(
    id SERIAL PRIMARY KEY,
    species_id INTEGER NOT NULL,
    vet_id INTEGER NOT NULL,
    CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species(id),
    CONSTRAINT fk_vet_id FOREIGN KEY (vet_id) REFERENCES vets(id)
);

/* VISITS JOIN TABLE */

CREATE TABLE visits(
    id SERIAL PRIMARY KEY,
    animal_id INTEGER NOT NULL,
    vet_id INTEGER NOT NULL,
    visit_date Date
    CONSTRAINT fk_animal_id FOREIGN KEY (animal_id) REFERENCES animals(id),
    CONSTRAINT fk_vet_id FOREIGN KEY (vet_id) REFERENCES vets(id)
);