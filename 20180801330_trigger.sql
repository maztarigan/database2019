1.Buat tabel T_GUDANG

CREATE TABLE  "T_GUDANG" 
   (	"NAMA_BARANG" VARCHAR2(50), 
	"QUANTITY" NUMBER, 
	 CONSTRAINT "T_GUDANG_PK" PRIMARY KEY ("NAMA_BARANG") ENABLE
   )

2.Buat tabel T_PURCHASE

CREATE TABLE  "T_PURCHASE" 
   (	"NAMA_BARANG" VARCHAR2(50), 
	"QUANTITY" NUMBER
   )
/
ALTER TABLE  "T_PURCHASE" ADD CONSTRAINT "T_PURCHASE_FK" FOREIGN KEY ("NAMA_BARANG")
	  REFERENCES  "T_GUDANG" ("NAMA_BARANG") ENABLE
/

3.Buat tabel T_SALES

CREATE TABLE  "T_SALES" 
   (	"NAMA_BARANG" VARCHAR2(50), 
	"QUANTITY" NUMBER
   )
/
ALTER TABLE  "T_SALES" ADD CONSTRAINT "T_SALES_FK" FOREIGN KEY ("NAMA_BARANG")
	  REFERENCES  "T_GUDANG" ("NAMA_BARANG") ENABLE
/


4.Buat trigger tabel T_PURCHASE

CREATE OR REPLACE TRIGGER  "T_PURCHASE" 
before insert or update on T_PURCHASE
for each row
 WHEN (new.nama_barang is not null) begin
update T_GUDANG
set quantity = quantity + :new.quantity
where nama_barang = :new.nama_barang;
end;

5.Buat trigger tabel T_SALES

CREATE OR REPLACE TRIGGER  "T_SALES" 
before insert or update on T_SALES
for each row
 WHEN (new.nama_barang is not null) begin
update T_GUDANG
set quantity = quantity - :new.quantity
where nama_barang = :new.nama_barang;
end;



select * from T_GUDANG

insert into T_GUDANG
values('khongguan','25')
insert into T_GUDANG
values('better','25')
insert into T_GUDANG
values('cimori','50')

select * from T_PURCHASE

insert into T_PURCHASE
values('better','25')


select * from T_SALES

insert into T_SALES
values('khongguan','15')

