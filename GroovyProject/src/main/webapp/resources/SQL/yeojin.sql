show user;


------------- >>>>>>>> 일정관리(풀캘린더) 시작 <<<<<<<< -------------
-- *** 캘린더 대분류(내캘린더, 사내캘린더  분류) ***
create table tbl_calendar_large_category 
(lgcatgono   number(3) not null      -- 일정 대분류 번호 // 1: 전사일정, 2:팀별일정, 3:개인일정
,lgcatgoname varchar2(50) not null   -- 일정 대분류 명 
,constraint PK_tbl_calendar_large_category primary key(lgcatgono)
);
-- Table TBL_CALENDAR_LARGE_CATEGORY이(가) 생성되었습니다.

insert into tbl_calendar_large_category(lgcatgono, lgcatgoname)
values(1, '전사일정');

insert into tbl_calendar_large_category(lgcatgono, lgcatgoname)
values(2, '팀별일정');

insert into tbl_calendar_large_category(lgcatgono, lgcatgoname)
values(3, '개인일정');

commit;
-- 커밋 완료.

select * 
from tbl_calendar_large_category;

rollback;

-- *** 캘린더 소분류 *** 
-- (예: 내캘린더중 점심약속, 내캘린더중 저녁약속, 내캘린더중 운동, 내캘린더중 휴가, 내캘린더중 여행, 내캘린더중 출장 등등) 
-- (예: 사내캘린더중 플젝주제선정, 사내캘린더중 플젝요구사항, 사내캘린더중 DB모델링, 사내캘린더중 플젝코딩, 사내캘린더중 PPT작성, 사내캘린더중 플젝발표 등등) 
create table tbl_calendar_small_category 
(smcatgono    number(8) not null      -- 일정 소분류 번호
,fk_lgcatgono number(3) not null      -- 일정 대분류 번호
,smcatgoname  varchar2(400) not null  -- 일정 소분류 명
,fk_empno     number  not null   -- 일정 소분류 작성자 유저아이디
,constraint PK_tbl_calendar_small_category primary key(smcatgono)
,constraint FK_small_category_fk_lgcatgono foreign key(fk_lgcatgono) 
            references tbl_calendar_large_category(lgcatgono) on delete cascade
,constraint FK_small_category_fk_empno foreign key(fk_empno) references tbl_employee(empno)            
);
-- Table TBL_CALENDAR_SMALL_CATEGORY이(가) 생성되었습니다.


create sequence seq_smcatgono
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_SMCATGONO이(가) 생성되었습니다.

insert into tbl_calendar_small_category(smcatgono, fk_lgcatgono, smcatgoname, fk_empno)
values(seq_smcatgono.nextval, 1, '교육일정', 15);

insert into tbl_calendar_small_category(smcatgono, fk_lgcatgono, smcatgoname, fk_empno)
values(seq_smcatgono.nextval, 2, '팀회의', 14);

insert into tbl_calendar_small_category(smcatgono, fk_lgcatgono, smcatgoname, fk_empno)
values(seq_smcatgono.nextval, 2, '인사총무팀회의', 15);

insert into tbl_calendar_small_category(smcatgono, fk_lgcatgono, smcatgoname, fk_empno)
values(seq_smcatgono.nextval, 2, '외부출장', 15);

insert into tbl_calendar_small_category(smcatgono, fk_lgcatgono, smcatgoname, fk_empno)
values(seq_smcatgono.nextval, 2, '외부출장', 14);

insert into tbl_calendar_small_category(smcatgono, fk_lgcatgono, smcatgoname, fk_empno)
values(seq_smcatgono.nextval, 2, '개발팀일정', 2);

insert into tbl_calendar_small_category(smcatgono, fk_lgcatgono, smcatgoname, fk_empno)
values(seq_smcatgono.nextval, 2, '이사실일정', 1);


commit;

select *
from tbl_calendar_small_category
order by smcatgono desc;

