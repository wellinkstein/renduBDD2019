-- Le nombre de slots sur une plaque ne peut pas �tre sup�rieur au nombre de slots maximum sur la plaque.

CREATE OR REPLACE TRIGGER ctrNbSlotPlaque BEFORE INSERT ON Slot
DECLARE
    nbSlotPlaque INTEGER;
BEGIN
    nbSlotPlaque :=0;
    FOR curseur in (SELECT * FROM Plaque) LOOP
        SELECT COUNT(*) INTO nbSlotPlaque FROM Slot WHERE curseur.IdPlaque = IdPlaque;
        if (nbSlotPlaque >= curseur.nbSlot) then
            raise_application_error(-20115, 'Nombre de slot maximum atteint pour cette plaque');
        END IF;
        nbSlotPlaque :=0;
    END LOOP;
END;
/
COMMIT;

-- Un uplet complet doit contenir un nombre de slots d�fini par l'attribut nbSlotParUplet de la table experience.

CREATE OR REPLACE PROCEDURE ctrSlotsUplet AS
    nbSlot NUMBER;
    nbSlotUplet NUMBER;
BEGIN

FOR CURSEUR IN (SELECT IdUplet, IdExperience, complet FROM Uplet) LOOP
    IF curseur.complet = 1 then
        SELECT COUNT (*) INTO nbSlot FROM Slot WHERE IdUplet = curseur.IdUplet;
        SELECT nbSLotParUplet INTO nbSlotUplet FROM Experience WHERE IdExperience = curseur.IdExperience;
        IF nbSlot != nbSlotUplet THEN
            raise_application_error(-20116, 'La plaque est en statut complet sans avoir un nombre suffisant de slots');
        END IF;
    END if;
END LOOP;

END;
/
COMMIT;

-- Un r�actif opacim�trique ne peut pas �tre utilis� pour une exp�rience colorim�trique.

CREATE OR REPLACE TRIGGER ctrUtilisationReactifOpa BEFORE INSERT ON Experience
FOR EACH ROW
declare
    reaType varchar(25);
begin
    SELECT typeReactif into reaType FROM Reactif WHERE IdReactif = :new.IdReactif;
    if (reaType = 'opacimetrique' and :new.typeExperience = 'colorimetrique')then
        raise_application_error(-20109, 'Un r�actif opacimetrique ne peut pas etre utilise pour une experience colorimetrique');
    end if;
end;
/
commit;

-- Un r�actif colorimetrique ne peut pas �tre utilis� pour une exp�rience opacim�trique.

CREATE OR REPLACE TRIGGER ctrUtilisationReactifColo BEFORE INSERT ON Experience
FOR EACH ROW
DECLARE
    reaType varchar(25);
BEGIN
    SELECT typeReactif INTO reaType FROM Reactif WHERE IdReactif = :new.IdReactif;
    if (reaType = 'colorimetrique' and :new.typeExperience = 'opacimetrique') then
        raise_application_error(-20110, 'Un reactif colorimetrique ne peut pas etre utilise pour une experience opacimetrique');
    end if;
end;
/
commit;

-- La date de validation de l'exp�rience doit �tre prost�rieure � la date de d�but de l'exp�rience et ant�rieure
-- � la date de fin de l'exp�rience.

CREATE OR REPLACE TRIGGER ctrValidationDate BEFORE INSERT ON Validation
FOR EACH ROW
DECLARE
    dateDebutExp date;
    dateFinExp date;
BEGIN
    SELECT (dateDebut) INTO dateDebutExp FROM Experience WHERE IdExperience = :new.IdExperience;
    SELECT (dateFin) INTO dateFinExp FROM Experience WHERE IdExperience = :new.IdExperience;
    if :new.dateValidation < dateDebutExp or :new.dateValidation > dateFinExp then
         raise_application_error(-20111, 'La date de validation de l experience ne peut pas etre anterieure au debut de lexperience et posterieure a la fin de l experience');
    end if;
END;
/
commit;

-- La dur�e de location du photom�tre ne peut pas �tre sup�rieure � la dur�e de l'exp�rience

CREATE OR REPLACE TRIGGER ctrExpDureeLoc BEFORE UPDATE ON Experience
DECLARE
    dureeLocInv number;
BEGIN
    SELECT COUNT (*) INTO dureeLocInv FROM (SELECT * FROM Experience WHERE dureeLocationP is not null and dureeLocationP > dureeExperience)T1;
    if dureeLocInv > 0 then
        raise_application_error(-20112, 'La duree de la location du photometre est superieure a la duree de l experience');
    end if;
end;
/
commit;

-- Calcul du montant de l'exp�rience

CREATE OR REPLACE TRIGGER ctrMontantfacture AFTER UPDATE ON Experience
FOR EACH ROW
DECLARE
    prixRea FLOAT;
    volRea FLOAT;
    coutVolReactif FLOAT;
    coutTotReactif FLOAT;
    coutVolAgentBio FLOAT;
    coutTotAgentBio FLOAT;
    nbSlot NUMBER;
    nbPhotos NUMBER;
    coutPhoto FLOAT;
    coutPhotos FLOAT;
    coutUnePhoto FLOAT;
