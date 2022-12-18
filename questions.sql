-- Nous souhaitons afficher le nom et le prénom des compétiteurs n'ayant remporté aucune récompense
SELECT nom, prenom
FROM Competiteurs
WHERE num_competiteur NOT IN (SELECT num_competiteur FROM Recompense);

-- Résultat attendu :
-- Zverev       Alexander


-- Nous souhaitons afficher le nom et le prénom des compétiteurs ayant remporté au moins une récompense dans une épreuve de catégorie Débutant ou Intermédiaire
SELECT nom, prenom
FROM Competiteurs
WHERE num_competiteur IN (SELECT num_competiteur
                          FROM Recompense
                          WHERE num_epreuve IN (SELECT num_epreuve
                                                FROM Epreuves
                                                WHERE cat_e IN ('Débutant', 'Intermédiaire')));

-- Résultat attendu :
-- Djokovic	Novak
-- Dupont	Lambargamber
-- Thiem	Dominic
-- Osaka	Naomi
-- Serena	Venus
--Barty	    Ashleigh
--Halep	    Simona

-- Nous souhaitons afficher le nombre de visiteurs de chaque ville, trié par ordre décroissant de nombre de visiteurs
SELECT ville, COUNT(*) as nb_visiteurs
FROM Visiteurs
GROUP BY ville
ORDER BY nb_visiteurs DESC;

-- Résultat attendu :
--Tokyo	    2
--Sydney	2
--Paris	    2
--New York	2
--Londres	2

-- Nous souhaitons afficher les épreuves sportives organisées dans les stades ayant une capacité supérieure à 25 000 places, triées par date décroissante
SELECT sport, date_e
FROM Epreuves e
         JOIN Stades s ON e.num_stade = s.num_stade
WHERE s.capacite > 25000
ORDER BY date_e DESC;

-- Résultat attendu :
--Athlétisme	16/12/22
--Escrime	    01/07/22
--Volley-ball	08/06/22
--Escrime	    08/05/22
--Natation	    16/01/22
--Natation	    14/11/21
--Tennis	    02/06/21
--Football	    18/09/20
--Volley-ball	26/09/18
--Football	    10/04/18
--Tennis	    04/08/15
--Athlétisme	30/12/12


-- Nous souhaitons afficher le nombre de visiteurs ayant acheté une place dans les stades de chaque ville, trié par ordre croissant de nombre de visiteurs
SELECT s.ville, COUNT(v.num_visiteur) as nb_visiteurs
FROM Visiteurs v
         JOIN Place p ON v.num_visiteur = p.num_visiteur
         JOIN Stades s ON p.num_stade = s.num_stade
GROUP BY s.ville
ORDER BY nb_visiteurs ASC;

-- Résultat attendu :
--Paris	    10


-- Nous souhaitons afficher le nombre total de places disponibles dans les stades de la ville de Ville4
SELECT SUM(capacite) as total_places
FROM Stades
WHERE ville = 'Paris';

-- Résultat attendu :
--80000

-- Nous souhaitons afficher le nombre de visiteurs ayant acheté une place dans un stade de chaque ville, ayant organisé au moins une épreuve de catégorie Débutant
SELECT s.ville, COUNT(v.num_visiteur) as nb_visiteurs
FROM Visiteurs v
         JOIN Place p ON v.num_visiteur = p.num_visiteur
         JOIN Stades s ON p.num_stade = s.num_stade
         JOIN Epreuves e ON s.num_stade = e.num_stade
WHERE e.cat_e = 'Débutant'
GROUP BY s.ville;

-- Résultat attendu :
--Paris 	20


-- Nous souhaitons afficher les villes ayant organisé au moins une épreuve de catégorie Débutant, mais pas d'épreuve de catégorie Professionnel
SELECT DISTINCT ville
FROM Stades
WHERE ville IN (SELECT ville FROM Stades WHERE num_stade IN (SELECT num_stade FROM Epreuves WHERE cat_e = 'Débutant'))
MINUS
SELECT DISTINCT ville
FROM Stades
WHERE ville IN
      (SELECT ville FROM Stades WHERE num_stade IN (SELECT num_stade FROM Epreuves WHERE cat_e = 'Professionnel'));

-- Résultat attendu :
-- Paris


-- Nous souhaitons afficher les villes ayant organisé au moins une épreuve de catégorie Débutant et une épreuve de catégorie Professionnel
SELECT DISTINCT ville
FROM Stades
WHERE ville IN (SELECT ville FROM Stades WHERE num_stade IN (SELECT num_stade FROM Epreuves WHERE cat_e = 'Débutant'))
INTERSECT
SELECT DISTINCT ville
FROM Stades
WHERE ville IN
      (SELECT ville FROM Stades WHERE num_stade IN (SELECT num_stade FROM Epreuves WHERE cat_e = 'Professionnel'));

-- Résultat attendu :
-- Cape Town


-- Nous souhaitons afficher toutes les villes ayant organisé au moins une épreuve de catégorie Débutant ou une épreuve de catégorie Professionnel
SELECT DISTINCT ville
FROM Stades
WHERE ville IN (SELECT ville FROM Stades WHERE num_stade IN (SELECT num_stade FROM Epreuves WHERE cat_e = 'Débutant'))
UNION
SELECT DISTINCT ville
FROM Stades
WHERE ville IN
      (SELECT ville FROM Stades WHERE num_stade IN (SELECT num_stade FROM Epreuves WHERE cat_e = 'Professionnel'));

-- Résultat attendu :
--Cape Town
--Londres
--Mexico
--Paris
--Tokyo


-- Nous souhaitons afficher le nombre de catégorie différentes des épreuves ayant eu lieu dans le stade avec la plus grand capacité d’accueil à l’étranger
SELECT COUNT(DISTINCT cat_e) AS NB
FROM competiteurs c
         JOIN participe p ON c.num_competiteur = p.num_competiteur
         JOIN epreuves e ON p.num_epreuve = e.num_epreuve
         JOIN stades s ON e.num_stade = s.num_stade
WHERE capacite IN (SELECT MAX(DISTINCT capacite) FROM stades)
  AND pays_origine != 'France';

-- Résultat attendu :
--2


-- Nous souhaitons afficher le nom des compétiteurs ayant gagné aux moins deux médailles compétitions ayant eu lieu dans leur ville, triés par ordre alphabétique
SELECT nom
FROM (SELECT c.nom, COUNT(rang) AS NB
      FROM recompense r
               JOIN competiteurs c ON r.num_competiteur = c.num_competiteur
               JOIN villes v ON c.nom_ville = v.nom_ville
               JOIN stades s ON v.nom_ville = s.ville
      GROUP BY c.nom)
WHERE NB >= 2
ORDER BY nom;

-- Résultat attendu :
--Halep
--Kerber