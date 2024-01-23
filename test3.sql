create database quanlyvattu;
use quanlyvattu;
create table vattu(
id int primary key,
mavattu int,
tenvattu varchar(255),
donvi varchar(255),
giatien int);
create table tonkho(
id int primary key,
vattu_id int,
soluongdau int,
tongnhap int,
tongxuat int);
create table nhacungcap(
id int primary key,
manhacungcap int,
tennhacungcap varchar(255),
diachia varchar(255),
sdt int(10));
create table donhang(
id int primary key,
madonhang int,
ngaydathang date,
nhacungcap_id int,
foreign key (nhacungcap_id) references nhacungcap(id));
create table phieunhap(
id int primary key,
maphieunhap int,
ngaynhap date,
donhang_id int,
foreign key (donhang_id) references donhang(id));
create table phieuxuat(
id int primary key,
maphieuxuat int,
ngayxuat date,
tenkhachhang varchar(255));
create table chitietdonhang(
id int primary key,
donhang_id int,
vattu_id int,
soluongdat int,
foreign key (donhang_id) references donhang(id));
create table chitietphieunhap(
id int primary key,
phieunhap_id int,
vattu_id int,
soluongnhap int,
dongianhap int,
ghichu varchar(255),
foreign key (phieunhap_id) references phieunhap(id),
foreign key (vattu_id) references vattu(id));
create table chitietphieuxuat(
id int primary key,
phieuxuat_id int,
vattu_id int,
soluongxuat int,
dongiaxuat int,
ghichu varchar(255),
foreign key (phieuxuat_id) references phieuxuat(id),
foreign key (vattu_id) references vattu(id));

alter table tonkho add foreign key (vattu_id) references vattu(id); 

insert into vattu values(1,11,'Sat','kg',10),
(2,22,'vai','m',20),
(3,33,'thep','kg',15),
(4,44,'ong nhua','cai',25),
(5,55,'si mang','bao',50);

insert into tonkho values(1,1,25,100,50),
(2,2,10,50,32),
(3,3,70,85,60),
(4,4,12,30,6),
(5,5,34,47,57);

insert into nhacungcap values(1,15,'cty abc','HN',0123564879),
(2,18,'cty xyz','HP',0564642694),
(3,20,'cty hhh','BG',0784562489);

insert into donhang values(1,101,'2020-03-12',1),
(2,122,'2020-10-11',2),
(3,302,'2020-12-25',3);

insert into phieunhap values(1,120320,'2020-03-12',1),
(2,11102020,'2020-10-11',2),
(3,25122020,'2020-12-25',3);

insert into phieuxuat values (1,11112020,'2020-11-11','Nguyen Van A'),
(2,01062020,'2020-06-01','Tran Van B'),
(3,01052020,'2020-05-01','Nguyen Van A');

insert into chitietdonhang values(1,1,1,100),
(2,3,3,200),
(3,2,5,130),
(4,2,4,60),
(5,1,2,75),
(6,3,1,300);

insert into chitietphieunhap values (1,1,1,100,9,'100kg sat'),
(2,1,3,300,13,'300kg thep'),
(3,2,2,50,18,'50m vai'),
(4,2,5,150,45,'150 bao'),
(5,3,4,20,21,'20 cai'),
(6,3,2,80,17,'80m vai');

insert into chitietphieuxuat values (1,1,1,100,11,'xuat 100kg sat'),
(2,1,3,150,14,'xuat 150kg thep'),
(3,2,2,30,21,'xuat 30m vai'),
(4,2,5,100,53,'xuat 100 bao'),
(5,3,4,15,25,'xuat 15 cai'),
(6,3,2,60,19,' xuat 60m vai');

-- Câu 1. Tạo view có tên vw_CTPNHAP bao gồm các 
-- thông tin sau: số phiếu nhập hàng, mã vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.
create view vw_ctpnhap as select maphieunhap,vattu.mavattu,c.soluongnhap,c.dongianhap,(c.soluongnhap*c.dongianhap) as thanhtien 
from phieunhap p
join chitietphieunhap c on p.id = c.phieunhap_id
join vattu on c.vattu_id = vattu.id;

--  Câu 2. Tạo view có tên vw_CTPNHAP_VT bao gồm các thông tin sau: 
--  số phiếu nhập hàng, mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.
create view vw_ctpnhap_vt as  select maphieunhap,c.vattu_id,vattu.tenvattu,c.soluongnhap,c.dongianhap,(c.soluongnhap*c.dongianhap) 
as thanhtien from phieunhap p
join chitietphieunhap c on p.id = c.phieunhap_id 
join vattu on c.vattu_id = vattu.id;


-- Câu 3. Tạo view có tên vw_CTPNHAP_VT_PN bao gồm các thông tin sau: số phiếu nhập hàng, ngày nhập hàng, 
-- số đơn đặt hàng, mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.
create view vw_ctpnhap_vt_pn as
select maphieunhap,d.ngaydathang,d.madonhang,c.vattu_id,vattu.tenvattu,c.soluongnhap,c.dongianhap,(c.soluongnhap*c.dongianhap) 
as thanhtien from phieunhap p
join chitietphieunhap c on p.id = c.phieunhap_id 
join vattu on c.vattu_id = vattu.id
join donhang d on p.donhang_id = d.id;


-- Câu 4. Tạo view có tên vw_CTPNHAP_VT_PN_DH bao gồm các thông tin sau: số phiếu nhập hàng, ngày nhập hàng, số đơn đặt hàng,
--  mã nhà cung cấp, mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.
create view  vw_CTPNHAP_VT_PN_DH as
select maphieunhap,d.ngaydathang,d.madonhang,n.manhacungcap,c.vattu_id,vattu.tenvattu,c.soluongnhap,c.dongianhap,(c.soluongnhap*c.dongianhap) 
as thanhtien from phieunhap p
join chitietphieunhap c on p.id = c.phieunhap_id 
join vattu on c.vattu_id = vattu.id
join donhang d on p.donhang_id = d.id
join nhacungcap n on n.id = d.nhacungcap_id;

