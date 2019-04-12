-- Déclaration de package type
create or replace package PDTypes  
as
    TYPE ref_cursor IS REF CURSOR;
end;

-- Déclaration du package d'intégrité
create or replace package IntegrityPackage AS
 procedure InitNestLevel;
 function GetNestLevel return number;
 procedure NextNestLevel;
 procedure PreviousNestLevel;
 end IntegrityPackage;
/

-- Définition du package d'intégrité
create or replace package body IntegrityPackage AS
 NestLevel number;

-- Procédure d'initialisation du niveau de trigger
 procedure InitNestLevel is
 begin
 NestLevel := 0;
 end;


-- Fonction retournant le niveau d'imbrication
 function GetNestLevel return number is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 return(NestLevel);
 end;

-- Procédure d'augmentation du niveau de trigger
 procedure NextNestLevel is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 NestLevel := NestLevel + 1;
 end;

-- Procédure de diminution du niveau de trigger
 procedure PreviousNestLevel is
 begin
 NestLevel := NestLevel - 1;
 end;

 end IntegrityPackage;
/


drop trigger COMPOUNDDELETETRIGGER_ACTIONS_
/

drop trigger COMPOUNDINSERTTRIGGER_ACTIONS_
/

drop trigger COMPOUNDUPDATETRIGGER_ACTIONS_
/

drop trigger TIB_ACTIONS_REALISEES
/

drop trigger COMPOUNDDELETETRIGGER_CHERCHEU
/

drop trigger COMPOUNDINSERTTRIGGER_CHERCHEU
/

drop trigger COMPOUNDUPDATETRIGGER_CHERCHEU
/

drop trigger TIB_CHERCHEUR
/

drop trigger COMPOUNDDELETETRIGGER_EQUIPE
/

drop trigger COMPOUNDINSERTTRIGGER_EQUIPE
/

drop trigger COMPOUNDUPDATETRIGGER_EQUIPE
/

drop trigger TIB_EQUIPE
/

drop trigger COMPOUNDDELETETRIGGER_EXPERIEN
/

drop trigger COMPOUNDINSERTTRIGGER_EXPERIEN
/

drop trigger COMPOUNDUPDATETRIGGER_EXPERIEN
/

drop trigger TIB_EXPERIENCE
/

drop trigger COMPOUNDDELETETRIGGER_FACTURE
/

drop trigger COMPOUNDINSERTTRIGGER_FACTURE
/

drop trigger COMPOUNDUPDATETRIGGER_FACTURE
/

drop trigger TIB_FACTURE
/

drop trigger COMPOUNDDELETETRIGGER_INTERVEN
/

drop trigger COMPOUNDINSERTTRIGGER_INTERVEN
/

drop trigger COMPOUNDUPDATETRIGGER_INTERVEN
/

drop trigger TIB_INTERVENANT
/

drop trigger COMPOUNDDELETETRIGGER_INTERVEN
/

drop trigger COMPOUNDINSERTTRIGGER_INTERVEN
/

drop trigger COMPOUNDUPDATETRIGGER_INTERVEN
/

drop trigger TIB_INTERVENTION
/

drop trigger COMPOUNDDELETETRIGGER_LABORANT
/

drop trigger COMPOUNDINSERTTRIGGER_LABORANT
/

drop trigger COMPOUNDUPDATETRIGGER_LABORANT
/

drop trigger TIB_LABORANTIN
/

drop trigger COMPOUNDDELETETRIGGER_PHOTO
/

drop trigger COMPOUNDINSERTTRIGGER_PHOTO
/

drop trigger COMPOUNDUPDATETRIGGER_PHOTO
/

drop trigger TIB_PHOTO
/

drop trigger COMPOUNDDELETETRIGGER_PHOTOMET
/

drop trigger COMPOUNDINSERTTRIGGER_PHOTOMET
/

drop trigger COMPOUNDUPDATETRIGGER_PHOTOMET
/

drop trigger TIB_PHOTOMETRE
/

drop trigger COMPOUNDDELETETRIGGER_PLAQUE
/

drop trigger COMPOUNDINSERTTRIGGER_PLAQUE
/

drop trigger COMPOUNDUPDATETRIGGER_PLAQUE
/

drop trigger TIB_PLAQUE
/

drop trigger COMPOUNDDELETETRIGGER_REACTIF
/

drop trigger COMPOUNDINSERTTRIGGER_REACTIF
/

drop trigger COMPOUNDUPDATETRIGGER_REACTIF
/

