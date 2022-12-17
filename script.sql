--||||||||||||||||||||||||||||||||||||||||||||--
-------------Suppression des tables-------------
--||||||||||||||||||||||||||||||||||||||||||||--

DROP TABLE Participe;
DROP TABLE Recompense;
DROP TABLE Place;
DROP TABLE Visiteurs;
DROP TABLE Competiteurs;
DROP TABLE Epreuves;
DROP TABLE Stades;
DROP TABLE Villes;

--||||||||||||||||||||||||||||||||||||||||||||--
--------------Creation des tables---------------
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
    CONSTRAINT cat_e CHECK (cat_e='Débutant' OR cat_e='Intermédiaire' OR cat_e='Professionnel')
);


CREATE TABLE Competiteurs
(
    num_competiteur  INTEGER      NOT NULL,
    nom              VARCHAR(255) NOT NULL,
    prenom           VARCHAR(255) NOT NULL,
    date_inscription DATE         DEFAULT CURRENT_DATE,
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
--------------Insertion des tables--------------
--||||||||||||||||||||||||||||||||||||||||||||--

-- INSERT INTO Villes
INSERT INTO Villes (nom_ville, num_depart, nb_habitant)
VALUES ('Paris', 75, 1500);
INSERT INTO Villes
VALUES ('Londres', 702, 120);
INSERT INTO Villes
VALUES ('New York', 384, 4122);
INSERT INTO Villes
VALUES ('Tokyo', 659, 3423);
INSERT INTO Villes
VALUES ('Sydney', 304, 10);
INSERT INTO Villes
VALUES ('Rio de Janeiro', 213, 1234);
INSERT INTO Villes
VALUES ('Cape Town', 552, 12214);
INSERT INTO Villes
VALUES ('Moscou', 405, 1500);
INSERT INTO Villes
VALUES ('Pékin', 342, 3332);
INSERT INTO Villes
VALUES ('Mexico', 213, 2312);

-- INSERT INTO Competiteurs
INSERT INTO Competiteurs (num_competiteur, nom, prenom, date_inscription, date_naissance, pays_origine, nom_ville)
VALUES (1, 'Djokovic', 'Novak', TO_DATE('2020-02-01', 'YYYY-MM-DD'), TO_DATE('1981-05-22', 'YYYY-MM-DD'), 'Serbie',
        'Londres');
INSERT INTO Competiteurs
VALUES (2, 'Dupont', 'Lambargamber', TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('1987-05-22', 'YYYY-MM-DD'), 'Serbie',
        'Paris');
INSERT INTO Competiteurs
VALUES (3, 'Federer', 'Roger', TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('1981-08-08', 'YYYY-MM-DD'), 'Suisse',
        'New York');
INSERT INTO Competiteurs
VALUES (4, 'Zverev', 'Alexander', TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('1997-04-20', 'YYYY-MM-DD'), 'Allemagne',
        'Tokyo');
INSERT INTO Competiteurs
VALUES (5, 'Thiem', 'Dominic', TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('1993-09-03', 'YYYY-MM-DD'), 'Autriche',
        'Sydney');
INSERT INTO Competiteurs
VALUES (6, 'Osaka', 'Naomi', TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('1997-10-16', 'YYYY-MM-DD'), 'Japon',
        'Rio de Janeiro');
INSERT INTO Competiteurs
VALUES (7, 'Kerber', 'Angelique', TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('1988-01-18', 'YYYY-MM-DD'), 'Allemagne',
        'Cape Town');
INSERT INTO Competiteurs
VALUES (8, 'Serena', 'Venus', TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('1980-06-17', 'YYYY-MM-DD'), 'États-Unis',
        'Moscou');
INSERT INTO Competiteurs
VALUES (9, 'Barty', 'Ashleigh', TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('1996-04-24', 'YYYY-MM-DD'), 'Australie',
        'Pékin');
INSERT INTO Competiteurs
VALUES (10, 'Halep', 'Simona', TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('1991-09-27', 'YYYY-MM-DD'), 'Roumanie',
        'Mexico');

-- INSERT INTO Stades
INSERT INTO Stades (num_stade, nom, adresse, capacite, ville)
VALUES (1, 'Stade de France', 'Zac du Cornillon Nord, 93216 Saint-Denis', 80000, 'Paris');
INSERT INTO Stades
VALUES (2, 'Wembley Stadium', 'Wembley, London HA9 0WS, Royaume-Uni', 90000, 'Londres');
INSERT INTO Stades
VALUES (3, 'Newlands Stadium', 'Boundary Rd, Newlands, Le Cap, Afrique du Sud', 52000, 'Cape Town');
INSERT INTO Stades
VALUES (4, 'Tokyo Dome', '1-3-61 Koraku, Bunkyo City, Tokyo 112-0004, Japon', 55000, 'Tokyo');
INSERT INTO Stades
VALUES (5, 'ANZ Stadium', 'Olympic Park, Sydney NSW 2140, Australie', 83000, 'Sydney');
INSERT INTO Stades
VALUES (6, 'Maracanã', 'Rua Professor Eurico Rabelo, Maracanã, Rio de Janeiro, Brésil', 78000, 'Rio de Janeiro');
INSERT INTO Stades
VALUES (7, 'Newlands Stadium', 'Boundary Rd, Newlands, Le Cap, Afrique du Sud', 52000, 'Cape Town');
INSERT INTO Stades
VALUES (8, 'Luzhniki Stadium', 'Prospekt Vernadskogo, Moscou, Russie', 80000, 'Moscou');
INSERT INTO Stades
VALUES (9, 'Nest Stadium', 'Olympic Green, Chaoyang, Pékin, Chine', 90000, 'Pékin');
INSERT INTO Stades
VALUES (10, 'Estadio Azteca', 'Calle de Rio Churubusco s/n, Santa Ursula Coapa, Coyoacán, Mexico DF, Mexique', 95000,
        'Mexico');

-- INSERT INTO Visiteurs
INSERT INTO Visiteurs (num_visiteur, nom, prenom, ville)
VALUES (1, 'Dupont', 'Jean', 'Paris');
INSERT INTO Visiteurs
VALUES (2, 'Durand', 'Marie', 'Paris');
INSERT INTO Visiteurs
VALUES (3, 'Martin', 'Luc', 'Londres');
INSERT INTO Visiteurs
VALUES (4, 'Petit', 'Jacques', 'Londres');
INSERT INTO Visiteurs
VALUES (5, 'Lefebvre', 'Sophie', 'New York');
INSERT INTO Visiteurs
VALUES (6, 'Garcia', 'Olivier', 'New York');
INSERT INTO Visiteurs
VALUES (7, 'Johnson', 'Emma', 'Tokyo');
INSERT INTO Visiteurs
VALUES (8, 'Smith', 'David', 'Tokyo');
INSERT INTO Visiteurs
VALUES (9, 'Williams', 'Samantha', 'Sydney');
INSERT INTO Visiteurs
VALUES (10, 'Jones', 'Michael', 'Sydney');

-- INSERT INTO Épreuves
INSERT INTO Epreuves (num_epreuve, sport, cat_e, date_e, num_stade)
VALUES (1, 'Tennis', 'Débutant', TO_DATE('2021-06-02 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO Epreuves
VALUES (2, 'Tennis', 'Débutant', TO_DATE('2015-08-04 10:10:00', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO Epreuves
VALUES (3, 'Football', 'Professionnel', TO_DATE('2018-04-10 21:20:00', 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO Epreuves
VALUES (4, 'Football', 'Professionnel', TO_DATE('2020-09-18 22:40:00', 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO Epreuves
VALUES (5, 'Natation', 'Intermédiaire', TO_DATE('2021-11-14 23:30:00', 'YYYY-MM-DD HH24:MI:SS'), 3);
INSERT INTO Epreuves
VALUES (6, 'Natation', 'Débutant', TO_DATE('2022-01-16 23:55:00', 'YYYY-MM-DD HH24:MI:SS'), 3);
INSERT INTO Epreuves
VALUES (7, 'Athlétisme', 'Intermédiaire', TO_DATE('2012-12-30 10:50:00', 'YYYY-MM-DD HH24:MI:SS'), 4);
INSERT INTO Epreuves
VALUES (8, 'Athlétisme', 'Professionnel', TO_DATE('2022-12-16 10:43:00', 'YYYY-MM-DD HH24:MI:SS'), 4);
INSERT INTO Epreuves
VALUES (9, 'Escrime', 'Intermédiaire', TO_DATE('2022-07-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);
INSERT INTO Epreuves
VALUES (10, 'Escrime', 'Professionnel', TO_DATE('2022-05-08 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 10);
INSERT INTO Epreuves
VALUES (11, 'Volley-ball', 'Intermédiaire', TO_DATE('2022-06-08 17:30:00', 'YYYY-MM-DD HH24:MI:SS'), 10);
INSERT INTO Epreuves
VALUES (12, 'Volley-ball', 'Professionnel', TO_DATE('2018-09-26 21:20:00', 'YYYY-MM-DD HH24:MI:SS'), 3);
-- INSERT INTO Place
INSERT INTO Place (num_visiteur, num_stade, num_place, prix_place, date_achat)
VALUES (1, 1, 1, 50.0, TO_DATE('2020-01-01', 'YYYY-MM-DD'));
INSERT INTO Place
VALUES (2, 1, 2, 50.0, TO_DATE('2020-01-01', 'YYYY-MM-DD'));
INSERT INTO Place
VALUES (3, 1, 3, 50.0, TO_DATE('2020-01-01', 'YYYY-MM-DD'));
INSERT INTO Place
VALUES (4, 1, 4, 50.0, TO_DATE('2020-01-01', 'YYYY-MM-DD'));
INSERT INTO Place
VALUES (5, 1, 5, 50.0, TO_DATE('2022-12-14', 'YYYY-MM-DD'));
INSERT INTO Place
VALUES (6, 1, 6, 50.0, TO_DATE('2020-01-01', 'YYYY-MM-DD'));
INSERT INTO Place
VALUES (7, 1, 7, 50.0, TO_DATE('2020-01-01', 'YYYY-MM-DD'));
INSERT INTO Place
VALUES (8, 1, 8, 50.0, TO_DATE('2020-01-01', 'YYYY-MM-DD'));
INSERT INTO Place
VALUES (9, 1, 9, 50.0, TO_DATE('2020-01-01', 'YYYY-MM-DD'));
INSERT INTO Place
VALUES (10, 1, 10, 50.0, TO_DATE('202-01-01', 'YYYY-MM-DD'));

-- INSERT INTO Participe
INSERT INTO Participe (num_competiteur, num_epreuve)
VALUES (1, 1);
INSERT INTO Participe
VALUES (2, 2);
INSERT INTO Participe
VALUES (3, 8);
INSERT INTO Participe
VALUES (2, 4);
INSERT INTO Participe
VALUES (5, 6);
INSERT INTO Participe
VALUES (6, 2);
INSERT INTO Participe
VALUES (7, 4);
INSERT INTO Participe
VALUES (8, 1);
INSERT INTO Participe
VALUES (9, 9);
INSERT INTO Participe
VALUES (10, 10);
INSERT INTO Participe
VALUES (10, 11);
INSERT INTO Participe
VALUES (3, 12);

-- INSERT INTO Recompense
INSERT INTO Recompense (num_competiteur, num_epreuve, rang)
VALUES (1, 1, 'Argent');
INSERT INTO Recompense
VALUES (2, 2, 'Or');
INSERT INTO Recompense
VALUES (3, 8, 'Bronze');
INSERT INTO Recompense
VALUES (10, 5, 'Or');
INSERT INTO Recompense
VALUES (5, 6, 'Argent');
INSERT INTO Recompense
VALUES (6, 2, 'Bronze');
INSERT INTO Recompense
VALUES (7, 4, 'Argent');
INSERT INTO Recompense
VALUES (8, 1, 'Argent');
INSERT INTO Recompense
VALUES (9, 9, 'Or');
INSERT INTO Recompense
VALUES (10, 10, 'Or');
INSERT INTO Recompense
VALUES (10, 11, 'Or');
INSERT INTO Recompense
VALUES (3, 12, 'Or');
--||||||||||||||||||||||||||||||||||||||||||||--
------------Manipulations de données------------
--||||||||||||||||||||||||||||||||||||||||||||--

--|||||| Ville : DONE
--      CONSTRAINT pk_nom_ville PRIMARY KEY (nom_ville) DONE !
INSERT INTO Villes (nom_ville, num_depart, nb_habitant)
VALUES ('', '451', 23);
-- Cette insertion échouerait en raison de la contrainte NOT NULL sur la colonne nom_ville, qui spécifie que la colonne ne peut pas contenir de valeurs NULL.

--      CONSTRAINT fk_num_depart FOREIGN KEY (num_depart) REFERENCES Departements(num_depart) DONE !
INSERT INTO Villes (nom_ville, num_depart, nb_habitant)
VALUES ('Paris', '451', 23);
-- Cette insertion échouerait en raison de la contrainte FOREIGN KEY sur la colonne num_depart, qui spécifie que la colonne ne peut contenir que des valeurs qui correspondent à une valeur de la colonne num_depart de la table Departements.

--      CONSTRAINT ck_nb_habitant CHECK (nb_habitant > 0) DONE !
INSERT INTO Villes (nom_ville, num_depart, nb_habitant)
VALUES ('Paris', '451', -23);
-- Cette insertion échouerait en raison de la contrainte CHECK sur la colonne nb_habitant, qui spécifie que la colonne ne peut contenir que des valeurs positives.

--|||||| Competiteurs : DONE

--     CONSTRAINT pk_num_competiteur PRIMARY KEY (num_competiteur)
INSERT INTO Competiteurs (num_competiteur, nom, prenom, date_inscription, date_naissance, pays_origine, nom_ville)
VALUES ('', 'DUPONT', 'Jean', TO_DATE('2013-01-01', 'YYYY-MM-DD'), TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'Serbie', 'Paris');
-- Cette insertion échouerait en raison de la contrainte NOT NULL sur la colonne num_competiteur, qui spécifie que la colonne ne peut pas contenir de valeurs NULL.


--     CONSTRAINT fk_ville FOREIGN KEY (ville) REFERENCES Villes (nom_ville)
INSERT INTO Competiteurs
VALUES (1, 'Doe', 'John', '14-12-2022', '15-12-2000', 'France', 'Miami')
-- Cette insertion échouera car elle tente d'insérer une valeur qui n'existe pas dans la colonne nom_ville, qui est définie comme une clé étrangère.

--     CONSTRAINT date_naissance CHECK (date_inscription > date_naissance)
INSERT INTO Competiteurs (num_competiteur, nom, prenom, date_inscription, date_naissance, pays_origine, nom_ville)
VALUES (1, 'Doe', 'John', '12-03-2022', '12-04-2022', 'France', 'Paris');
--La raison de l'échec de cette insertion serait que la date de naissance de John Doe est postérieure à sa date d'inscription, ce qui va à l'encontre de la contrainte de domaine sur la date de naissance des compétiteurs.

--|||||| Stades : DONE
--     CONSTRAINT pk_num_stade PRIMARY KEY (num_stade)
INSERT INTO Stades (num_stade, nom, adresse, capacite, ville)
VALUES (1, 'Stade de France', '24 rue du Commandant Guilbaud', 80000, 'Paris');
-- Cette insertion échouera car elle tente d'insérer une valeur qui existe deja dans la colonne num_stade, qui est définie comme une clé étrangère.

--     CONSTRAINT fk_ville_s FOREIGN KEY (ville) REFERENCES Villes (nom_ville)
INSERT INTO Stades (num_stade, nom, adresse, capacite, ville)
VALUES (11, 'Stade 1', 'Adresse 1', 1, 'Miami');
-- ORA-02291: violation de contrainte d'intégrité (GARROC.FK_VILLE_S) - clé parent introuvable


--     CONSTRAINT capacite CHECK (capacite > 0)
INSERT INTO Stades (num_stade, nom, adresse, capacite, ville)
VALUES (1, 'Stade 1', 'Adresse 1', -10, 'Ville 1');
-- La valeur de la colonne "capacite" est inférieure à 0, ce qui violerait la contrainte de domaine "capacite > 0" définie pour cette colonne dans la table Stades.
-- ORA-02290: violation de contraintes (GARROC.CAPACITE) de vérification

--|||||| Visiteurs : DONE
--     CONSTRAINT pk_num_visiteur_v PRIMARY KEY (num_visiteur),
DELETE FROM Visiteurs
WHERE num_visiteur = 1
--Cette suppression échouerait car elle violerait la contrainte de clé primaire, car elle entraînerait la suppression d'une valeur de clé primaire de 1 de la table, ce qui n'est pas autorisé.
-- ORA-02292: violation de contrainte (GARROC.FK_NUM_VISITEUR) d'intégrité - enregistrement fils existant

--     CONSTRAINT fk_ville_v FOREIGN KEY (ville) REFERENCES Villes (nom_ville),
INSERT INTO Visiteurs
VALUES (11, 'John', 'Adresse 1', 'Miami')
-- Cette insertion échouera car elle tente d'insérer une valeur qui n'existe pas dans la colonne nom_ville, qui est définie comme une clé étrangère.
-- ORA-02291: violation de contrainte d'intégrité (GARROC.FK_VILLE_V) - clé parent introuvable

--|||||| Epreuves :
--     CONSTRAINT pk_num_epreuve PRIMARY KEY (num_epreuve),
INSERT INTO Epreuves (num_epreuve, sport, cat_e, date_e, num_stade)
VALUES ('', 'Sport 1', 'Professionnel', TO_DATE('2018-09-26 21:20:00', 'YYYY-MM-DD HH24:MI:SS'), 1)
-- Cette insertion échouera car elle tente d'insérer une valeur qui existe deja dans la colonne num_epreuve, qui est définie comme une clé étrangère.
-- ORA-01400: impossible d'insérer NULL dans ("GARROC"."EPREUVES"."NUM_EPREUVE")

--     CONSTRAINT fk_stade FOREIGN KEY (stade) REFERENCES Stades (num_stade)
INSERT INTO Epreuves
VALUES (14, 'Epreuve 1', 'Professionnel', TO_DATE('2018-09-26 21:20:00', 'YYYY-MM-DD HH24:MI:SS'), -1)
-- Cette insertion échouera car elle tente d'insérer une valeur qui n'existe pas dans la colonne num_stade, qui est définie comme une clé étrangère.
-- ORA-02291: violation de contrainte d'intégrité (GARROC.FK_STADE) - clé parent introuvable

-- CONSTRAINT cat_e CHECK (cat_e='Débutant' OR cat_e='Intermédiaire' OR cat_e='Professionnel')
INSERT INTO Epreuves
VALUES (14, 'Epreuve 1', 'Kebab', TO_DATE('2018-09-26 21:20:00', 'YYYY-MM-DD HH24:MI:SS'), 1)
-- ORA-02290: violation de contraintes (GARROC.CAT_E) de vérification

--|||||| Place :
--     CONSTRAINT fk_num_visiteur FOREIGN KEY (num_visiteur) REFERENCES Visiteurs (num_visiteur),
INSERT INTO Place (num_visiteur, num_stade, num_place, prix_place, date_achat)
VALUES (-1, 1, 1, 5, TO_DATE('2018-09-26', 'YYYY-MM-DD'))
-- Cette insertion échouera car elle tente d'insérer une valeur qui n'existe pas dans la colonne num_visiteur, qui est définie comme une clé étrangère.
-- ORA-02291: violation de contrainte d'intégrité (GARROC.FK_NUM_VISITEUR) - clé parent introuvable

--     CONSTRAINT fk_num_stade FOREIGN KEY (num_stade) REFERENCES Stades (num_stade),
INSERT INTO Place
VALUES (1, -1, 1, 5, TO_DATE('2018-09-26', 'YYYY-MM-DD'))
-- Cette insertion échouera car elle tente d'insérer une valeur qui n'existe pas dans la colonne num_stade, qui est définie comme une clé étrangère.
-- ORA-02291: violation de contrainte d'intégrité (GARROC.FK_NUM_STADE) - clé parent introuvable

--     CONSTRAINT prix_place CHECK (prix_place > 0.0)
INSERT INTO Place (num_visiteur, num_stade, num_place, prix_place, date_achat)
VALUES (1, 1, 1, -10.0, TO_DATE('2018-09-26', 'YYYY-MM-DD'))
-- La valeur de la colonne "prix_place" est inférieure à 0, ce qui violerait la contrainte de domaine "prix_place > 0.0" définie pour cette colonne dans la table Place.
-- ORA-02290: violation de contraintes (GARROC.PRIX_PLACE) de vérification

-- CONSTRAINT num_place CHECK (num_place > 0)
INSERT INTO Place (num_visiteur, num_stade, num_place, prix_place, date_achat)
VALUES (1, 1, 0, 1, TO_DATE('2018-09-26', 'YYYY-MM-DD'))
-- ORA-02290: violation de contraintes (GARROC.NUM_PLACE) de vérification

--|||||| Participe :
--     CONSTRAINT fk_num_competiteur_participe FOREIGN KEY (num_competiteur) REFERENCES Competiteurs (num_competiteur),
INSERT INTO Participe (num_competiteur, num_epreuve)
VALUES (-1, 1)
-- Cette insertion échouera car elle tente d'insérer une valeur qui n'existe pas dans la colonne num_competiteur, qui est définie comme une clé étrangère.
-- ORA-02291: violation de contrainte d'intégrité (GARROC.FK_NUM_COMPETITEUR_PARTICIPE) - clé parent introuvable

--     CONSTRAINT fk_num_epreuve_participe FOREIGN KEY (num_epreuve) REFERENCES Epreuves (num_epreuve)
INSERT
INTO Participe (num_competiteur, num_epreuve)
VALUES (1, -2)
-- Cette insertion échouera car elle tente d'insérer une valeur qui n'existe pas dans la colonne num_epreuve, qui est définie comme une clé étrangère.
-- ORA-02291: violation de contrainte d'intégrité (GARROC.FK_NUM_EPREUVE_PARTICIPE) - clé parent introuvable

--|||||| Recompense :
--     CONSTRAINT fk_num_competiteur FOREIGN KEY (num_competiteur) REFERENCES Competiteurs (num_competiteur),
INSERT INTO Recompense (num_competiteur, num_epreuve, rang)
VALUES (-1, 1, 'Bronze')
-- Cette insertion échouera car elle tente d'insérer une valeur qui n'existe pas dans la colonne num_competiteur, qui est définie comme une clé étrangère.
-- ORA-02291: violation de contrainte d'intégrité (GARROC.FK_NUM_COMPETITEUR) - clé parent introuvable

--     CONSTRAINT fk_num_epreuve FOREIGN KEY (num_epreuve) REFERENCES Epreuves (num_epreuve)
INSERT INTO Recompense (num_competiteur, num_epreuve, rang)
VALUES (1, -2, '0r')
-- Cette insertion échouera car elle tente d'insérer une valeur qui n'existe pas dans la colonne num_epreuve, qui est définie comme une clé étrangère.
-- ORA-02291: violation de contrainte d'intégrité (GARROC.FK_NUM_EPREUVE) - clé parent introuvable

--     CONSTRAINT rang CHECK (rang = 'Or' OR rang = 'Argent' OR rang = 'Bronze')
INSERT INTO Recompense (num_competiteur, num_epreuve, rang)
VALUES (1, -2, 'Bois')
-- ORA-02290: violation de contraintes (GARROC.RANG) de vérification


