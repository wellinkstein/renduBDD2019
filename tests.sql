-------------------------------------------------------
------------------------ TESTS ------------------------
-------------------------------------------------------

-- Une intervention ne peut pas être programmée sur un photomètre opérationnel.

-- test déclenchement

CREATE OR REPLACE PROCEDURE test_ctrInterPhotoInv as
    VPho NUMBER;
BEGIN
    INSERT INTO Photometre VALUES (1, 0.20, 1, 'modele', to_date('01-01-2010'));
    SELECT SEQUENCE_16.currval into VPho FROM dual;
    INSERT INTO Intervention VALUES (1, Vpho, TO_DATE('25/03/2019'), 'societe');
END;
/
commit;

call test_ctrInterPhotoInv();
/
commit;

-- test non déclenchement

CREATE OR REPLACE PROCEDURE test_ctrInterPhotoVal as
    VPho NUMBER;
BEGIN
    INSERT INTO Photometre VALUES (1, 0.20, 0, 'modele', to_date('01-01-2010'));
    SELECT SEQUENCE_16.currval into VPho FROM dual;
    INSERT INTO Intervention VALUES (1, Vpho, TO_DATE('25/03/2019'), 'societe');
END;
/
commit;

call test_ctrInterPhotoVal();
/
commit;

-- Un réactif de type opacimétrique ne doit pas avoir de valeur pour les couleurs

-- test déclenchement

CREATE OR REPLACE PROCEDURE test_ctrReactifCouleurInv AS
BEGIN
    INSERT INTO Reactif (IdReactif, typeReactif, couleurVivantes, couleurMortes) Values (2, 'opacimétrique', 1, 1);
END;
/
commit;

call test_ctrReactifCouleurInv();
/
commit;

-- test non déclenchement

CREATE OR REPLACE PROCEDURE test_ctrReactifCouleurVal AS
BEGIN
    INSERT INTO Reactif (IdReactif, typeReactif) Values (3, 'opacimétrique');
end;
/
commit;

call test_ctrReactifCouleurVal();
/
commit;

-- La date de prise de photo est postérieure au début de l'experience

-- test déclenchement

CREATE OR REPLACE PROCEDURE test_ctrDatePhotoInv AS
    VU1 NUMBER;
    VU2 NUMBER;
    VEq NUMBER;
    VRea1 NUMBER;
    VLab NUMBER;
    VChe NUMBER;
    VExp NUMBER;
    VPhoto NUMBER;
    VPla NUMBER;
    VUpl NUMBER;
    VSlo NUMBER;
    VPhotom NUMBER;
BEGIN

    INSERT INTO Utilisateur values (1, 'U1', 'mdpU1', 'Laborantin');
    SELECT SEQUENCE_5.currval into VU1 from dual;
    
    INSERT INTO Utilisateur values (1, 'U2', 'mdpU2', 'Checheur');
    SELECT SEQUENCE_5.currval into VU2 from dual;

    INSERT INTO Equipe values (1, 'coor1');
    SELECT SEQUENCE_8.currval into VEq from dual;
    
    INSERT INTO Laborantin values (1, VU1, VEq, 'Nomlab', 'Prenonomlab');
    SELECT SEQUENCE_3.currval into VLab from dual;
    
    INSERT INTO Chercheur values (1, VEq, VU2, 'C1', 'C1');
    SELECT SEQUENCE_6.currval into VChe from dual;
    
    INSERT INTO Reactif(IdReactif, nomReactif, typeReactif, fournisseurReactif, prixReactif) values (1, 'R1', 'Opacimétrique', 'f1', 1.0);
    SELECT SEQUENCE_14.currval into VRea1 from dual;

    INSERT INTO Experience (IdExperience, IdReactif, IdChercheur, IdLaborantin, DateSoumission, dateDebut, typeExperience) values(1, VRea1, VChe, VLab, TO_DATE('25/03/2019'), TO_DATE('26/03/2019'), 'Opacimétrique');
    SELECT SEQUENCE_2.currval into Vexp from dual;
    
    INSERT INTO Plaque VALUES (1, 96, 1.0);
    SELECT SEQUENCE_11.currval into VPla from dual;
    
    INSERT INTO Uplet VALUES (1, VPla, VExp, 1.0, 1.0,0);
    SELECT SEQUENCE_10.currval into VUpl from dual;
    
    INSERT INTO Slot (IDSlot, IdUplet, IdPlaque) values (1, VUpl, VPla);
    SELECT SEQUENCE_13.currval into VSlo from dual;
    
    INSERT INTO Photometre (IdPhotometre, operationnel) VALUES (1, 1);
    SELECT SEQUENCE_16.currval into VPhotom from dual;
    
    INSERT INTO Photo VALUES (1, VPhotom, VPla, to_date('27/03/2019'));
    SELECT SEQUENCE_12.currval into VPhoto from dual;
