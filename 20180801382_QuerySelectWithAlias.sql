20180801382_ArneaWandaIzzi_TeknikInformatika_BasisData

//TUGAS

//#1 TAMPILKAN KRS NAMA MAHASISWA 'ADELITA'
//
SELECT A.NIM, B.NAMA AS NAMA_MAHASISWA, A.KDMK, C.NAMA AS NAMA_MATKUL, C.SKS FROM AWI_KRS A, AWI_MAHASISWA B, AWI_MATKUL C
WHERE B.NIM = A.NIM AND C.KDMK = A.KDMK
AND B.NAMA = 'ADELITA'
//
//#2 TAMPILKAN DOSEN PENGAMPU MK 'KALKULUS 2'
//
SELECT A.NIDN, B.NAMA AS NAMA_DOSEN, A.KDMK, C.NAMA AS NAMA_MATKUL, C.SKS FROM AWI_PENGAMPU A, AWI_DOSEN B, AWI_MATKUL C
WHERE B.NIDN = A.NIDN AND C.KDMK = A.KDMK
AND C.NAMA = 'KALKULUS 2'
//
//#3 TAMPILKAN MAHASISWA YANG DOSEN WALINYA 'MARZUKI SILALAHI'
//
SELECT A.NIM, C.NAMA AS NAMA_MAHASISWA, A.NIDN, B.NAMA AS NAMA_DOSEN FROM AWI_WALI A, AWI_DOSEN B, AWI_MAHASISWA C
WHERE B.NIDN = A.NIDN AND C.NIM = A.NIM
AND B.NAMA = 'MARZUKI SILALAHI'
//
//#4 TAMPILKAN DOSEN YANG MEMILIKI MAHASISWA TERBANYAK DI KELAS
//
SELECT A.NIDN, B.NAMA AS NAMA_DOSEN, A.NIM, C.NAMA AS NAMA_MAHASISWA, E.KDMK, E.NAMA AS NAMA_MATKUL FROM AWI_WALI A, AWI_DOSEN B, AWI_MAHASISWA C, AWI_PENGAMPU D, AWI_MATKUL E
WHERE B.NIDN = A.NIDN AND C.NIM = A.NIM AND D.NIDN = A.NIDN AND E.KDMK = D.KDMK
AND B.NAMA =
(
SELECT B.NAMA FROM
(SELECT TOP 1 COUNT(B.NAMA) AS NAMA_DOSEN, B.NAMA
FROM AWI_WALI A, AWI_DOSEN B, AWI_MAHASISWA C, AWI_PENGAMPU D, AWI_MATKUL E
WHERE B.NIDN = A.NIDN AND C.NIM = A.NIM AND D.NIDN = A.NIDN AND E.KDMK = D.KDMK
GROUP BY B.NAMA
ORDER BY NAMA_DOSEN DESC) AS X
)
//
//#5 TAMPILKAN MATA KULIAH FAVORIT
//
SELECT A.KDMK, B.NAMA AS NAMA_MATKUL, A.NIM, C.NAMA AS NAMA_MAHASISWA FROM AWI_KRS A, AWI_MATKUL B, AWI_MAHASISWA C
WHERE B.KDMK = A.KDMK AND C.NIM = A.NIM
AND B.NAMA =
(
SELECT B.NAMA FROM
(SELECT TOP 1 COUNT(B.NAMA) AS NAMA_MATKUL, B.NAMA
FROM AWI_KRS A, AWI_MATKUL B, AWI_MAHASISWA C
WHERE B.KDMK = A.KDMK AND C.NIM = A.NIM
GROUP BY B.NAMA
ORDER BY NAMA_MATKUL DESC) AS X
)