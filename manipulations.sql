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
VALUES ('', 'DUPONT', 'Jean', TO_DATE('2013-01-01', 'YYYY-MM-DD'), TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'Serbie',
        'Paris');
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
DELETE
FROM Visiteurs
WHERE num_visiteur = 1
--Cette suppression échouerait car elle violerait la contrainte de clé primaire, car elle entraînerait la suppression d'une valeur de clé primaire de 1 de la table, ce qui n'est pas autorisé.
-- ORA-02292: violation de contrainte (GARROC.FK_NUM_VISITEUR) d'intégrité - enregistrement fils existant

--     CONSTRAINT fk_ville_v FOREIGN KEY (ville) REFERENCES Villes (nom_ville),
INSERT INTO Visiteurs
VALUES (11, 'John', 'Adresse 1', 'Miami')
-- Cette insertion échouera car elle tente d'insérer une valeur qui n'existe pas dans la colonne nom_ville, qui est définie comme une clé étrangère.
-- ORA-02291: violation de contrainte d'intégrité (GARROC.FK_VILLE_V) - clé parent introuvable

--|||||| Epreuves : DONE
--     CONSTRAINT pk_num_epreuve PRIMARY KEY (num_epreuve),
INSERT INTO Epreuves (num_epreuve, sport, cat_e, date_e, num_stade)
VALUES ('', 'Sport 1', 'Professionnel', TO_DATE('2018-09-26 21:20:00', 'YYYY-MM-DD HH24:MI:SS'), 1)
-- ORA-01400: impossible d'insérer NULL dans ("GARROC"."EPREUVES"."NUM_EPREUVE")

--     CONSTRAINT fk_stade FOREIGN KEY (num_stade) REFERENCES Stades (num_stade)
INSERT INTO Epreuves
VALUES (14, 'Epreuve 1', 'Professionnel', TO_DATE('2018-09-26 21:20:00', 'YYYY-MM-DD HH24:MI:SS'), -1)
-- ORA-02291: violation de contrainte d'intégrité (GARROC.FK_STADE) - clé parent introuvable

-- CONSTRAINT cat_e CHECK (cat_e='Débutant' OR cat_e='Intermédiaire' OR cat_e='Professionnel')
INSERT INTO Epreuves (num_epreuve, sport, cat_e, date_e, num_stade)
VALUES (1, 'Sport 1', 'Amateur', TO_DATE('2018-09-26 21:20:00', 'YYYY-MM-DD HH24:MI:SS'), 1)
-- ORA-02290: violation de contraintes (GARROC.CAT_E) de vérification

--|||||| Place : DONE
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

--|||||| Participe : DONE
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

--|||||| Recompense : DONE
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
