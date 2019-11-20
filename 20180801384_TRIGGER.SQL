TRIGGER = adanya perubahan pada data tsb memicu perubahan pada data yang lainnya.

insert into gnov_product
values('beng beng',5)
insert into gnov_product
values('SMM',7)
insert into gnov_product
values('jasjus',12)

select * from gnov_product
select * from gnov_purchase
select * from gnov_sales

insert into gnov_purchase
values('SMM','5')

insert into gnov_sales
values('jasjus',2)

==========================================
	       TRIGGER INSERT
==========================================
create or replace TRIGGER nov_purchase_qty_product
BEFORE INSERT OR UPDATE ON gnov_purchase
FOR EACH ROW
WHEN (NEW.NAMA IS NOT NULL)
BEGIN
     UPDATE gnov_product
     SET qty_stock = qty_stock + :NEW.qty
     WHERE nama = :NEW.nama;
END;

========================================
	       TRIGGER DELETE
========================================
create or replace TRIGGER NOV_SALESS_QTY_PRODUCT
BEFORE INSERT OR UPDATE ON gnov_sales
FOR EACH ROW
WHEN (NEW.NAMA IS NOT NULL)
BEGIN
     UPDATE gnov_product
     SET qty_stock = qty_stock - :NEW.qty_sales
     WHERE nama = :NEW.nama;
END;