
-- 사원테이블
create table tbl_employee
(empno              varchar2(15)   not null   -- 사원번호
,cpemail            varchar2(200)  not null  -- 회사이메일 (AES-256 암호화/복호화 대상)
,name               varchar2(30)   not null  -- 회원명
,pwd                varchar2(200)  not null  -- 비밀번호 (SHA-256 암호화 대상)
,position           Nvarchar2(20)            -- 직급
,jubun              varchar2(15)   not null  -- 주민번호
,postcode           varchar2(5)              -- 우편번호
,address            varchar2(200)            -- 주소
,detailaddress      varchar2(200)            -- 상세주소
,extraaddress       varchar2(200)            -- 참고항목
,empimg             varchar2(200)            -- 사원이미지파일
,birthday           varchar2(10)             -- 생년월일   
,bumun              varchar2(100)    not null  -- 부문 
,department         varchar2(100)    not null  -- 부서(팀)
,pvemail            varchar2(200)  not null  -- 개인이메일 (AES-256 암호화/복호화 대상)
,mobile             varchar2(200)  not null  -- 연락처 (AES-256 암호화/복호화 대상)
,depttel            varchar2(30)   not null  -- 내선번호
,joindate           date   default sysdate   -- 입사일자
,empstauts          varchar2(1)    not null  -- 재직구분 (3개월이후 정직원 1정규직, 2비정규직)
,bank               Nvarchar2(20)  not null  -- 은행
,account            number(20)     not null  -- 계좌번호
,annualcnt          varchar2(5) default 15 not null;  -- 연차갯수
,salary             NUMBER(30)    not null;   -- 연봉
,constraint PK_tbl_employee_empno primary key(empno)
,constraint CK_tbl_employee_empstauts check( empstauts in('1','2') )
,constraint UK_tbl_employee_cpemail unique(cpemail)
,constraint UK_tbl_employee_pvemail unique(pvemail)
);
-- Table TBL_EMPLOYEE이(가) 생성되었습니다.

-- 사원테이블 시퀀스
create sequence seq_tbl_employee
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_TBL_EMPLOYEE이(가) 생성되었습니다.

-- 급여테이블
create table tbl_pay
(payno              number        not null       -- 급여번호
,fk_empno           number        not null       -- 사원번호
,pay                number(30)   default 10000   -- 기본급
,annualpay          number(30)                  -- 연차수당
,overtimepay        number(30)                  -- 초과근무수당
,incomtax		    number        default 0.07   -- 소득세
,pension		    number        default 0.05 	-- 국민연금
,insurance	        number        default 0.008 	-- 건강보험
,paymentdate        date  default sysdate       -- 지급일자(특정일자)
,constraint PK_tbl_pay_payno primary key(payno)
,constraint FK_tbl_pay_fk_empno foreign key(fk_empno) references tbl_employee(empno)
);
-- Table TBL_PAY이(가) 생성되었습니다.

-- 지급항목
초과근무수당 :  pay * 1.5*근무시간
연차수당 : 연차수당 일급(시간*8)*연차휴가 미사용갯수

-- 공제항목
소득세 : 0.07
국민연금 : 0.05
고용보험 : 0.008


-- 급여테이블 시퀀스
create sequence seq_tbl_pay
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_TBL_PAY이(가) 생성되었습니다.

-- 경조비테이블
create table tbl_celebrate
(clbno               number(30)                 not null   -- 경조비신청번호
,fk_empno            number (30)                 not null   -- 사원번호
,clbdate             date default sysdate    not null   -- 신청일자
,clbpay              number(30)              not null   -- 신청금액  (1- 50, 2-20, 3-30 )
,clbtype             Nvarchar2(20)           not null  -- 경조구분 (1명절상여금, 2생일상여금, 3휴가상여금)
,clbstatus           varchar2(1)    default 0    not null  -- 승인여부  (0 미승인, 1 승인)
,constraint PK_tbl_celebrate_clbno primary key(clbno)
,constraint FK_tbl_celebrate_fk_empno foreign key(fk_empno) references tbl_employee(empno)
,constraint CK_tbl_celebrate_clbtype check( clbtype in('1','2','3') )
,constraint CK_tbl_celebrate_clbstatus check( clbstatus in('0','1') )
);
-- Table TBL_CELEBRATE이(가) 생성되었습니다.