drop trigger TIB_REACTIF
/

drop trigger COMPOUNDDELETETRIGGER_RESULTAT
/

drop trigger COMPOUNDINSERTTRIGGER_RESULTAT
/

drop trigger COMPOUNDUPDATETRIGGER_RESULTAT
/

drop trigger TIB_RESULTATS_SLOT
/

drop trigger COMPOUNDDELETETRIGGER_SLOT
/

drop trigger COMPOUNDINSERTTRIGGER_SLOT
/

drop trigger COMPOUNDUPDATETRIGGER_SLOT
/

drop trigger TIB_SLOT
/

drop trigger COMPOUNDDELETETRIGGER_UPLET
/

drop trigger COMPOUNDINSERTTRIGGER_UPLET
/

drop trigger COMPOUNDUPDATETRIGGER_UPLET
/

drop trigger TIB_UPLET
/

drop trigger COMPOUNDDELETETRIGGER_UTILISAT
/

drop trigger COMPOUNDINSERTTRIGGER_UTILISAT
/

drop trigger COMPOUNDUPDATETRIGGER_UTILISAT
/

drop trigger TIB_UTILISATEUR
/

drop trigger COMPOUNDDELETETRIGGER_VALIDATI
/

drop trigger COMPOUNDINSERTTRIGGER_VALIDATI
/

drop trigger COMPOUNDUPDATETRIGGER_VALIDATI
/

drop trigger TIB_VALIDATION
/

alter table ACTIONS_REALISEES
   drop constraint FK_ACTIONS__REALISE_L_UTILISAT
/

alter table CHERCHEUR
   drop constraint FK_CHERCHEU_EST_CHERC_EQUIPE
/

alter table CHERCHEUR
   drop constraint FK_CHERCHEU_EST_UN_CH_UTILISAT
/

alter table EXPERIENCE
   drop constraint FK_EXPERIEN_COUT_DE_FACTURE
/

alter table EXPERIENCE
   drop constraint FK_EXPERIEN_EST_PROPO_CHERCHEU
/

alter table EXPERIENCE
   drop constraint FK_EXPERIEN_EST_REALI_LABORANT
/

alter table EXPERIENCE
   drop constraint FK_EXPERIEN_NECESSITE_REACTIF
/

alter table EXPERIENCE
   drop constraint FK_EXPERIEN_VALIDE_VALIDATI
/

alter table INTERVENTION
   drop constraint FK_INTERVEN_EST_PROGR_PHOTOMET
/

alter table INTERVIENT_AU_COURS_D_UNE
   drop constraint FK_INTERVIE_INTEREVENANT
/

alter table INTERVIENT_AU_COURS_D_UNE
   drop constraint FK_INTERVIE_INTERVENTION
/

alter table LABORANTIN
   drop constraint FK_LABORANT_EST_LABOR_EQUIPE
/

alter table LABORANTIN
   drop constraint FK_LABORANT_EST_UN_LA_UTILISAT
/

alter table PHOTO
   drop constraint FK_PHOTO_EST_PRISE_PHOTOMET
/

alter table PHOTO
   drop constraint FK_PHOTO_RELATION__PLAQUE
/

alter table RESULTATS_SLOT
   drop constraint FK_RESULTAT_ANALYSE_D_PHOTO
/

alter table RESULTATS_SLOT
   drop constraint FK_RESULTAT_RESULTAT__SLOT
/

alter table SLOT
   drop constraint FK_SLOT_EST_PRESE_PLAQUE
/

alter table SLOT
   drop constraint FK_SLOT_FAIT_PART_UPLET
/

alter table UPLET
   drop constraint FK_UPLET_ANALYSE_P_EXPERIEN
/

alter table UPLET
   drop constraint FK_UPLET_CONTIENT__PLAQUE
/

alter table VALIDATION
   drop constraint FK_VALIDATI_VALIDE2_EXPERIEN
/

drop index REALISE_LES_ACTIONS_FK
/

drop table ACTIONS_REALISEES cascade constraints
/

drop index EST_UN_CHERCHEUR_FK
/

drop index EST_CHERCHEUR_DANS_UNE_FK
/

drop table CHERCHEUR cascade constraints
/

drop table EQUIPE cascade constraints
/

drop index NECESSITE_DES_FK
/

drop index VALIDE_FK
/

drop index COUT_DE_FK
/

drop index EST_REALISEE_PAR_FK
/

drop index EST_PROPOSEE_PAR_FK
/

