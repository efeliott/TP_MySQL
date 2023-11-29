-- Créez une vue qui affiche les informations suivantes pour chaque entrepôt : nom de l'entrepôt, adresse complète, nombre d'expéditions envoyées au cours des 30 derniers jours

CREATE VIEW entrepot_expeditions_30jours AS
SELECT 
    e.nom_ent,
    CONCAT(e.adresse_ent, ', ', e.ville_ent, ', ', e.pays_ent) AS AdresseComplete,
    COUNT(ex.id_exp) AS NbExpeditions30Jours
FROM entrepots e
LEFT JOIN expeditions ex ON e.id_ent = ex.id_ent_source 
    AND ex.date_exp BETWEEN DATE_SUB(CURDATE(), INTERVAL 30 DAY) AND CURDATE()
GROUP BY e.nom_ent, e.adresse_ent, e.ville_ent, e.pays_ent;

SELECT * FROM entrepot_expeditions_30jours;

-- Créez une procédure stockée qui prend en entrée l'ID d'un entrepôt et renvoie le nombre total d'expéditions envoyées par cet entrepôt au cours du dernier mois

DELIMITER //

CREATE PROCEDURE GetExpeditionsLastMonth(IN entrepotID INT)
BEGIN
    SELECT COUNT(id_exp) AS totalExpeditions
    FROM expeditions 
    WHERE id_ent_source = entrepotID 
    AND date_exp BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND CURDATE();
END //

DELIMITER ;

CALL GetExpeditionsLastMonth(3);

-- Créez une fonction qui prend en entrée une date et renvoie le nombre total d'expéditions livrées ce jour-là

DELIMITER //

CREATE FUNCTION GetTotalExpeditionsByDate(input_date DATE) RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE totalExpeditions INT;

    SELECT COUNT(*)
    INTO totalExpeditions
    FROM expeditions
    WHERE date_livraison = input_date AND statut = 'Livrée';

    RETURN totalExpeditions;
END //

DELIMITER ;

SELECT GetTotalExpeditionsByDate('2023-11-02');