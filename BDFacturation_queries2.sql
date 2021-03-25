-- 1-Donner les pays dans lesquels se trouvent des clients de catÃ©gorie 1 ou 2.
-- Trier-les par ordre alphabÃ©tique.
    SELECT PAYS FROM CLIENTS WHERE CATEGORIE=1 OR  CATEGORIE=2 ORDER BY PAYS ASC;
    
-- 2-Donner la rÃ©fÃ©rence des produits qui ont Ã©tÃ© commandÃ©s en quantitÃ© 15 ou en quantitÃ© 20.
-- Trier-les par ordre dÃ©croissant.
    
    SELECT REF_PRODUIT FROM DETAILS_COMMANDES WHERE QUANTITE=15 OR QUANTITE=20 ORDER BY REF_PRODUIT DESC;
    
-- 3-Donner la rÃ©fÃ©rence des produits qui ont Ã©tÃ© commandÃ©s en quantitÃ© 15 et en quantitÃ© 20.
-- Donner 2 Ã©critures.
    
    SELECT REF_PRODUIT FROM DETAILS_COMMANDES WHERE QUANTITE=15 AND REF_PRODUIT IN (SELECT REF_PRODUIT FROM DETAILS_COMMANDES WHERE QUANTITE=20);

    SELECT DISTINCT REF_PRODUIT FROM DETAILS_COMMANDES WHERE QUANTITE=15 INTERSECT SELECT REF_PRODUIT FROM DETAILS_COMMANDES WHERE QUANTITE=20;

-- 4-Donner le code des clients espagnols qui n'ont pas commandÃ©.
-- Donner 2 Ã©critures.
      
    SELECT CODE_CLIENT, SOCIETE FROM CLIENTS WHERE CODE_CLIENT NOT IN (SELECT CODE_CLIENT FROM COMMANDES) AND PAYS='Espagne';


-- 5-Donner le numÃ©ro des commandes de aout 2008 des clients
-- habitant au Royaume-Uni ou Ã  Toulouse.
-- Afficher le jour de la commande.
    
    SELECT NO_COMMANDE, TO_CHAR(DATE_COMMANDE,'DD') AS DATECOM FROM COMMANDES COM JOIN CLIENTS C ON COM.CODE_CLIENT=C.CODE_CLIENT WHERE TO_CHAR(DATE_COMMANDE,'MM/YYYY')='08/2008' AND (PAYS='Royaume-Uni' OR VILLE='Toulouse');

-- 6-Donner le code et le pays des clients ayant commandÃ© le produit nÂ°31.
-- Afficher le pays sous cette forme : Aut. (3 premiÃ¨res lettres + point).
    
    SELECT DISTINCT C.CODE_CLIENT, C.PAYS FROM CLIENTS C JOIN COMMANDES COM ON C.CODE_CLIENT=COM.CODE_CLIENT JOIN DETAILS_COMMANDES D ON COM.NO_COMMANDE=D.NO_COMMANDE WHERE D.REF_PRODUIT=31;
    
