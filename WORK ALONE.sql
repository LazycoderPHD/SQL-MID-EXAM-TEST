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

