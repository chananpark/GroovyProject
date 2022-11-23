
-- 사원테이블
create table tbl_employee
(empno              varchar2(15)   not null   -- 사원번호
,cpemail            varchar2(200)  not null  -- 회사이메일 (AES-256 암호화/복호화 대상)
,name               varchar2(30)   not null  -- 회원명
,pwd                varchar2(200)  not null  -- 비밀번호 (SHA-256 암호화 대상)
,position           Nvarchar2(20)            -- 직급
,jubun              varchar2(15)   not null  -- 주민번호
,postcode           varchar2(5)    not null  -- 우편번호
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
,joindate           varchar2(10)   not null  -- 입사일자
,empstauts          varchar2(1)    not null  -- 재직구분 (3개월이후 정직원)
,bank               Nvarchar2(20)  not null  -- 은행
,account            number(20)     not null  -- 계좌번호
,annualcnt          number(10)     not null  -- 연차갯수
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
(payno               number        not null   -- 급여번호
,fk_empno            number        not null   -- 사원번호
,pay                 number(30)    not null   -- 기본급
,annualpay           number(30)               -- 연차수당
,overtimepay         number(30)               -- 초과근무수당
,paymentdate         date  default sysdate    -- 지급일자(특정일자)
,constraint PK_tbl_pay_payno primary key(payno)
,constraint FK_tbl_pay_fk_empno foreign key(fk_empno) references tbl_employee(empno)
);
-- Table TBL_PAY이(가) 생성되었습니다.

drop table tbl_pay

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
(clbno               number                  not null   -- 경조비신청번호
,fk_empno            number                  not null   -- 사원번호
,clbdate             date default sysdate    not null   -- 신청일자
,clbpay              number(30)              not null   -- 신청금액
,clbtype             Nvarchar2(20)           not null  -- 경조구분
,clbstatus           varchar2(1)             not null  -- 승인여부(1명절상여금, 2생일상여금, 3휴가상여금)
,constraint PK_tbl_celebrate_clbno primary key(clbno)
,constraint FK_tbl_celebrate_fk_empno foreign key(fk_empno) references tbl_employee(empno)
,constraint CK_tbl_celebrate_clbstatus check( clbstatus in('1','2','3') )
);
-- Table TBL_CELEBRATE이(가) 생성되었습니다.

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

-- 이미지 칼럼 추가
alter table tbl_employee
   add signimg varchar2(200); 

desc TBL_EMPLOYEE

-- 성별칼럼추가
alter table tbl_employee add gender varchar2(2);

-- 칼럼 변경
alter table tbl_employee modify empno varchar2(15) null;


alter table tbl_employee MODIFY annualcnt varchar2(5);

update tbl_employee set account = '123456789'
where account 

update tbl_employee set annualcnt = 'n'
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


select empno, cpemail, name, pwd, position, jubun, postcode, address, detailaddress
     , extraaddress,empimg,birthday, bumun,department,pvemail,mobile,depttel,joindate
     ,empstauts,bank, account,annualcnt, empimg
from tbl_employee
where cpemail = minsu@groovy.com and  pwd = 'qwer1234$'

delete from tbl_employee 
where annualcnt = 15

DELETE FROM tbl_employee 
WHERE account = 210123456789


select empno, name, position, department,cpemail,mobile,joindate
from tbl_employee

SELECT * 
		FROM ( SELECT A.*, ROWNUM AS RNO
		    FROM ( SELECT *
		            FROM
		            VIEW_MY_DRAFT_PROCESSED
                
		            ORDER BY sortType
		            )A )
		WHERE RNO BETWEEN #{startRno} AND #{endRno}
		and FK_APPROVAL_EMPNO = #{empno}

select *
from (SELECT ROWNUM AS RNO, v.*
from( 
    select *
    from tbl_employee
    order by bumun
)V)

WHERE RNO BETWEEN 1 AND 10
		and empno =

select *
from tbl_employee

INSERT INTO tbl_employee 
(empno,cpemail,name,position,jubun,postcode,ADDRESS,DETAILADDRESS, EXTRAADDRESS
,EMPIMG,birthday, bumun,department,pvemail
,mobile,depttel,joindate,empstauts,bank,account,annualcnt,gender)
VALUES

insert into tbl_certificate 
values(seq_tbl_certificate.nextval, 13, sysdate, '1');
(select name, empno, bumun,department, position from tbl_employee)

select *
from tbl_certificate

rollback

proofno              number             not null   -- 증명서번호
,fk_empno             number             not null   -- 사원번호
,issuedate            date default sysdate          -- 발급일자(sysdate)
,issueuse            

insert into tbl_certificate 
values(   seq_tbl_certificate.nextval, 13, sysdate, '1',
(select name, empno, bumun,department, position, proofno, issuedate, issueuse
from tbl_employee A, tbl_certificate B
where A.empno = B.fk_empno) )

insert into tbl_certificate 
values(seq_tbl_certificate.nextval, 13, sysdate, '1')

INSERT INTO tbl_certificate C (
	proofno
    , fk_empno
    , issuedate
    , issueuse

)
SELECT
    name, empno, bumun,department, position, proofno, issuedate, issueuse

FROM tbl_employee 

INNER JOIN tbl_employee e  ON 1=1

insert all 
    into tbl_certificate values(seq_tbl_certificate.nextval, 13, sysdate, '1',)
    into tbl_employee  name, empno, bumun,department, position, proofno, issuedate, issueuse
    SELECT name, empno, bumun,department, position, proofno, issuedate, issueuse
    FROM tbl_employee 





