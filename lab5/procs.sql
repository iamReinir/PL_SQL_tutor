/*
 1.Write function name: StudenID_ Func1 with parameter @mavt,
 return the sum of sl * giaban corresponding.
 */
CREATE FUNCTION QE170172_Func1(tar_vt in varchar2(5)) RETURN int IS total int;

num int;

price int;

BEGIN
SELECT
    sl INTO num,
    giaban INTO price
FROM
    CHITIETHOADON
WHERE
    MaVT = tar_vt;

total := num * price;

return total;

END;

/