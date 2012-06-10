/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     06/05/2012 18:26:51                          */
/*==============================================================*/


drop table if exists ASISTEN;

drop table if exists CONTACTOS;

drop table if exists DEUDAS;

drop table if exists ES_CONTACTO;

drop table if exists ES_USUARIO;

drop table if exists EVENTOS;

drop table if exists GASTOS;

drop table if exists TIPO_EVENTO;

/*==============================================================*/
/* Table: ASISTEN                                               */
/*==============================================================*/
create table ASISTEN
(
   ID_CONTACTO          bigint not null,
   ID_EVENTO            bigint not null,
   primary key (ID_CONTACTO, ID_EVENTO)
);

/*==============================================================*/
/* Table: CONTACTOS                                             */
/*==============================================================*/
create table CONTACTOS
(
   ID_CONTACTO          bigint not null AUTO_INCREMENT,
   NOMBRE_CONTACTO      varchar(255),
   EMAIL_CONTACTO       varchar(255),
   primary key (ID_CONTACTO)
);

alter table CONTACTOS comment 'Contactos de los usuarios que pueden ir a eventos';

/*==============================================================*/
/* Table: DEUDAS                                                */
/*==============================================================*/
create table DEUDAS
(
   ID_DEUDA             bigint not null AUTO_INCREMENT,
   ID_CONTACTO          bigint not null,
   ID_GASTO             bigint not null,
   CANTIDAD_DEUDA       decimal(7,2),
   PAGADO               bool,
   primary key (ID_DEUDA)
);

/*==============================================================*/
/* Table: ES_CONTACTO                                           */
/*==============================================================*/
create table ES_CONTACTO
(
   ID_CONTACTO          bigint not null,
   ES__ID_CONTACTO      bigint not null,
   primary key (ID_CONTACTO)
);

/*==============================================================*/
/* Table: ES_USUARIO                                            */
/*==============================================================*/
create table ES_USUARIO
(
   ID_CONTACTO          bigint not null,
   PWD                  varchar(40),
   primary key (ID_CONTACTO)
);

/*==============================================================*/
/* Table: EVENTOS                                               */
/*==============================================================*/
create table EVENTOS
(
   ID_EVENTO            bigint not null AUTO_INCREMENT,
   ID_TIPO_EVENTO       bigint not null,
   ID_CONTACTO          bigint not null,
   NOMBRE_EVENTO        varchar(255),
   FECHA_EVENTO         date,
   CERRADO              bool,
   primary key (ID_EVENTO)
);

/*==============================================================*/
/* Table: GASTOS                                                */
/*==============================================================*/
create table GASTOS
(
   ID_GASTO             bigint not null AUTO_INCREMENT,
   ID_CONTACTO          bigint not null,
   ID_EVENTO            bigint not null,
   CONCEPTO             varchar(255),
   CANTIDAD_GASTO       numeric(7,2),
   primary key (ID_GASTO)
);

/*==============================================================*/
/* Table: TIPO_EVENTO                                           */
/*==============================================================*/
create table TIPO_EVENTO
(
   ID_TIPO_EVENTO       bigint not null AUTO_INCREMENT,
   NOMBRE_TIPO_EVENTO   varchar(50),
   primary key (ID_TIPO_EVENTO)
);

alter table ASISTEN add constraint FK_ASISTEN foreign key (ID_CONTACTO)
      references CONTACTOS (ID_CONTACTO) on delete restrict on update restrict;

alter table ASISTEN add constraint FK_ASISTEN2 foreign key (ID_EVENTO)
      references EVENTOS (ID_EVENTO) on delete restrict on update restrict;

alter table DEUDAS add constraint FK_ASUME foreign key (ID_CONTACTO)
      references CONTACTOS (ID_CONTACTO) on delete restrict on update restrict;

alter table DEUDAS add constraint FK_GENERA foreign key (ID_GASTO)
      references GASTOS (ID_GASTO) on delete restrict on update restrict;

alter table ES_CONTACTO add constraint FK_PERTENECE foreign key (ES__ID_CONTACTO)
      references ES_USUARIO (ID_CONTACTO) on delete restrict on update restrict;

alter table ES_CONTACTO add constraint FK_TIPO_CONTACTO2 foreign key (ID_CONTACTO)
      references CONTACTOS (ID_CONTACTO) on delete restrict on update restrict;

alter table ES_USUARIO add constraint FK_TIPO_CONTACTO foreign key (ID_CONTACTO)
      references CONTACTOS (ID_CONTACTO) on delete restrict on update restrict;

alter table EVENTOS add constraint FK_ORGANIZA foreign key (ID_CONTACTO)
      references ES_USUARIO (ID_CONTACTO) on delete restrict on update restrict;

alter table EVENTOS add constraint FK_PERTECENE foreign key (ID_TIPO_EVENTO)
      references TIPO_EVENTO (ID_TIPO_EVENTO) on delete restrict on update restrict;

alter table GASTOS add constraint FK_CREA foreign key (ID_CONTACTO)
      references CONTACTOS (ID_CONTACTO) on delete restrict on update restrict;

alter table GASTOS add constraint FK_ESTA_ASOCIADO foreign key (ID_EVENTO)
      references EVENTOS (ID_EVENTO) on delete restrict on update restrict;

/*
   VISTAS
*/

/* Vista para consultas de login */
CREATE VIEW vista_login AS 
SELECT c.ID_CONTACTO, c.NOMBRE_CONTACTO, c.EMAIL_CONTACTO, es.PWD
FROM contactos c, es_usuario es
WHERE c.ID_CONTACTO=es.ID_CONTACTO;


CREATE VIEW vista_lista_contactos AS 
SELECT c.ID_CONTACTO, c.NOMBRE_CONTACTO, c.EMAIL_CONTACTO, es.ES__ID_CONTACTO
FROM contactos c, es_contacto es
WHERE c.ID_CONTACTO=es.ID_CONTACTO;

