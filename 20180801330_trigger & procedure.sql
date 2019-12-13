1.Buat tabel ST_MAHASISWA

CREATE TABLE  "ST_MAHASISWA" 
   (	"NIM" VARCHAR2(15) NOT NULL ENABLE, 
	"NAMA" VARCHAR2(25) NOT NULL ENABLE, 
	"FAKULTAS" VARCHAR2(15) NOT NULL ENABLE, 
	"HP" NUMBER, 
	 CONSTRAINT "ST_MAHASISWA_PK" PRIMARY KEY ("NIM") ENABLE
   )


2.Buat tabel ST_MKULIAH

CREATE TABLE  "ST_MKULIAH" 
   (	"KD_MK" VARCHAR2(10) NOT NULL ENABLE, 
	"NM_MK" VARCHAR2(25) NOT NULL ENABLE, 
	 CONSTRAINT "ST_MKULIAH_PK" PRIMARY KEY ("KD_MK") ENABLE
   )


3.Buat tabel ST_UJIAN

CREATE TABLE  "ST_UJIAN" 
   (	"NIM" VARCHAR2(15) NOT NULL ENABLE, 
	"KD_MK" VARCHAR2(10) NOT NULL ENABLE, 
	"NILAI" NUMBER NOT NULL ENABLE, 
	"HURUF" CHAR(1)
   )
/
ALTER TABLE  "ST_UJIAN" ADD CONSTRAINT "ST_UJIAN_FK" FOREIGN KEY ("NIM")
	  REFERENCES  "ST_MAHASISWA" ("NIM") ENABLE
/
ALTER TABLE  "ST_UJIAN" ADD CONSTRAINT "ST_UJIAN_FK2" FOREIGN KEY ("KD_MK")
	  REFERENCES  "ST_MKULIAH" ("KD_MK") ENABLE
/


4.Buat tabel ST_REKAP

CREATE TABLE  "ST_REKAP" 
   (	"NIM" VARCHAR2(15) NOT NULL ENABLE, 
	"KD_MK" VARCHAR2(10) NOT NULL ENABLE, 
	"HURUF" CHAR(1) NOT NULL ENABLE
   )
/
ALTER TABLE  "ST_REKAP" ADD CONSTRAINT "ST_REKAP_FK" FOREIGN KEY ("NIM")
	  REFERENCES  "ST_MAHASISWA" ("NIM") ENABLE
/
ALTER TABLE  "ST_REKAP" ADD CONSTRAINT "ST_REKAP_FK2" FOREIGN KEY ("KD_MK")
	  REFERENCES  "ST_MKULIAH" ("KD_MK") ENABLE
/


5.Buat trigger konversi & update tabel st_rekap

create or replace trigger "update_tabel_rekap"
after insert or update on ST_UJIAN
for each row

declare
konversi char(1);

begin
if (:new.nilai > 79) then
konversi := 'A';
elsif (69 < :new.nilai) and (:new.nilai < 80) then
konversi := 'B';
elsif (59 < :new.nilai) and (:new.nilai < 70) then
konversi := 'C';
elsif (49 < :new.nilai) and (:new.nilai < 60) then
konversi := 'D';
elsif (:new.nilai < 50) then
konversi := 'E';
end if;

insert into ST_REKAP
values(:new.nim, :new.kd_mk,konversi);
end;


6.Input data ST_MAHASISWA

select * from ST_MAHASISWA

insert into st_mahasiswa
values('20180801330','yulius','fasilkom','081287229019')
insert into st_mahasiswa
values('20180801331','daniel','hukum','081287229020')
insert into st_mahasiswa
values('20180801332','yatino','akutansi','081287229090')


7.Input data ST_MKULIAH

select * from ST_MKULIAH

insert into st_mkuliah
values('cr101','aljabar')
insert into st_mkuliah
values('cr102','kalkulus')
insert into st_mkuliah
values('cr103','statistik')


8.Input data ST_UJIAN

select * from ST_UJIAN

insert into st_ujian
values('20180801330','cr101',85,'')
insert into st_ujian
values('20180801331','cr102',73,'')
insert into st_ujian
values('20180801332','cr103',67,'')
insert into st_ujian
values('20180801332','cr101',47,'')


select a.nim,b.nama,a.kd_mk,c.nm_mk,a.huruf
from st_rekap a, st_mahasiswa b, st_mkuliah c
where a.nim = b.nim and a.kd_mk = c.kd_mk


9.Buat procedure insert

create or replace PROCEDURE insert_ujian(
nim_input IN varchar,
kd_mk_input IN varchar,
nilai_input IN number)

IS
BEGIN
INSERT INTO st_ujian(nim,kd_mk,nilai)
values(nim_input,kd_mk_input,nilai_input);
end;

10.Tes procedure insert

begin 
insert_ujian('20180801331','cr103',58);
end;

11.Buat procedure update

create or replace PROCEDURE update_ujian(
n_nim IN varchar,
n_kd_mk IN varchar,
n_nilai IN number)

IS
BEGIN
update st_ujian
set nilai=n_nilai
where nim=n_nim and kd_mk=n_kd_mk;
end;

12.Tes procedure update

BEGIN 
update_ujian2('20180801330','cr103',77);
end;

13.Buat procedure delete

create or replace PROCEDURE delete_ujian(
n_nim IN varchar,
n_kd_mk IN varchar)

IS
BEGIN
delete st_ujian
where nim=n_nim and kd_mk=n_kd_mk;
end;

14.Tes procedure delete

BEGIN
delete_ujian('20180801332','cr103');
end;