drop table tbl_celebrate
commit

insert into tbl_celebrate (clbno, fk_empno, clbdate, clbpay, clbtype, clbstatus)
values(seq_tbl_celebrate.nextval, 13, sysdate, 1, 1, default)

select *
from tbl_celebrate

rollback

-- 경조비테이블시퀀스
create sequence seq_tbl_celebrate
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_TBL_CELEBRATE이(가) 생성되었습니다.

--증명서테이블
create table tbl_certificate
(proofno              number             not null   -- 증명서번호
,fk_empno             number             not null   -- 사원번호
,issuedate            date default sysdate          -- 발급일자(sysdate)
,issueuse             varchar2(1)                   -- 발급용도
,constraint PK_tbl_certificate_proofno primary key(proofno)
,constraint FK_tbl_certificate_fk_empno foreign key(fk_empno) references tbl_employee(empno)
,constraint CK_tbl_certificate_issueuse check( issueuse in('1','2') )  -- 1 은행제출용, 2 공공기관용
);
-- Table TBL_CERTIFICATE이(가) 생성되었습니다.


-- 증명서테이블시퀀스
create sequence seq_tbl_certificate
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_TBL_CERTIFICATE이(가) 생성되었습니다.


-- 근태 테이블
tbl_attendance
( fk_empno       number  not null                -- 사원번호
, workdate        date default sysdate not null  -- 날짜(매일 1am 마다 insert 됨)
, workstart      date                            -- 출근시간
, workend        date                            -- 퇴근시간
, trip           Nvarchar2(1) default 'N'        -- 출장여부
, tripstart      date                            -- 출장시작 (ex. 2022-10-10 11:00)
, tripend        date                            -- 출장종료 (ex. 2022-10-10 11:00)
, dayoff         Nvarchar2(1) default 'N'        -- 연차여부
, extendstart    date                            -- 연장근무시작시간 
, constraint FK_tbl_attendance_fk_empno Foreign key(fk_empno) references tbl_employee(empno)
, constraint PK_tbl_attendance_fk_empno_workdate primary key(fk_empno, workdate)
);

select *
from tbl_attendance



-- 이미지 칼럼 추가
alter table tbl_employee
   add joindate  VARCHAR2(15)    not null; 
   
-- 연봉컬럼추가
alter table tbl_employee
   add salary  NUMBER(30)    not null; 
   
update tbl_employee set salary = 50000000

commit
   
   update tbl_employee set joindate = '2022-12-02'
insert into tbl_employee (joindate) values ('2022-12-02')
   
-- 컬럼삭제
alter table tbl_employee drop column pay

ALTER TABLE tbl_employee
ADD [CONSTRAINT UK_tbl_employee_pay]
unique(pay);

-- 제약추가하기
ALTER TABLE tbl_employee add constraint  UK_tbl_employee_pay  unique(pay);
alter table tbl_employee constraint UK_tbl_employee_pay unique(pay) ;

select joindate
from tbl_employee

commit

desc TBL_EMPLOYEE

-- 성별칼럼추가
alter table tbl_employee add gender varchar2(2);

-- 연차칼럼추가
alter table tbl_employee add ANNUALCNT varchar2(5) default 15 not null;

-- 급여 디폴트값걸기
alter table tbl_pay add pay  number(30)  default 10000 not null;


-- 칼럼 변경
alter table tbl_pay modify pay NUMBER(30) default 10000   not null;



alter table tbl_employee modify salary NUMBER(30)    not null;
-- pvemail 칼럼변경
alter table tbl_employee modify pvemail varchar2(200) null;

select joindate
from tbl_employee