-- Câu 5. Tạo view có tên vw_CTPNHAP_loc  bao gồm các thông tin sau: số phiếu nhập hàng,
--  mã vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập. Và chỉ liệt kê các chi tiết nhập có số lượng nhập > 5.
create view vw_CTPNHAP_loc as
select maphieunhap,vattu.mavattu,c.soluongnhap,c.dongianhap,(c.soluongnhap*c.dongianhap) as thanhtien 
from phieunhap p
join chitietphieunhap c on p.id = c.phieunhap_id
join vattu on c.vattu_id = vattu.id where c.soluongnhap > 5;

-- Câu 6. Tạo view có tên vw_CTPNHAP_VT_loc bao gồm các thông tin sau: số phiếu nhập hàng,
--  mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập. Và chỉ liệt kê các chi tiết nhập vật tư có đơn vị tính là Bộ.
create view vw_CTPNHAP_VT_loc as
select maphieunhap,vattu.mavattu,c.soluongnhap,c.dongianhap,(c.soluongnhap*c.dongianhap) as thanhtien 
from phieunhap p
join chitietphieunhap c on p.id = c.phieunhap_id
join vattu on c.vattu_id = vattu.id where vattu.donvi like 'Bộ';

-- Câu 7. Tạo view có tên vw_CTPXUAT bao gồm các thông tin sau: số phiếu xuất hàng,
--  mã vật tư, số lượng xuất, đơn giá xuất, thành tiền xuất.
create view  vw_CTPXUAT as
select px.maphieuxuat,vt.mavattu,ctpx.soluongxuat,ctpx.dongiaxuat,(ctpx.soluongxuat * ctpx.dongiaxuat) as thanhtien 
from phieuxuat px
join chitietphieuxuat ctpx on px.id = ctpx.phieuxuat_id
join vattu vt on vt.id = ctpx.vattu_id;

-- Câu 8. Tạo view có tên vw_CTPXUAT_VT bao gồm các thông tin sau:
--  số phiếu xuất hàng, mã vật tư, tên vật tư, số lượng xuất, đơn giá xuất.
create view vw_CTPXUAT_VT as
select px.maphieuxuat,vt.mavattu,vt.tenvattu,ctpx.soluongxuat,ctpx.dongiaxuat from phieuxuat px
join chitietphieuxuat ctpx on px.id = ctpx.phieuxuat_id
join vattu vt on vt.id = ctpx.vattu_id;

-- Câu 9. Tạo view có tên vw_CTPXUAT_VT_PX bao gồm các thông tin sau:
--  số phiếu xuất hàng, tên khách hàng, mã vật tư, tên vật tư, số lượng xuất, đơn giá xuất.
create view vw_CTPXUAT_VT_PX as
select px.maphieuxuat,px.tenkhachhang,vt.mavattu,vt.tenvattu,ctpx.soluongxuat,ctpx.dongiaxuat from phieuxuat px
join chitietphieuxuat ctpx on px.id = ctpx.phieuxuat_id
join vattu vt on vt.id = ctpx.vattu_id;


-- Câu 1. Tạo Stored procedure (SP) cho biết 
-- tổng số lượng cuối của vật tư với mã vật tư là tham số vào.

DELIMITER //
CREATE PROCEDURE soluongcuoi(in mavt int,out soluong int)
 BEGIN
	set soluong = (select (sum(ctpn.soluongnhap) - sum(ctpx.soluongxuat)) as soluong from  vattu vt 
 join tonkho tk on vt.id = tk.vattu_id
 join chitietphieunhap ctpn on ctpn.vattu_id = vt.id
 join chitietphieuxuat ctpx on ctpx.vattu_id = vt.id where vt.id = mavt
 group by vt.id);
 END //

DELIMITER ;


-- Câu 2. Tạo SP cho biết tổng tiền xuất của vật tư với mã vật tư là tham số vào, out là tổng tiền xuất
DELIMITER //
CREATE PROCEDURE sotienxuat(in mavt int,out tongtien int)
 BEGIN
	set tongtien = (select (sum(ctpx.dongiaxuat) * sum(ctpx.soluongxuat)) as soluong from  vattu vt 
 join chitietphieuxuat ctpx on ctpx.vattu_id = vt.id where vt.id = mavt
 group by vt.id);
 END //

DELIMITER ;

-- Câu 3. Tạo SP cho biết tổng số lượng đặt theo số đơn hàng với số đơn hàng là tham số vào.
DELIMITER //
CREATE PROCEDURE loluongdat(in madh int)
 BEGIN
	select dh.id,sum(soluongdat) from donhang dh 
    join chitietdonhang ctdh on dh.id = ctdh.donhang_id
    where dh.id = madh
    group by dh.id;
 END //
DELIMITER ;

-- Câu 4. Tạo SP dùng để thêm một đơn đặt hàng.
DELIMITER //
CREATE PROCEDURE themdonhang(in id int,in madh int,in ngay date,in nhacungcap_id int)
 BEGIN
	insert into donhang values(id,madh,ngay,nhacungcap_id);
 END //
DELIMITER ;

-- Câu 5. Tạo SP dùng để thêm một chi tiết đơn đặt hàng.
DELIMITER //
CREATE PROCEDURE themctdonhang(in id int,in donhang_id int,in vattu_id int,in soluongdat int)
 BEGIN
	insert into chitietdonhang values(id,donhang_id,vattu_id,soluongdat);
 END //
DELIMITER ;
call themctdonhang(7,4,5,60);