select smcatgono, fk_lgcatgono, smcatgoname
from tbl_calendar_small_category
where fk_lgcatgono = 1
order by smcatgono asc;


-- 전사일정 소분류 존재 여부 확인
select smcatgono, fk_lgcatgono, smcatgoname
from tbl_calendar_small_category
where smcatgoname = '교육일정';


-- 팀별일정 소분류 보여주기
select smcatgono, fk_lgcatgono, smcatgoname, fk_empno, department
from
(
    select smcatgono, fk_lgcatgono, smcatgoname, fk_empno, E.department
    from tbl_calendar_small_category C join tbl_employee E
    on C.fk_empno = E.empno
    where fk_lgcatgono = 2
    order by smcatgono asc
)
where department = '인사총무팀';


-- 팀별일정 소분류명 존재 여부 확인
select count(*)
from 
(
    select smcatgono, fk_lgcatgono, smcatgoname, fk_empno, E.department
    from tbl_calendar_small_category C join tbl_employee E
    on C.fk_empno = E.empno
    where fk_lgcatgono = 2 and department = (select department from tbl_employee where empno = 15)
    order by smcatgono asc
)
where fk_lgcatgono = 2 and smcatgoname = '외부출장';


-- 개인일정 소분류 보여주기
select smcatgono, fk_lgcatgono, smcatgoname, fk_empno
from tbl_calendar_small_category
where fk_lgcatgono = 3 and fk_empno = 15
order by smcatgono asc;


-- 일정 등록시 전사일정, 팀별일정, 개인일정 선택에 따른 서브캘린더 종류를 알아오기
select smcatgono, fk_lgcatgono, smcatgoname, fk_empno, department
from 
(
    select smcatgono, fk_lgcatgono, smcatgoname, fk_empno, department
    from tbl_calendar_small_category C join tbl_employee E
    on C.fk_empno = E.empno
    where fk_lgcatgono = 3 and department = (select department from tbl_employee where empno = 15)
    order by smcatgono asc
)

where fk_lgcatgono = 1 and fk_empno= 15;


-- *** 캘린더 일정 *** 
create table tbl_calendar_schedule 
(scheduleno    number                 -- 일정관리 번호
,startdate     date                   -- 시작일자
,enddate       date                   -- 종료일자
,subject       varchar2(400)          -- 제목
,color         varchar2(50)           -- 색상
,place         varchar2(200)          -- 장소
,joinuser      varchar2(4000)         -- 공유자   
,content       varchar2(4000)         -- 내용   
,fk_smcatgono  number(8)              -- 캘린더 소분류 번호
,fk_lgcatgono  number(3)              -- 캘린더 대분류 번호
,fk_empno      number       not null  -- 캘린더 일정 작성자 사원번호
,constraint PK_schedule_scheduleno primary key(scheduleno)
,constraint FK_schedule_fk_smcatgono foreign key(fk_smcatgono) 
            references tbl_calendar_small_category(smcatgono) on delete cascade
,constraint FK_schedule_fk_lgcatgono foreign key(fk_lgcatgono) 
            references tbl_calendar_large_category(lgcatgono) on delete cascade   
,constraint FK_schedule_fk_empno foreign key(fk_empno) references tbl_employee(empno) 
);
-- Table TBL_CALENDAR_SCHEDULE이(가) 생성되었습니다.

create sequence seq_scheduleno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_SCHEDULENO이(가) 생성되었습니다.

select *
from tbl_calendar_schedule 
order by scheduleno desc;


