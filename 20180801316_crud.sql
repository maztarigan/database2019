//READ ALL:
SELECT * FROM T_9_MAHASISWA

//READ WHERE BY NIM:
SELECT * FROM T_9_MAHASISWA
WHERE nim = '20180801316'

//INSERT:
INSERT INTO T_9_MAHASISWA(NIM,NAMA,ALAMAT,NOHP)
VALUES('20180801316','Wied','kp.dukuh rt.15 rw.04 ds.dukuh kec.cikupa kab.tangerang','081383434386')

INSERT INTO T_9_MAHASISWA(NIM,NAMA)
VALUES('20180801309','Bagus')

INSERT INTO T_9_MAHASISWA(NIM,NAMA)
VALUES('20180801310','Iip')

INSERT INTO T_9_MAHASISWA(NIM,NAMA)
VALUES('20180801311','Rizki')

INSERT INTO T_9_MAHASISWA(NIM,NAMA)
VALUES('20180801312','Sopo')

INSERT INTO T_9_MAHASISWA(NIM,NAMA)
VALUES('20180801313','Pandu')

//UPDATE:
UPDATE T_9_MAHASISWA
SET ALAMAT = 'Curug 2 No A1'
WHERE nim = '20180801309'

//DELETE:
DELETE T_9_MAHASISWA
WHERE nim = '20180801312'