BEGIN
    IF :new.dateFin != null THEN
        SELECT prixReactif INTO prixRea FROM REACTIF WHERE :new.IdReactif = idReactif;
        SELECT t1.col, t3.col FROM table1 join table2 using (table) join table3 using (table2);
        
        
    END IF;
END;
/
COMMIT;

-- La date de la facture ne peut pas �tre ant�rieure � la date de fin de l'exp�rience

CREATE OR REPLACE TRIGGER ctrFactureDate BEFORE INSERT ON Facture
DECLARE
    dateFactureInv number;
BEGIN
    -- creation d'une dateFin, dateFacture
    SELECT COUNT (*) into dateFactureInv FROM 
    (SELECT Experience.dateFin, Facture.dateFacture FROM Experience INNER JOIN Facture USING (IdFacture))T1 
    WHERE dateFacture < dateFin;
    if dateFactureInv > 0 then
        raise_application_error(-20113, 'La date de la facture est anterieure a la date de fin de lexperience');
    end if;
end;
/
commit;

-- Les valeurs des attibuts de l'ex�rience ne peuvent pas �tre modifi�es une fois que l'exp�rience est termin�e.

CREATE OR REPLACE TRIGGER ctrValeurExp BEFORE UPDATE ON Experience
FOR EACH ROW
BEGIN

    if :old.dateFin like null then
        if :new.IdExperience != :old.IdExperience or
        :new.IdReactif != :old.IdReactif or
        :new.IdChercheur != :old.IdChercheur or
        :new.IdLaborantin != :old.IdLaborantin or
        :new.IdValidation != :old.IdValidation or
        :new.IdFacture != :old.IdFacture or
        :new.dateSoumission != :old.dateSoumission or
        :new.dateDebut != :old.dateDebut or
        :new.dateFin != :old.dateFin or
        :new.dateTransmission != :old.dateTransmission or
        :new.nbSlotParUplet != :old.nbSlotParUplet or
        :new.dureeExperience != :old.dureeExperience or
        :new.urgent != :old.urgent or
        :new.prixAgentBiologique != :old.prixAgentBiologique or
        :new.typeExperience != :old.typeExperience then
            raise_application_error(-20114, 'Une experience finie est non modifiable');
        end if;
    end if;

END;
/
commit;

-- L'exp�rience passe par le statut de soumission, puis d�but, date de fin, date de transmission.

CREATE OR REPLACE TRIGGER ctrTemporalit�Exp�rience BEFORE UPDATE ON Experience
FOR EACH ROW
BEGIN
    if :new.dateDebut < :new.dateSoumission then
        raise_application_error(-20113, 'Erreur temporalit� de l experience');
    end if;
    
    if :new.dateFin < :new.dateDebut then
        raise_application_error(-20114, 'Erreur temporalit� de l experience');
    end if;
    
    if :new.dateTransmission < :new.dateFin then
        raise_application_error(-20114, 'Erreur temporalit� de l experience');
    end if;
    
END;
/
COMMIT;

-- La validation d'une exp�rience affecte l'IdValidation � l'exp�rience

CREATE OR REPLACE TRIGGER valIdExperience AFTER INSERT ON Experience
BEGIN
    FOR curseur IN (SELECT IdValidation, IdExperience FROM Validation) LOOP
        UPDATE Experience SET IdValidation = curseur.IdValidation WHERE curseur.IdExperience=IdExperience;
    END LOOP;
END;
/
COMMIT;

-- A la fin d'une exp�rience, la dur�e de l'exp�rience est �gale � dateDebut-dateFin
CREATE OR REPLACE TRIGGER ctrDureeExperience AFTER UPDATE ON Experience
BEGIN
    for curseur in (SELECT IdExperience FROM Experience WHERE dateDebut!=to_date(null) and dateFin !=to_date(null)) loop
        UPDATE Experience SET dureeExperience = dateFin-dateDebut WHERE curseur.IdExperience = IdExperience;
    end loop;
END;
/
COMMIT;

-- Quand le bon nombre de slot est attribu� � un uplet, il passe au statut "complet"

CREATE OR REPLACE TRIGGER ctrStatutUplet AFTER UPDATE ON Slot
FOR EACH ROW
DECLARE
    nbSlot number;
    nbSlotUplet number;
BEGIN
    SELECT COUNT (*) into nbSlot FROM Slot WHERE IdUplet = :new.IdUplet;
    SELECT nbSlotParUplet into nbSlotUplet FROM Experience WHERE (SELECT (IdExperience) FROM Uplet WHERE IdUplet = :new.IdUplet) = IdExperience;
    if nbSlot = nbSlotUplet then
        UPDATE Uplet SET complet = 1 WHERE IdUplet = :new.IdUplet;
    end if;
END;
/
COMMIT;

-- Apr�s une intervention sur un photom�te, le statut du photom�tre passe � op�rationnel.

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