-- 일정 상세 보기
select scheduleno, startdate, enddate, subject, color, place, joinuser, content, fk_smcatgono, fk_lgcatgono, fk_empno, name, smcatgoname, department, position, cpemail
from 
(
select  row_number() over(order by SD.scheduleno desc) as rno 
     , SD.scheduleno
     , to_char(SD.startdate,'yyyy-mm-dd hh24:mi') as startdate
     , to_char(SD.enddate,'yyyy-mm-dd hh24:mi') as enddate  
     , SD.subject
     , SD.color
     , nvl(SD.place,'-') as place
     , nvl(SD.joinuser,'공유자가 없습니다.') as joinuser
     , nvl(SD.content,'') as content
     , SD.fk_smcatgono
     , SD.fk_lgcatgono
     , SD.fk_empno
     , E.name
     , SC.smcatgoname
     , department
     , position
     , cpemail
from tbl_calendar_schedule SD 
JOIN tbl_employee E
ON SD.fk_empno = E.empno
JOIN tbl_calendar_small_category SC
ON SD.fk_smcatgono = SC.smcatgono
) V 
where V.rno between 1 and 10;

select scheduleno
    from tbl_calendar_schedule
    where scheduleno = 36

select scheduleno, 
       startdate, enddate, subject, color, place, joinuser, content, 
       fk_smcatgono, fk_lgcatgono, smcatgoname, 
       fk_empno, name, department, position, cpemail
from 
(
    select  row_number() over(order by SD.scheduleno desc) as rno 
         , SD.scheduleno
         , to_char(SD.startdate,'yyyy-mm-dd hh24:mi') as startdate
         , to_char(SD.enddate,'yyyy-mm-dd hh24:mi') as enddate  
         , SD.subject
         , SD.color
         , nvl(SD.place,'-') as place
         , nvl(SD.joinuser,'공유자가 없습니다.') as joinuser
         , nvl(SD.content,'') as content
         , SD.fk_smcatgono
         , SD.fk_lgcatgono
         , SD.fk_empno
         , E.name
         , SC.smcatgoname
         , department
         , position
         , cpemail
    from tbl_calendar_schedule SD 
    JOIN tbl_employee E
    ON SD.fk_empno = E.empno
    JOIN tbl_calendar_small_category SC
    ON SD.fk_smcatgono = SC.smcatgono
    
   where ( to_char(startdate,'YYYY-MM-DD') between '2022-10-25' and '2022-12-25' )
   and   ( to_char(enddate,'YYYY-MM-DD') between '2022-10-25' and '2022-12-25' ) 

) V 
where V.rno between 1 and 10;


-- 일정 공유자 리스트 찾아오기
select empno, name, cpemail
from tbl_employee
where lower(name) like '%'|| lower('김') ||'%';


-- 등록된 일정 달력에 표시하기
select scheduleno, to_char(startdate,'yyyy-mm-dd hh24:mi'), to_char(enddate,'yyyy-mm-dd hh24:mi'), subject, color, place, joinuser, content, fk_smcatgono, fk_lgcatgono, fk_empno, department
from tbl_calendar_schedule C join tbl_employee E
on C.fk_empno = E.empno
where fk_empno = 15 OR
fk_lgcatgono = 1 OR
(fk_lgcatgono = 2 AND department = (select department from tbl_employee where empno = 15) ) OR
fk_lgcatgono = 3 OR 
lower(joinuser) like '%'|| lower('shonyj@groovy.com') ||'%'
order by scheduleno asc;



DELETE FROM tbl_calendar_schedule
WHERE scheduleno = 3;
commit;

------------- >>>>>>>> 일정관리(풀캘린더) 끝 <<<<<<<< -------------

select *
from tbl_employee
order by empno;


-- 사원 insert 문
INSERT INTO tbl_employee 
(empno,cpemail,name,pwd,position,jubun,postcode,bumun,department,pvemail
,mobile,depttel,joindate,empstauts,bank,account,annualcnt)
VALUES(SEQ_TBL_EMPLOYEE.NEXTVAL, 'shonyj@groovy.com', '손여진', 'qwer1234$',
'부문장', '970226-2222222', '12345', '마케팅영업부문','마케팅팀','jin_92214@naver.com',
'010-1111-2222','301','2022/11/18','1','국민은행','019123456789',15);

UPDATE tbl_employee SET mobile='01012341234' WHERE empno = 14;
UPDATE tbl_employee SET empimg='yjprofile.jpg' WHERE empno = 14;

commit;