END;
/
commit;

call test_ctrDatePhotoInv();
/
commit;

-- test non déclenchement

CREATE OR REPLACE PROCEDURE test_ctrDatePhotoVal AS
    VU1 NUMBER;
    VU2 NUMBER;
    VEq NUMBER;
    VRea1 NUMBER;
    VLab NUMBER;
    VChe NUMBER;
    VExp NUMBER;
    VPhoto NUMBER;
    VPla NUMBER;
    VUpl NUMBER;
    VSlo NUMBER;
    VPhotom NUMBER;
BEGIN

    INSERT INTO Utilisateur values (1, 'U1', 'mdpU1', 'Laborantin');
    SELECT SEQUENCE_5.currval into VU1 from dual;
    
    INSERT INTO Utilisateur values (1, 'U2', 'mdpU2', 'Checheur');
    SELECT SEQUENCE_5.currval into VU2 from dual;

    INSERT INTO Equipe values (1, 'coor1');
    SELECT SEQUENCE_8.currval into VEq from dual;
    
    INSERT INTO Laborantin values (1, VU1, VEq, 'Nomlab', 'Prenonomlab');
    SELECT SEQUENCE_3.currval into VLab from dual;
    
    INSERT INTO Chercheur values (1, VEq, VU2, 'C1', 'C1');
    SELECT SEQUENCE_6.currval into VChe from dual;
    
    INSERT INTO Reactif(IdReactif, nomReactif, typeReactif, fournisseurReactif, prixReactif) values (1, 'R1', 'Opacimétrique', 'f1', 1.0);
    SELECT SEQUENCE_14.currval into VRea1 from dual;

    INSERT INTO Experience (IdExperience, IdReactif, IdChercheur, IdLaborantin, DateSoumission, dateDebut, typeExperience) values(1, VRea1, VChe, VLab, TO_DATE('25/03/2019'), TO_DATE('26/03/2019'), 'Opacimétrique');
    SELECT SEQUENCE_2.currval into Vexp from dual;
    
    INSERT INTO Plaque VALUES (1, 96, 1.0);
    SELECT SEQUENCE_11.currval into VPla from dual;
    
    INSERT INTO Uplet VALUES (1, VPla, VExp, 1.0, 1.0, 0);
    SELECT SEQUENCE_10.currval into VUpl from dual;
    
    INSERT INTO Slot (IDSlot, IdUplet, IdPlaque) values (1, VUpl, VPla);
    SELECT SEQUENCE_13.currval into VSlo from dual;
    
    INSERT INTO Photometre (IdPhotometre, operationnel) VALUES (1, 1);
    SELECT SEQUENCE_16.currval into VPhotom from dual;
    
    INSERT INTO Photo VALUES (1, VPhotom, VPla, to_date('24/03/2019'));
    SELECT SEQUENCE_12.currval into VPhoto from dual;

END;
/
commit;

call test_ctrDatePhotoVal();
/
commit;

