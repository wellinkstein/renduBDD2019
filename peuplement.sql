CREATE OR REPLACE PROCEDURE peuplementDefaut AS

    VU1 NUMBER;
    VU2 NUMBER;
    VEq NUMBER;
    VLab NUMBER;
    VChe NUMBER;
    VRea1 NUMBER;
    VRea2 NUMBER;
    VExp NUMBER;
    VVal NUMBER;
    VPla1 NUMBER;
    VPla2 NUMBER;
    VUpl NUMBER;
    VSlo NUMBER;
    VPho1 NUMBER;
    VPho2 NUMBER;
    VPhoto NUMBER;
    VRes NUMBER;
    VInterva NUMBER;
    VIntervi NUMBER;
    
BEGIN

    INSERT INTO Utilisateur values (1, 'U1', 'mdpU1', 'Laborantin');
    SELECT SEQUENCE_5.currval into VU1 from dual;
    
    INSERT INTO Utilisateur values (2, 'U2', 'mdpU2', 'Checheur');
    SELECT SEQUENCE_5.currval into VU2 from dual;

    INSERT INTO Equipe values (1, 'coor1');
    SELECT SEQUENCE_8.currval into VEq from dual;
    
    INSERT INTO Laborantin values (1, VU1, VEq, 'Nomlab', 'Prenonomlab');
    SELECT SEQUENCE_3.currval into VLab from dual;
    
    INSERT INTO Chercheur values (1, VEq, VU2, 'C1', 'C1');
    SELECT SEQUENCE_6.currval into VChe from dual;
    
    INSERT INTO Reactif(IdReactif, nomReactif, typeReactif, fournisseurReactif, prixReactif) values (1, 'R1', 'Opacimétrique', 'f1', 1.0);
    SELECT SEQUENCE_14.currval into VRea1 from dual;
    
    INSERT INTO Reactif values (1, 'R24', 'Colorimétrique', 1.0, 1.0, 'f2', 1.0);
    SELECT SEQUENCE_14.currval into VRea2 from dual;
    
    INSERT INTO Experience(IdExperience, IdReactif, IdChercheur, IdLaborantin, dateSoumission, dateDebut, dateFin, dateTransmission, nbSlotParUplet, dureeExperience, urgent, prixAgentBiologique, dureeLocationP, typeExperience) values(1, VRea1, VChe, VLab, TO_DATE('20/03/2019'), TO_DATE('21/03/2019'), TO_DATE('27/03/2019'), TO_DATE('28/03/2019'), 1, 1, 1, 1.0, 1, 'Opacimétique');
    SELECT SEQUENCE_2.currval into VExp from dual;
    
    INSERT INTO Validation values (1, VExp, 1.0, 1.0, 1.0, 1.0, 1.0, 1, TO_DATE('26/03/2019'));
    SELECT SEQUENCE_9.currval into VVal from dual;
    
    INSERT INTO Plaque values (1, 96, 1.0);
    SELECT SEQUENCE_11.currval into VPla1 from dual;
    
    INSERT INTO Plaque values (1, 384, 1.5);
    SELECT SEQUENCE_11.currval into VPla2 from dual;
    
    INSERT INTO Uplet values (1, VPla1, VExp, 1.0, 1.0,0);
    SELECT SEQUENCE_10.currval into VUpl from dual;
    
    INSERT INTO Slot values (1, VUpl, VPla1, 1.0, 'A', 1.0, 1, 1, 1.0);
    SELECT SEQUENCE_13.currval into VSlo from dual;
    
    INSERT INTO Photometre values (1, 1.0, 1, 'mod1', to_date('01-01-2010'));
    SELECT SEQUENCE_16.currval into VPho1 from dual;
    
    INSERT INTO Photometre values (1, 1.0, 0, 'mod2', to_date('01-01-2010'));
    SELECT SEQUENCE_16.currval into VPho2 from dual;
    
    INSERT INTO Photo values (1, VPho2, VPla1, TO_DATE('22/03/2019'));
    SELECT SEQUENCE_12.currval into VPhoto from dual;
    
    INSERT INTO Resultats_Slot values (1, VSlo, VPhoto, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 'Mortes', TO_DATE('23/03/2019'));
    SELECT SEQUENCE_1.currval into VRes from dual;
    
    INSERT INTO Intervenant values(1, 'NomI', 'PrenomI');
    SELECT SEQUENCE_15.currval into VInterva from dual;
    
    INSERT INTO Intervention values (1, 2, TO_DATE('25/03/2019'), 'soci');
    SELECT SEQUENCE_17.currval into VIntervi from dual;
    
    INSERT INTO intervient_au_cours_d_une values (VInterva,VIntervi);
    
END;
/
COMMIT;

call peuplementDefaut();
/
commit;