INSERT INTO tbl_employee 
(empno,cpemail,name,pwd,position,jubun,postcode,bumun,department,pvemail
,mobile,depttel,joindate,empstauts,bank,account,annualcnt)
VALUES(SEQ_TBL_EMPLOYEE.NEXTVAL, 'schedule@groovy.com', '김일정', 'qwer1234$',
'선임', '981230-1111111', '12345', '경영지원부문','인사총무팀','schedule@naver.com',
'01011112222','106','2022/11/18','1','국민은행','119123456789',15);

INSERT INTO tbl_employee 
(empno,cpemail,name,pwd,position,jubun,postcode,bumun,department,pvemail
,mobile,depttel,joindate,empstauts,bank,account,annualcnt, fk_position_no, fk_department_no, fk_bumun_no)
VALUES(SEQ_TBL_EMPLOYEE.NEXTVAL, 'facility@groovy.com', '이시설', 'qwer1234$',
'선임', '951230-2222222', '12345', '경영지원부문','인사총무팀','facility@naver.com',
'01011112222','111','2022/11/18','1','국민은행','123456789',15, 1,2,2);


-- 참석자 선택하기에서 사원 list 불러오는 쿼리문
select empno, name, bumun, department, position, cpemail
from tbl_employee
where lower(name) like '%'|| lower('김') ||'%';


-- 일정 검색 전체 글 개수 구하기
select count(*) 
from tbl_calendar_schedule C join tbl_employee E
on C.fk_empno = E.empno
where ( to_char(startdate,'YYYY-MM-DD hh24:mi:ss') between '2022-10-28 00:00:00' and '2022-11-28 00:00:00' )
or  ( to_char(enddate,'YYYY-MM-DD hh24:mi:ss')  between '2022-10-28 00:00:00' and '2022-11-28 00:00:00' );

-- 일정분류가 없고 검색어도 없는 경우
select count(*) 
from tbl_calendar_schedule C join tbl_employee E
on C.fk_empno = E.empno
where ( to_char(startdate,'YYYY-MM-DD') between '2022-10-25' and '2022-12-25' )
and   ( to_char(enddate,'YYYY-MM-DD') between '2022-10-25' and '2022-12-25' ) 
and ((fk_lgcatgono = 1 OR (fk_lgcatgono = 2 AND department = (select department from tbl_employee where empno = 15)) OR fk_empno = 15)
OR ( fk_empno != 15 and lower(joinuser) like '%'||lower('schedule@groovy.com')||'%' )) ;
   
-- 전사일정이고 검색어가 없을 경우
select count(*) 
from tbl_calendar_schedule C join tbl_employee E
on C.fk_empno = E.empno
where ( to_char(startdate,'YYYY-MM-DD') between '2022-10-25' and '2022-12-25' )
and   ( to_char(enddate,'YYYY-MM-DD') between '2022-10-25' and '2022-12-25' ) 
and ( fk_lgcatgono = 1 );       
      
-- 팀별일정이고 검색어가 없을 경우    
select count(*) 
from tbl_calendar_schedule C join tbl_employee E
on C.fk_empno = E.empno
where ( to_char(startdate,'YYYY-MM-DD') between '2022-10-25' and '2022-12-25' )
and   ( to_char(enddate,'YYYY-MM-DD') between '2022-10-25' and '2022-12-25' ) 
and ( fk_lgcatgono = 2 AND department = (select department from tbl_employee where empno = 15));                                  

-- 전사일정이고 검색어가 없을 경우
select count(*) 
from tbl_calendar_schedule
where ( to_char(startdate,'YYYY-MM-DD') between '2022-10-25' and '2022-11-25' )
or   ( to_char(enddate,'YYYY-MM-DD') between '2022-10-25' and '2022-11-25' ) 
-- 내캘린더이고 검색대상이 없을 경우 -->
and ( fk_lgcatgono = 1 AND fk_empno = 15 )                                   

