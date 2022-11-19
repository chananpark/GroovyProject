show user;

select *
from user_tables;

select *
from tbl_employee;

select * 
from tbl_attendance;

commit;

drop table tbl_attendance purge;


create table tbl_attendance
( fk_empno       number  not null                -- 사원번호
, workdate        date default sysdate not null   -- 날짜
, workend        date                            -- 퇴근시간(출근시간은 usedate 에 포함)
, trip           Nvarchar2(1) default 'N'        -- 출장여부
, tripstart      date                            -- 출장시작 (ex. 2022-10-10 11:00)
, tripend        date                            -- 출장종료 (ex. 2022-10-10 11:00)
, dayoff         Nvarchar2(1) default 'N'        -- 연차여부
, extendstart    date                            -- 연장근무시작시간 
, constraint FK_tbl_attendance_fk_empno Foreign key(fk_empno) references tbl_employee(empno)
, constraint PK_tbl_attendance_fk_empno_workdate primary key(fk_empno, workdate)
);
-- Table TBL_ATTENDANCE이(가) 생성되었습니다.

insert into tbl_attendance (fk_empno ) values (6);

update tbl_attendance set workend = 'jaeseok.jpg'
where empno = 10;

create table tbl_attendance_request
( requestid         number        not null         --  근태신청번호 attend_request_seq
, fk_empno          number        not null         --  사원번호
, attend_index      Nvarchar2(10) not null        --   근태종류
, starttime         date          not null         --  시작시간 (ex. 2022-10-10 11:00)
, endtime           date          not null         --  종료시간 (ex. 2022-10-10 11:00)
, place             Nvarchar2(100)                 --  장소
, reason            Nvarchar2(200)                 --  사유
, registerdate      date default sysdate not null  --  신청일자
, constraint PK_tbl_attendance_request_requestid primary key(requestid)
, constraint FK_tbl_attendance_request_fk_empno Foreign key(fk_empno) references tbl_employee(empno)
);
-- Table TBL_ATTENDANCE_REQUEST이(가) 생성되었습니다.

select *
from user_tables;


INSERT INTO tbl_employee 
(empno,cpemail,name,pwd,position,jubun,postcode,bumun,department,pvemail
,mobile,depttel,joindate,empstauts,bank,account,annualcnt)
VALUES(SEQ_TBL_EMPLOYEE.NEXTVAL, 'hyewon@groovy.com', '김혜원', 'qwer1234$',
'부문장', '960319-2222222', '12345', '경영지원부문','인사총무팀','hwon319@daum.net',
'01022223333','101','2022/11/18','1','국민은행','210123456789',15);

INSERT INTO tbl_employee 
(empno,cpemail,name,pwd,position,jubun,postcode,bumun,department,pvemail
,mobile,depttel,joindate,empstauts,bank,account,annualcnt)
VALUES(SEQ_TBL_EMPLOYEE.NEXTVAL, 'hyewon@groovy.com', '김혜원', 'qwer1234$',
'부문장', '960319-2222222', '12345', '경영지원부문','인사총무팀','hwon319@daum.net',
'01022223333','101','2022/11/18','1','국민은행','210123456789',15);

INSERT INTO tbl_employee 
(empno,cpemail,name,pwd,position,jubun,postcode,bumun,department,pvemail
,mobile,depttel,joindate,empstauts,bank,account,annualcnt)
VALUES(SEQ_TBL_EMPLOYEE.NEXTVAL, 'hyewon@groovy.com', '김혜원', 'qwer1234$',
'부문장', '960319-2222222', '12345', '경영지원부문','인사총무팀','hwon319@daum.net',
'01022223333','101','2022/11/18','1','국민은행','210123456789',15);

INSERT INTO tbl_employee 
(empno,cpemail,name,pwd,position,jubun,postcode,bumun,department,pvemail
,mobile,depttel,joindate,empstauts,bank,account,annualcnt)
VALUES(SEQ_TBL_EMPLOYEE.NEXTVAL, 'hyewon@groovy.com', '김혜원', 'qwer1234$',
'부문장', '960319-2222222', '12345', '경영지원부문','인사총무팀','hwon319@daum.net',
'01022223333','101','2022/11/18','1','국민은행','210123456789',15);

commit;

update tbl_employee set empimg = 'jaeseok.jpg'
where empno = 10;





