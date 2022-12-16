--R1 Combien de compétiteurs ont reçu au moins deux médailles d'or dans le stade avec la plus grande capacité d'accueil ?
SELECT COUNT(num_competiteur) FROM(SELECT num_competiteur, COUNT(rang) AS nbRang
 FROM (SELECT num_stade, nbCap
       FROM (SELECT num_competiteur
             FROM (SELECT num_stade, nbCap
                   FROM (SELECT num_stade, MAX(capacite) AS nbCap
                         FROM Stades
                         GROUP by num_stade)
                   WHERE nbCap = (SELECT MAX(capacite) FROM Stades)
                   )
             )
       ) -- MANQUE JOINTURE AVEC COMP
 WHERE rang ='Or'
 GROUP BY num_competiteur) WHERE nbRang >= 2

SELECT COUNT(*)
FROM (SELECT r.num_competiteur
      FROM Recompense r
               JOIN Epreuves e ON e.num_epreuve = r.num_epreuve
               JOIN Stades s ON s.num_stade = e.num_stade
               JOIN (SELECT num_stade, MAX(capacite) AS max_capacite FROM Stades GROUP BY num_stade) s2
                    ON s2.num_stade = s.num_stade AND s.capacite = s2.max_capacite
      )
--R2 DONE
         SELECT nom, prenom, date_naissance
FROM Competiteurs c
JOIN Recompense r
ON c.num_competiteur = r.num_competiteur
WHERE r.rang = 'Argent'
AND c.nom_ville = c.pays_origine

--R3


--R4


--R5


--R6 DONE
SELECT s.nom
FROM Epreuves e
         JOIN Stades s ON s.num_stade = e.num_stade
WHERE e.date_e = (SELECT MIN(date_e) FROM Epreuves)


--R7 FALSE
SELECT c.num_competiteur, c.nom, c.prenom
FROM Competiteurs c
         JOIN Participe pa ON pa.num_competiteur = c.num_competiteur
         JOIN Recompense r ON r.num_epreuve = pa.num_epreuve AND r.num_competiteur = c.num_competiteur
         JOIN Epreuves e ON e.num_epreuve = pa.num_epreuve
WHERE e.num_epreuve = (SELECT MAX(num_epreuve) FROM Epreuves)


--R8 FALSE
SELECT DISTINCT s.num_stade, s.nom
FROM Stades s
         JOIN Epreuves e ON e.num_stade = s.num_stade
         JOIN Place p ON p.num_stade = s.num_stade
         JOIN Visiteurs v ON v.num_visiteur = p.num_visiteur
         JOIN Competiteurs c ON c.nom_ville = v.ville
         JOIN Participe pa ON pa.num_competiteur = c.num_competiteur
         JOIN Recompense r
              ON r.num_epreuve = pa.num_epreuve AND r.num_competiteur = c.num_competiteur AND r.rang IN ('Argent', 'Or')
WHERE e.date_e = (SELECT MIN(date_e) FROM Epreuves)

--R9 DONE
SELECT s.num_stade, s.nom, s.adresse, s.capacite, s.ville
FROM Stades s
         JOIN Epreuves e ON e.num_stade = s.num_stade
WHERE e.num_epreuve =
      (SELECT MIN(num_epreuve) FROM Epreuves WHERE num_epreuve > (SELECT MIN(num_epreuve) FROM Epreuves));

--R10 DONE
SELECT Visiteurs.*
FROM Visiteurs
         JOIN Place
              ON Visiteurs.num_visiteur = Place.num_visiteur
WHERE Place.date_achat = (SELECT MAX(date_achat) FROM Place)