-- La date de prise de photo est antérieure à la date de validation de l'expérience

-- test declenchement

CREATE OR REPLACE PROCEDURE test_ctrDateAntPhotoInv AS
    VU1 NUMBER;
    VU2 NUMBER;
    VEq NUMBER;
    VRea1 NUMBER;
    VLab NUMBER;
    VChe NUMBER;
    VExp NUMBER;
    VPhoto NUMBER;
    VPla NUMBER;
    VUpl NUMBER;
    VSlo NUMBER;
    VPhotom NUMBER;
BEGIN

    INSERT INTO Utilisateur values (1, 'U1', 'mdpU1', 'Laborantin');
    SELECT SEQUENCE_5.currval into VU1 from dual;
    
    INSERT INTO Utilisateur values (1, 'U2', 'mdpU2', 'Checheur');
    SELECT SEQUENCE_5.currval into VU2 from dual;

    INSERT INTO Equipe values (1, 'coor1');
    SELECT SEQUENCE_8.currval into VEq from dual;
    
    INSERT INTO Laborantin values (1, VU1, VEq, 'Nomlab', 'Prenonomlab');
    SELECT SEQUENCE_3.currval into VLab from dual;
    
    INSERT INTO Chercheur values (1, VEq, VU2, 'C1', 'C1');
    SELECT SEQUENCE_6.currval into VChe from dual;
    
    INSERT INTO Reactif(IdReactif, nomReactif, typeReactif, fournisseurReactif, prixReactif) values (1, 'R1', 'Opacimétrique', 'f1', 1.0);
    SELECT SEQUENCE_14.currval into VRea1 from dual;

    INSERT INTO Experience (IdExperience, IdReactif, IdChercheur, IdLaborantin, DateSoumission, dateDebut, dateFin, dateTransmission, typeExperience) values(1, VRea1, VChe, VLab, TO_DATE('20/03/2019'), TO_DATE('21/03/2019'), TO_DATE('30/03/2019'), TO_DATE('31/03/2019'), 'Opacimétrique');
    SELECT SEQUENCE_2.currval into Vexp from dual;
    
    INSERT INTO Plaque VALUES (1, 96, 1.0);
    SELECT SEQUENCE_11.currval into VPla from dual;
    
    INSERT INTO Uplet VALUES (1, VPla, VExp, 1.0, 1.0, 0);
    SELECT SEQUENCE_10.currval into VUpl from dual;
    
    INSERT INTO Slot (IDSlot, IdUplet, IdPlaque) values (1, VUpl, VPla);
    SELECT SEQUENCE_13.currval into VSlo from dual;
    
    INSERT INTO Photometre (IdPhotometre, operationnel) VALUES (1, 1);
    SELECT SEQUENCE_16.currval into VPhotom from dual;
    
    INSERT INTO Photo VALUES (1, VPhotom, VPla, to_date('27/03/2019'));
    SELECT SEQUENCE_12.currval into VPhoto from dual;
    
    INSERT INTO Validation (IdValidation, IdExperience, dateValidation) values (1,VExp,to_date('24/03/2019'));
END;
/
commit;

call test_ctrDateAntPhotoInv();
/
commit;

-- test non déclenchement

CREATE OR REPLACE PROCEDURE test_ctrDateAntPhotoVal AS
    VU1 NUMBER;
    VU2 NUMBER;
    VEq NUMBER;
    VRea1 NUMBER;
    VLab NUMBER;
    VChe NUMBER;
    VExp NUMBER;
    VPhoto NUMBER;
    VPla NUMBER;
    VUpl NUMBER;
    VSlo NUMBER;
    VPhotom NUMBER;