drop table EXPERIENCE cascade constraints
/

drop table FACTURE cascade constraints
/

drop table INTERVENANT cascade constraints
/

drop index EST_PROGRAMMEE_SUR_UN_FK
/

drop table INTERVENTION cascade constraints
/

drop index INTERVIENT_AU_COURS_D_UNE2_FK
/

drop index INTERVIENT_AU_COURS_D_UNE_FK
/

drop table INTERVIENT_AU_COURS_D_UNE cascade constraints
/

drop index EST_UN_LABORANTIN_FK
/

drop index EST_LABORANTIN_DANS_UNE_FK
/

drop table LABORANTIN cascade constraints
/

drop index RELATION_17_FK
/

drop index EST_PRISE_PAR_UN_FK
/

drop table PHOTO cascade constraints
/

drop table PHOTOMETRE cascade constraints
/

drop table PLAQUE cascade constraints
/

drop table REACTIF cascade constraints
/

drop index ANALYSE_DE_FK
/

drop index RESULTAT_ANALYSE_D_UN_FK
/

drop table RESULTATS_SLOT cascade constraints
/

drop index FAIT_PARTIE_D_UN_FK
/

drop index EST_PRESENT_SUR_UNE_FK
/

drop table SLOT cascade constraints
/

drop index CONTIENT_DES_FK
/

drop index ANALYSE_PAR_FK
/

drop table UPLET cascade constraints
/

drop table UTILISATEUR cascade constraints
/

drop index VALIDE2_FK
/

drop table VALIDATION cascade constraints
/

drop sequence SEQUENCE_1
/

drop sequence SEQUENCE_10
/

drop sequence SEQUENCE_11
/

drop sequence SEQUENCE_12
/

drop sequence SEQUENCE_13
/

drop sequence SEQUENCE_14
/

drop sequence SEQUENCE_15
/

drop sequence SEQUENCE_16
/

drop sequence SEQUENCE_17
/

drop sequence SEQUENCE_18
/

drop sequence SEQUENCE_2
/

drop sequence SEQUENCE_3
/

drop sequence SEQUENCE_4
/

drop sequence SEQUENCE_5
/

drop sequence SEQUENCE_6
/

drop sequence SEQUENCE_7
/

drop sequence SEQUENCE_8
/

drop sequence SEQUENCE_9
/

create sequence SEQUENCE_1
increment by 1
start with 1
/

create sequence SEQUENCE_10
increment by 1
start with 1
/

create sequence SEQUENCE_11
increment by 1
start with 1
/

create sequence SEQUENCE_12
increment by 1
start with 1
/

create sequence SEQUENCE_13
increment by 1
start with 1
/

create sequence SEQUENCE_14
increment by 1
start with 1
/

create sequence SEQUENCE_15
increment by 1
start with 1
/

create sequence SEQUENCE_16
increment by 1
start with 1
/

create sequence SEQUENCE_17
increment by 1
start with 1
/

create sequence SEQUENCE_18
/

create sequence SEQUENCE_2
increment by 1
start with 1
/

create sequence SEQUENCE_3
increment by 1
start with 1
/

create sequence SEQUENCE_4
increment by 1
start with 1
/

create sequence SEQUENCE_5
increment by 1
start with 1
/

create sequence SEQUENCE_6
increment by 1
start with 1
/

create sequence SEQUENCE_7
increment by 1
start with 1
/

create sequence SEQUENCE_8
increment by 1
start with 1
/

create sequence SEQUENCE_9
increment by 1
start with 1
/

/*==============================================================*/
/* Table : ACTIONS_REALISEES                                    */
/*==============================================================*/
create table ACTIONS_REALISEES 
(
   IDACTION             INTEGER              not null,
   IDUTILISATEUR        INTEGER              not null,
   DATEACTION           DATE,
   TYPEACTION           VARCHAR2(1024),
   constraint PK_ACTIONS_REALISEES primary key (IDACTION)
)
/

/*==============================================================*/
/* Index : REALISE_LES_ACTIONS_FK                               */
/*==============================================================*/
create index REALISE_LES_ACTIONS_FK on ACTIONS_REALISEES (
   IDUTILISATEUR ASC
)
/

/*==============================================================*/
/* Table : CHERCHEUR                                            */
/*==============================================================*/
create table CHERCHEUR 
(
   IDCHERCHEUR          INTEGER              not null,
   IDEQUIPE             INTEGER,
   IDUTILISATEUR        INTEGER              not null,
   NOMCHERCHEUR         VARCHAR2(1024)       not null,
   PRENOMCHERCHEUR      VARCHAR2(1024)       not null,
   constraint PK_CHERCHEUR primary key (IDCHERCHEUR)
)
/

