--||||||||||||||||||||||||||||||||||||||||||||--
----------------- Livrable 2 -------------------
--||||||||||||||||||||||||||||||||||||||||||||--

CREATE TABLE Villes
(
    nom_ville   VARCHAR(255) NOT NULL,
    num_depart  INTEGER      NOT NULL,
    nb_habitant INTEGER      NOT NULL,
    CONSTRAINT pk_nom_ville PRIMARY KEY (nom_ville),
    CONSTRAINT nb_habitant CHECK (nb_habitant > 0),
    CONSTRAINT num_depart CHECK (0 < num_depart AND num_depart < 990)
);

CREATE TABLE Stades
(
    num_stade INTEGER      NOT NULL,
    nom       VARCHAR(255) NOT NULL,
    adresse   VARCHAR(255) NOT NULL,
    capacite  INTEGER      NOT NULL,
    ville     VARCHAR(255) NOT NULL,
    CONSTRAINT pk_num_stade PRIMARY KEY (num_stade),
    CONSTRAINT fk_ville_s FOREIGN KEY (ville) REFERENCES Villes (nom_ville),
    CONSTRAINT capacite CHECK (capacite > 0)
);

CREATE TABLE Epreuves
(
    num_epreuve INTEGER      NOT NULL,
    sport       VARCHAR(255) NOT NULL,
    cat_e       VARCHAR(255) NOT NULL,
    date_e      DATE         NOT NULL,
    num_stade   INTEGER      NOT NULL,
    CONSTRAINT pk_num_epreuve PRIMARY KEY (num_epreuve),
    CONSTRAINT fk_stade FOREIGN KEY (num_stade) REFERENCES Stades (num_stade),
    CONSTRAINT cat_e CHECK (cat_e = 'Débutant' OR cat_e = 'Intermédiaire' OR cat_e = 'Professionnel')
);

CREATE TABLE Competiteurs
(
    num_competiteur  INTEGER      NOT NULL,
    nom              VARCHAR(255) NOT NULL,
    prenom           VARCHAR(255) NOT NULL,
    date_inscription DATE DEFAULT CURRENT_DATE,
    date_naissance   DATE         NOT NULL,
    pays_origine     VARCHAR(255) NOT NULL,
    nom_ville        VARCHAR(255) NOT NULL,
    CONSTRAINT pk_num_competiteur PRIMARY KEY (num_competiteur),
    CONSTRAINT fk_ville FOREIGN KEY (nom_ville) REFERENCES Villes (nom_ville),
    CONSTRAINT date_naissance CHECK (date_inscription > date_naissance)
);

CREATE TABLE Visiteurs
(
    num_visiteur INTEGER      NOT NULL,
    nom          VARCHAR(255) NOT NULL,
    prenom       VARCHAR(255) NOT NULL,
    ville        VARCHAR(255) NOT NULL,
    CONSTRAINT pk_num_visiteur_v PRIMARY KEY (num_visiteur),
    CONSTRAINT fk_ville_v FOREIGN KEY (ville) REFERENCES Villes (nom_ville)
);

CREATE TABLE Place
(
    num_visiteur INTEGER          NOT NULL,
    num_stade    INTEGER          NOT NULL,
    num_place    INTEGER          NOT NULL,
    prix_place   DOUBLE PRECISION NOT NULL,
    date_achat   DATE             NOT NULL,
    CONSTRAINT fk_num_visiteur FOREIGN KEY (num_visiteur) REFERENCES Visiteurs (num_visiteur),
    CONSTRAINT fk_num_stade FOREIGN KEY (num_stade) REFERENCES Stades (num_stade),
    CONSTRAINT prix_place CHECK (prix_place > 0.0),
    CONSTRAINT num_place CHECK (num_place > 0)
);

CREATE TABLE Recompense
(
    num_competiteur INTEGER     NOT NULL,
    num_epreuve     INTEGER     NOT NULL,
    rang            VARCHAR(10) NOT NULL,
    CONSTRAINT fk_num_competiteur FOREIGN KEY (num_competiteur) REFERENCES Competiteurs (num_competiteur),
    CONSTRAINT fk_num_epreuve FOREIGN KEY (num_epreuve) REFERENCES Epreuves (num_epreuve),
    CONSTRAINT rang CHECK (rang = 'Or' OR rang = 'Argent' OR rang = 'Bronze')
);

CREATE TABLE Participe
(
    num_competiteur INTEGER NOT NULL,
    num_epreuve     INTEGER NOT NULL,
    CONSTRAINT fk_num_competiteur_participe FOREIGN KEY (num_competiteur) REFERENCES Competiteurs (num_competiteur),
    CONSTRAINT fk_num_epreuve_participe FOREIGN KEY (num_epreuve) REFERENCES Epreuves (num_epreuve)
);

--||||||||||||||||||||||||||||||||||||||||||||--
----------------- Livrable 3 -------------------
--||||||||||||||||||||||||||||||||||||||||||||--


CREATE TABLE Date_a
(
    date_a DATE,
    PRIMARY KEY (date_a)
);

CREATE TABLE Date_p
(
    date_p DATE,
    PRIMARY KEY (date_p)
);

ALTER TABLE Place
    ADD CONSTRAINT fk_date_achat FOREIGN KEY (date_achat) REFERENCES Date_a (date_a);
ALTER TABLE Participe
    ADD date_p DATE;
ALTER TABLE Participe
    ADD CONSTRAINT fk_date_p_participe FOREIGN KEY (date_p) REFERENCES Date_p (date_p);

INSERT INTO Date_p (date_p)
VALUES ('01-01-2018');
INSERT INTO Date_p (date_p)
VALUES ('12-12-2020');
INSERT INTO Date_p (date_p)
VALUES ('14-02-2019');
INSERT INTO Date_p (date_p)
VALUES ('23-05-2018');
INSERT INTO Date_p (date_p)
VALUES ('11-04-2017');
INSERT INTO Date_p (date_p)
VALUES ('22-12-2020');
INSERT INTO Date_p (date_p)
VALUES ('07-08-2019');
INSERT INTO Date_p (date_p)
VALUES ('30-07-2018');

INSERT INTO Date_a
VALUES ('21-03-2016');
INSERT INTO Date_a
VALUES ('18-11-2019');
INSERT INTO Date_a
VALUES ('07-04-2021');
INSERT INTO Date_a
VALUES ('23-05-2020');
INSERT INTO Date_a
VALUES ('07-01-2023');
INSERT INTO Date_a
VALUES ('08-10-2019');
INSERT INTO Date_a
VALUES ('11-03-2018');
INSERT INTO Date_a
VALUES ('14-10-2017');
