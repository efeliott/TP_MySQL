-- Ajout du continet de l'entrepot

ALTER TABLE entrepots
ADD continent_ent varchar(50);

UPDATE entrepots 
SET continent_ent = "Europe"
WHERE pays_ent not like "Chine";

UPDATE entrepots 
SET continent_ent = "Asie"
WHERE pays_ent = "Chine";

-- Affichez les expéditions en transit qui ont été initiées par un entrepôt situé en Europe et à destination d'un entrepôt situé en Asie

SELECT exp.*
FROM expeditions exp
JOIN entrepots ent_source ON exp.id_ent_source = ent_source.id_ent
JOIN entrepots ent_dest ON exp.id_ent_dest = ent_dest.id_ent
WHERE exp.statut = 'En transit'
AND ent_source.continent_ent = 'Europe'
AND ent_dest.continent_ent = 'Asie';

-- Affichez les entrepôts qui ont envoyé des expéditions à destination d'un entrepôt situé dans le même pays

SELECT DISTINCT ent_source.nom_ent AS Entrepot_Expéditeur
FROM expeditions exp
JOIN entrepots ent_source ON exp.id_ent_source = ent_source.id_ent
JOIN entrepots ent_dest ON exp.id_ent_dest = ent_dest.id_ent
WHERE ent_source.pays_ent = ent_dest.pays_ent;

-- Affichez les entrepôts qui ont envoyé des expéditions à destination d'un entrepôt situé dans un pays différent

SELECT DISTINCT ent_source.nom_ent AS Entrepot_Expediteur
FROM expeditions exp
JOIN entrepots ent_source ON exp.id_ent_source = ent_source.id_ent
JOIN entrepots ent_dest ON exp.id_ent_dest = ent_dest.id_ent
WHERE ent_source.pays_ent != ent_dest.pays_ent;

-- Affichez les expéditions en transit qui ont été initiées par un entrepôt situé dans un pays dont le nom commence par la lettre "F" et qui pèsent plus de 500 kg

SELECT exp.*
FROM expeditions exp
JOIN entrepots ent_source ON exp.id_ent_source = ent_source.id_ent
WHERE exp.statut = 'En transit'
AND ent_source.pays_ent LIKE 'F%'
AND exp.poid > 500;

-- Affichez le nombre total d'expéditions pour chaque combinaison de pays d'origine et de destination

SELECT 
    ent_source.pays_ent AS Pays_Origine,
    ent_dest.pays_ent AS Pays_Destination,
    COUNT(*) AS Nombre_Expeditions
FROM 
    expeditions exp
INNER JOIN entrepots ent_source ON exp.id_ent_source = ent_source.id_ent
INNER JOIN entrepots ent_dest ON exp.id_ent_dest = ent_dest.id_ent
GROUP BY 
    Pays_Origine, 
    Pays_Destination;

-- Affichez les entrepôts qui ont envoyé des expéditions au cours des 30 derniers jours et dont le poids total des expéditions est supérieur à 1000 kg

SELECT 
    ent_source.id_ent,
    ent_source.nom_ent,
    SUM(exp.poid) AS Poids_Total
FROM 
    expeditions exp
JOIN entrepots ent_source ON exp.id_ent_source = ent_source.id_ent
WHERE 
    exp.date_exp >= CURDATE() - INTERVAL 30 DAY
GROUP BY 
    ent_source.id_ent,
    ent_source.nom_ent
HAVING 
    SUM(exp.poid) > 1000;

-- Affichez les expéditions qui ont été livrées avec un retard de plus de 2 jours

ALTER TABLE expeditions
ADD date_livraison DATE;

ALTER TABLE expeditions
ADD date_livraison_prevue DATE;

SELECT * 
FROM expeditions
WHERE datediff(date_livraison, date_livraison_prevue) > 2;

-- Affichez le nombre total d'expéditions pour chaque jour du mois en cours, trié par ordre décroissant

SELECT 
    DAY(date_exp) AS DayOfMonth, 
    COUNT(*) AS TotalExpeditions
FROM expeditions
WHERE MONTH(date_exp) = MONTH(CURDATE()) AND YEAR(date_exp) = YEAR(CURDATE())
GROUP BY DayOfMonth
ORDER BY TotalExpeditions DESC, DayOfMonth DESC;

