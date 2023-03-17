/*
 1.Write function name: StudenID_ Func1 with parameter @mavt,
 return the sum of sl * giaban corresponding.
 */
CREATE OR REPLACE FUNCTION QE170172_Func1(tar_vt in varchar2) RETURN int 
IS 
	total int := 0;
	num int := 0;
	price int := 0;
BEGIN
FOR vt IN( SELECT
    sl, giaban   
FROM
    CHITIETHOADON
WHERE
    MaVT = tar_vt)
LOOP
total :=  total + vt.sl * vt.giaban;
END LOOP;
return total;
END;
/

drop function test;

CREATE FUNCTION test RETURN int
IS
	return 10;
END;
/