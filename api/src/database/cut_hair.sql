-- show databases;
-- create database cut_hair;
-- drop database cut_hair;
-- use cut_hair;
-- creae table
create table baber(
	idBaber varchar(50) primary key,
    nameBaber varchar(50) not null,
    position varchar(50) not null,
    gender varchar(6) not null,
    contact varchar(10) not null,
    email varchar(100) not null,
    address varchar(100) not null,
    birthDay date, #nam-thang-ngay
    isActive numeric(1) not null, #1 true, 0 false
    salary float default 0  check (salary >= 0),
    avatar varchar(200)
);
create table customer(
	idCustomer varchar(50) primary key,
    nameCustomer varchar(50) not null,
    timeBook timestamp, #nam-thang-ngay gio:phut
    phone varchar(10) not null
);
create table product(
	idProduct varchar(50) primary key,
    nameProduct varchar(50)
);
create table productItem(
	idProductItem varchar(50) primary key,
    nameProductItem varchar(50) not null,
    idProduct varchar(50) references product(idProduct),
    priceProductItem float default 0 check (priceProductItem>=0),
    imageProductItem varchar(200)
);
create table service(
	idService varchar(50) primary key,
    nameService varchar(50) not null
);
create table serviceItem(
	idServiceItem varchar(50) primary key,
    nameServiceItem varchar(50) not null,
	time time, #gio:phut:giay
    idService varchar(50) references service(idService),
    priceServiceItem float default 0 check (priceServiceItem>=0),
    imageServiceItem varchar(200)
);

create table bill(
	idBill varchar(50) primary key,
    idBaber varchar(50) references baber(idBaber),
    idCustomer varchar(50) references customer(idCustomer),
	totalPrice float default 0 check (totalprice >= 0)
);
create table billListService(
	idBill varchar(50) references bill(idBill),
	idServiceItem varchar(50) references serviceItem(idServiceItem),
    unique (idBill, idServiceItem)
);

create table billListProduct(
	idBill varchar(50) references bill(idBill),
    idProductItem varchar(50) references productItem(idProductItem),
    unique (idBill, idProductItem)
);
-- them hoac sua Barber
delimiter //
create procedure insertUpdateBaber(
	idBaber varchar(50),
    nameBaber varchar(50),
    position varchar(50),
    gender varchar(6),
    contact varchar(10),
    email varchar(100),
    address varchar(100),
    birthDay date, 
    isActive numeric(1),
    salary float,
    avatar varchar(200))
begin
	if exists ( select baber.idBaber from baber where baber.idBaber = idBaber) then
		update baber set 
			baber.nameBaber = nameBaber,
			baber.position = position,
			baber.gender = gender,
			baber.contact = contact,
            baber.email = email,
			baber.address = address,
			baber.birthDay = birthDay,
			baber.isActive = isActive,
			baber.salary = salary ,
            baber.avatar = avatar
		where baber.idBaber = idBaber;
	else
		insert into baber
		values (idBaber, nameBaber, position, gender, contact, email, address, birthDay, isActive, salary, avatar);
	end if;
end//
delimiter ;
-- xoa barber
delimiter //
create procedure deleteBaber(in idBaber varchar(50))
begin
	delete from baber where baber.idBaber = idBaber;
end//
delimiter ;
-- them hoac sua customer
delimiter //
create procedure insertUpdateCustomer(
	idCustomer varchar(50),
    nameCustomer varchar(50),
    timebook timestamp, #nam-thang-ngay gio:phut
    phone varchar(10))
begin
	if exists (select customer.idCustomer from customer where customer.idCustomer = idCustomer) then
		update customer set
			customer.nameCustomer = nameCustomer,
			customer.timeBook = timeBook,
			customer.phone = phone
		where customer.idCustomer = idCustomer;
    else
		insert into customer 
		values (idCustomer, nameCustomer, timeBook, phone);
	end if;
    commit;
end//
delimiter ;
-- xoa customer
delimiter //
create procedure deleteCustomer(idCustomer varchar(50))
begin
	delete from customer where customer.idCustomer = idCustomer;
    commit;
