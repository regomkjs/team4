insert into upper values (0,'문학'),(1,'철학'),(2,'종교'),(3,'사회과학'),(100,'임시');
insert into under values (1,'임시',0,100);
insert into under(un_name,un_code,un_up_num) values 
('문학',0,0),('문학이론',1,0),('문장작법',2,0),
('철학',0,1),('형이상학작법',10,1),('인식론',20,1),
('종교',0,2),('종교철학',1,2),('불교',20,2),
('사회과학',0,3),('잡지',3,3),('연속간행물',5,3);

insert into sale_state values (1,'준비'),(2,'배송'),(3,'도착'),(4,'수령'),(5,'취소');
/*group by 에러 발생시
SET GLOBAL sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
*/