-- drop objects
drop table unv_facolta cascade constraints;
drop table unv_docente cascade constraints;
drop table unv_tipo_laurea cascade constraints;
drop table unv_laurea cascade constraints;
drop table unv_materia cascade constraints;
drop table unv_appello cascade constraints;
drop table unv_studente cascade constraints;
drop table unv_stato_esame cascade constraints;
drop table unv_esame cascade constraints;

-- create tables
create table unv_facolta (
    id                             number generated by default on null as identity 
                                   constraint unv_facolta_id_pk primary key,
    facolta                        varchar2(10 char) not null,
    created                        date not null,
    created_by                     varchar2(255 char) not null,
    updated                        date not null,
    updated_by                     varchar2(255 char) not null
)
;

create table unv_docente (
    id                             number generated by default on null as identity 
                                   constraint unv_docente_id_pk primary key,
    facolta_id                     number
                                   constraint unv_docente_facolta_id_fk
                                   references unv_facolta on delete cascade not null,
    docente                        varchar2(60 char)
                                   constraint unv_docente_docente_unq unique not null,
    created                        date not null,
    created_by                     varchar2(255 char) not null,
    updated                        date not null,
    updated_by                     varchar2(255 char) not null
)
;

-- table index
create index unv_docente_i1 on unv_docente (facolta_id);

create table unv_tipo_laurea (
    id                             number generated by default on null as identity 
                                   constraint unv_tipo_laurea_id_pk primary key,
    tipo_laurea                    varchar2(17 char)
                                   constraint unv_tipo_laurea_tipo_laure_unq unique not null,
    created                        date not null,
    created_by                     varchar2(255 char) not null,
    updated                        date not null,
    updated_by                     varchar2(255 char) not null
)
;

create table unv_laurea (
    id                             number generated by default on null as identity 
                                   constraint unv_laurea_id_pk primary key,
    facolta_id                     number
                                   constraint unv_laurea_facolta_id_fk
                                   references unv_facolta on delete cascade not null,
    tipo_laurea_id                 number
                                   constraint unv_laurea_tipo_laurea_id_fk
                                   references unv_tipo_laurea on delete cascade not null,
    laurea                         varchar2(60 char)
                                   constraint unv_laurea_laurea_unq unique not null,
    anno_inizio                    number not null,
    created                        date not null,
    created_by                     varchar2(255 char) not null,
    updated                        date not null,
    updated_by                     varchar2(255 char) not null
)
;

-- table index
create index unv_laurea_i1 on unv_laurea (facolta_id);
create index unv_laurea_i122 on unv_laurea (tipo_laurea_id);

create table unv_materia (
    id                             number generated by default on null as identity 
                                   constraint unv_materia_id_pk primary key,
    laurea_id                      number
                                   constraint unv_materia_laurea_id_fk
                                   references unv_laurea on delete cascade not null,
    docente_id                     number
                                   constraint unv_materia_docente_id_fk
                                   references unv_docente on delete cascade not null,
    materia                        varchar2(60 char)
                                   constraint unv_materia_materia_unq unique not null,
    materia_des                    varchar2(60 char) not null,
    anno                           integer not null,
    periodo                        integer not null,
    crediti                        integer not null,
    created                        date not null,
    created_by                     varchar2(255 char) not null,
    updated                        date not null,
    updated_by                     varchar2(255 char) not null
)
;

-- table index
create index unv_materia_i1 on unv_materia (docente_id);
create index unv_materia_i182 on unv_materia (laurea_id);

create table unv_appello (
    id                             number generated by default on null as identity 
                                   constraint unv_appello_id_pk primary key,
    materia_id                     number
                                   constraint unv_appello_materia_id_fk
                                   references unv_materia on delete cascade not null,
    appello                        varchar2(60 char)
                                   constraint unv_appello_appello_unq unique not null,
    data                           date not null,
    created                        date not null,
    created_by                     varchar2(255 char) not null,
    updated                        date not null,
    updated_by                     varchar2(255 char) not null
)
;

-- table index
create index unv_appello_i1 on unv_appello (materia_id);

create table unv_studente (
    id                             number generated by default on null as identity 
                                   constraint unv_studente_id_pk primary key,
    laurea_id                      number
                                   constraint unv_studente_laurea_id_fk
                                   references unv_laurea on delete cascade not null,
    studente                       varchar2(60 char)
                                   constraint unv_studente_studente_unq unique not null,
    foto                           blob,
    foto_filename                  varchar2(512 char),
    foto_mimetype                  varchar2(512 char),
    foto_charset                   varchar2(512 char),
    foto_lastupd                   date,
    created                        date not null,
    created_by                     varchar2(255 char) not null,
    updated                        date not null,
    updated_by                     varchar2(255 char) not null
)
;

-- table index
create index unv_studente_i1 on unv_studente (laurea_id);

create table unv_stato_esame (
    id                             number generated by default on null as identity 
                                   constraint unv_stato_esame_id_pk primary key,
    stato_esame                    varchar2(12 char)
                                   constraint unv_stato_esame_stato_esam_unq unique not null,
    created                        date not null,
    created_by                     varchar2(255 char) not null,
    updated                        date not null,
    updated_by                     varchar2(255 char) not null
)
;

