--R1

--R2
SELECT nom, prenom, date_naissance
FROM Competiteurs
WHERE rang = 2
  AND ville = pays_origine;


--R3
SELECT DISTINCT Competiteurs.num_competiteur
FROM Competiteurs
JOIN Recompense
ON Competiteurs.num_competiteur = Recompense.num_competiteur
JOIN Epreuves
ON Recompense.num_epreuve = Epreuves.num_epreuve
WHERE Epreuves.cat_e = 'pro'
GROUP BY Competiteurs.num_competiteur
HAVING COUNT(DISTINCT Epreuves.num_epreuve) >= 2

--R4
SELECT DISTINCT Visiteurs.nom
FROM Visiteurs
WHERE NOT EXISTS (
    SELECT *
    FROM Epreuves
    JOIN Stades
    ON Epreuves.stade = Stades.num_stade
    WHERE Stades.ville = Visiteurs.ville
    AND Epreuves.num_epreuve NOT IN (
        SELECT num_epreuve
        FROM Place
        JOIN Stades
        ON Place.num_stade = Stades.num_stade
        WHERE Place.num_visiteur = Visiteurs.num_visiteur
        AND Stades.ville = Visiteurs.ville
    )
)

--R5