/*==============================================================*/
/* Index : EST_CHERCHEUR_DANS_UNE_FK                            */
/*==============================================================*/
create index EST_CHERCHEUR_DANS_UNE_FK on CHERCHEUR (
   IDEQUIPE ASC
)
/

/*==============================================================*/
/* Index : EST_UN_CHERCHEUR_FK                                  */
/*==============================================================*/
create index EST_UN_CHERCHEUR_FK on CHERCHEUR (
   IDUTILISATEUR ASC
)
/

/*==============================================================*/
/* Table : EQUIPE                                               */
/*==============================================================*/
create table EQUIPE 
(
   IDEQUIPE             INTEGER              not null,
   COORDONNEES          VARCHAR2(1024),
   constraint PK_EQUIPE primary key (IDEQUIPE)
)
/

/*==============================================================*/
/* Table : EXPERIENCE                                           */
/*==============================================================*/
create table EXPERIENCE 
(
   IDEXPERIENCE         INTEGER              not null,
   IDREACTIF            INTEGER              not null,
   IDCHERCHEUR          INTEGER              not null,
   IDLABORANTIN         INTEGER              not null,
   IDVALIDATION         INTEGER,
   IDFACTURE            INTEGER,
   DATESOUMISSION       DATE,
   DATEDEBUT            DATE,
   DATEFIN              DATE,
   DATETRANSMISSION     DATE,
   NBSLOTPARUPLET       SMALLINT,
   DUREEEXPERIENCE      SMALLINT,
   URGENT               SMALLINT,
   PRIXAGENTBIOLOGIQUE  FLOAT,
   DUREELOCATIONP       SMALLINT,
   TYPEEXPERIENCE       VARCHAR2(1024),
   SUIVITEMPS           SMALLINT,
   constraint PK_EXPERIENCE primary key (IDEXPERIENCE)
)
/

/*==============================================================*/
/* Index : EST_PROPOSEE_PAR_FK                                  */
/*==============================================================*/
create index EST_PROPOSEE_PAR_FK on EXPERIENCE (
   IDCHERCHEUR ASC
)
/

/*==============================================================*/
/* Index : EST_REALISEE_PAR_FK                                  */
/*==============================================================*/
create index EST_REALISEE_PAR_FK on EXPERIENCE (
   IDLABORANTIN ASC
)
/

/*==============================================================*/
/* Index : COUT_DE_FK                                           */
/*==============================================================*/
create index COUT_DE_FK on EXPERIENCE (
   IDFACTURE ASC
)
/

/*==============================================================*/
/* Index : VALIDE_FK                                            */
/*==============================================================*/
create index VALIDE_FK on EXPERIENCE (
   IDVALIDATION ASC
)
/

/*==============================================================*/
/* Index : NECESSITE_DES_FK                                     */
/*==============================================================*/
create index NECESSITE_DES_FK on EXPERIENCE (
   IDREACTIF ASC
)
/

/*==============================================================*/
/* Table : FACTURE                                              */
/*==============================================================*/
create table FACTURE 
(
   IDFACTURE            INTEGER              not null,
   DATEFACTURE          DATE,
   MONTANTEXPERIENCE    FLOAT,
   constraint PK_FACTURE primary key (IDFACTURE)
)
/

/*==============================================================*/
/* Table : INTERVENANT                                          */
/*==============================================================*/
create table INTERVENANT 
(
   IDINTERVENANT        INTEGER              not null,
   NOMINTERVENANT       VARCHAR2(1024),
   PRENOMINTERVENANT    VARCHAR2(1024),
   constraint PK_INTERVENANT primary key (IDINTERVENANT)
)
/

/*==============================================================*/
/* Table : INTERVENTION                                         */
/*==============================================================*/
create table INTERVENTION 
(
   IDINTERVENTION       INTEGER              not null,
   IDPHOTOMETRE         INTEGER              not null,
   DATEINTERVENTION     DATE,
   SOCIETE              VARCHAR2(1024),
   constraint PK_INTERVENTION primary key (IDINTERVENTION)
)
/

/*==============================================================*/
/* Index : EST_PROGRAMMEE_SUR_UN_FK                             */
/*==============================================================*/
create index EST_PROGRAMMEE_SUR_UN_FK on INTERVENTION (
   IDPHOTOMETRE ASC
)
/