rollback
alter table tbl_employee MODIFY annualcnt varchar2(5);

update tbl_employee set pay = '1'
where account 

update tbl_employee set pay = 'n'
where annualcnt is null 

select *
from tbl_employee
where department = '인사총무팀'
order by empno 

update tbl_employee set depttel = '102'
where name ='김민수' 

commit

rollback

delete from tbl_employee
where empno = 7

INSERT INTO tbl_employee 
(empno,cpemail,name,pwd,position,jubun,postcode,bumun,department,pvemail
,mobile,depttel,joindate,empstauts,bank,account,annualcnt)
VALUES(SEQ_TBL_EMPLOYEE.NEXTVAL, 'minsu@groovy.com', '김민수', 'qwer1234$',
'책임자', '981210-2222222', '12345', 'IT사업부문','개발팀','alstn8109@naver.com',
'010-1111-2222','201','2022/11/18','1','국민은행','21520204188',15);

INSERT INTO tbl_employee 
(empno,cpemail,name,pwd,position,jubun,postcode,bumun,department,pvemail
,mobile,depttel,joindate,empstauts,bank,account,annualcnt)
VALUES(SEQ_TBL_EMPLOYEE.NEXTVAL, 'mangdb@groovy.com', '맹단비', 'qwer1234$',
'선임', '990102-2222222', '12345', '경영지원본부','인사총무팀','mangdb@naver.com',
'010-1111-2222','106','2022/11/18','1','국민은행','123456789',15);

commit

-- 로그인 조회
select empno, cpemail, name, pwd, position, jubun, postcode, address, detailaddress
     , extraaddress,empimg,birthday, bumun,department,pvemail,mobile,depttel,joindate
     ,empstauts,bank, account,annualcnt, empimg
from tbl_employee
where cpemail = minsu@groovy.com and  pwd = 'qwer1234$'


select *
from tbl_employee

-- 사원테이블에 정보넣기
INSERT INTO tbl_employee 
(empno,cpemail,name,position,jubun,postcode,ADDRESS,DETAILADDRESS, EXTRAADDRESS
,EMPIMG,birthday, bumun,department,pvemail
,mobile,depttel,joindate,empstauts,bank,account,annualcnt,gender)
VALUES


select *
from tbl_certificate


-- 증명서테이블에 insert
insert into tbl_certificate 
values(seq_tbl_certificate.nextval, 13, sysdate, '1')

-- 증명서 테이블신청내역 조회
select proofno,fk_empno, issuedate, issueuse
from tbl_certificate
where fk_empno = '13' 
commit

select proofno,fk_empno, to_char(issuedate, 'yyyy-mm-dd') issuedate , issueuse
from tbl_certificate

select cpemail
from tbl_employee

select position, bumun,department,
		    fk_position_no, fk_bumun_no, fk_department_no
		from tbl_employee




insert into tbl_employee (empimg)
values ('dog.png')
where 




select *
from tbl_employee
where empno = 13

-- 칼럼 값변경
ALTER TABLE tbl_employee MODIFY pwd varchar2(200) DEFAULT 1111;
ALTER TABLE tbl_employee MODIFY joindate varchar2(10) DEFAULT SYSDATE;

-- 경조비 목록 조회
select clbno, fk_empno, to_char(clbdate, 'yyyy-mm-dd') AS clbdate, clbpay, clbtype, clbstatus
from tbl_celebrate
where fk_empno = 13


drop table tbl_celebrate
drop sequence tbl_celebrate

ALTER TABLE tbl_employee MODIFY EMPSTAUTS varchar2(1)  DEFAULT 1;

update tbl_employee set postcode = '48060' , address = '부산 해운대구 APEC로 17' , DETAILADDRESS='108동', EXTRAADDRESS='우동', EMPIMG= 'null', PVEMAIL='alstn8109@naver.com'
where empno = 13

rollback

commit


select count(*)
		from tbl_employee
		where pvemail = 'alstn8109@naver.com'
        
        