-- 7-Donner le code et la sociÃ©tÃ© des clients de catÃ©gorie 1 avec le numÃ©ro de leurs commandes
-- (on veut afficher tous les clients mÃªme ceux qui n'ont pas encore de commande).
-- Trier les lignes par numÃ©ro de commande.
    SELECT C.CODE_CLIENT, SOCIETE, NO_COMMANDE FROM CLIENTS C JOIN COMMANDES COM ON C.CODE_CLIENT=COM.CODE_CLIENT WHERE C.CATEGORIE=1 ORDER BY COM.NO_COMMANDE ASC NULLS FIRST;
    
    SELECT CODE_CLIENT FROM CLIENTS WHERE CATEGORIE=1 AND CODE_CLIENT NOT IN (SELECT CODE_CLIENT FROM COMMANDES);
    
-- 8-RequÃªte 4 avec une jointure externe (anti-jointure).

-- 9-RequÃªte 4 avec un NOT EXISTS.

-- 10-Donner la rÃ©fÃ©rence des produits dont le nom contient 'Sauce'
-- ou qui ont Ã©tÃ© commandÃ© avec une quantitÃ© comprise entre 50 et 60.

-- 11-Donner les produits commandÃ©s en mÃªme quantitÃ© dans une mÃªme commande
-- (uniquement si la quantitÃ© est supÃ©rieure Ã  45).

-- 12-Donner pour chaque produit, les produits qui coutent 10â‚¬ de plus.
-- Afficher les rÃ©fÃ©rences et les prix des produits
-- Trier par produit.

-- 13-Donner le nombre de clients qui ont commandÃ© le produit nÂ° 31.
    SELECT COUNT(CODE_CLIENT) AS NB_CLIENT FROM COMMANDES COM JOIN DETAILS_COMMANDES D ON COM.NO_COMMANDE=D.NO_COMMANDE WHERE D.REF_PRODUIT=31;

-- 14-Donner la rÃ©fÃ©rence et le nom du ou des produits les plus chers.
    SELECT REF_PRODUIT FROM PRODUITS WHERE PRIX_UNITAIRE=(SELECT MAX(PRIX_UNITAIRE) FROM PRODUITS);
-- 15-Donner le nombre de clients de catÃ©gorie 0 ou 1 par pays (sauf la France).
-- Trier par nombre dÃ©croissant.

    SELECT COUNT(CODE_CLIENT), PAYS FROM CLIENTS WHERE (CATEGORIE=0 OR CATEGORIE=1) AND PAYS!='France' GROUP BY PAYS;


-- 16-Donner le nombre de clients par pays et par catÃ©gorie.
-- Trier par pays, catÃ©gorie.
    SELECT COUNT(CODE_CLIENT)AS NB_CLIENT, CATEGORIE, PAYS FROM CLIENTS GROUP BY PAYS,CATEGORIE;
-- 17-Donner les pays ayant des sociÃ©tÃ©s d'au moins 2 catÃ©gories diffÃ©rentes.
  
-- 18-Donner le nombre de produits total par commande (uniquement si au moins 4 rÃ©fÃ©rences diffÃ©rentes).
    SELECT COUNT(DISTINCT REF_PRODUIT) as NB_PRODUITS, NO_COMMANDE FROM DETAILS_COMMANDES HAVING COUNT(DISTINCT REF_PRODUIT)>=4 GROUP BY NO_COMMANDE;
    
-- 19-Donner la rÃ©fÃ©rence des commandes dont le montant est supÃ©rieur Ã  20000
-- (afficher le montant total de la facture).
-- VÃ©rifier le rÃ©sultat pour une facture.
    SELECT SUM(PRIX_UNITAIRE) AS TOTAL,NO_COMMANDE FROM PRODUITS P JOIN DETAILS_COMMANDES D ON P.REF_PRODUIT=D.REF_PRODUIT GROUP BY NO_COMMANDE HAVING SUM(PRIX_UNITAIRE)>=20000 ORDER BY TOTAL ASC;
    -- Verifier si bien 0 commande à ce prix

-- 20-Donner le numÃ©ro et la date des commandes avec au moins 4 rÃ©fÃ©rences diffÃ©rentes.
    SELECT NO_COMMANDE, TO_CHAR(DATE_COMMANDE, 'DD/MM/YYYY') FROM COMMANDES WHERE NO_COMMANDE IN (SELECT NO_COMMANDE FROM DETAILS_COMMANDES GROUP BY (NO_COMMANDE)  HAVING COUNT(DISTINCT REF_PRODUIT)>=4);
    
-- 21-Donner le numÃ©ro des commandes contenant tous les produits qui coutent 105â‚¬.

-- 22-Donner la rÃ©fÃ©rence des produits qui sont dans toutes les commandes de ERNSH.

-- 23-Donner la rÃ©fÃ©rence du produit qui a Ã©tÃ© le plus commandÃ©.

-- 24-Donner le numÃ©ro des commandes de 2010 (avec le code des clients) contenant tous les produits les plus chers.