/*==============================================================*/
/* Table : INTERVIENT_AU_COURS_D_UNE                            */
/*==============================================================*/
create table INTERVIENT_AU_COURS_D_UNE 
(
   IDINTERVENANT        INTEGER              not null,
   IDINTERVENTION       INTEGER              not null,
   constraint PK_INTERVIENT_AU_COURS_D_UNE primary key (IDINTERVENANT, IDINTERVENTION)
)
/

/*==============================================================*/
/* Index : INTERVIENT_AU_COURS_D_UNE_FK                         */
/*==============================================================*/
create index INTERVIENT_AU_COURS_D_UNE_FK on INTERVIENT_AU_COURS_D_UNE (
   IDINTERVENANT ASC
)
/

/*==============================================================*/
/* Index : INTERVIENT_AU_COURS_D_UNE2_FK                        */
/*==============================================================*/
create index INTERVIENT_AU_COURS_D_UNE2_FK on INTERVIENT_AU_COURS_D_UNE (
   IDINTERVENTION ASC
)
/

/*==============================================================*/
/* Table : LABORANTIN                                           */
/*==============================================================*/
create table LABORANTIN 
(
   IDLABORANTIN         INTEGER              not null,
   IDUTILISATEUR        INTEGER              not null,
   IDEQUIPE             INTEGER,
   NOMLABORANTIN        VARCHAR2(1024),
   PRENOMLABORANTIN     VARCHAR2(1024),
   constraint PK_LABORANTIN primary key (IDLABORANTIN)
)
/

/*==============================================================*/
/* Index : EST_LABORANTIN_DANS_UNE_FK                           */
/*==============================================================*/
create index EST_LABORANTIN_DANS_UNE_FK on LABORANTIN (
   IDEQUIPE ASC
)
/

/*==============================================================*/
/* Index : EST_UN_LABORANTIN_FK                                 */
/*==============================================================*/
create index EST_UN_LABORANTIN_FK on LABORANTIN (
   IDUTILISATEUR ASC
)
/

/*==============================================================*/
/* Table : PHOTO                                                */
/*==============================================================*/
create table PHOTO 
(
   IDPHOTO              INTEGER              not null,
   IDPHOTOMETRE         INTEGER              not null,
   IDPLAQUE             INTEGER              not null,
   DATEPHOTO            DATE,
   constraint PK_PHOTO primary key (IDPHOTO)
)
/

/*==============================================================*/
/* Index : EST_PRISE_PAR_UN_FK                                  */
/*==============================================================*/
create index EST_PRISE_PAR_UN_FK on PHOTO (
   IDPHOTOMETRE ASC
)
/

/*==============================================================*/
/* Index : RELATION_17_FK                                       */
/*==============================================================*/
create index RELATION_17_FK on PHOTO (
   IDPLAQUE ASC
)
/

/*==============================================================*/
/* Table : PHOTOMETRE                                           */
/*==============================================================*/
create table PHOTOMETRE 
(
   IDPHOTOMETRE         INTEGER              not null,
   COUTPHOTO            FLOAT,
   OPERATIONNEL         SMALLINT,
   MODELEPHOTOMETRE     VARCHAR2(1024),
   DATEDERNIEREINTERVENTION DATE,
   constraint PK_PHOTOMETRE primary key (IDPHOTOMETRE)
)
/

/*==============================================================*/
/* Table : PLAQUE                                               */
/*==============================================================*/
create table PLAQUE 
(
   IDPLAQUE             INTEGER              not null,
   NBSLOT               INTEGER,
   COUTPLAQUE			FLOAT,
   constraint PK_PLAQUE primary key (IDPLAQUE)
)
/

/*==============================================================*/
/* Table : REACTIF                                              */
/*==============================================================*/
create table REACTIF 
(
   IDREACTIF            INTEGER              not null,
   NOMREACTIF           VARCHAR2(1024),
   TYPEREACTIF          VARCHAR2(1024),
   COULEURVIVANTES      FLOAT,
   COULEURMORTES        FLOAT,
   FOURNISSEURREACTIF   VARCHAR2(1024),
   PRIXREACTIF          FLOAT,
   constraint PK_REACTIF primary key (IDREACTIF)
)
/