-- 참석자로 검색할 경우
select count(*) 
from tbl_calendar_schedule
where ( to_char(startdate,'YYYY-MM-DD') between '2022-10-25' and '2022-12-25' )
and   ( to_char(enddate,'YYYY-MM-DD') between '2022-10-25' and '2022-12-25' ) 
    and fk_lgcatgono != 1                        
    and fk_empno = 15                            -- 로그인한 사용자가 작성한 것을 다른 사용자에게 공유 한것
    and lower(joinuser) like '%'||lower('shonyj')||'%' -- 검색대상 및 검색어 -->


-- 참석자 외로 검색한 경우
select count(*) 
from tbl_calendar_schedule
where ( to_char(startdate,'YYYY-MM-DD') between '2022-10-25' and '2022-12-25' )
and   ( to_char(enddate,'YYYY-MM-DD') between '2022-10-25' and '2022-12-25' ) 

    and lower(subject) like '%'||lower('일정')||'%' <!-- 검색대상 및 검색어 -->
    <choose>
        <when test='fk_lgcatgono == "1" '>                       <!-- 내캘린더내에서만 검색할 경우  -->
            and fk_lgcatgono = 1 
            and fk_userid = #{fk_userid}                         <!-- 로그인한 사용자가 작성한 것 -->
        </when>
        
        <when test='fk_lgcatgono == "2" '>                       <!-- 사내캘린더내에서만 검색할 경우  -->
            and fk_lgcatgono = 2 
        </when>
    </choose>			



select scheduleno, 
			   startdate, enddate, subject, color, place, joinuser, content, 
			   fk_smcatgono, fk_lgcatgono, smcatgoname, 
			   fk_empno, name, department, position, cpemail
		from 
		(
			select  row_number() over(order by SD.scheduleno desc) as rno 
			     , SD.scheduleno
			     , to_char(SD.startdate,'yyyy-mm-dd hh24:mi') as startdate
			     , to_char(SD.enddate,'yyyy-mm-dd hh24:mi') as enddate  
			     , SD.subject
			     , SD.color
			     , nvl(SD.place,'-') as place
			     , nvl(SD.joinuser,'공유자가 없습니다.') as joinuser
			     , nvl(SD.content,'') as content
			     , SD.fk_smcatgono
			     , SD.fk_lgcatgono
			     , SD.fk_empno
			     , E.name
			     , SC.smcatgoname
			     , department
			     , position
			     , cpemail
			from tbl_calendar_schedule SD 
			JOIN tbl_employee E
			ON SD.fk_empno = E.empno
			JOIN tbl_calendar_small_category SC
			ON SD.fk_smcatgono = SC.smcatgono

    )




select scheduleno, 
           startdate, enddate, subject, color, place, joinuser, content, 
           fk_smcatgono, fk_lgcatgono, smcatgoname, 
           fk_empno, name, department, position, cpemail
    from 
    (
        select  row_number() over(order by SD.scheduleno desc) as rno 
             , SD.scheduleno
             , to_char(SD.startdate,'yyyy-mm-dd hh24:mi') as startdate
             , to_char(SD.enddate,'yyyy-mm-dd hh24:mi') as enddate  
             , SD.subject
             , SD.color
             , nvl(SD.place,'-') as place
             , nvl(SD.joinuser,'공유자가 없습니다.') as joinuser
             , nvl(SD.content,'') as content
             , SD.fk_smcatgono
             , SD.fk_lgcatgono
             , SD.fk_empno
             , E.name
             , SC.smcatgoname
             , department
             , position
             , cpemail
        from tbl_calendar_schedule SD 
        JOIN tbl_employee E
        ON SD.fk_empno = E.empno
        JOIN tbl_calendar_small_category SC
        ON SD.fk_smcatgono = SC.smcatgono

where (( to_char(startdate,'YYYY-MM-DD') between '2022-10-25' and '2022-12-25' )
or  ( to_char(enddate,'YYYY-MM-DD') between '2022-10-25' and '2022-12-25' ) )
)
    and ((lower(SD.subject) like '%'||lower('스왈')||'%') or (lower(SD.content) like '%'||lower('스왈')||'%') or (lower(SD.joinuser) like '%'||lower('스왈')||'%'))
    and SD.fk_lgcatgono = 2 AND E.department = (select department from tbl_employee where empno = 15)
)


