-- Câu 1 [cite: 30, 31, 32]
CREATE DATABASE [25DH110167];
GO
USE [25DH110167];
GO

-- Câu 2 [cite: 37, 38, 16, 18]
CREATE TABLE DANHMUC (
    MaDM CHAR(5) PRIMARY KEY,
    TenDM NVARCHAR(100) NOT NULL UNIQUE,
    MoTa NVARCHAR(500)
);

CREATE TABLE KHACHHANG (
    MaKH CHAR(8) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    DienThoai CHAR(10),
    DiaChi NVARCHAR(200),
    NgayDangKy DATE DEFAULT GETDATE()
);

-- Câu 3 [cite: 42, 43, 44, 20, 22, 24]
CREATE TABLE SANPHAM (
    MaSP CHAR(8) PRIMARY KEY,
    TenSP NVARCHAR(200) NOT NULL,
    MaDM CHAR(5) FOREIGN KEY REFERENCES DANHMUC(MaDM),
    GiaBan DECIMAL(15,0) CHECK (GiaBan > 0),
    TonKho INT DEFAULT 0 CHECK (TonKho >= 0),
    TrangThai NVARCHAR(20) DEFAULT 'Dang ban' CHECK (TrangThai IN ('Dang ban', 'Ngung ban', 'Het hang'))
);

CREATE TABLE DONHANG (
    MaDH CHAR(10) PRIMARY KEY,
    MaKH CHAR(8) NOT NULL FOREIGN KEY REFERENCES KHACHHANG(MaKH),
    MaSP CHAR(8) NOT NULL FOREIGN KEY REFERENCES SANPHAM(MaSP),
    SoLuong INT CHECK (SoLuong >= 1),
    DonGia DECIMAL(15,0),
    NgayDat DATETIME DEFAULT GETDATE(),
    TrangThai NVARCHAR(20) DEFAULT 'Cho xac nhan' CHECK (TrangThai IN ('Cho xac nhan', 'Dang giao', 'Da giao', 'Da huy'))
);

-- Câu 4 [cite: 52, 53, 54, 55, 56, 57, 58]
INSERT INTO DANHMUC (MaDM, TenDM, MoTa) VALUES
('DM001', N'Điện thoại', N'Các loại điện thoại'),
('DM002', N'Laptop', N'Máy tính xách tay'),
('DM003', N'Phụ kiện', N'Phụ kiện điện tử');

INSERT INTO KHACHHANG (MaKH, HoTen, Email, DienThoai, DiaChi) VALUES
('KH000001', N'Nguyễn Văn A', 'a@gmail.com', '0901234567', N'Hà Nội'),
('KH000002', N'Trần Thị B', 'b@yahoo.com', '0912345678', N'TP.HCM'),
('KH000003', N'Lê Văn C', 'c@gmail.com', '0923456789', N'Đà Nẵng'),
('KH000004', N'Phạm Thị D', 'd@hotmail.com', '0934567890', N'Hải Phòng'),
('KH000005', N'Hoàng Văn E', 'e@gmail.com', '0945678901', N'Cần Thơ');

INSERT INTO SANPHAM (MaSP, TenSP, MaDM, GiaBan, TonKho, TrangThai) VALUES
('SP000001', N'iPhone 15', 'DM001', 25000000, 10, 'Dang ban'),
('SP000002', N'Samsung S24', 'DM001', 20000000, 15, 'Dang ban'),
('SP000003', N'Oppo Reno', 'DM001', 8000000, 5, 'Ngung ban'),
('SP000004', N'MacBook Pro', 'DM002', 35000000, 8, 'Dang ban'),
('SP000005', N'Dell XPS', 'DM002', 30000000, 12, 'Dang ban'),
('SP000006', N'Asus ROG', 'DM002', 25000000, 0, 'Ngung ban'),
('SP000007', N'Tai nghe AirPods', 'DM003', 4000000, 50, 'Dang ban'),
('SP000008', N'Chuột Logitech', 'DM003', 1000000, 30, 'Dang ban');