/*==============================================================*/
/* Table : RESULTATS_SLOT                                       */
/*==============================================================*/
create table RESULTATS_SLOT 
(
   IDRESULTATSLOT       INTEGER              not null,
   IDSLOT               INTEGER              not null,
   IDPHOTO              INTEGER              not null,
   RESULTATX            FLOAT,
   RESULTATY            FLOAT,
   RM                   FLOAT,
   RD                   FLOAT,
   VM                   FLOAT,
   VD                   FLOAT,
   BM                   FLOAT,
   BD                   FLOAT,
   TM                   FLOAT,
   TD                   FLOAT,
   ETATCELLULES         VARCHAR2(1024),
   DATEANALYSE          DATE,
   constraint PK_RESULTATS_SLOT primary key (IDRESULTATSLOT)
)
/

/*==============================================================*/
/* Index : RESULTAT_ANALYSE_D_UN_FK                             */
/*==============================================================*/
create index RESULTAT_ANALYSE_D_UN_FK on RESULTATS_SLOT (
   IDSLOT ASC
)
/

/*==============================================================*/
/* Index : ANALYSE_DE_FK                                        */
/*==============================================================*/
create index ANALYSE_DE_FK on RESULTATS_SLOT (
   IDPHOTO ASC
)
/

/*==============================================================*/
/* Table : SLOT                                                 */
/*==============================================================*/
create table SLOT 
(
   IDSLOT               INTEGER              not null,
   IDUPLET              INTEGER              not null,
   IDPLAQUE             INTEGER              not null,
   QUANTITEAGENTBIOLOGIQUE FLOAT,
   TYPECELLULE          VARCHAR2(1024),
   QUANTITECELLULES     FLOAT,
   SLOTX                SMALLINT,
   SLOTY                SMALLINT,
   QUANTITEREACTIF      FLOAT,
   constraint PK_SLOT primary key (IDSLOT)
)
/

/*==============================================================*/
/* Index : EST_PRESENT_SUR_UNE_FK                               */
/*==============================================================*/
create index EST_PRESENT_SUR_UNE_FK on SLOT (
   IDPLAQUE ASC
)
/

/*==============================================================*/
/* Index : FAIT_PARTIE_D_UN_FK                                  */
/*==============================================================*/
create index FAIT_PARTIE_D_UN_FK on SLOT (
   IDUPLET ASC
)
/

/*==============================================================*/
/* Table : UPLET                                                */
/*==============================================================*/
create table UPLET 
(
   IDUPLET              INTEGER              not null,
   IDPLAQUE             INTEGER              not null,
   IDEXPERIENCE         INTEGER              not null,
   MOYENNESLOT          FLOAT,
   ECARTTYPESLOT        FLOAT,
   COMPLET              SMALLINT             default 0,
   constraint PK_UPLET primary key (IDUPLET)
)
/

/*==============================================================*/
/* Index : ANALYSE_PAR_FK                                       */
/*==============================================================*/
create index ANALYSE_PAR_FK on UPLET (
   IDEXPERIENCE ASC
)
/

/*==============================================================*/
/* Index : CONTIENT_DES_FK                                      */
/*==============================================================*/
create index CONTIENT_DES_FK on UPLET (
   IDPLAQUE ASC
)
/

/*==============================================================*/
/* Table : UTILISATEUR                                          */
/*==============================================================*/
create table UTILISATEUR 
(
   IDUTILISATEUR        INTEGER              not null,
   NOMUTILISATEUR       VARCHAR2(1024),
   MDPUTILISATEUR       VARCHAR2(1024),
   TYPEUTILISATEUR      VARCHAR2(1024),
   constraint PK_UTILISATEUR primary key (IDUTILISATEUR)
)
/

/*==============================================================*/
/* Table : VALIDATION                                           */
/*==============================================================*/
create table VALIDATION 
(
   IDVALIDATION         INTEGER              not null,
   IDEXPERIENCE         INTEGER              not null,
   MOYENNEEXP           FLOAT,
   ECARTTYPEEXP         FLOAT,
   A1                   FLOAT,
   A2                   FLOAT,
   A3                   FLOAT,
   VALIDEE              SMALLINT,
   DATEVALIDATION       DATE,
   constraint PK_VALIDATION primary key (IDVALIDATION)
)
/

/*==============================================================*/
/* Index : VALIDE2_FK                                           */
/*==============================================================*/
create index VALIDE2_FK on VALIDATION (
   IDEXPERIENCE ASC
)
/

alter table ACTIONS_REALISEES
   add constraint FK_ACTIONS__REALISE_L_UTILISAT foreign key (IDUTILISATEUR)
      references UTILISATEUR (IDUTILISATEUR)
