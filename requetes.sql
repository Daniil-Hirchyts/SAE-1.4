--R1
SELECT COUNT(*)
FROM Competiteurs c
         JOIN Participe p ON p.num_competiteur = c.num_competiteur
         JOIN Epreuves e ON e.num_epreuve = p.num_epreuve
         JOIN Stades s ON s.num_stade = e.num_stade
         JOIN (SELECT num_stade, MAX(capacite) AS max_capacite FROM Stades GROUP BY num_stade) s2 ON s2.num_stade = s.num_stade AND s.capacite = s2.max_capacite
         JOIN Recompense r ON r.num_epreuve = e.num_epreuve AND r.num_competiteur = c.num_competiteur AND r.rang = 'Or'
GROUP BY c.num_competiteur
HAVING COUNT(*) >= 2;


SELECT COUNT(*)
FROM (
         SELECT c.num_competiteur
         FROM Competiteurs c
                  JOIN Participe p ON p.num_competiteur = c.num_competiteur
                  JOIN Epreuves e ON e.num_epreuve = p.num_epreuve
                  JOIN Stades s ON s.num_stade = e.num_stade
                  JOIN (SELECT num_stade, MAX(capacite) AS max_capacite FROM Stades GROUP BY num_stade) s2 ON s2.num_stade = s.num_stade AND s.capacite = s2.max_capacite
                  JOIN Recompense r ON r.num_epreuve = e.num_epreuve AND r.num_competiteur = c.num_competiteur AND r.rang = 'Or'
         GROUP BY c.num_competiteur
         HAVING COUNT(*) >= 2
     ) ;

--R2
SELECT nom, prenom, date_naissance
FROM Competiteurs
WHERE rang = 2
  AND ville = pays_origine;


--R3


--R4


--R5




--R9
SELECT s.num_stade, s.nom
FROM Stades s
         JOIN Epreuves e ON e.num_stade = s.num_stade
WHERE e.num_epreuve = (SELECT MIN(num_epreuve) FROM Epreuves WHERE num_epreuve > (SELECT MIN(num_epreuve) FROM Epreuves));

--R10
SELECT v.num_visiteur, v.nom, v.prenom
FROM Visiteurs v
         JOIN Place p ON p.num_visiteur = v.num_visiteur
WHERE p.date_achat = (SELECT MAX(date_achat) FROM Place);