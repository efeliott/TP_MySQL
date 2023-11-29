-- create database
create database transport_logistique;

create table entrepots (
	id_ent int primary key auto_increment,
    nom_ent varchar(50),
    adresse_ent varchar(150),
    ville_ent varchar(50),
    pays_ent varchar(50)
);

create table expeditions (
	id_exp int primary key auto_increment,
    date_exp date,
    id_ent_source int,
    id_ent_dest int,
    poid decimal,
    statut varchar(50),
    FOREIGN KEY (id_ent_source) REFERENCES entrepots(id_ent),
    FOREIGN KEY (id_ent_dest) REFERENCES entrepots(id_ent)
);

-- remplissage table entrepots
INSERT INTO entrepots(nom_ent, adresse_ent, ville_ent, pays_ent)
VALUES ("Lyon Est", "2 Rue Jean Jaures", "Lyon", "France");

INSERT INTO entrepots(nom_ent, adresse_ent, ville_ent, pays_ent)
VALUES ("Bruxelles centre", "15 Rue Lamartine", "Bruxelles", "Belgique");

INSERT INTO entrepots(nom_ent, adresse_ent, ville_ent, pays_ent)
VALUES ("Milan Monza", "8 Avenue Garibaldi", "Milan", "Italie");

INSERT INTO entrepots(nom_ent, adresse_ent, ville_ent, pays_ent)
VALUES ("Paris 18ème", "26 Avenue Foch", "Paris", "France");

INSERT INTO entrepots(nom_ent, adresse_ent, ville_ent, pays_ent)
VALUES ("Berlin Ouest", "41 Rue Bissmark", "Berlin", "Allemagne");

-- remplissage table expedition
INSERT INTO expeditions(date_exp, id_ent_source, id_ent_dest, poid, statut)
VALUES (20231103, 2, 4, 325.50, "Programme");

INSERT INTO expeditions(date_exp, id_ent_source, id_ent_dest, poid, statut)
VALUES (20231101, 1, 5, 540.00, "En transit");

INSERT INTO expeditions(date_exp, id_ent_source, id_ent_dest, poid, statut)
VALUES (20231030, 4, 2, 152.75, "En transit");

INSERT INTO expeditions(date_exp, id_ent_source, id_ent_dest, poid, statut)
VALUES (20231025, 3, 1, 430.20, "Livrée");

INSERT INTO expeditions(date_exp, id_ent_source, id_ent_dest, poid, statut)
VALUES (20231020, 5, 3, 350.00, "Livrée");

INSERT INTO expeditions(date_exp, id_ent_source, id_ent_dest, poid, statut)
VALUES (20231103, 3, 5, 275.65, "Programme");

INSERT INTO expeditions(date_exp, id_ent_source, id_ent_dest, poid, statut)
VALUES (20231101, 2, 1, 125.00, "En transit");

INSERT INTO expeditions(date_exp, id_ent_source, id_ent_dest, poid, statut)
VALUES (20231022, 4, 3, 489.30, "Livrée");

INSERT INTO expeditions(date_exp, id_ent_source, id_ent_dest, poid, statut)
VALUES (20231103, 5, 2, 213.90, "Programme");

INSERT INTO expeditions(date_exp, id_ent_source, id_ent_dest, poid, statut)
VALUES (20231029, 2, 5, 398.20, "En transit");