BEGIN

    INSERT INTO Utilisateur values (1, 'U1', 'mdpU1', 'Laborantin');
    SELECT SEQUENCE_5.currval into VU1 from dual;
    
    INSERT INTO Utilisateur values (1, 'U2', 'mdpU2', 'Checheur');
    SELECT SEQUENCE_5.currval into VU2 from dual;

    INSERT INTO Equipe values (1, 'coor1');
    SELECT SEQUENCE_8.currval into VEq from dual;
    
    INSERT INTO Laborantin values (1, VU1, VEq, 'Nomlab', 'Prenonomlab');
    SELECT SEQUENCE_3.currval into VLab from dual;
    
    INSERT INTO Chercheur values (1, VEq, VU2, 'C1', 'C1');
    SELECT SEQUENCE_6.currval into VChe from dual;
    
    INSERT INTO Reactif(IdReactif, nomReactif, typeReactif, fournisseurReactif, prixReactif) values (1, 'R1', 'Opacimétrique', 'f1', 1.0);
    SELECT SEQUENCE_14.currval into VRea1 from dual;

    INSERT INTO Experience (IdExperience, IdReactif, IdChercheur, IdLaborantin, DateSoumission, dateDebut, typeExperience) values(1, VRea1, VChe, VLab, TO_DATE('25/03/2019'), TO_DATE('26/03/2019'), 'Opacimétrique');
    SELECT SEQUENCE_2.currval into Vexp from dual;
    
    INSERT INTO Plaque VALUES (1, 96, 1.0);
    SELECT SEQUENCE_11.currval into VPla from dual;
    
    INSERT INTO Uplet VALUES (1, VPla, VExp, 1.0, 1.0, 0);
    SELECT SEQUENCE_10.currval into VUpl from dual;
    
    INSERT INTO Slot (IDSlot, IdUplet, IdPlaque) values (1, VUpl, VPla);
    SELECT SEQUENCE_13.currval into VSlo from dual;
    
    INSERT INTO Photometre (IdPhotometre, operationnel) VALUES (1, 1);
    SELECT SEQUENCE_16.currval into VPhotom from dual;
    
    INSERT INTO Photo VALUES (1, VPhotom, VPla, to_date('27/03/2019'));
    SELECT SEQUENCE_12.currval into VPhoto from dual;
    
    INSERT INTO Validation (IdValidation, IdExperience, dateValidation) values (1,VExp,to_date('28/03/2019'));
END;
/
commit;

call test_ctrDateAntPhotoVal();
/
commit;

-- Une photo ne peut pas être prise par un photometre dans un état non opérationnel

--test déclenchement

CREATE OR REPLACE PROCEDURE test_ctrPhotoOpeInv AS
    VPhotom NUMBER;
    VPlaque NUMBER;
BEGIN
    INSERT INTO Photometre VALUES (1, 1.0, 0, 'mod1', to_date('01-01-2010'));
    SELECT SEQUENCE_16.currval INTO VPhotom from dual;
    
    INSERT INTO Plaque VALUES (1, 96, 1.0);
    SELECT SEQUENCE_11.currval INTO Vplaque from dual;
    
    INSERT INTO Photo (IdPhoto, IdPhotometre, IdPlaque) values (1, VPhotom, VPlaque);
END;
/
COMMIT;

call test_ctrPhotoOpeInv();
/
commit;

-- test non déclenchement

CREATE OR REPLACE PROCEDURE test_ctrPhotoOpeVal AS
    VPhotom NUMBER;
    VPlaque NUMBER;
BEGIN
    INSERT INTO Photometre VALUES (1, 1.0, 1, 'mod1', to_date('01-01-2010'));
    SELECT SEQUENCE_16.currval INTO VPhotom from dual;
    
    INSERT INTO Plaque VALUES (1, 96, 1.0);
    SELECT SEQUENCE_11.currval INTO Vplaque from dual;
    
    INSERT INTO Photo (IdPhoto, IdPhotometre, IdPlaque) values (1, VPhotom, VPlaque);
END;
/
COMMIT;

call test_ctrPhotoOpeVal();
/
commit;

-- La date d'analyse du slot est postérieure à la prise de la photo du slot

-- test déclenchement

