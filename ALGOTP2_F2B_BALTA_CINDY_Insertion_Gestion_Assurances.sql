-- Création des clients
	INSERT INTO CLIENT (NOM,ADRESSE) 
	VALUES('BROUSSE LUC','1 RUE DES PLANTES 67000 STRASBOURG');
	
	INSERT INTO CLIENT (NOM,ADRESSE) 
	VALUES('RENARD MARIE','20 RUE MARTIN 67000 STRASBOURG');
	
	INSERT INTO CLIENT (NOM,ADRESSE) 
	VALUES('RENE AXEL','12 ALLEE DES POLYANTHAS 67000 STRASBOURG');
	
	INSERT INTO CLIENT (NOM,ADRESSE) 
	VALUES('KADUC LUCY','55 AVENUE DES ETANGS 35000 RENNES');
	
	INSERT INTO CLIENT (NOM,ADRESSE) 
	VALUES('KADUC JEAN-PIERRE','55 AVENUE DES ETANGS 35000 RENNES');
	
-- Création des contrats (certains clients n'en ont pas encore)
	-- Contrat de Marie Renard
	INSERT INTO CONTRAT (SIGNATAIRE,NUMCTR,TYPECTR,DATESIGN) 
	VALUES	( 
				(select NUMCLIENT 	from CLIENT where NOM like 'RENARD MARIE'),
				(select max(NUMCTR) from CONTRAT)+1,
				'AUTO',
				'2017-06-01'
			);
	
	-- Premier contrat de Lucy Kaduc
	INSERT INTO CONTRAT (SIGNATAIRE,NUMCTR,TYPECTR,DATESIGN) 
	VALUES	( 
				(select NUMCLIENT 	from CLIENT where NOM like 'KADUC LUCY'),
				(select max(NUMCTR) from CONTRAT)+1,
				'AUTO',
				'2015-01-12'
			);
			
	-- Deuxième contrat de Lucy Kaduc (contrat d'habitation, non lié à une voiture)
	INSERT INTO CONTRAT (SIGNATAIRE,NUMCTR,TYPECTR,DATESIGN) 
	VALUES	( 
				(select NUMCLIENT 	from CLIENT where NOM like 'KADUC LUCY'),
				(select max(NUMCTR) from CONTRAT)+1,
				'HABITATION',
				'2016-05-05'
			);
			
	-- Contrat d'Axel Rene (couvrant plusieurs voitures)
	INSERT INTO CONTRAT (SIGNATAIRE,NUMCTR,TYPECTR,DATESIGN) 
	VALUES	( 
				(select NUMCLIENT 	from CLIENT where NOM like 'RENE AXEL'),
				(select max(NUMCTR) from CONTRAT)+1,
				'AUTO',
				'2010-04-04'
			);
			
-- Création des véhicules
	-- La base de données ne permet pas d'avoir un véhicule sans contrat ni propriétaire
	
	-- Véhicule dont le signataire de contrat et le propriétaire sont la même personne (Marie Renard)
	INSERT INTO VEHICULE (NUMVEH,MARQUE,MODELE,ANNEE,CYLINDREE,SIGNATAIRE,NUMCTR,NUMCLIENT)
	VALUES (
				(select max(NUMVEH) from VEHICULE)+1,
				'AUDI',
				'TT',
				2008,
				'1000CM3',
				(select NUMCLIENT 	from CLIENT where NOM like 'RENARD MARIE'),
				(select SIGNATAIRE 	from CONTRAT where SIGNATAIRE = (select NUMCLIENT 	from CLIENT where NOM like 'RENARD MARIE')),
				(select NUMCTR 		from CONTRAT where SIGNATAIRE = (select SIGNATAIRE 	from CONTRAT where SIGNATAIRE = (select NUMCLIENT from CLIENT where NOM like 'RENARD MARIE') and TYPECTR = 'AUTO'),
			);
			
	-- Véhicule dont le signataire de contrat (Lucy Kaduc) et le propriétaire (Luc Brousse) ne sont pas la même personne
	INSERT INTO VEHICULE (NUMVEH,MARQUE,MODELE,ANNEE,CYLINDREE,SIGNATAIRE,NUMCTR,NUMCLIENT)
	VALUES (
				(select max(NUMVEH) from VEHICULE)+1,
				'CHEVROLET',
				'CAMARO',
				1992,
				'5000CM3',
				(select NUMCLIENT 	from CLIENT where NOM like 'BROUSSE LUC'),
				(select SIGNATAIRE 	from CONTRAT where SIGNATAIRE = (select NUMCLIENT 	from CLIENT where NOM like 'KADUC LUCY')),
				(select NUMCTR 		from CONTRAT where SIGNATAIRE = (select SIGNATAIRE 	from CONTRAT where SIGNATAIRE = (select NUMCLIENT from CLIENT where NOM like 'KADUC LUCY') and TYPECTR = 'AUTO')),
			);
			
	-- Véhicules dont le signataire de contrat et le propriétaire sont la même personne (Axel Rene) et assurés par le même contrat
	INSERT INTO VEHICULE (NUMVEH,MARQUE,MODELE,ANNEE,CYLINDREE,SIGNATAIRE,NUMCTR,NUMCLIENT)
	VALUES (
				(select max(NUMVEH) from VEHICULE)+1,
				'RENAUD',
				'TWINGO',
				2003,
				'400CM3',
				(select NUMCLIENT 	from CLIENT where NOM like 'RENE AXEL'),
				(select SIGNATAIRE 	from CONTRAT where SIGNATAIRE = (select NUMCLIENT 	from CLIENT where NOM like 'RENE AXEL')),
				(select NUMCTR 		from CONTRAT where SIGNATAIRE = (select SIGNATAIRE 	from CONTRAT where SIGNATAIRE = (select NUMCLIENT from CLIENT where NOM like 'RENE AXEL') and TYPECTR = 'AUTO'),
			);
			
	INSERT INTO VEHICULE (NUMVEH,MARQUE,MODELE,ANNEE,CYLINDREE,SIGNATAIRE,NUMCTR,NUMCLIENT)
	VALUES (
				(select max(NUMVEH) from VEHICULE)+1,
				'RENAUD',
				'CLIO',
				2005,
				'400CM3',
				(select NUMCLIENT 	from CLIENT where NOM like 'RENE AXEL'),
				(select SIGNATAIRE 	from CONTRAT where SIGNATAIRE = (select NUMCLIENT 	from CLIENT where NOM like 'RENE AXEL')),
				(select NUMCTR 		from CONTRAT where SIGNATAIRE = (select SIGNATAIRE 	from CONTRAT where SIGNATAIRE = (select NUMCLIENT from CLIENT where NOM like 'RENE AXEL') and TYPECTR = 'AUTO'),
			);
			
-- Insertion des accidents
	-- Un accident...
	INSERT INTO ACCIDENT (DATEACC,MONTANT)
	VALUES ('2017-06-01',1635);
	
		-- ...impliquant une voiture seule (celle de Marie Renard)
		INSERT INTO IMPLICATION (NUMACC,NUMVEH)
		VALUES	(
					(select NUMACC from ACCIDENT where DATEACC like '2017-06-01'),
					(select NUMVEH from VEHICULE where SIGNATAIRE  = (select SIGNATAIRE from CONTRAT where SIGNATAIRE = (select NUMCLIENT from CLIENT where NOM like 'RENARD MARIE')))
				);
		
		
	-- Un autre accident...
	INSERT INTO ACCIDENT (DATEACC,MONTANT)
	VALUES ('2017-01-01',NULL);
	
		-- ...impliquant deux voitures (celle de Marie Renard et celle de Jean-Pierre Kaduc)
		INSERT INTO IMPLICATION (NUMACC,NUMVEH)
		VALUES	(
					(select NUMACC from ACCIDENT where DATEACC like '2017-01-01'),
					(select NUMVEH from VEHICULE where SIGNATAIRE  = (select SIGNATAIRE from CONTRAT where SIGNATAIRE = (select NUMCLIENT from CLIENT where NOM like 'RENARD MARIE')))
				);
				
		INSERT INTO IMPLICATION (NUMACC,NUMVEH)
		VALUES	(
					(select NUMACC from ACCIDENT where DATEACC like '2017-01-01'),
					(select NUMVEH from VEHICULE where SIGNATAIRE  = (select SIGNATAIRE from CONTRAT where SIGNATAIRE = (select NUMCLIENT from CLIENT where NOM like 'KADUC LUCY')))
				);
	
	-- Accident domestique n'impliquant aucun véhicule
	INSERT INTO ACCIDENT (DATEACC,MONTANT)
	VALUES ('2008-11-30',65);