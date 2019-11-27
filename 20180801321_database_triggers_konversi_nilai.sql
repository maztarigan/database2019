CREATE OR REPLACE TRIGGER konversi_nilai_triggers
AFTER INSERT OR UPDATE ON a_nilai 
FOR EACH ROW
WHEN (NEW.angka IS NOT NULL)
DECLARE
nilai number(12) := 0;
hasil char(1) := 0;
BEGIN
nilai := 0;
if nilai >= 79 then
dbms_output.put_line(nilai||'A');
elseif 69 <= nilai || nilai <= 80 then
dbms_output.put_line(nilai||'B');
elseif 59 <= nilai || nilai <= 70 then
dbms_output.put_line(nilai||C');
elseif 49 <= nilai || nilai <= 60 then
dbms_output.put_line(nilai||'D');
else
dbms_output.put_line(nilai||'E');
end if;
UPDATE A_NILAI
SET Huruf = hasil
WHERE kd_mk = :NEW.kd_mk AND NIM = :NEW.nim;
end;