DELETE FROM tbl_calendar_schedule
WHERE scheduleno = 23;
commit;


select scheduleno, startdate, enddate, subject, color, place, joinuser, content, fk_smcatgono, fk_lgcatgono, fk_empno, department
		from tbl_calendar_schedule C join tbl_employee E
		on C.fk_empno = E.empno
		where C.fk_empno = 14 OR
		fk_lgcatgono = 1 OR
		(fk_lgcatgono = 2 AND department = (select department from tbl_employee where empno = 14) ) OR
		(fk_lgcatgono = 3 and lower(joinuser) like '%'|| lower('sche') ||'%') OR
        (fk_lgcatgono = 3 and C.fk_empno = 14 )
		order by scheduleno asc
        
        
select count(*)
from tbl_calendar_small_category 
where fk_empno = 15 and fk_lgcatgono = 3
        
        
select count(*)
from tbl_calendar_schedule SD 
JOIN tbl_employee E
ON SD.fk_empno = E.empno
JOIN tbl_calendar_small_category SC
ON SD.fk_smcatgono = SC.smcatgono
where SD.fk_lgcatgono = 2 AND E.department = (select department from tbl_employee where empno = 3)
        
         select fk_empno, department
        from tbl_calendar_small_category SC
        JOIN tbl_employee E
        ON SC.fk_empno = E.empno
        
select count(*)
from tbl_calendar_small_category SC
JOIN tbl_employee E
ON SC.fk_empno = E.empno
where SC.fk_lgcatgono = 2 AND E.department = (select department from tbl_employee where empno = 15)       
        
select count(*)
from tbl_calendar_small_category         
where fk_lgcatgono = 1    

commit;





----------------------------------------------------------------------------------------------------------------------
-- 자원예약 --
-- *** 자원예약 대분류(회의실, 기기, 차량  분류) ***
create table tbl_reservation_large_category 
(lgcatgono   number(3) not null      -- 자원 대분류 번호 // 1: 회의실, 2:기기, 3:차량
,lgcatgoname varchar2(50) not null   -- 자원 대분류 명 
,lgcategcontent nvarchar2(500)       -- 자원 대분류 설명
,constraint PK_tbl_reservation_large_category primary key(lgcatgono)
);

insert into tbl_reservation_large_category(lgcatgono, lgcatgoname)
values(1, '회의실');
insert into tbl_reservation_large_category(lgcatgono, lgcatgoname)
values(2, '기기');
insert into tbl_reservation_large_category(lgcatgono, lgcatgoname)
values(3, '차량');

commit;


-- *** 자원 항목 *** 
create table tbl_reservation_small_category 
(smcatgono    number(8) not null      -- 자원 항목 번호
,fk_lgcatgono number(3) not null      -- 자원 대분류 번호
,smcatgoname  varchar2(400) not null  -- 자원 항목명
,smcatgocontent nvarchar2(500)       -- 자원 항목 설명
,fk_empno     number  not null        -- 자원 항목 작성자 유저아이디
,constraint PK_tbl_reservation_small_category primary key(smcatgono)
,constraint FK_tbl_reservation_small_category_fk_lgcatgono foreign key(fk_lgcatgono) 
            references tbl_reservation_large_category(lgcatgono) on delete cascade
,constraint FK_tbl_reservation_small_category_fk_empno foreign key(fk_empno) references tbl_employee(empno)            
);
-- Table tbl_reservation_small_category(가) 생성되었습니다.


select *
from tbl_reservation_small_category

create sequence seq_reserv_smcatgono
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence seq_reserv_smcatgono(가) 생성되었습니다.