select payno, fk_empno,pay,annualpay,overtimepay,paymentdate
from tbl_pay

insert tbl_pay into payno='seq_tbl_pay.nextval', fk_empno='13', pay= 3000000, annualpay=100000, overtimepay=100000, paymentdate = sysdate
where empno = 13

insert into tbl_pay  
values(seq_tbl_pay.nextval, 13, 3000000, 100000, 100000,sysdate)

select payno, fk_empno, pay, annualpay, overtimepay, paymentdate
from tbl_pay 


-- 급여 테이블 목록 조회
select name, payno, fk_empno, pay, annualpay, overtimepay, paymentdate
from tbl_pay P join tbl_employee e
on p.fk_empno = e.empno


select name, clbno, fk_empno, to_char(clbdate, 'yyyy-mm-dd') AS clbdate, clbpay, clbtype, clbstatus
from tbl_celebrate C join tbl_employee E
on C.fk_empno = E.empno
order by clbno desc


select 
from tbl_celebrate

select name, clbno, fk_empno, to_char(clbdate, 'yyyy-mm-dd') AS clbdate, clbpay, clbtype, clbstatus
from tbl_celebrate C join tbl_employee E
on C.fk_empno = E.empno
where clbstatus = '0'
order by clbno desc

update tbl_celebrate set clbstatus = '1'
where fk_empno = 13

select *
from tbl_celebrate

insert into tbl_celebrate values(seq_tbl_celebrate.nextval, 14,sysdate, 200000, 3,0)
commit


-- 재직증명서 모두 조회
select name, proofno, fk_empno, to_char(issuedate, 'yyyy-mm-dd') AS issuedate, issueuse
		from tbl_certificate C join tbl_employee E
		on C.fk_empno = E.empno
		order by proofno desc
        
        
        
      create table tbl_certificate