create table unv_esame (
    id                             number generated by default on null as identity 
                                   constraint unv_esame_id_pk primary key,
    studente_id                    number
                                   constraint unv_esame_studente_id_fk
                                   references unv_studente on delete cascade not null,
    appello_id                     number
                                   constraint unv_esame_appello_id_fk
                                   references unv_appello on delete cascade not null,
    stato_esame_id                 number
                                   constraint unv_esame_stato_esame_id_fk
                                   references unv_stato_esame on delete cascade not null,
    esame                          varchar2(60 char) not null,
    voto                           integer,
    created                        date not null,
    created_by                     varchar2(255 char) not null,
    updated                        date not null,
    updated_by                     varchar2(255 char) not null
)
;

-- table index
create index unv_esame_i1 on unv_esame (appello_id);
create index unv_esame_i342 on unv_esame (stato_esame_id);
create index unv_esame_i353 on unv_esame (studente_id);


-- triggers
create or replace trigger unv_facolta_biu
    before insert or update 
    on unv_facolta
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end unv_facolta_biu;
/

create or replace trigger unv_docente_biu
    before insert or update 
    on unv_docente
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end unv_docente_biu;
/

create or replace trigger unv_tipo_laurea_biu
    before insert or update 
    on unv_tipo_laurea
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end unv_tipo_laurea_biu;
/

create or replace trigger unv_laurea_biu
    before insert or update 
    on unv_laurea
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end unv_laurea_biu;
/

create or replace trigger unv_materia_biu
    before insert or update 
    on unv_materia
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end unv_materia_biu;
/

create or replace trigger unv_appello_biu
    before insert or update 
    on unv_appello
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end unv_appello_biu;
/

create or replace trigger unv_studente_biu
    before insert or update 
    on unv_studente
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end unv_studente_biu;
/

create or replace trigger unv_stato_esame_biu
    before insert or update 
    on unv_stato_esame
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end unv_stato_esame_biu;
/

create or replace trigger unv_esame_biu
    before insert or update 
    on unv_esame
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end unv_esame_biu;
/

-- load data
 
insert into unv_facolta (
    id,
    facolta
) values (
    1,
    'AGRARIA'
);

insert into unv_facolta (
    id,
    facolta
) values (
    2,
    'ECONOMIA'
);

insert into unv_facolta (
    id,
    facolta
) values (
    3,
    'INGEGNERIA'
);

insert into unv_facolta (
    id,
    facolta
) values (
    4,
    'MEDICINA'
);

insert into unv_facolta (
    id,
    facolta
) values (
    5,
    'SCIENZE'
);

commit;

alter table unv_facolta
modify id generated always as identity restart start with 6;
 
-- load data
-- load data
 
insert into unv_tipo_laurea (
    id,
    tipo_laurea
) values (
    1,
    'LAUREA'
);

insert into unv_tipo_laurea (
    id,
    tipo_laurea
) values (
    2,
    'LAUREA MAGISTRALE'
);

insert into unv_tipo_laurea (
    id,
    tipo_laurea
) values (
    3,
    'CICLO UNICO'
);

commit;

alter table unv_tipo_laurea
modify id generated always as identity restart start with 4;
 
-- load data
 
insert into unv_stato_esame (
    id,
    stato_esame
) values (
    1,
    'DA SOSTENERE'
);

insert into unv_stato_esame (
    id,
    stato_esame
) values (
    2,
    'PASSATO'
);

insert into unv_stato_esame (
    id,
    stato_esame
) values (
    3,
    'NON PASSATO'
);

commit;

alter table unv_stato_esame
modify id generated always as identity restart start with 4;
 
 
-- Generated by Quick SQL Domenica Maggio 14, 2023  06:38:36
 
/*
facolta /insert 5
  facolta vc60 /nn /values AGRARIA,ECONOMIA,INGEGNERIA,MEDICINA,SCIENZE

docente
  docente vc60 /nn /unique
  facolta_id /nn
  
tipo_laurea /insert 3
  tipo_laurea vc60 /nn /unique /values LAUREA,LAUREA MAGISTRALE,CICLO UNICO

laurea
  laurea vc60 /nn /unique
  facolta_id /nn
  tipo_laurea_id /nn
  anno_inizio number /nn
 
materia
  materia vc60 /nn /unique
  materia_des vc60 /nn
  laurea_id /nn
  docente_id /nn
  anno int /nn
  periodo int /nn
  crediti int /nn

appello
  appello vc60 /nn /unique
  materia_id /nn
  data d /nn

studente
  studente vc60 /nn /unique
  laurea_id /nn
  foto file
  
stato_esame /insert 3
  stato_esame vc60 /nn /unique /values DA SOSTENERE,PASSATO,NON PASSATO

esame
  esame vc60 /nn
  studente_id /nn
  appello_id /nn
  stato_esame_id /nn
  voto int

# settings = { prefix: "UNV", semantics: "CHAR", auditCols: true, drop: true, language: "EN", APEX: true }
*/