insert into tbl_reservation_small_category(smcatgono, fk_lgcatgono, smcatgoname, fk_empno)
values(seq_reserv_smcatgono.nextval, 1, '3층 대회의실', 27);
insert into tbl_reservation_small_category(smcatgono, fk_lgcatgono, smcatgoname, fk_empno)
values(seq_reserv_smcatgono.nextval, 1, '5층 소회의실1', 27);
insert into tbl_reservation_small_category(smcatgono, fk_lgcatgono, smcatgoname, fk_empno)
values(seq_reserv_smcatgono.nextval, 1, '5층 소회의실2', 27);
insert into tbl_reservation_small_category(smcatgono, fk_lgcatgono, smcatgoname, fk_empno)
values(seq_reserv_smcatgono.nextval, 1, '6층 소회의실3', 27);
commit;


-- *** 자원예약 *** 
create table tbl_reservation
(reservationno    number                 -- 자원예약 번호
,startdate     date                   -- 시작일자
,enddate       date                   -- 종료일자
,realuser      varchar2(4000)         -- 실사용자(시간여유되면)
,fk_smcatgono  number(8)              -- 예약 항목 번호
,fk_lgcatgono  number(3)              -- 예약 대분류 번호
,fk_empno      number       not null  -- 예약자 사원번호
,reservdate    date         default sysdate -- 예약일자
,confirm       number                -- 승인여부(0 미승인, 1 승인)
,status        number                 -- 취소 및 반납 여부(예약상태 0, 취소 1, 반납 2)
,constraint PK_tbl_reservation_reservationno primary key(reservationno)
,constraint FK_tbl_reservation_fk_smcatgono foreign key(fk_smcatgono) 
            references tbl_reservation_small_category(smcatgono) on delete cascade
,constraint FK_tbl_reservation_fk_lgcatgono foreign key(fk_lgcatgono) 
            references tbl_reservation_large_category(lgcatgono) on delete cascade   
,constraint FK_tbl_reservation_fk_empno foreign key(fk_empno) references tbl_employee(empno) 
,constraint CK_tbl_reservation_confirm check(confirm in(0,1))
,constraint CK_tbl_reservation_status check(status in(0,1,2))
);
-- Table TBL_CALENDAR_SCHEDULE이(가) 생성되었습니다.
alter table tbl_reservation add return_time date; 
commit;

create sequence seq_reservationno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_SCHEDULENO이(가) 생성되었습니다.

commit;


select *
from tbl_reservation


select smcatgono, fk_lgcatgono, smcatgoname
from tbl_reservation_small_category
where fk_lgcatgono = 1;

insert into tbl_reservation(reservationno, startdate, enddate, realuser, fk_smcatgono, fk_lgcatgono, fk_empno, reservdate, confirm,  status)
values(seq_reservationno.nextval, 20221207230000, 20221208000000, #{realuser}, #{fk_smcatgono}, #{fk_lgcatgono}, #{empno}, sysdate, 0, 0)

insert into tbl_reservation(reservationno, startdate, enddate, realuser, fk_smcatgono, fk_lgcatgono, fk_empno, reservdate, confirm,  status, return_time)
values(seq_reservationno.nextval,  to_date(20221207230000, 'yyyymmddhh24miss'),  to_date(20221208000000, 'yyyymmddhh24miss'), null, 1, 1, 27, sysdate, 0, 0, null)
		
commit;


select reservationno, to_char(startdate, 'yyyymmddhh24') as startdate, to_char(enddate, 'yyyymmddhh24') as enddate, fk_smcatgono, fk_lgcatgono, confirm,  status
from tbl_reservation
where (( to_char(startdate,'yyyymmddhh24') between '2022120800' and '2022120823' )
or  ( to_char(enddate,'yyyymmddhh24') between '2022120800' and '2022120823' ) )
and fk_lgcatgono = 1


select count(*)
from tbl_reservation
where (( to_char(startdate,'yyyymmddhh24') between '2022120800' and '2022120822' )
or  ( to_char(enddate,'yyyymmddhh24') between '2022120800' and '2022120822' ) )
and fk_lgcatgono = 1





        
