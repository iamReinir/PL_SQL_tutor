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

