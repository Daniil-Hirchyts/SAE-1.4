--R1
SELECT COUNT(*)
FROM Competiteurs c
INNER JOIN Recompense r ON c.num_competiteur = r.num_competiteur
INNER JOIN Epreuves e ON r.num_epreuve = e.num_epreuve
INNER JOIN Stades s ON e.stade = s.num_stade
WHERE r.medaille = 'or'
GROUP BY c.num_competiteur
HAVING COUNT(*) >= 2
ORDER BY s.capacite DESC
LIMIT 1;