end//
delimiter ;
-- them hoac sua Product
delimiter //
create procedure insertUpdateProduct(
	idProduct varchar(50),
    nameProduct varchar(50))
begin
	if exists (select product.idProduct from product where product.idProduct = idProduct) then
		update product set
			product.nameProduct = nameProduct
		where product.idProduct = idProduct;
	else
		insert into product 
		values (idProduct, nameProduct);
	end if;
    commit;
end//
delimiter ;
-- xoa product
delimiter //
create procedure deleteProduct(idProduct varchar(50))
begin
	if exists (select productItem.idProduct from productItem where productItem.idProduct = idProduct) then
		delete from productItem where productItem.idProduct = idProduct;
		delete from product where product.idProduct = idProduct;
    end if;
    commit;
end//
delimiter ;
-- them hoac sua productItem
delimiter //
create procedure insertUpdateProductItem(
	idProductItem varchar(50),
    nameProductItem varchar(50),
    idProduct varchar(50),
    priceProductItem float,
    imageProductItem varchar(200))
begin
	if exists (select productItem.idProductItem 
			   from productItem 
               where productItem.idProductItem = idProductItem) then
		update productItem set
			productItem.nameProductItem = nameProductItem,
            productItem.idProduct = idProduct,
            productItem.priceProductItem = priceProductItem,
            productItem.imageProductItem = imageProductItem
		where productItem.idProductItem = idProductItem;
	else
		insert into productItem
		values (idProductItem, nameProductItem, idProduct, priceProductItem, imageProductItem);
	end if;
    commit;
end//
delimiter ;
-- xoa productItem
delimiter //
create procedure deleteProductItem(idProductItem varchar(50))
begin
	delete from productItem where productItem.idProductItem = idProductItem;
end//
delimiter ;
-- them hoac sua service
delimiter //
create procedure insertUpdateService(
	idService varchar(50),
    nameService varchar(50))
begin
	if exists ( select service.idService from service where service.idService = idService) then
		update service set
			service.nameService = nameService
		where service.idService = idService;
	else
		insert into service
		values (idService, nameService);
	end if;
    commit;
end//
delimiter ;
-- xoa service
delimiter //
create procedure deleteService(idService varchar(50))
begin
	if exists (select serviceItem.idService from serviceItem where serviceItem.idService = idService) then
		delete from serviceItem where serviceItem.idService = idService;
		delete from service where service.idService = idService;
    end if;
    commit;
end//
delimiter ;
-- them hoac sua serviceItem
delimiter //
create procedure insertUpdateServiceItem(
	idServiceItem varchar(50),
    nameServiceItem varchar(50),
	time time, #nam-thang-ngay gio:phut
    idService varchar(50),
    priceServiceItem float,
    imageServiceItem varchar(200))
begin
	if exists ( select serviceItem.idServiceItem 
				from serviceItem 
                where serviceItem.idServiceItem = idServiceItem) then
		update serviceItem set
			serviceItem.nameServiceItem = nameServiceItem,
            serviceItem.time = time,
            serviceItem.idService = idService,
            serviceItem.priceServiceItem = priceServiceItem,
            serviceItem.imageServiceItem = imageServiceItem
		where serviceItem.idServiceItem = idServiceItem;
	else
		insert into serviceItem
		values (idServiceItem , nameServiceItem, time, idService, priceServiceItem, imageServiceItem);
	end if;
    commit;
end//
delimiter ;
-- xoa serviceItem
delimiter //
create procedure deleteServiceItem(idServiceItem varchar(50))
begin
	delete from serviceItem where serviceItem.idServiceItem = idServiceItem;
    commit;
end//
delimiter ;
-- them Bill
delimiter //
create procedure insertUpdateBill(
	idBill varchar(50),
    idBaber varchar(50),
    idCustomer varchar(50))
begin
	insert into bill(idBill, idBaber, idCustomer)
		values (idBill, idBaber, idCustomer);
    commit;
end//
delimiter ;
-- them danh sach serviceItem trong bill
delimiter //
create procedure insertBillListService(
	idBill varchar(50), 
    idServiceItem varchar(50))
