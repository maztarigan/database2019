select * from MAHASISWA_UEU

desc MAHASISWA_UEU

INSERT

INSERT INTO MAHASISWA_UEU(NIM,NAMA)
VALUES('20180801312','Yondo Gabe')

INSERT INTO MAHASISWA_UEU(NIM,NAMA)
VALUES('20180801326','Rizky')

INSERT INTO MAHASISWA_UEU(NIM,NAMA)
VALUES('20180801323','Tony Afryanto')

INSERT INTO MAHASISWA_UEU(NIM,NAMA)
VALUES('20180801320','Adib Mujahid')

INSERT INTO MAHASISWA_UEU(NIM,NAMA)
VALUES('20180801330','Yulius')

INSERT INTO MAHASISWA_UEU(NIM,NAMA)
VALUES('20180801329','IIP')

READ:

READ ALL:
SELECT * FROM MAHASISWA_UEU

READ WHERE:
SELECT * FROM MAHASISWA_UEU
WHERE nim = '20180801312'

UPDATE:

UPDATE MAHASISWA_UEU
SET alamat = 'kp.cipari'
WHERE nim = '20180801312'

UPDATE MAHASISWA_UEU
SET no_hp = '082360125319'
WHERE nim = '20180801312'

DELETE:

DELETE MAHASISWA_UEU
WHERE nim = '20180801330'