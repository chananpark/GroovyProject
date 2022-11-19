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
values(1, '내캘린더');

insert into tbl_calendar_large_category(lgcatgono, lgcatgoname)
values(2, '사내캘린더');

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


select *
from tbl_calendar_small_category
order by smcatgono desc;


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
select SD.scheduleno
     , to_char(SD.startdate,'yyyy-mm-dd hh24:mi') as startdate
     , to_char(SD.enddate,'yyyy-mm-dd hh24:mi') as enddate  
     , SD.subject
     , SD.color
     , nvl(SD.place,'-') as place
     , nvl(SD.joinuser,'공유자가 없습니다.') as joinuser
     , nvl(SD.content,'') as content
     , SD.fk_smcatgono
     , SD.fk_lgcatgono
     , SD.fk_userid
     , M.name
     , SC.smcatgoname
from tbl_calendar_schedule SD 
JOIN tbl_member M
ON SD.fk_userid = M.userid
JOIN tbl_calendar_small_category SC
ON SD.fk_smcatgono = SC.smcatgono
where SD.scheduleno = 21;

------------- >>>>>>>> 일정관리(풀캘린더) 끝 <<<<<<<< -------------

select *
from tbl_employee;


-- 사원 insert 문
INSERT INTO tbl_employee 
(empno,cpemail,name,pwd,position,jubun,postcode,bumun,department,pvemail
,mobile,depttel,joindate,empstauts,bank,account,annualcnt)
VALUES(SEQ_TBL_EMPLOYEE.NEXTVAL, 'chanan@groovy.com', '박찬안', 'qwer1234$',
'부문장', '960719-2222222', '12345', 'IT사업부문','개발팀','pca_719@naver.com',
'010-1111-2222','201','2022/11/18','1','신한은행','110123456789',15);




