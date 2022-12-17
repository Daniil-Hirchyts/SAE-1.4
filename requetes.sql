--R1 DONE
SELECT COUNT(num_competiteur) as nbCompetiteur FROM(SELECT num_competiteur, COUNT(rang) AS nbRang
 FROM (SELECT *
             FROM Epreuves e JOIN Recompense r ON e.num_Epreuve = r.num_Epreuve
             WHERE num_stade = (SELECT num_stade FROM (SELECT num_stade, MAX(capacite) AS nbCap FROM Stades
                         GROUP by num_stade)
                   WHERE nbCap = (SELECT MAX(capacite) FROM Stades)
                   )
             )
 WHERE rang ='Or'
 GROUP BY num_competiteur) WHERE nbRang >= 2
--R2 DONE ajouter des insert pour cette requête
         SELECT nom, prenom, date_naissance
FROM Competiteurs c
JOIN Recompense r
ON c.num_competiteur = r.num_competiteur
WHERE r.rang = 'Argent'
AND c.nom_ville = c.pays_origine


--R3 DONE
Select num_competiteur
FROM (Select num_competiteur, COUNT(r.num_epreuve) as nbEpreuve FROM (Select num_epreuve FROM Epreuves WHERE cat_e = 'Professionnel') e
    JOIN Recompense r ON r.num_epreuve=e.num_epreuve
    GROUP BY num_competiteur)
WHERE nbEpreuve >= 2
--R4


--R5 DONE
Select v.num_visiteur, v.nom, v.prenom, v.ville
FROM Visiteurs v JOIN Place p ON v.num_visiteur = p.num_visiteur
    JOIN stades s ON s.num_stade = p.num_stade
    JOIN Epreuves e ON s.num_stade=e.num_stade
    JOIN participe p1 ON p1.num_epreuve=e.num_epreuve
    JOIN competiteurs c ON c.num_competiteur = p1.num_competiteur
WHERE v.nom = c.nom AND v.ville = c.nom_ville

--R6 DONE
SELECT s.nom
FROM Epreuves e
         JOIN Stades s ON s.num_stade = e.num_stade
WHERE e.date_e = (SELECT MIN(date_e) FROM Epreuves)


--R7 DONE
Select c.nom, c.prenom
FROM Recompense r
    JOIN Epreuves e On e.num_epreuve = r.num_epreuve
    JOIN competiteurs c ON c.num_competiteur = r.num_competiteur
WHERE date_e = (select MAX(date_e) FROM epreuves)


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
