use master
create database [test]
use test



create table khachhang
(
	makh char(8) primary key,
	hoten nvarchar(100) not null,
	email char(10) unique,
	dienthoai char(10),
	diachi nvarchar(200),
	ngaydangky date default getdate()
)

create table danhmuc
(
	madm char(5) primary key,
	tendm nvarchar(100) not null unique,
	mota nvarchar(500)
)

--drop table donhang
--drop table sanpham
--drop table danhmuc
create table sanpham
(
	masp char(8) primary key,
	tensp nvarchar(200) not null,
	madm char(5) foreign key references danhmuc(madm),
	giaban decimal(15,0) check (giaban >0),
	tonkho int default 0 check (tonkho >= 0),
	trangthai nvarchar(20) default 'dang ban' check (trangthai in ('dang ban', 'ngung ban', 'het hang'))
)

create table donhang
(
	madh char(10) primary key,
	makh char(8) foreign key references khachhang(makh) not null,
	masp char(8) foreign key references sanpham(masp) not null,
	soluong int check (soluong >= 1),
	dongia decimal(15,0),
	ngaydat datetime default getdate(),
	trangthai nvarchar(20) default 'cho xac nhan' check(trangthai in ('cho xac nhan', 'dang giao', 'da giao', 'da huy'))
)

insert into danhmuc (madm, tendm, mota) values
('DM001', N'Điện thoại', N'Thiết bị thông minh'),
('DM002', N'Laptop', N'Thiết bị thông minh'),
('DM003', N'Phụ kiện', N'Các loại phụ kiện')

INSERT INTO KHACHHANG (MaKH, HoTen, Email, DienThoai, DiaChi) VALUES
('KH000001', N'Nguyễn Văn A', 'a@gmail.com', '0901234567', N'Hà Nội'),
('KH000002', N'Trần Thị B', 'b@yahoo.com', '0912345678', N'TP.HCM'),
('KH000003', N'Lê Văn C', 'c@gmail.com', '0923456789', N'Đà Nẵng'),
('KH000004', N'Phạm Thị D', 'd@hotmail.com', '0934567890', N'Hải Phòng'),
('KH000005', N'Hoàng Văn E', 'e@gmail.com', '0945678901', N'Cần Thơ')

INSERT INTO SANPHAM (MaSP, TenSP, MaDM, GiaBan, TonKho, TrangThai) VALUES
('SP000001', N'iPhone 15', 'DM001', 25000000, 10, 'Dang ban'),
('SP000002', N'Samsung S24', 'DM001', 20000000, 15, 'Dang ban'),
('SP000003', N'Oppo Reno', 'DM001', 8000000, 5, 'Ngung ban'),
('SP000004', N'MacBook Pro', 'DM002', 35000000, 8, 'Dang ban'),
('SP000005', N'Dell XPS', 'DM002', 30000000, 12, 'Dang ban'),
('SP000006', N'Asus ROG', 'DM002', 25000000, 0, 'Ngung ban'),
('SP000007', N'Tai nghe AirPods', 'DM003', 4000000, 50, 'Dang ban'),
('SP000008', N'Chuột Logitech', 'DM003', 1000000, 30, 'Dang ban');

select * from danhmuc