CREATE OR REPLACE PROCEDURE test_ctrDateResultSlotInv AS
    VU1 NUMBER;
    VU2 NUMBER;
    VEq NUMBER;
    VRea1 NUMBER;
    VLab NUMBER;
    VChe NUMBER;
    VExp NUMBER;
    VPhoto NUMBER;
    VPla NUMBER;
    VUpl NUMBER;
    VSlo NUMBER;
    VPhotom NUMBER;
BEGIN

    INSERT INTO Utilisateur values (1, 'U1', 'mdpU1', 'Laborantin');
    SELECT SEQUENCE_5.currval into VU1 from dual;
    
    INSERT INTO Utilisateur values (1, 'U2', 'mdpU2', 'Checheur');
    SELECT SEQUENCE_5.currval into VU2 from dual;

    INSERT INTO Equipe values (1, 'coor1');
    SELECT SEQUENCE_8.currval into VEq from dual;
    
    INSERT INTO Laborantin values (1, VU1, VEq, 'Nomlab', 'Prenonomlab');
    SELECT SEQUENCE_3.currval into VLab from dual;
    
    INSERT INTO Chercheur values (1, VEq, VU2, 'C1', 'C1');
    SELECT SEQUENCE_6.currval into VChe from dual;
    
    INSERT INTO Reactif(IdReactif, nomReactif, typeReactif, fournisseurReactif, prixReactif) values (1, 'R1', 'Opacimétrique', 'f1', 1.0);
    SELECT SEQUENCE_14.currval into VRea1 from dual;

    INSERT INTO Experience (IdExperience, IdReactif, IdChercheur, IdLaborantin, DateSoumission, dateDebut, typeExperience) values(1, VRea1, VChe, VLab, TO_DATE('20/03/2019'), TO_DATE('21/03/2019'), 'Opacimétrique');
    SELECT SEQUENCE_2.currval into Vexp from dual;
    
    INSERT INTO Plaque VALUES (1, 96, 1.0);
    SELECT SEQUENCE_11.currval into VPla from dual;
    
    INSERT INTO Uplet VALUES (1, VPla, VExp, 1.0, 1.0, 0);
    SELECT SEQUENCE_10.currval into VUpl from dual;
    
    INSERT INTO Slot (IDSlot, IdUplet, IdPlaque) values (1, VUpl, VPla);
    SELECT SEQUENCE_13.currval into VSlo from dual;
    
    INSERT INTO Photometre (IdPhotometre, operationnel) VALUES (1, 1);
    SELECT SEQUENCE_16.currval into VPhotom from dual;
    
    INSERT INTO Photo VALUES (1, VPhotom, VPla, to_date('27/03/2019'));
    SELECT SEQUENCE_12.currval into VPhoto from dual;
    
    INSERT INTO Resultats_slot (IdResultatSlot, IdSlot, IdPhoto, dateAnalyse) VALUES (1, VSlo, VPhoto, to_date('26/03/2019'));

END;
/
commit;

call test_ctrDateResultSlotInv();
/
commit;

-- test non déclenchement

CREATE OR REPLACE PROCEDURE test_ctrDateResultSlotVal AS
    VU1 NUMBER;
    VU2 NUMBER;
    VEq NUMBER;
    VRea1 NUMBER;
    VLab NUMBER;
    VChe NUMBER;
    VExp NUMBER;
    VPhoto NUMBER;
    VPla NUMBER;
    VUpl NUMBER;
    VSlo NUMBER;
    VPhotom NUMBER;