begin
	insert into billListService(idBill, idServiceItem)
		values (idBill, idServiceItem);
    commit;
end//
delimiter ;
-- them danh sach productItem trong bill
delimiter //
create procedure insertBillListProduct(
	idBill varchar(50), 
    idProductItem varchar(50))
begin
	insert into billListProduct(idBill, idProductItem)
		values (idBill, idProductItem);
    commit;
end//
delimiter ;
-- tinh tong tien trong bill
delimiter //
create function calTotalPriceBill(idBill varchar(50))
returns float
begin
	declare sumPriceBill float;
    declare sumPriceService float;
    declare sumPriceProduct float;
    if not exists ( select *,billListService.idBill 
				from bill left outer join billListService on bill.idBill = billListService.idBill 
                where billListService.idBill = idbill) then
		select 0 into sumPriceService;
	else
		select sum(serviceItem.priceServiceItem) into sumPriceService 
		from bill join billListService on bill.idBill = billListService.idBill
				  join serviceItem on billListService.idServiceItem = serviceItem.idServiceItem
		where bill.idBill = idBill;
	end if;
    if not exists ( select billListProduct.idBill 
				from bill left outer join billListProduct on bill.idBill = billListProduct.idBill 
                where billListProduct.idBill = idbill) then
		select 0 into sumPriceProduct;
	else
		select sum(productItem.priceProductItem) into sumPriceProduct 
		from bill join billListProduct on bill.idBill = billListProduct.idBill
				  join ProductItem on billListProduct.idProductItem = productItem.idProductItem
		where bill.idBill = idBill;
	end if;
    return sumPriceService + sumPriceProduct ;
end//
delimiter ;
-- xoa bill
delimiter //
create procedure deleteBill(idBill varchar(50))
begin
	delete from bill where bill.idBill = idBill;
    commit;
end//
delimiter ;
-- them tong tien vao bill
delimiter //
create procedure updateTotalPriceBill(idBill varchar(50))
begin
	update bill set
			bill.totalPrice = (select avg(calTotalPriceBill(idBill)) from bill)
	where bill.idBill = idBill;
    commit;
end//
delimiter ;
-- xep hang serviceItem su dung nhieu nhat
delimiter //
create procedure rankServiceItem()
begin
	select serviceItem.nameServiceItem as name, count(billListService.idServiceItem) as orders, count(billListService.idServiceItem) / (select count(idServiceItem) from billListService) * 100  as percent 
	from billListService join serviceItem on billListService.idServiceItem = serviceItem.idServiceItem
	group by billListService.idServiceItem order by orders desc;
end//
delimiter ;
-- xep hang productItem su dung nhieu nhat
delimiter //
create procedure rankProductItem()
begin
	select productItem.nameProductItem as name, count(billListProduct.idProductItem) as orders, count(billListProduct.idProductItem) / (select count(idproductItem) from billListProduct) * 100  as percent 
	from billListProduct join productItem on billListProduct.idProductItem = productItem.idProductItem
	group by billListProduct.idProductItem order by orders desc;
end//
delimiter ;
-- thong ke bill
delimiter //
create procedure totalRank()
begin
	select count(bill.idBill) as booking, 
		(select count(idProductItem) from billListProduct) as orders, 
        (select count(idServiceItem) from billListService)  as services,
        sum(totalPrice) as balance
	from bill;
