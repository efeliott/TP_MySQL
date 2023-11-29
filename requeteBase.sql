-- Afficher tous les entrepots
SELECT * FROM entrepots;

-- Afficher toutes les expéditions 
SELECT * FROM expeditions;

-- Afficher toutes les expéditions en transit
SELECT * FROM expeditions WHERE statut = "En transit";

-- Afficher toutes les expéditions livrées
SELECT * FROM expeditions WHERE statut = "Livrée";