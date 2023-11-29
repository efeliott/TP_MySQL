-- SELECT des entrepots ayant envoyé au moins une expeditions en transit

SELECT DISTINCT e.nom_ent, e.adresse_ent, e.ville_ent, e.pays_ent
FROM entrepots AS e
LEFT JOIN expeditions AS ex ON e.id_ent = ex.id_ent_source
WHERE ex.statut = 'En transit';

-- SELECT des entrepots ayant reçu au moins une expeditions en transit

SELECT DISTINCT e.nom_ent, e.adresse_ent, e.ville_ent, e.pays_ent
FROM entrepots AS e
LEFT JOIN expeditions AS ex ON e.id_ent = ex.id_ent_dest
WHERE ex.statut = 'En transit';

-- Affichez les expéditions qui ont un poids supérieur à 100 kg et qui sont en transit

SELECT * 
FROM expeditions 
WHERE poid > 100
AND statut = 'En transit';

-- Affichez le nombre d'expéditions envoyées par chaque entrepôts

SELECT e.nom_ent, COUNT(ex.id_exp) AS nombre_expeditions
FROM entrepots e
JOIN expeditions ex ON e.id_ent = ex.id_ent_source
GROUP BY e.nom_ent;

-- Affichez le nombre total d'expéditions en transit

SELECT count(*) as nombre_exp_livree
FROM expeditions
WHERE statut = 'En transit';

-- Affichez le nombre total d'expéditions livrées

SELECT count(*) as nombre_exp_livree
FROM expeditions
WHERE statut = 'Livrée';

-- Affichez le nombre total d'expéditions pour chaque mois de l'année en cours

SELECT YEAR(date_exp) AS Annee, MONTH(date_exp) AS Mois, COUNT(*) AS NombreExpeditions
FROM expeditions
WHERE YEAR(date_exp) = YEAR(CURDATE())
GROUP BY YEAR(date_exp), MONTH(date_exp)
ORDER BY Mois;

-- Affichez les entrepôts qui ont envoyé des expéditions au cours des 30 derniers jours

SELECT DISTINCT e.id_ent, e.nom_ent, e.adresse_ent, e.ville_ent, e.pays_ent
FROM entrepots e
INNER JOIN expeditions ex ON e.id_ent = ex.id_ent_source
WHERE ex.date_exp >= CURDATE() - INTERVAL 30 DAY;

-- Affichez les entrepôts qui ont reçu des expéditions au cours des 30 derniers jours

SELECT DISTINCT e.id_ent, e.nom_ent, e.adresse_ent, e.ville_ent, e.pays_ent
FROM entrepots e
INNER JOIN expeditions ex ON e.id_ent = ex.id_ent_dest
WHERE ex.date_exp >= CURDATE() - INTERVAL 30 DAY;

-- Affichez les expéditions qui ont été livrées dans un délai de moins de 5 jours ouvrables