end//
delimiter ;
-- insert du lieu
-- barber
call insertUpdateBaber("d998c6c0-42f3-11ec-81d3-0242ac130003","Musa Chad","employee","male","0912345678","a@gmail.com","Can Tho","2000-01-01",1,300,"https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637153926/cut-hair/babers/photo-1570612861542-284f4c12e75f_lyewkg.jpg");
call insertUpdateBaber("406ff7ce-42f4-11ec-81d3-0242ac130003","Zane Hailey","employee","male","0912345679","b@gmail.com","Vinh Long","2001-01-01",1,290,"https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637153926/cut-hair/babers/360_F_258899001_68CalsKTRk6PZQgWH9JhR4heBlncCko9_jqi4sf.jpg");
call insertUpdateBaber("7528e1c3-df07-47b4-9586-53124c650182","Barrie Beverley","employee","male","0912345671","c@gmail.com","Can Tho","2001-01-02",1,290,"https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637153926/cut-hair/babers/b_n85zg1.jpg");
call insertUpdateBaber("a561bfc1-8e59-48cf-ae94-91c412b1b3c8","Conner Sands","employee","male","0912345672","d@gmail.com","Can Tho","2001-01-03",1,300,"https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637153926/cut-hair/babers/c_tgdaqv.jpg");
call insertUpdateBaber("674b722c-5ec7-4ee3-9c39-fab2ac73df01","Hollis Holme","employee","male","0912345673","e@gmail.com","Hau Giang","2000-01-02",1,320,"https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637153926/cut-hair/babers/a_roq45k.jpg");
call insertUpdateBaber("86d75940-e5e6-4a69-9ac7-860ea66a5f55","Carole Grey","employee","male","09123456734","f@gmail.com","Hau Giang","2000-01-02",1,320,"https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637153926/cut-hair/babers/close-portrait-young-smiling-handsome-260nw-1180874596_rs1a04.jpg");
call insertUpdateBaber("d24dc872-3919-479c-87cf-28369a4e3859","Manraj Vance","employee","male","0912345675","g@gmail.com","Hau Giang","2000-01-02",1,320,"https://res.cloudinary.com/dfcvhqdl0/image/upload/v1638112913/cut-hair/babers/barberb_lzwl3w.jpg");
call insertUpdateBaber("4051164a-c567-41fc-a4f2-9eb95700df88","Daniele Cuevas","employee","male","0912345676","h@gmail.com","Hau Giang","2000-01-02",1,320,"https://res.cloudinary.com/dfcvhqdl0/image/upload/v1638112913/cut-hair/babers/barbere_zxqggk.jpg");
call insertUpdateBaber("c8b5dacb-568b-45be-9a64-dd5179af2cb6","Anwen Cottrell","employee","male","0912345677","i@gmail.com","Hau Giang","2000-01-02",1,320,"https://res.cloudinary.com/dfcvhqdl0/image/upload/v1638112913/cut-hair/babers/barberc_ikseej.jpg");
call insertUpdateBaber("2fbd17ec-e2be-408a-be36-a20fdf559bb7","Amalia Guzman","employee","male","0912345678","j@gmail.com","Hau Giang","2000-01-02",1,320,"https://res.cloudinary.com/dfcvhqdl0/image/upload/v1638112913/cut-hair/babers/barbera_ragxhr.jpg");
call insertUpdateBaber("ffd238b8-074f-4f47-bb3f-9a95f2b5b634","Gruffydd Moyer","employee","male","0912345679","k@gmail.com","Hau Giang","2000-01-02",1,320,"https://res.cloudinary.com/dfcvhqdl0/image/upload/v1638112912/cut-hair/babers/barberd_dttm0a.jpg");
call insertUpdateBaber("6da8598a-d6ea-41b2-abd3-fb1631676bbf","Roma Mathews","employee","male","0912345680","l@gmail.com","Hau Giang","2000-01-02",1,320,"https://res.cloudinary.com/dfcvhqdl0/image/upload/v1638112906/cut-hair/babers/barberf_w5a8aq.jpg");
-- product
call insertUpdateProduct("3590d586-80f4-46cc-a124-7aca66d897c8", "Shampoo");
call insertUpdateProduct("214c068e-9ea6-403a-a20c-67b416006e73", "Hairspray");
call insertUpdateProduct("c37bf797-de00-4c3f-b9ba-bf3195f795ae", "Wax");
-- product item
call insertUpdateProductItem("c4d1f51a-6bf0-4049-b4ae-60204344ee20","Clear Men 900G", "3590d586-80f4-46cc-a124-7aca66d897c8", 7, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637152997/cut-hair/product/c4d1f51a-6bf0-4049-b4ae-60204344ee20_t23tx9.jpg");
call insertUpdateProductItem("e518c363-0f0d-44bc-adbb-77e17edc8103","X-Men Wood 650G", "3590d586-80f4-46cc-a124-7aca66d897c8", 6, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637152997/cut-hair/product/e518c363-0f0d-44bc-adbb-77e17edc8103_x3kqtu.jpg");
call insertUpdateProductItem("2bb8bcdf-f29f-4220-a284-629cdc8db0f0","Head Shoulders UltraMen 650ml", "3590d586-80f4-46cc-a124-7aca66d897c8", 5, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637152999/cut-hair/product/2bb8bcdf-f29f-4220-a284-629cdc8db0f0_etubs6.png");
call insertUpdateProductItem("05a48ff4-82b4-4999-86d7-395be73a9b80","PHARMAACT COOL TONIC 600ml", "3590d586-80f4-46cc-a124-7aca66d897c8", 4, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637152997/cut-hair/product/05a48ff4-82b4-4999-86d7-395be73a9b80_iogcnj.jpg");

call insertUpdateProductItem("fc579435-6bef-4a73-be19-b4341da6ea4d","Daily Ultra Holding Scalp Spray 50ml", "214c068e-9ea6-403a-a20c-67b416006e73", 7, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637152999/cut-hair/product/fc579435-6bef-4a73-be19-b4341da6ea4d_o9zmrc.jpg");
call insertUpdateProductItem("3763c7ff-7f08-45dc-b69d-9dd532b553f1","BRITISH M Hard Tailor Spray 80ml", "214c068e-9ea6-403a-a20c-67b416006e73", 5, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637152997/cut-hair/product/3763c7ff-7f08-45dc-b69d-9dd532b553f1_dhqrsf.jpg");
call insertUpdateProductItem("ee2f6478-5584-4eb4-9413-31ba5e421f6d","Absolute Set Haircoat 500ml", "214c068e-9ea6-403a-a20c-67b416006e73", 22, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637152998/cut-hair/product/ee2f6478-5584-4eb4-9413-31ba5e421f6d_p4n5jz.jpg");
call insertUpdateProductItem("1e342e6d-f8e9-4f9f-ae85-eebcd8721dfe","CEDEL HAIRSPRAY 250G", "214c068e-9ea6-403a-a20c-67b416006e73", 10, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637153000/cut-hair/product/1e342e6d-f8e9-4f9f-ae85-eebcd8721dfe_hbidmi.jpg");

call insertUpdateProductItem("f10ebb95-3ddc-4f3c-9fff-7dee46067b0f","Dr.smart", "c37bf797-de00-4c3f-b9ba-bf3195f795ae", 10, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1638113370/cut-hair/product/41Tt-uXtg7L_jqmino.jpg");
call insertUpdateProductItem("08d46a5c-b336-44d0-804b-9f6ed538954f","Baber Wax", "c37bf797-de00-4c3f-b9ba-bf3195f795ae", 10, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1638113371/cut-hair/product/30e6dd2453e6c29c7cc8a5ffde109c69_osnakr.jpg");
call insertUpdateProductItem("d607c898-2fb9-4f07-b507-deada20e227c","Clay Wax", "c37bf797-de00-4c3f-b9ba-bf3195f795ae", 10, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1638113371/cut-hair/product/193e0272760565eea210c6dba68a432d_drghc0.jpg");
call insertUpdateProductItem("e405becc-6c1e-4dab-b31c-1fced235bb9d","Colmay", "c37bf797-de00-4c3f-b9ba-bf3195f795ae", 10, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1638113371/cut-hair/product/1555408207_sap-wax-tao-kieu-toc-nam-colmav-barber-pomade-den_xvwixo.jpg");
-- service
call insertUpdateService("0ce4f955-802a-407b-afa8-f59cfd0a0345", "Cuts");
call insertUpdateService("bf6c2fdd-778c-4e8d-a2b6-c2004f4f39ab", "Stylize hair");
-- serviceItem
call insertUpdateServiceItem("0cb9d9b8-5b93-4306-b3f2-b5cfcb2ccbc4" , "Hair cut", "00:20:00", "0ce4f955-802a-407b-afa8-f59cfd0a0345", 2, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637154440/cut-hair/services/0cb9d9b8-5b93-4306-b3f2-b5cfcb2ccbc4_lvq66x.jpg");
call insertUpdateServiceItem("88b6ca01-3dd5-4e83-87b4-78f1a4f0a4fa" , "Face shave", "00:10:00", "0ce4f955-802a-407b-afa8-f59cfd0a0345", 1, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637154441/cut-hair/services/88b6ca01-3dd5-4e83-87b4-78f1a4f0a4fa_kumhz4.jpg");
call insertUpdateServiceItem("1507afd1-3aad-493f-9268-5c9438629433" , "Ear removal", "00:10:00", "0ce4f955-802a-407b-afa8-f59cfd0a0345", 1, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637154442/cut-hair/services/depositphotos_227942814-stock-photo-turkish-barber-ear-hairs-removal_ihw8me.jpg");
call insertUpdateServiceItem("775da628-8999-4780-a83b-5d703fedfc5c" , "Hairwash", "00:20:00", "0ce4f955-802a-407b-afa8-f59cfd0a0345", 2, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637154440/cut-hair/services/775da628-8999-4780-a83b-5d703fedfc5c_u1szsv.jpg");
call insertUpdateServiceItem("fb4a8949-9c64-4a86-be6b-5bdf2a8493ac" , "Face massage", "00:20:00", "0ce4f955-802a-407b-afa8-f59cfd0a0345", 2, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637154442/cut-hair/services/fb4a8949-9c64-4a86-be6b-5bdf2a8493ac_pnzcuy.jpg");
call insertUpdateServiceItem("489ef695-f333-4ad7-9bd8-fc8804555e9b" , "Eyebrow threading", "00:10:00", "0ce4f955-802a-407b-afa8-f59cfd0a0345", 1, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637154440/cut-hair/services/489ef695-f333-4ad7-9bd8-fc8804555e9b_ily3or.jpg");

call insertUpdateServiceItem("c0be18f5-b44f-4b51-b7ee-c454826a8e88" , "Hair dying", "01:00:00", "bf6c2fdd-778c-4e8d-a2b6-c2004f4f39ab", 10, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637154441/cut-hair/services/c0be18f5-b44f-4b51-b7ee-c454826a8e88_xynvvn.jpg");
call insertUpdateServiceItem("b3204f64-b3ef-4d3c-ae68-5d00063649f9" , "Curling hair", "02:00:00", "bf6c2fdd-778c-4e8d-a2b6-c2004f4f39ab", 10, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637154440/cut-hair/services/b3204f64-b3ef-4d3c-ae68-5d00063649f9_mkb6oe.jpg");
call insertUpdateServiceItem("1ba0c3a1-83bb-451c-a916-359efa3b3ebd" , "Hair bleach", "01:00:00", "bf6c2fdd-778c-4e8d-a2b6-c2004f4f39ab", 5, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637154441/cut-hair/services/1ba0c3a1-83bb-451c-a916-359efa3b3ebd_birrmn.jpg");
call insertUpdateServiceItem("57c687de-9de4-4736-a829-1b43016d7477" , "Straighten", "01:00:00", "bf6c2fdd-778c-4e8d-a2b6-c2004f4f39ab", 10, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637154442/cut-hair/services/maxresdefault_dmv7f4.jpg");
call insertUpdateServiceItem("f4717544-970a-49dd-b5ad-7f92f080cc42" , "Highlights", "01:00:00", "bf6c2fdd-778c-4e8d-a2b6-c2004f4f39ab", 10, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637154442/cut-hair/services/hair-highlights-for-men-chocolate-parted-faded-683x1024_knpvf0.jpg");
call insertUpdateServiceItem("27aa742c-a61d-4c5c-9bac-8e460d120df2" , "Air press hair", "01:00:00", "bf6c2fdd-778c-4e8d-a2b6-c2004f4f39ab", 10, "https://res.cloudinary.com/dfcvhqdl0/image/upload/v1637154442/cut-hair/services/best-hair-gel-2020_hbhhhw.jpg");