(proofno              number             not null   -- 증명서번호
,fk_empno             number             not null   -- 사원번호
,issuedate            date default sysdate          -- 발급일자(sysdate)
,issueuse   

insert into tbl_employee 
select *
from tbl_pay P right join tbl_employee e
on p.fk_empno = e.empno


select *
from tbl_employee
where name = '아이유'

update tbl_employee
set mobile = '010-1234-5678';
commit;

update tbl_employee set pwd = 'qwer1234$'
where name = '아이유'

commit

insert into TBL_PAY(PAYNO, FK_EMPNO, PAY, ANNUALPAY, OVERTIMEPAY, PAYMENTDATE)
values(seq_tbl_pay.nextval, 13,3000000, 100000, 200000,sysdate)

SELECT PAYNO, FK_EMPNO, PAY, ANNUALPAY, OVERTIMEPAY, PAYMENTDATE
FROM TBL_PAY


-- 급여정보 조회
select E.empno, name, bumun, department, position, ceil(salary/12) as salary,
        PAYNO, FK_EMPNO, PAY, ANNUALPAY, OVERTIMEPAY, to_char(paymentdate, 'yyyy-mm-dd') AS paymentdate
from tbl_employee E right join TBL_PAY P
on E.empno = P.fk_empno
where name = '김민수'



(payno               number        not null       -- 급여번호
,fk_empno            number        not null       -- 사원번호
,pay                 number(30)   default 10000   -- 기본급
,annualpay           number(30)                  -- 연차수당
,overtimepay         number(30)                  -- 초과근무수당
,paymentdate   

select payno, fk_empno,money,annualpay, overtimepay, paymentdate, money*3.3 as tax
from V
(select payno, fk_empno, ceil(salary/12) as money, annualpay, overtimepay, paymentdate
from tbl_pay P join tbl_employee E
on P.fk_empno = E.empno)

-- 급여테이블에 넣는 방법
select payno, fk_empno, money, annualpay, overtimepay, paymentdate, round(money*0.07) as incomtax, round(money*0.55) as pension, round(money*0.07) as insurance
from 
(
    select empno, ceil(salary/12) as money
    from tbl_employee
)A
join
(
    select payno,annualpay, overtimepay, paymentdate ,fk_empno
    from tbl_pay
)B
on  A.empno = B.fk_empno


-- 지급항목
초과근무수당 :  pay * 1.5*근무시간
연차수당 : 연차수당 일급(시간*8)*연차휴가 미사용갯수

-- 공제항목
소득세 : 0.07
국민연금 : 0.55
건강보험 : 0.07

insert into tbl_pay set 

insert into tbl_pay (salary,payno, fk_empno,annualpay, overtimepay, paymentdate)
select salary
from tbl_employee





insert into TBL_PAY (payno,fk_empno,pay,overtimepay,incomtax,pension,insurance,paymentdate)
values(seq_tbl_pay.nextval,13,default, 100000,default, default, default,sysdate)
where fk_empno = 13
commit
select *
from TBL_PAY

-- 급여테이블 조회
select PAYNO, FK_EMPNO, NAME, BUMUN, DEPARTMENT, POSITION, SALARY,PAY ,ANNUALPAY,OVERTIMEPAY,PAYMENTDATE,OVERPAY,
        INCOMTAX,PENSION,INSURANCE, ALLPAY, tax,
        (ALLPAY - tax) AS monthpay
from 
    (
        select PAYNO, FK_EMPNO, NAME, BUMUN, DEPARTMENT, POSITION, SALARY,PAY ,ANNUALPAY,OVERTIMEPAY,PAYMENTDATE,OVERPAY,
                    INCOMTAX,PENSION,INSURANCE, 
                    (SALARY+ANNUALPAY+OVERTIMEPAY) AS ALLPAY,
                    (INCOMTAX+PENSION+INSURANCE) AS tax
                    
        from 
        (
            SELECT PAYNO, FK_EMPNO, NAME, BUMUN, DEPARTMENT, POSITION, SALARY,PAY ,ANNUALPAY,OVERTIMEPAY,PAYMENTDATE, (ANNUALPAY+OVERTIMEPAY) AS OVERPAY,
                    CEIL(SALARY*INCOMTAX) AS INCOMTAX, CEIL(SALARY*PENSION)AS PENSION, CEIL(SALARY*INSURANCE)AS INSURANCE
            FROM
                (SELECT E.EMPNO, NAME, BUMUN, DEPARTMENT, POSITION, ROUND(SALARY/12)AS SALARY,
                        PAYNO, FK_EMPNO, PAY, NVL(ANNUALPAY,0) AS ANNUALPAY, NVL(OVERTIMEPAY,0)  AS OVERTIMEPAY, TO_CHAR(PAYMENTDATE, 'YYYY-MM-DD') AS PAYMENTDATE
                        ,INCOMTAX,PENSION,INSURANCE
                FROM TBL_EMPLOYEE E RIGHT JOIN TBL_PAY P
                ON E.EMPNO = P.FK_EMPNO
            )V
        )A
    )P

-- ====================================================================================================================================== --

-- 설문조사테이블
create table  tbl_survey 
(surno		    number(20)        		not null   -- 설문번호
,fk_empno	    number   		        not null   -- 사원번호
,surtitle  	   	Nvarchar2(30)  		    not null   -- 설문제목
,surexplain    	Nvarchar2(30)         		       -- 설문설명
,surcreatedate 	date  default sysdate   not null   -- 설문생성일
,surstart 	    date  			        not null   -- 설문시작일
,surend	   	    date  			        not null   -- 설문종료일
,surstatus    	number(1)   default 1  	not null   -- 상태(0 임시저장, 1 저장)
,suropenstatus  number(1)   default 1   not null   -- 설문결과공개여부(0비공개, 1공개)
,constraint PK_tbl_survey_surno primary key(surno)
,constraint FK_tbl_survey_fk_empno foreign key(fk_empno) references tbl_employee(empno)
,constraint CK_tbl_survey_surstatus check( surstatus in('0','1') )
,constraint CK_tbl_survey_suropenstatus check(suropenstatus in('0','1') )
);

-- 설문조사테이블 시퀀스
create sequence seq_tbl_survey
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 설문조사대상테이블
create table  tbl_target
(surtarget     	number(1)    not null   -- 설문대상(1전직원, 0직접선택)
,fk_surno		number(20)        	     not null   -- 설문번호
,constraint PK_tbl_target_surtarget primary key(surtarget)
,constraint CK_tbl_target_surtarget check(surtarget in('0','1') )
,constraint FK_tbl_target_fk_surno foreign key(fk_surno) references tbl_survey(surno)ON DELETE CASCADE
);

drop table tbl_target

-- 설문조사대상테이블 시퀀스
create sequence seq_tbl_target
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 설문조사문항테이블
create table  tbl_ask
(questno 	    number(20)      not null       -- 문항번호
,fk_surno		number(20)      not null       -- 설문번호
,question		varchar2(300)   not null       -- 설문질문
,option1		number(1)                      -- 선택지1
,option2		number(1)        	           -- 선택지2
,option3		number(1)        	           -- 선택지3
,option4		number(1)        	           -- 선택지4
,option5		number(1)        	           -- 선택지5
,constraint PK_tbl_ask_questno   primary key(questno)
,constraint FK_tbl_ask_fk_surno foreign key(fk_surno) references tbl_survey(surno)ON DELETE CASCADE
);


-- 설문조사문항테이블 시퀀스
create sequence seq_tbl_ask
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

drop table tbl_joinsurvey

-- 설문참여테이블
create table  tbl_joinsurvey 
(joinsurno 	number(20)        not null       -- 설문참여번호
,fk_empno	number            not null   	 -- 사원번호
,fk_surno   number(20)        not null       -- 설문번호
,fk_questno	number(20)        not null       -- 문항번호
,answer		number(20)        not null       -- 답변
,sursubdate date  default sysdate  not null  -- 답변제출일
,constraint PK_tbl_joinsurvey_joinsurno  primary key(joinsurno)
,constraint FK_tbl_joinsurvey_fk_empno foreign key(fk_empno) references tbl_employee(empno)ON DELETE CASCADE
,constraint FK_tbl_joinsurvey_fk_surno foreign key(fk_surno) references tbl_survey(surno)ON DELETE CASCADE
,constraint FK_tbl_joinsurvey_fk_questno foreign key(fk_empno) references tbl_ask(questno)ON DELETE CASCADE
);

-- 설문참여테이블 시퀀스
create sequence seq_tbl_joinsurvey
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit


-- 시퀀스조회
SELECT seq_tbl_survey.CURRVAL FROM DUAL;

SELECT seq_tbl_survey.NEXTVAL FROM DUAL;
SELECT seq_tbl_survey.CURRVAL FROM DUAL
where surno=1;

SELECT surno from tbl_survey where surno = 1

delete from tbl_survey where surno = 3

--- 설문테이블 insert
insert into tbl_survey(surno,fk_empno,surtitle,surexplain,surcreatedate,surstart,surend,surstatus,suropenstatus)
values(seq_tbl_survey.nextval,13,'설문조사','확인해보기',sysdate,'2022-12-10','2022-12-20',default, default)

select *
from tbl_ask

select *
from tbl_survey


insert into tbl_ask(questno,fk_surno,question,option1)
values(seq_tbl_ask.nextval,2,'팀플설문조사 많이 어려운가요?', 1)

create table  c
(questno 	    number(20)        	not null       -- 문항번호
,fk_surno		number(20)        	not null       -- 설문번호
,question		varchar2(300)   	not null       -- 설문질문
,option1		number(1)        	not null       -- 선택지1
,option2		number(1)        	not null       -- 선택지2
,option3		number(1)        	not null       -- 선택지3
,option4		number(1)        	not null       -- 선택지4
,option5


drop table tbl_ask
drop table tbl_joinsurvey
drop table tbl_target




select * from seq_tbl_survey
delete from tbl_survey 
where surno = 2
commit