INSERT INTO DONHANG (MaDH, MaKH, MaSP, SoLuong, DonGia, NgayDat, TrangThai) VALUES
('DH00000001', 'KH000001', 'SP000001', 1, 25000000, '2023-12-01', 'Da giao'),
('DH00000002', 'KH000002', 'SP000004', 1, 35000000, '2023-12-15', 'Da huy'),
('DH00000003', 'KH000003', 'SP000002', 2, 20000000, '2024-01-10', 'Da giao'),
('DH00000004', 'KH000004', 'SP000005', 1, 30000000, '2024-02-05', 'Dang giao'),
('DH00000005', 'KH000005', 'SP000007', 3, 4000000, '2023-11-20', 'Da huy'),
('DH00000006', 'KH000001', 'SP000008', 2, 1000000, '2024-03-01', 'Cho xac nhan'),
('DH00000007', 'KH000002', 'SP000001', 1, 25000000, '2024-03-05', 'Dang giao'),
('DH00000008', 'KH000003', 'SP000007', 1, 4000000, '2023-12-25', 'Da giao'),
('DH00000009', 'KH000004', 'SP000008', 5, 1000000, '2024-03-08', 'Da giao'),
('DH00000010', 'KH000005', 'SP000002', 1, 20000000, '2024-03-10', 'Cho xac nhan');

-- Câu 5 [cite: 63, 64, 65]
UPDATE SANPHAM
SET GiaBan = GiaBan * 1.05
WHERE MaDM IN (SELECT MaDM FROM DANHMUC WHERE TenDM = 'Laptop');

UPDATE DONHANG
SET TrangThai = 'Da giao'
WHERE NgayDat < '2024-01-01' AND TrangThai != 'Da huy';

-- Câu 6 [cite: 73, 74, 75]
SELECT MaSP AS [Mã Sản Phẩm], TenSP AS [Tên Sản Phẩm], GiaBan AS [Giá Bán], TonKho AS [Tồn Kho]
FROM SANPHAM
WHERE TrangThai = 'Dang ban'
ORDER BY GiaBan DESC;

-- Câu 7 [cite: 79, 80, 81]
SELECT HoTen AS [Họ Tên], Email AS [Email]
FROM KHACHHANG
WHERE Email LIKE '%@gmail.com'
ORDER BY HoTen ASC;

-- Câu 8 [cite: 86, 87, 88]
SELECT TrangThai AS [Trạng Thái], COUNT(MaSP) AS [Số Lượng]
FROM SANPHAM
GROUP BY TrangThai
ORDER BY COUNT(MaSP) DESC;

-- Câu 9 [cite: 92, 93, 94]
SELECT TenSP AS [Tên Sản Phẩm], GiaBan AS [Giá Bán]
FROM SANPHAM
WHERE GiaBan BETWEEN 5000000 AND 20000000 AND TonKho > 0
ORDER BY GiaBan ASC;

-- Câu 10 [cite: 102, 103]
SELECT d.MaDH AS [Mã Đơn Hàng], k.HoTen AS [Họ Tên Khách Hàng], s.TenSP AS [Tên Sản Phẩm], d.SoLuong AS [Số Lượng], d.DonGia AS [Đơn Giá], d.NgayDat AS [Ngày Đặt]
FROM DONHANG d
JOIN KHACHHANG k ON d.MaKH = k.MaKH
JOIN SANPHAM s ON d.MaSP = s.MaSP
ORDER BY d.NgayDat DESC;

-- Câu 11 [cite: 108, 109, 110]
SELECT d.MaDH AS [Mã Đơn Hàng], k.HoTen AS [Họ Tên Khách Hàng], s.TenSP AS [Tên Sản Phẩm], (d.SoLuong * d.DonGia) AS [Thành Tiền]
FROM DONHANG d
JOIN KHACHHANG k ON d.MaKH = k.MaKH
JOIN SANPHAM s ON d.MaSP = s.MaSP
WHERE d.TrangThai = 'Da giao'
ORDER BY (d.SoLuong * d.DonGia) DESC;

-- Câu 12 [cite: 114, 115, 116, 117]
SELECT s.TenSP AS [Tên Sản Phẩm], s.GiaBan AS [Giá Bán], s.TonKho AS [Tồn Kho], dm.TenDM AS [Tên Danh Mục]
FROM SANPHAM s
LEFT JOIN DANHMUC dm ON s.MaDM = dm.MaDM
ORDER BY dm.TenDM ASC, s.TenSP ASC;

-- Câu 13 [cite: 122, 123, 124]
SELECT k.HoTen AS [Họ Tên], k.Email AS [Email]
FROM KHACHHANG k
LEFT JOIN DONHANG d ON k.MaKH = d.MaKH
WHERE d.MaDH IS NULL;

