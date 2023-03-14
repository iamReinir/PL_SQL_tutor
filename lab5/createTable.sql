CREATE DATABASE ABCCompany;

CREATE TABLE KHACHHANG (
    MaKH nvarchar(5) NOT NULL PRIMARY KEY,
    TenKH nvarchar(30) NOT NULL,
    DiaChi nvarchar(50),
    DT nvarchar(10),
    Email nvarchar(30)
);

CREATE TABLE VATTU (
    MaVT nvarchar(5) PRIMARY KEY NOT NULL,
    TenVT nvarchar(30) NOT NULL,
    DVT nvarchar(20),
    GiaMua int CHECK (GiaMua > 0),
    SLTon int CHECK (SLTon >= 0)
);

CREATE TABLE HOADON (
    MaHD nvarchar(10) PRIMARY KEY NOT NULL,
    Ngay datetime CHECK(Ngay < getdate()),
    MaKH nvarchar(5) FOREIGN KEY REFERENCES KHACHHANG(MaKH),
    TongTG int
);

CREATE TABLE CHITIETHOADON (
    MaHD nvarchar(10) FOREIGN KEY REFERENCES HOADON(MaHD),
    MaVT nvarchar(5) FOREIGN KEY REFERENCES VATTU(MaVT),
    PRIMARY KEY (MaHD, MaVT),
    SL int,
    KhuyenMai int,
    GiaBan int
);

INSERT
    VATTU
VALUES
    ('VT01', 'XI MANG', 'BAO', 50000, 5000);

INSERT
    VATTU
VALUES
    ('VT02', 'CAT', 'KHOI', 45000, 50000);

INSERT
    VATTU
VALUES
    ('VT03', 'GACH ONG', 'VIEN', 120, 800000);

INSERT
    VATTU
VALUES
    ('VT04', 'GACH THE', 'VIEN', 110, 800000);

INSERT
    VATTU
VALUES
    ('VT05', 'DA LON', 'KHOI', 25000, 100000);

INSERT
    VATTU
VALUES
    ('VT06', 'DA NHO', 'KHOI', 33000, 100000);

INSERT
    KHACHHANG
VALUES
    (
        'KH01',
        'NGUYEN THI BE',
        'TAN BINH',
        8457895,
        'bnt@yahoo.com'
    );

INSERT
    KHACHHANG
VALUES
    (
        'KH02',
        'LE HOANG NAM',
        'BINH CHANH',
        9878987,
        'namlehoang @abc.com.vn'
    );

INSERT
    KHACHHANG
VALUES
    (
        'KH03',
        'TRAN THI CHIEU',
        'TAN BINH',
        8457895,
        null
    );

INSERT
    KHACHHANG
VALUES
    (
        'KH04',
        'MAI THI QUE ANH',
        'BINH CHANH	',
        null,
        null
    );

INSERT
    KHACHHANG
VALUES
    (
        'KH05',
        'LE VAN SANG',
        'QUAN 10',
        null,
        'sanglv@hcm.vnn.vn'
    );

INSERT
    KHACHHANG
VALUES
    (
        'KH06',
        'TRAN HOANG KHAI',
        'TAN BINH',
        8457897,
        null
    )
INSERT
    HOADON([MaHD], [Ngay], [MaKH])
VALUES
    ('HD001', '2000-05-12', 'KH01');

INSERT
    HOADON([MaHD], [Ngay], [MaKH])
VALUES
    ('HD002', '2000-05-25', 'KH02');

INSERT
    HOADON([MaHD], [Ngay], [MaKH])
VALUES
    ('HD003', '2000-05-25', 'KH01');

INSERT
    HOADON([MaHD], [Ngay], [MaKH])
VALUES
    ('HD004', '2000-05-25', 'KH04');

INSERT
    HOADON([MaHD], [Ngay], [MaKH])
VALUES
    ('HD005', '2000-05-26', 'KH04');

INSERT
    HOADON([MaHD], [Ngay], [MaKH])
VALUES
    ('HD006', '2000-05-02', 'KH03');

INSERT
    HOADON([MaHD], [Ngay], [MaKH])
VALUES
    ('HD007', '2000-06-22', 'KH04');

INSERT
    HOADON([MaHD], [Ngay], [MaKH])
VALUES
    ('HD008', '2000-06-25', 'KH03');

INSERT
    HOADON([MaHD], [Ngay], [MaKH])
VALUES
    ('HD009', '2000-08-15', 'KH04');

INSERT
    HOADON([MaHD], [Ngay], [MaKH])
VALUES
    ('HD010', '2000-08-30', 'KH01');

INSERT
    CHITIETHOADON([MaHD], [MaVT], [SL], [GiaBan])
VALUES
    ('HD001', 'VT01', 5, 52000);

INSERT
    CHITIETHOADON([MaHD], [MaVT], [SL], [GiaBan])
VALUES
    ('HD001', 'VT05', 10, 30000);

INSERT
    CHITIETHOADON([MaHD], [MaVT], [SL], [GiaBan])
VALUES
    ('HD002', 'VT03', 10000, 150);

INSERT
    CHITIETHOADON([MaHD], [MaVT], [SL], [GiaBan])
VALUES
    ('HD003', 'VT02', 20, 55000);

INSERT
    CHITIETHOADON([MaHD], [MaVT], [SL], [GiaBan])
VALUES
    ('HD004', 'VT03', 50000, 150);

INSERT
    CHITIETHOADON([MaHD], [MaVT], [SL], [GiaBan])
VALUES
    ('HD004', 'VT04', 20000, 120);

INSERT
    CHITIETHOADON([MaHD], [MaVT], [SL], [GiaBan])
VALUES
    ('HD005', 'VT05', 10, 30000);

INSERT
    CHITIETHOADON([MaHD], [MaVT], [SL], [GiaBan])
VALUES
    ('HD006', 'VT04', 10000, 120);

INSERT
    CHITIETHOADON([MaHD], [MaVT], [SL], [GiaBan])
VALUES
    ('HD007', 'VT04', 20000, 125);

INSERT
    CHITIETHOADON([MaHD], [MaVT], [SL], [GiaBan])
VALUES
    ('HD008', 'VT01', 100, 55000);

INSERT
    CHITIETHOADON([MaHD], [MaVT], [SL], [GiaBan])
VALUES
    ('HD009', 'VT02', 25, 48000);

INSERT
    CHITIETHOADON([MaHD], [MaVT], [SL], [GiaBan])
VALUES
    ('HD010', 'VT01', 25, 57000);