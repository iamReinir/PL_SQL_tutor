/*
 1.Write function name: StudenID_ Func1 with parameter @mavt,
 return the sum of sl * giaban corresponding.
 */
CREATE
OR REPLACE FUNCTION QE170172_Func1(tar_vt in varchar2) RETURN int
IS
	total int := 0;
	num int := 0;
	price int := 0;
BEGIN
	FOR vt IN(
		SELECT
			sl,
			giaban
		FROM
			CHITIETHOADON
		WHERE
			MaVT = tar_vt)
	LOOP
		total := total + vt.sl * vt.giaban;
	END LOOP;
return total;
END;
/
/*
 2.Write function to return a total of the HoaDon
 (@MahD is a parameter)
 */
CREATE OR REPLACE
FUNCTION total_HoaDon(code in varchar2) RETURN int
IS
	result int := 0;
BEGIN
	FOR rec IN (SELECT sl,giaban FROM CHITIETHOADON WHERE MaHD=code)
	loop
		result := result + rec.sl*rec.giaban;
	end loop;
	return result;
END;
/

/*
3.	Write procedure name: StudenId _Proc1, parameter @makh, @diachi. This procedure
help user update @diachi corresponding @makh.
*/

CREATE OR REPLACE
procedure qe170172_proc1(
  cust_code in varchar2,
  address in varchar2
)
is
begin
  update KHACHHANG
	 set DiaChi=address
   where MaKH=cust_code;
end;
/

/*
4.	Write procedure to add an item into Hoadon
*/

CREATE OR REPLACE
procedure add_to_hoadon(
	code in varchar2,
	day in date,
	cust_code in varchar2
)
is
begin
  insert into HoaDon (MaHD,ngay,MaKH)
  values (code,dat,cust_code);
end;
/

/*
5.	Write trigger name: StudenId_ Trig1 on table Chitiethoadon,
when user insert data into Chitiethoadon,
the trigger will update the Tongtien in HoaDon
(student should add Tongtien column into Hoadon, tongtien=sum(sl*giaban).
*/

CREATE OR REPLACE
TRIGGER qe170172_trig1 AFTER INSERT ON CHITIETHOADON
REFERENCING NEW AS newRow
begin
  update HOADON
	 set TongTG= newRow.sl * newRow.giaban;
   where condition
end;