-- Câu 14 [cite: 130, 132, 133, 134]
SELECT k.HoTen AS [Họ Tên], SUM(d.SoLuong * d.DonGia) AS [Tổng Doanh Thu]
FROM KHACHHANG k
JOIN DONHANG d ON k.MaKH = d.MaKH
WHERE d.TrangThai = 'Da giao'
GROUP BY k.HoTen
HAVING SUM(d.SoLuong * d.DonGia) >= 5000000
ORDER BY SUM(d.SoLuong * d.DonGia) DESC;

-- Câu 15 [cite: 138, 139, 140]
SELECT dm.TenDM AS [Tên Danh Mục], COUNT(d.MaDH) AS [Tổng Số Đơn Hàng], SUM(d.SoLuong) AS [Tổng Số Lượng], AVG(d.SoLuong * d.DonGia) AS [Doanh Thu Trung Bình]
FROM DANHMUC dm
JOIN SANPHAM s ON dm.MaDM = s.MaDM
JOIN DONHANG d ON s.MaSP = d.MaSP
WHERE d.TrangThai = 'Da giao'
GROUP BY dm.TenDM;

-- Câu 16 [cite: 145, 146, 147]
WITH CTE AS (
    SELECT dm.TenDM, s.TenSP, SUM(d.SoLuong) AS TongSoLuong,
           RANK() OVER(PARTITION BY dm.MaDM ORDER BY SUM(d.SoLuong) DESC) as rn
    FROM DANHMUC dm
    JOIN SANPHAM s ON dm.MaDM = s.MaDM
    JOIN DONHANG d ON s.MaSP = d.MaSP
    WHERE d.TrangThai != 'Da huy'
    GROUP BY dm.MaDM, dm.TenDM, s.TenSP
)
SELECT TenDM AS [Tên Danh Mục], TenSP AS [Tên Sản Phẩm], TongSoLuong AS [Tổng Số Lượng Bán]
FROM CTE
WHERE rn = 1;

-- Câu 17a [cite: 153, 154, 156]
SELECT MaKH AS [Mã Khách Hàng], HoTen AS [Họ Tên]
FROM KHACHHANG
WHERE MaKH IN (
    SELECT MaKH FROM DONHANG WHERE TrangThai = 'Da giao'
    EXCEPT
    SELECT MaKH FROM DONHANG WHERE TrangThai = 'Da huy'
);

-- Câu 17b [cite: 157]
SELECT MaKH AS [Mã Khách Hàng], HoTen AS [Họ Tên]
FROM KHACHHANG
WHERE MaKH IN (
    SELECT MaKH FROM DONHANG WHERE TrangThai = 'Da giao'
    UNION
    SELECT MaKH FROM DONHANG WHERE TrangThai = 'Dang giao'
);

-- Câu 18 [cite: 161, 162]
SELECT MaSP AS [Mã Sản Phẩm], TenSP AS [Tên Sản Phẩm]
FROM SANPHAM
WHERE MaSP IN (
    SELECT MaSP FROM DONHANG WHERE TrangThai = 'Da giao'
    INTERSECT
    SELECT MaSP FROM DONHANG WHERE TrangThai = 'Da huy'
);

-- Câu 19 [cite: 170, 171, 172, 173]
SELECT k.HoTen AS [Họ Tên], SUM(d.SoLuong * d.DonGia) AS [Tổng Chi Tiêu]
FROM KHACHHANG k
JOIN DONHANG d ON k.MaKH = d.MaKH
WHERE d.TrangThai = 'Da giao'
GROUP BY k.MaKH, k.HoTen
HAVING SUM(d.SoLuong * d.DonGia) > (
    SELECT AVG(TongChiTieu)
    FROM (
        SELECT SUM(SoLuong * DonGia) AS TongChiTieu
        FROM DONHANG
        WHERE TrangThai = 'Da giao'
        GROUP BY MaKH
    ) AS T
)
ORDER BY SUM(d.SoLuong * d.DonGia) DESC;

-- Câu 20 [cite: 181, 182, 183, 184]
SELECT k.HoTen AS [Họ Tên], k.Email AS [Email]
FROM KHACHHANG k
WHERE NOT EXISTS (
    SELECT s.MaSP
    FROM SANPHAM s
    JOIN DANHMUC dm ON s.MaDM = dm.MaDM
    WHERE dm.TenDM = N'Điện thoại'
    EXCEPT
    SELECT d.MaSP
    FROM DONHANG d
    WHERE d.MaKH = k.MaKH AND d.TrangThai != 'Da huy'
);

