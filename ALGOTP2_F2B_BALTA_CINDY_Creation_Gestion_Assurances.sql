PRAGMA Foreign_Keys = ON;

--create schema GESTION_ASSURANCES;

-- Table CLIENT
create table CLIENT 	(	
							NUMCLIENT	int identity(15)   	not null,
							NOM 		char(32)  			not null,
							ADRESSE		char(100) 			not null,
							constraint CLI_PK	primary key (NUMCLIENT)
						);
						
-- Table CONTRAT
create table CONTRAT 	(	
							SIGNATAIRE	int(15)   	not null,
							NUMCTR 		int(15)  	not null,
							TYPECTR		char(50) 	not null,
							DATESIGN	date(10)	not null,
							constraint CTR_PK 	primary key (SIGNATAIRE,NUMCTR),
							constraint CTR_FK 	foreign key (SIGNATAIRE) references CLIENT
								on delete no action on update cascade
						);
					
-- Table VEHICULE
create table VEHICULE 	(	
							NUMVEH		int indentity(15)   not null,
							MARQUE 		char(20)  			not null,
							MODELE		char(20)  			not null,
							ANNEE		int(4)				not null,
							CYLINDREE	char(10)			not null,
							SIGNATAIRE	int(15)				not null,
							NUMCTR		int(15)				not null,
							NUMCLIENT	int(15)				not null,
							constraint VEH_PK	 	primary key (NUMVEH),
							constraint VEH_CTRFK 	foreign key (SIGNATAIRE,NUMCTR) references CONTRAT
								on delete no action on update cascade,
							constraint VEH_CLIFK 	foreign key (NUMCLIENT) references CLIENT
								on delete no action on update cascade
						);
						
-- Table ACCIDENT
create table ACCIDENT 	(	
							NUMACC		int identity(15)  	not null,
							DATEACC 	date(10)  			not null,
							MONTANT		int(7)				,
							constraint ACC_PK primary key (NUMACC)	
						);						
						
-- Table IMPLICATION
create table IMPLICATION 	(	
								NUMACC		int(15)   	not null,
								NUMVEH 		int(15)  	not null,
								constraint IMP_PK 		primary key (NUMACC,NUMVEH),
								constraint IMP_VEHFK 	foreign key (NUMVEH) references VEHICULE
									on delete no action on update cascade,
								constraint IMP_ACCFK 	foreign key (NUMACC) references ACCIDENT
									on delete no action on update cascade
							);
							
-- INDEX sur la table CLIENT
create index XCLI_NUMCLIENT		on CLIENT(NUMCLIENT);
create index XCLI_NOM	 		on CLIENT(NOM);

-- INDEX sur la table CONTRAT
create index XCTR_SIGNATAIRE 	on CONTRAT(SIGNATAIRE);
create index XCTR_NUMCTR	 	on CONTRAT(NUMCTR);

-- INDEX sur la table VEHICULE
create index XVEH_NUMVEH		on VEHICULE(NUMVEH);
create index XVEH_SIGNATAIRE 	on VEHICULE(SIGNATAIRE);
create index XVEH_NUMCLIENT		on VEHICULE(NUMCLIENT);
create index XVEH_NUMCTR	 	on VEHICULE(NUMCTR);

-- INDEX sur la table ACCIDENT
create index XACC_NUMACC 		on ACCIDENT(NUMACC);
create index XACC_DATE	 		on ACCIDENT(DATEACC);

-- INDEX sur la table IMPLICATION
create index XIMP_NUMACC 		on IMPLICATION(NUMACC);
create index XIMP_NUMVEH	 	on IMPLICATION(NUMVEH);