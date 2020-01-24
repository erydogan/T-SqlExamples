-- Açıklama için https://saitorhan.com/gercek-ad-ve-soyadlarindan-rastgele-veri-uretmek/ adresini ziyaret ediniz.

drop table if exists #Names

create table #Names(
userName nvarchar(100) null,
[Name] nvarchar(200),
[Surname] nvarchar(200)
)

declare @n nvarchar(200)  -- ad
declare @sn nvarchar(200) -- soyad
declare @un nvarchar(200) -- kullanıcı adı
declare @id int -- gerçek verinin Id değeri
declare @max int -- gerçek verinin satır sayısı

select @max = COUNT(*) from Users

insert into #Names([Name], [Surname])
select SUBSTRING(FullName,0, CHARINDEX(' ', FullName)), 
SUBSTRING(FullName,CHARINDEX(' ', FullName),200)
from Users  where CHARINDEX(' ', FullName) > 1

update #Names set [Surname] = TRIM([Surname])

--select * from #Names

--select * from Users
--SQL CURSOR KULLANIMI

	DECLARE crs CURSOR FOR
	
	SELECT Id FROM Users -- Cursur de işlenecek veriler ve listeyi select sorgusu ile çekiyoruz .

	OPEN crs -- Cursor ü açıyoruz

	FETCH NEXT FROM crs INTO @id -- Select sorgusunda gelen sütunlar sırasına göre değişkenlere atanıyor Örn : @id = Id

	WHILE @@FETCH_STATUS =0
		BEGIN
			
			select @n = [Name] from #Names order by NEWID()
			select @sn = [Surname] from #Names where CHARINDEX(' ', [Surname]) = 0 order by NEWID()
			set @un = lower(SUBSTRING(@n,1,1)+@sn+CONVERT(varchar, CONVERT(int, RAND()*@max+1)))
			set @un = REPLACE(@un,'ç', 'c')
			set @un = REPLACE(@un,'ı', 'i')
			set @un = REPLACE(@un,'ğ', 'g')
			set @un = REPLACE(@un,'ö', 'o')
			set @un = REPLACE(@un,'ş', 's')
			set @un = REPLACE(@un,'ü', 'u')

			while exists (select UserName from Users where UserName = @un)
			begin
				set @un = lower(  SUBSTRING(@n,1,1)+@sn+CONVERT(varchar, CONVERT(int, RAND()*@max+1)))
				set @un = REPLACE(@un,'ç', 'c')
				set @un = REPLACE(@un,'ı', 'i')
				set @un = REPLACE(@un,'ğ', 'g')
				set @un = REPLACE(@un,'ö', 'o')
				set @un = REPLACE(@un,'ş', 's')
				set @un = REPLACE(@un,'ü', 'u')
			end
			
			update Users set FullName = @n + ' ' + @sn, UserName = @un where Id = @id

			FETCH NEXT FROM crs INTO @id
 
		END

	CLOSE crs -- Cursor ü kapatýyoruz.

	DEALLOCATE crs -- Cursor ile işimiz bittiğinde sistemden tamizlememiz için DEALLOCATE etmemiz gerekmektedir.

	update Users set Email = UserName + '@domain.com'

	select * from Users

--
