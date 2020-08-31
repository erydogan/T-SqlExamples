-- https://youtu.be/YeZCFiqn9Zo Anlat�m videosu

create table Dersler(
Id int primary key identity,
DersAd nvarchar(100) not null,
Sinif tinyint not null,
OgretmenId int not null,
--Tablonun ilk olu�turulmas�nda forign key tan�mlama
constraint fk_dersler_ogretmen foreign key (OgretmenId) references Ogretmenler(Id)
)

-- Varolan bir tabloya foreign ekleme
Alter table Dersler
add constraint fk_dersler_ogretmen foreign key (OgretmenId) references Ogretmenler(Id)

-- Die�r se�enekler
ON {UPDATE | DELETE} {CASCADE | NO ACTION |SET DEFAULT | SET NULL}

-- foreign key kald�rma
alter table Dersler
drop constraint [fk_dersler_ogretmen]