/

alter table CHERCHEUR
   add constraint FK_CHERCHEU_EST_CHERC_EQUIPE foreign key (IDEQUIPE)
      references EQUIPE (IDEQUIPE)
/

alter table CHERCHEUR
   add constraint FK_CHERCHEU_EST_UN_CH_UTILISAT foreign key (IDUTILISATEUR)
      references UTILISATEUR (IDUTILISATEUR)
/

alter table EXPERIENCE
   add constraint FK_EXPERIEN_COUT_DE_FACTURE foreign key (IDFACTURE)
      references FACTURE (IDFACTURE)
/

alter table EXPERIENCE
   add constraint FK_EXPERIEN_EST_PROPO_CHERCHEU foreign key (IDCHERCHEUR)
      references CHERCHEUR (IDCHERCHEUR)
/

alter table EXPERIENCE
   add constraint FK_EXPERIEN_EST_REALI_LABORANT foreign key (IDLABORANTIN)
      references LABORANTIN (IDLABORANTIN)
/

alter table EXPERIENCE
   add constraint FK_EXPERIEN_NECESSITE_REACTIF foreign key (IDREACTIF)
      references REACTIF (IDREACTIF)
/

alter table EXPERIENCE
   add constraint FK_EXPERIEN_VALIDE_VALIDATI foreign key (IDVALIDATION)
      references VALIDATION (IDVALIDATION)
/

alter table INTERVENTION
   add constraint FK_INTERVEN_EST_PROGR_PHOTOMET foreign key (IDPHOTOMETRE)
      references PHOTOMETRE (IDPHOTOMETRE)
/

alter table INTERVIENT_AU_COURS_D_UNE
   add constraint FK_INTERVIE_INTEREVENANT foreign key (IDINTERVENANT)
      references INTERVENANT (IDINTERVENANT)
/

alter table INTERVIENT_AU_COURS_D_UNE
   add constraint FK_INTERVIE_INTERVENTION foreign key (IDINTERVENTION)
      references INTERVENTION (IDINTERVENTION)
/

alter table LABORANTIN
   add constraint FK_LABORANT_EST_LABOR_EQUIPE foreign key (IDEQUIPE)
      references EQUIPE (IDEQUIPE)
/

alter table LABORANTIN
   add constraint FK_LABORANT_EST_UN_LA_UTILISAT foreign key (IDUTILISATEUR)
      references UTILISATEUR (IDUTILISATEUR)
/

alter table PHOTO
   add constraint FK_PHOTO_EST_PRISE_PHOTOMET foreign key (IDPHOTOMETRE)
      references PHOTOMETRE (IDPHOTOMETRE)
/

alter table PHOTO
   add constraint FK_PHOTO_RELATION__PLAQUE foreign key (IDPLAQUE)
      references PLAQUE (IDPLAQUE)
/

alter table RESULTATS_SLOT
   add constraint FK_RESULTAT_ANALYSE_D_PHOTO foreign key (IDPHOTO)
      references PHOTO (IDPHOTO)
/

alter table RESULTATS_SLOT
   add constraint FK_RESULTAT_RESULTAT__SLOT foreign key (IDSLOT)
      references SLOT (IDSLOT)
/

alter table SLOT
   add constraint FK_SLOT_EST_PRESE_PLAQUE foreign key (IDPLAQUE)
      references PLAQUE (IDPLAQUE)
/

alter table SLOT
   add constraint FK_SLOT_FAIT_PART_UPLET foreign key (IDUPLET)
      references UPLET (IDUPLET)
/

alter table UPLET
   add constraint FK_UPLET_ANALYSE_P_EXPERIEN foreign key (IDEXPERIENCE)
      references EXPERIENCE (IDEXPERIENCE)
/

alter table UPLET
   add constraint FK_UPLET_CONTIENT__PLAQUE foreign key (IDPLAQUE)
      references PLAQUE (IDPLAQUE)
/

alter table VALIDATION
   add constraint FK_VALIDATI_VALIDE2_EXPERIEN foreign key (IDEXPERIENCE)
      references EXPERIENCE (IDEXPERIENCE)
/



create trigger TIB_ACTIONS_REALISEES before insert
on ACTIONS_REALISEES for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  La colonne "IDACTION" utilise la sequence SEQUENCE_4
    select SEQUENCE_4.NEXTVAL INTO :new.IDACTION from dual;

