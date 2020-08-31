-- https://youtu.be/YeZCFiqn9Zo Anlatým videosu

create table Dersler(
Id int primary key identity,
DersAd nvarchar(100) not null,
Sinif tinyint not null,
OgretmenId int not null,
--Tablonun ilk oluþturulmasýnda forign key tanýmlama
constraint fk_dersler_ogretmen foreign key (OgretmenId) references Ogretmenler(Id)
)

-- Varolan bir tabloya foreign ekleme
Alter table Dersler
add constraint fk_dersler_ogretmen foreign key (OgretmenId) references Ogretmenler(Id)

-- Dieðr seçenekler
ON {UPDATE | DELETE} {CASCADE | NO ACTION |SET DEFAULT | SET NULL}

-- foreign key kaldýrma
alter table Dersler
drop constraint [fk_dersler_ogretmen]