BEGIN

    INSERT INTO Utilisateur values (1, 'U1', 'mdpU1', 'Laborantin');
    SELECT SEQUENCE_5.currval into VU1 from dual;
    
    INSERT INTO Utilisateur values (1, 'U2', 'mdpU2', 'Checheur');
    SELECT SEQUENCE_5.currval into VU2 from dual;

    INSERT INTO Equipe values (1, 'coor1');
    SELECT SEQUENCE_8.currval into VEq from dual;
    
    INSERT INTO Laborantin values (1, VU1, VEq, 'Nomlab', 'Prenonomlab');
    SELECT SEQUENCE_3.currval into VLab from dual;
    
    INSERT INTO Chercheur values (1, VEq, VU2, 'C1', 'C1');
    SELECT SEQUENCE_6.currval into VChe from dual;
    
    INSERT INTO Reactif(IdReactif, nomReactif, typeReactif, fournisseurReactif, prixReactif) values (1, 'R1', 'Opacimétrique', 'f1', 1.0);
    SELECT SEQUENCE_14.currval into VRea1 from dual;

    INSERT INTO Experience (IdExperience, IdReactif, IdChercheur, IdLaborantin, DateSoumission, dateDebut, typeExperience) values(1, VRea1, VChe, VLab, TO_DATE('20/03/2019'), TO_DATE('21/03/2019'), 'Opacimétrique');
    SELECT SEQUENCE_2.currval into Vexp from dual;
    
    INSERT INTO Plaque VALUES (1, 96, 1.0);
    SELECT SEQUENCE_11.currval into VPla from dual;
    
    INSERT INTO Uplet VALUES (1, VPla, VExp, 1.0, 1.0, 0);
    SELECT SEQUENCE_10.currval into VUpl from dual;
    
    INSERT INTO Slot (IDSlot, IdUplet, IdPlaque) values (1, VUpl, VPla);
    SELECT SEQUENCE_13.currval into VSlo from dual;
    
    INSERT INTO Photometre (IdPhotometre, operationnel) VALUES (1, 1);
    SELECT SEQUENCE_16.currval into VPhotom from dual;
    
    INSERT INTO Photo VALUES (1, VPhotom, VPla, to_date('27/03/2019'));
    SELECT SEQUENCE_12.currval into VPhoto from dual;
    
    INSERT INTO Resultats_slot (IdResultatSlot, IdSlot, IdPhoto, dateAnalyse) VALUES (1, VSlo, VPhoto, to_date('28/03/2019'));

END;
/
commit;

call test_ctrDateResultSlotVal();
/
commit;

-- Un uplet ne peut pas contenir un nombre de slot supérieur au nombre de slot max sur une plaque

-- test déclenchement

CREATE OR REPLACE PROCEDURE test_ctrNbSlotUpletInv AS
    VU1 NUMBER;
    VU2 NUMBER;
    VEq NUMBER;
    VRea1 NUMBER;
    VLab NUMBER;
    VChe NUMBER;
    VExp NUMBER;
    VPhoto NUMBER;
    VPla NUMBER;
    VUpl NUMBER;
BEGIN

    INSERT INTO Utilisateur values (1, 'U1', 'mdpU1', 'Laborantin');
    SELECT SEQUENCE_5.currval into VU1 from dual;
    
    INSERT INTO Utilisateur values (1, 'U2', 'mdpU2', 'Checheur');
    SELECT SEQUENCE_5.currval into VU2 from dual;

    INSERT INTO Equipe values (1, 'coor1');
    SELECT SEQUENCE_8.currval into VEq from dual;
    
    INSERT INTO Laborantin values (1, VU1, VEq, 'Nomlab', 'Prenonomlab');
    SELECT SEQUENCE_3.currval into VLab from dual;
    
    INSERT INTO Chercheur values (1, VEq, VU2, 'C1', 'C1');
    SELECT SEQUENCE_6.currval into VChe from dual;
    
    INSERT INTO Reactif(IdReactif, nomReactif, typeReactif, fournisseurReactif, prixReactif) values (1, 'R1', 'Opacimétrique', 'f1', 1.0);
    SELECT SEQUENCE_14.currval into VRea1 from dual;

    INSERT INTO Experience (IdExperience, IdReactif, IdChercheur, IdLaborantin, DateSoumission, dateDebut, typeExperience, nbSlotParUplet) values(1, VRea1, VChe, VLab, TO_DATE('20/03/2019'), TO_DATE('21/03/2019'), 'Opacimétrique', '97');
    SELECT SEQUENCE_2.currval into Vexp from dual;
    
    INSERT INTO Plaque VALUES (1, 96, 1.0);
    SELECT SEQUENCE_11.currval into VPla from dual;
    
    INSERT INTO Uplet VALUES (1, VPla, VExp, 1.0, 1.0, 0);
    SELECT SEQUENCE_10.currval into VUpl from dual;
    
    FOR i IN 1..97 LOOP
        INSERT INTO Slot (IDSlot, IdUplet, IdPlaque) values (1, VUpl, VPla);
    END LOOP;