--  Traitement d'erreurs
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_CHERCHEUR before insert
on CHERCHEUR for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  La colonne "IDCHERCHEUR" utilise la sequence SEQUENCE_6
    select SEQUENCE_6.NEXTVAL INTO :new.IDCHERCHEUR from dual;

--  Traitement d'erreurs
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

create trigger TIB_EQUIPE before insert
on EQUIPE for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  La colonne "IDEQUIPE" utilise la sequence SEQUENCE_8
    select SEQUENCE_8.NEXTVAL INTO :new.IDEQUIPE from dual;

--  Traitement d'erreurs
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_EXPERIENCE before insert
on EXPERIENCE for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  La colonne "IDEXPERIENCE" utilise la sequence SEQUENCE_2
    select SEQUENCE_2.NEXTVAL INTO :new.IDEXPERIENCE from dual;

--  Traitement d'erreurs
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/



create trigger TIB_FACTURE before insert
on FACTURE for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  La colonne "IDFACTURE" utilise la sequence SEQUENCE_7
    select SEQUENCE_7.NEXTVAL INTO :new.IDFACTURE from dual;

--  Traitement d'erreurs
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_INTERVENANT before insert
on INTERVENANT for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  La colonne "IDINTERVENANT" utilise la sequence SEQUENCE_15
    select SEQUENCE_15.NEXTVAL INTO :new.IDINTERVENANT from dual;

--  Traitement d'erreurs
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/



create trigger TIB_INTERVENTION before insert
on INTERVENTION for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  La colonne "IDINTERVENTION" utilise la sequence SEQUENCE_17
    select SEQUENCE_17.NEXTVAL INTO :new.IDINTERVENTION from dual;

--  Traitement d'erreurs
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_LABORANTIN before insert
on LABORANTIN for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  La colonne "IDLABORANTIN" utilise la sequence SEQUENCE_3
    select SEQUENCE_3.NEXTVAL INTO :new.IDLABORANTIN from dual;

--  Traitement d'erreurs
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_PHOTO before insert
on PHOTO for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  La colonne "IDPHOTO" utilise la sequence SEQUENCE_12
    select SEQUENCE_12.NEXTVAL INTO :new.IDPHOTO from dual;

--  Traitement d'erreurs
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

create trigger TIB_PHOTOMETRE before insert
on PHOTOMETRE for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  La colonne "IDPHOTOMETRE" utilise la sequence SEQUENCE_16
    select SEQUENCE_16.NEXTVAL INTO :new.IDPHOTOMETRE from dual;

--  Traitement d'erreurs
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_PLAQUE before insert
on PLAQUE for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  La colonne "IDPLAQUE" utilise la sequence SEQUENCE_11
    select SEQUENCE_11.NEXTVAL INTO :new.IDPLAQUE from dual;

--  Traitement d'erreurs
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

create trigger TIB_REACTIF before insert
on REACTIF for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  La colonne "IDREACTIF" utilise la sequence SEQUENCE_14
    select SEQUENCE_14.NEXTVAL INTO :new.IDREACTIF from dual;

--  Traitement d'erreurs
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/



create trigger TIB_RESULTATS_SLOT before insert
on RESULTATS_SLOT for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  La colonne "IDRESULTATSLOT" utilise la sequence SEQUENCE_1
    select SEQUENCE_1.NEXTVAL INTO :new.IDRESULTATSLOT from dual;

--  Traitement d'erreurs
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

create trigger TIB_SLOT before insert
on SLOT for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  La colonne "IDSLOT" utilise la sequence SEQUENCE_13
    select SEQUENCE_13.NEXTVAL INTO :new.IDSLOT from dual;

--  Traitement d'erreurs
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

create trigger TIB_UPLET before insert
on UPLET for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  La colonne "IDUPLET" utilise la sequence SEQUENCE_10
    select SEQUENCE_10.NEXTVAL INTO :new.IDUPLET from dual;

--  Traitement d'erreurs
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

create trigger TIB_UTILISATEUR before insert
on UTILISATEUR for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  La colonne "IDUTILISATEUR" utilise la sequence SEQUENCE_5
    select SEQUENCE_5.NEXTVAL INTO :new.IDUTILISATEUR from dual;

--  Traitement d'erreurs
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

create trigger TIB_VALIDATION before insert
on VALIDATION for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  La colonne "IDVALIDATION" utilise la sequence SEQUENCE_9
    select SEQUENCE_9.NEXTVAL INTO :new.IDVALIDATION from dual;

--  Traitement d'erreurs
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/
