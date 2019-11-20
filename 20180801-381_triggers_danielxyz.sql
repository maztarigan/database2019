%% Trigger adalah blok PL/SQL yang disimpan dalam database dan akan diaktivasi ketika kita melakukan statement-statement SQL (DELETE, UPDATE, dan INSERT) 
%% pada sebuah tabel. Aktivasi trigger didasarkan pada event yang terjadi di dalam tabel tersebut 
%% sehingga trigger dapat membantu dalam menjaga integritas dan konsistensi data. 
%% Implementasi trigger yang sering ditemui dalam dunia nyata adalah untuk mengeset dan mengubah nilai kolom dalam suatu tabel 
%% sehingga validasi nilai dari tabel tersebut akan terjaga. Adanya trigger dalam database akan meringankan kita dalam pembuatan 
%% aplikasi karena di dalam aplikasi yang kita buat, kita tidak perlu lagi untuk melakukan validasi data.

FORMAT PENULISAN:

CREATE OR REPLACE TRIGGER nama_trigger
timing (BEFORE/AFTER)
event1 OR event2 OR event3 (INSERT/UPDATE/DELETE)
ON nama_objek
FOR EACH ROW
when ()
begin
...<statement>...
    -- trigger body
		-- this code is applied to every 
		-- inserted/updated/deleted row
end;

================================================================
  NOTE
================================================================  
timing      : BEFORE, AFTER, INSTEAD OF
event1/2/3  : INSERT, UPDATE, DELETE, LOGON, LOGOFF
objek       : nama table, nama user, database
================================================================
TASK:
-> BUATLAH 3 TABEL YANG AKAN DIHUBUNGKAN TRIGGERNYA:
    - Nov_Product (Main table)
    - Nov_Purchase (Untuk menambahkan data tabel product)
    - Nov_Sell (Untuk mengurangi data tabel product)
    
-> Query SQL
1. Table Product
CREATE TABLE  "NOV_PRODUCT" 
   (	"NAMA" VARCHAR2(15), 
	"QTY_STOCK" NUMBER, 
	 CONSTRAINT "NOV_PRODUCT_PK" PRIMARY KEY ("NAMA") ENABLE
   )
/


CREATE OR REPLACE TRIGGER  "BI_NOV_PRODUCT" 
  before insert on "NOV_PRODUCT"               
  for each row  
begin   
  if :NEW."NAMA" is null then 
    select "NOV_PRODUCT_SEQ".nextval into :NEW."NAMA" from sys.dual; 
  end if; 
end; 

/
ALTER TRIGGER  "BI_NOV_PRODUCT" ENABLE
/

2. Table Purchase
CREATE TABLE  "NOV_PURCHASE" 
   (	"NAMA" VARCHAR2(15), 
	"QTY" NUMBER
   )
/
ALTER TABLE  "NOV_PURCHASE" ADD CONSTRAINT "NOV_PURCHASE_FK" FOREIGN KEY ("NAMA")
	  REFERENCES  "NOV_PRODUCT" ("NAMA") ENABLE
/


CREATE OR REPLACE TRIGGER  "NOV_PURCHASE_QTY_PRODUCT" 
BEFORE INSERT OR UPDATE ON NOV_PURCHASE
FOR EACH ROW
 WHEN (NEW.nama IS NOT NULL) BEGIN
    UPDATE NOV_PRODUCT
    SET QTY_STOCK = QTY_STOCK + :NEW.qty
    WHERE NAMA = :NEW.nama;
END;
/
ALTER TRIGGER  "NOV_PURCHASE_QTY_PRODUCT" ENABLE
/

3. Table Sell
CREATE TABLE  "NOV_SELL" 
   (	"NAMA" VARCHAR2(15), 
	"QTY" NUMBER
   )
/
ALTER TABLE  "NOV_SELL" ADD CONSTRAINT "NOV_SELL_FK" FOREIGN KEY ("NAMA")
	  REFERENCES  "NOV_PRODUCT" ("NAMA") ENABLE
/


CREATE OR REPLACE TRIGGER  "NOV_SELL_QTY_PRODUCT" 
BEFORE INSERT OR UPDATE ON NOV_SELL 
FOR EACH ROW
 WHEN (NEW.nama IS NOT NULL) BEGIN
    UPDATE NOV_PRODUCT 
SET QTY_STOCK = QTY_STOCK - :NEW.qty 
    WHERE NAMA = :NEW.nama; 
END;
/
ALTER TRIGGER  "NOV_SELL_QTY_PRODUCT" ENABLE
/

================
TRIGGER PURCHASE
================

SELECT * FROM NOV_PRODUCT
DESC NOV_PRODUCT
INSERT INTO NOV_PRODUCT
VALUES('HEXOHM',100)
INSERT INTO NOV_PRODUCT
VALUES('LIQUID',100)
INSERT INTO NOV_PRODUCT
VALUES('RDA',100)

CREATE OR REPLACE TRIGGER NOV_PURCHASE_QTY_PRODUCT //nama trigger bebas
BEFORE INSERT OR UPDATE ON NOV_PURCHASE // sebelum insert atau update diatas/pada table...
FOR EACH ROW
WHEN (NEW.nama IS NOT NULL)
BEGIN
    UPDATE NOV_PRODUCT // TRIGGER UNTUK MEMPERBAHARUI TABEL NOV_PRODUCT
    SET QTY_STOCK = QTY_STOCK + :NEW.qty // JIKA QTY_STOCK ditambah+ qty_baru dalam table purchase
    WHERE NAMA = :NEW.nama; 
END;

SELECT * FROM NOV_PURCHASE
INSERT INTO NOV_PURCHASE
VALUES('HEXOHM',25) //syntax ini untuk menambahkan data '+25' pada kolom 'nama' item product hexohm, setelah di trigger

============
TRIGGER SELL
============

SELECT * FROM NOV_PRODUCT
DESC NOV_PRODUCT
INSERT INTO NOV_PRODUCT
VALUES('HEXOHM',125)
INSERT INTO NOV_PRODUCT
VALUES('LIQUID',100)
INSERT INTO NOV_PRODUCT
VALUES('RDA',100)

CREATE OR REPLACE TRIGGER NOV_SELL_QTY_PRODUCT 
BEFORE INSERT OR UPDATE ON NOV_SELL 
FOR EACH ROW
WHEN (NEW.nama IS NOT NULL)
BEGIN
    UPDATE NOV_PRODUCT 
SET QTY_STOCK = QTY_STOCK - :NEW.qty 
    WHERE NAMA = :NEW.nama; 
END;

SELECT * FROM NOV_SELL
INSERT INTO NOV_SELL
VALUES('LIQUID',75) //syntax ini untuk mengurangi data '-75' pada kolom 'nama' item product liquid, setelah di trigger


/.../
