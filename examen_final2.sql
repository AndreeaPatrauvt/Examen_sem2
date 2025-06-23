create extension if not exists postgis;

create table if not exists oras
(
fid serial primary key,
nume varchar(50) not null,
suprafata int not null,
geom geometry(Polygon,4326) not null
);

create table if not exists piste_biciclete 
(
fid serial primary key,
stare varchar(50) not null,
lungime_km int not null,
geom geometry(Linestring,4326) not null,
fid_oras int not null, 
foreign key (fid_oras) references oras(fid)
);

create table if not exists tip_transport
(
id serial primary key,
tip varchar(50) not null
);

create table if not exists transport_public
(
id serial primary key,
nume varchar(100) not null,
an_infiintare int not null,
fid_oras integer not null,
id_tip_transport integer not null,
foreign key (fid_oras) references oras(fid),
foreign key (id_tip_transport) references tip_transport(id)
);

create table if not exists ghiseu_bilete 
(
fid serial primary key,
nume varchar(50) not null,
geom geometry(Point,4326) not null,
id_transport_public integer not null,
foreign key(id_transport_public) references transport_public(id)
);

create table if not exists sediu
(
fid serial primary key,
nume varchar(100) not null,
adresa varchar(100) not null,
geom geometry(Polygon) not null,
id_transport_public int unique not null,
foreign key(id_transport_public) references transport_public(id)
);

create table if not exists vehicul
(
id serial primary key, 
stare varchar(50) not null,
tip varchar(50) not null,
nr_inmatriculare varchar(10) not null unique,
id_tip_transport int not null,
foreign key (id_tip_transport) references tip_transport(id)
);

create table if not exists statie
(
fid serial primary key,
nume varchar(50) not null,
geom geometry(Point,4326) not null,
id_tip_transport int not null,
foreign key(id_tip_transport) references tip_transport(id)
);

create table if not exists trasee
(
fid serial primary key,
denumire varchar(50) not null,
geom geometry(Linestring,4326) not null,
id_tip_transport int not null,  
foreign key(id_tip_transport) references tip_transport(id)
);

create table if not exists statie_traseu
(
id serial primary key,
fid_statie int not null, 
fid_trasee int not null,
foreign key(fid_statie) references statie(fid),
foreign key(fid_trasee) references trasee(id)
);