END;
/
COMMIT;

call test_ctrNbSlotUpletInv();
/
commit;

-- test non déclenchement

CREATE OR REPLACE PROCEDURE test_ctrNbSlotUpletVal AS
    VU1 NUMBER;
    VU2 NUMBER;
    VEq NUMBER;
    VRea1 NUMBER;
    VLab NUMBER;
    VChe NUMBER;
    VExp NUMBER;
    VPhoto NUMBER;
    VPla NUMBER;
    VUpl NUMBER;
BEGIN

    INSERT INTO Utilisateur values (1, 'U1', 'mdpU1', 'Laborantin');
    SELECT SEQUENCE_5.currval into VU1 from dual;
    
    INSERT INTO Utilisateur values (1, 'U2', 'mdpU2', 'Checheur');
    SELECT SEQUENCE_5.currval into VU2 from dual;

    INSERT INTO Equipe values (1, 'coor1');
    SELECT SEQUENCE_8.currval into VEq from dual;
    
    INSERT INTO Laborantin values (1, VU1, VEq, 'Nomlab', 'Prenonomlab');
    SELECT SEQUENCE_3.currval into VLab from dual;
    
    INSERT INTO Chercheur values (1, VEq, VU2, 'C1', 'C1');
    SELECT SEQUENCE_6.currval into VChe from dual;
    
    INSERT INTO Reactif(IdReactif, nomReactif, typeReactif, fournisseurReactif, prixReactif) values (1, 'R1', 'Opacimétrique', 'f1', 1.0);
    SELECT SEQUENCE_14.currval into VRea1 from dual;

    INSERT INTO Experience (IdExperience, IdReactif, IdChercheur, IdLaborantin, DateSoumission, dateDebut, typeExperience, nbSlotParUplet) values(1, VRea1, VChe, VLab, TO_DATE('20/03/2019'), TO_DATE('21/03/2019'), 'Opacimétrique', '96');
    SELECT SEQUENCE_2.currval into Vexp from dual;
    
    INSERT INTO Plaque VALUES (1, 96, 1.0);
    SELECT SEQUENCE_11.currval into VPla from dual;
    
    INSERT INTO Uplet VALUES (1, VPla, VExp, 1.0, 1.0, 0);
    SELECT SEQUENCE_10.currval into VUpl from dual;
    
    FOR i IN 1..96 LOOP
        INSERT INTO Slot (IDSlot, IdUplet, IdPlaque) values (1, VUpl, VPla);
    END LOOP;
END;
/
COMMIT;

call test_ctrNbSlotUpletVal();
/
commit;

-- Après une intervention sur un photomète, le statut du photomètre passe à opérationnel.

CREATE OR REPLACE PROCEDURE test_ctrStatutPhotometre AS
    VPhotom NUMBER;
BEGIN
    
    INSERT INTO Photometre (IdPhotometre, operationnel) VALUES (1, 0);
    SELECT SEQUENCE_16.currval INTO VPhotom FROM dual;
    
    INSERT INTO Intervention (IdIntervention, IdPhotometre) VALUES (1, VPhotom);
END;
/
COMMIT;

CALL test_ctrStatutPhotometre();
/
COMMIT; 
