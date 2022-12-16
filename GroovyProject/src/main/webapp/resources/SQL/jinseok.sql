show user;
--




create table TBL_MAIL
(MAIL_NO number not null--메일번호      시퀀스
,FK_Sender_address  VARCHAR2(200 BYTE) not null--발신자메일주소   
,FK_Recipient_address  VARCHAR2(200 BYTE) not null--수신사메일주소
,FK_Referenced_address  VARCHAR2(200 BYTE) --참조메일주소
,SUBJECT CLOB NOT NULL --메일제목
,CONTENTS CLOB NOT NULL --메일내용
,SEND_TIME DATE --발신시간 그냥 보낼땐 sysdate, 예약시 직접 지정한 시간으로 , 임시저장한 메일은 NULL 로 남겨둠
,read_check Number(1) default 0 not null --읽음여부 check 0 안읽음 1 읽음    // 표시용
,sender_delete Number(1) default 0 not null -- 보낸 쪽에서 보낸메일함에서 안보이도록 지울때
,Recipient_delete Number(1) default 0 not null -- 받은 쪽에서 받은메일함에서 안보이게 지울때
,SENDER_IMPORTANT Number(1) default 0 not null --중요표시(보낸이) check 0 안중요 1 중요
,Recipient_IMPORTANT Number(1) default 0 not null --중요표시(받는이) check 0 안중요 1 중요
,fileName       varchar2(255)                    -- WAS(톰캣)에 저장될 파일명(2022103109271535243254235235234.png)                                       
,orgFilename    varchar2(255)                    -- 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명 
,fileSize       number                           -- 파일크기  
,MAIL_PWD       varchar2(20)  --메일암호
-- 기존의 임시저장칼럼은 DATE 가 NULL 인 애들조회로 가능하게
,constraint PK_tbl_mail_MAIL_NO primary key(MAIL_NO)
,constraint FK_TBL_MAIL_FK_Sender_address foreign key(FK_Sender_address) references tbl_EMPLOYEE(CPEMAIL)
,constraint FK_TBL_MAIL_FK_Recipient_address foreign key(FK_Recipient_address) references tbl_EMPLOYEE(CPEMAIL)
,constraint FK_TBL_MAIL_FK_Referenced_address foreign key(FK_Referenced_address) references tbl_EMPLOYEE(CPEMAIL)
,constraint CK_tbl_MAIL_read_check check( read_check in (0,1) )
,constraint CK_tbl_MAIL_sender_delete check( sender_delete in (0,1) )
,constraint CK_tbl_MAIL_Recipient_delete check( Recipient_delete in (0,1) )
);

commit;
rollback;
-- drop table TBL_tag purge; 삭제
select * from tbl_mail;

--태그테이블
--태그지정자id or 이메일
--메일번호
--태그이름(직접설정 가능하게)
--태그색 //#ffffff 이런식

INSERT INTO tbl_employee 
(empno,cpemail,name,pwd,position,jubun,postcode,bumun,department,pvemail
,mobile,depttel,joindate,empstauts,bank,account,annualcnt)
VALUES(SEQ_TBL_EMPLOYEE.NEXTVAL, 'kjskjskjs@groovy.com', '김진진석', 'qwer1234$',
'선임', '960525-2222222', '12345', 'IT사업부문','개발팀','kjskjskjs@naver.com',
'010-1132-2232','208','2022/11/18','1','국민은행','123423456789',15);

commit;

--MAIL_NO,FK_Sender_address,FK_Recipient_address,FK_Referenced_address
--,SUBJECT,CONTENTS,SEND_TIME,read_check,sender_delete,Recipient_delete
--,SENDER_IMPORTANT,Recipient_IMPORTANT,fileName,orgFilename,fileSize,MAIL_PWD

insert into tbl_mail(MAIL_NO, FK_Sender_address,FK_Recipient_address,SUBJECT, CONTENTS,SEND_TIME)
values(112,'kjsaj0525@groovy.com','kjskjskjs@groovy.com','xptmxm','내용10',null);

select * from tbl_mail;

commit;
-- 
select count(*)
	    from tbl_mail
	    where SEND_TIME< sysdate 
        and FK_Recipient_address = 'kjsaj0525@groovy.com'
        
        
        and SUBJECT like '%'||lower('제')||'%';
        
select count(*)
	    from tbl_mail
	    where SEND_TIME is null;
        
update tbl_mail set Recipient_IMPORTANT = 1 
where mail_no in (107);   

commit;

select * from tbl_mail;   
select *
	    from tbl_mail
        where SEND_TIME <= sysdate
        and ((FK_Recipient_address = 'kjsaj0525@groovy.com' and Recipient_IMPORTANT = 1)
    			  or (FK_Sender_address = 'kjsaj0525@groovy.com' and SENDER_IMPORTANT = 1));
        
        
select seq, fk_userid, name, subject, readcount, regdate, commentCount,
		       groupno, fk_seq, depthno
		     , fileName
		from 
		(
		    select rownum AS rno,
		           seq, fk_userid, name, subject, readcount, regdate, commentCount,
		           groupno, fk_seq, depthno
		         , fileName
		    from 
		    (
		        select  MAIL_NO,FK_Sender_address,FK_Recipient_address,FK_Referenced_address
                ,SUBJECT,CONTENTS,SEND_TIME,read_check,sender_delete,Recipient_delete
                ,SENDER_IMPORTANT,Recipient_IMPORTANT,fileName,orgFilename,fileSize,MAIL_PWD
                
		        from tbl_board
		        where status = 1
			    <if test='searchType != "" and searchWord != "" '>
			    and lower(${searchType}) like '%'||lower(#{searchWord})||'%'
			    </if>
		        start with fk_seq = 0 
		        connect by prior seq = fk_seq 
		        order by SEND_TIME asc
		    ) V
		) T 
		where rno between #{startRno} and #{endRno}        


select count(*)
	    from tbl_mail
	   where SEND_TIME <= sysdate;	    

-- 갯수 카운트해주는 함수는 아래처럼 작동된다	  
 select *
	    from tbl_mail
	    where SEND_TIME <= sysdate 
	    and  FK_Recipient_address =  'kjsaj0525@groovy.com'
        and lower(FK_Sender_address) like '%'||lower('k')||'%';
        
--        

-- 태그 테이블 생성
create table tbl_tag
(tag_no number not null
,FK_mail_address VARCHAR2(200 BYTE) not null
, tag_color char(6) not null
, tag_name  Nchar(10) not null
, fk_MAIL_NO number
, constraint FK_tbl_tag_tag_no primary key(tag_no)
,constraint FK_tbl_tag_FK_mail_address foreign key(FK_mail_address) references tbl_EMPLOYEE(CPEMAIL)
,constraint FK_tbl_tag_fk_MAIL_NO foreign key(fk_MAIL_NO) references TBL_MAIL(MAIL_NO)
);

create sequence seq_tag_no
start with 1                 
increment by 1              
nomaxvalue                   
nominvalue                   
nocycle                      
nocache;
DROP SEQUENCE seq_tag_no;
commit;
select * from tbl_tag order by fk_MAIL_NO asc, tag_color asc;
select *
		from tbl_tag
        where FK_mail_address = 'kjsaj0525@groovy.com'
        and fk_MAIL_NO = 45;
        order by tag_color asc;
insert into tbl_tag (tag_no,FK_mail_address,tag_color,tag_name ,fk_MAIL_NO )
values(seq_tag_no.nextval,'kjsaj0525@groovy.com','f9320c','빨강',45);
select * from tbl_tag;

insert into tbl_tag (tag_no,FK_mail_address,tag_color,tag_name ,fk_MAIL_NO)
values(seq_tag_no.nextval,'kjsaj0525@groovy.com','00b9f1','파랑',45);

insert into tbl_tag (tag_no,FK_mail_address,tag_color,tag_name ,fk_MAIL_NO )
values(seq_tag_no.nextval,'kjsaj0525@groovy.com','f9c00c','노랑',45);
-- 메일 변경
update tbl_mail set send_time = send_time-1;
commit;
-- 태그 변경
update tbl_tag set fk_MAIL_Recipient_NO = '100,101,106'
where FK_mail_address = 'kjsaj0525@groovy.com' and tag_color = 'f9320c';
commit;



commit;


------------ 태그 테이블 조회
select * 
from tbl_tag
where FK_mail_address = 'kjsaj0525@groovy.com';


create sequence seq_mail_no
start with 1                 
increment by 1              
nomaxvalue                   
nominvalue                   
nocycle                      
nocache;

commit;
insert into tbl_mail(MAIL_NO, FK_Sender_address,FK_Recipient_address,SUBJECT, CONTENTS,
							SEND_TIME,mail_pwd,orgFilename,fileName,fileSize)
					values(seq_mail_no.nextval, 'kjsaj0525@groovy.com' ,'kjsaj0525@groovy.com','wpa2222hr','sodyd',
			to_date('2022-11-28 15:17:26','yyyy-mm-dd hh24:mi:ss'),
			null,
			null,
			null,
			null
    );
    
    commit;
    select * from tbl_mail
    order by send_time asc;
    
    select to_char(SEND_TIME,'yyyy-mm-dd hh24:mi:ss')
    from tbl_mail;
    
    
    
    insert into tbl_mail(MAIL_NO, FK_Sender_address,FK_Recipient_address,SUBJECT, CONTENTS,
							SEND_TIME,mail_pwd,orgFilename,fileName,fileSize)
					values(seq_mail_no.nextval, 'kjsaj0525@groovy.com' ,'kjsaj0525@groovy.com','?','?',
		
		 
	    	    sysdate,
	    	 
	    
	     
	    	    null,
                null,
                null,
                null
                


		)
        
        
        rollback;
        
        
        commit;
        
        
        select '"'||department||position||name||'<'||cpemail||'>'||'"' as cpemail
		from tbl_employee;
        
        select * from tbl_mail order by send_time asc;
        
        
        select *
	    from tbl_tag
        where FK_MAIL_ADDRESS = 'kjsaj0525@groovy.com'
        and MAIL_NO like '%'||lower('102')||'%'; 
   
   select * from tbl_mail
   where substr(FK_RECIPIENT_ADDRESS, 2*1+1, 1) = 's';
        
   update tbl_mail set read_check = 1
   where MAIL_NO = 102;

create sequence seq_mail_recipient_no
start with 1                 
increment by 1              
nomaxvalue                   
nominvalue                   
nocycle                      
nocache;

create table TBL_MAIL_Recipient
(MAIL_Recipient_NO number not null -- 관리번호 시퀀스
,FK_MAIL_NO number not null--메일번호      시퀀스
,FK_Recipient_address  VARCHAR2(200 BYTE) --수신자메일주소
,FK_Referenced_address  VARCHAR2(200 BYTE) --참조메일주소
,read_check Number(1) default 0 not null --읽음여부 check 0 안읽음 1 읽음    // 표시용
,Recipient_delete Number(1) default 0 not null -- 받은 쪽에서 받은메일함에서 안보이게 지울때
,Recipient_IMPORTANT Number(1) default 0 not null --중요표시(받는이) check 0 안중요 1 중요

-- 기존의 임시저장칼럼은 DATE 가 NULL 인 애들조회로 가능하게
,constraint PK_TBL_MAIL_Recipient_MAIL_Recipient_NO primary key(MAIL_Recipient_NO)
,constraint FK_TBL_MAIL_Recipient_FK_Recipient_address foreign key(FK_Recipient_address) references tbl_EMPLOYEE(CPEMAIL)
,constraint FK_TBL_MAIL_Recipient_FK_Referenced_address foreign key(FK_Referenced_address) references tbl_EMPLOYEE(CPEMAIL)
,constraint CK_tbl_MAIL_Recipient_read_check check( read_check in (0,1) )
,constraint CK_tbl_MAIL_Recipient_Recipient_delete check( Recipient_delete in (0,1) )
,constraint CK_tbl_MAIL_Recipient_Recipient_IMPORTANT check( Recipient_IMPORTANT in (0,1) )
);

select *  from tbl_mail;
select * from TBL_MAIL_Recipient;

update TBL_MAIL_Recipient set read_check =  1
   		where fk_MAIL_NO = 45
   		and FK_RECIPIENT_ADDRESS_INDIVIDUAL = 'kjsaj0525@groovy.com';

rollback;

insert into TBL_MAIL_Recipient(MAIL_Recipient_NO,FK_MAIL_NO, FK_Recipient_address)
values(seq_mail_recipient_no.nextval,35,'kjskjskjs@groovy.com');


select * from TBL_MAIL_Recipient;

select M.MAIL_NO,M.FK_SENDER_ADDRESS,M.FK_RECIPIENT_ADDRESS
		        ,M.SUBJECT,M.contents,M.send_Time,M.SENDER_DELETE,M.SENDER_IMPORTANT
		        ,M.FILENAME, M.ORGFILENAME, M.FILESIZE,M.MAIL_PWD
		        
		        	,R.mail_recipient_no,R.FK_RECIPIENT_ADDRESS_individual,R.FK_REFERENCED_ADDRESS_individual
                    ,R.READ_CHECK,R.RECIPIENT_DELETE,R.RECIPIENT_IMPORTANT
				
			
			   from tbl_mail M  
		
				   right JOIN TBL_MAIL_Recipient R  
				   ON R.fk_mail_no = M.mail_no

 
       where SEND_TIME <= sysdate
     
and  ((FK_Recipient_address_individual = 'kjsaj0525@groovy.com')
			    			  or (FK_REFERENCED_ADDRESS_individual = 'kjsaj0525@groovy.com'))
                              and lower(subject) like '%'||'메일'||'%';
		        <![CDATA[]]>;
	
		        	<if test='listType == "FK_Recipient_address" or listType == "FK_Sender_address"'>    	
			    		and  FK_Recipient_address like '%'||#{mail_address}||'%'
			    	</if>
	
			    		and ((FK_Recipient_address = #{mail_address} and Recipient_IMPORTANT = 1)
			    			  or (FK_Sender_address = #{mail_address} and SENDER_IMPORTANT = 1))

	
			    	and lower(${searchType}) like '%'||lower(#{searchWord})||'%'


		        order by SEND_TIME desc
commit;

select * from TBL_MAIL_Recipient;

MERGE 
 INTO TBL_MAIL_Recipient 
USING dual
   ON (READ_CHECK = 1)
 WHEN MATCHED THEN
      UPDATE
         SET RECIPIENT_IMPORTANT = 1
      where MAIL_RECIPIENT_NO =  3 
 WHEN NOT MATCHED THEN
      UPDATE
         SET RECIPIENT_IMPORTANT = 0
      where MAIL_RECIPIENT_NO =  3;
      -- merge 문은 on 절에 쓴 컬럼은 변경 불가
      
     
select RECIPIENT_IMPORTANT
from TBL_MAIL_Recipient
where MAIL_RECIPIENT_NO=3;


 select rownum AS rno, V.*
 from        
 (           select M.MAIL_NO,M.FK_SENDER_ADDRESS,M.FK_RECIPIENT_ADDRESS
 ,M.SUBJECT,M.contents,M.send_Time,M.SENDER_DELETE,M.SENDER_IMPORTANT 
 ,M.FILENAME, M.ORGFILENAME, M.FILESIZE,M.MAIL_PWD
 ,R.mail_recipient_no,R.FK_RECIPIENT_ADDRESS_individual
 ,R.FK_REFERENCED_ADDRESS_individual,R.READ_CHECK 
 ,R.RECIPIENT_DELETE,R.RECIPIENT_IMPORTANT 
 
 from tbl_mail M                                 
 where SEND_TIME <= sysdate      
 and ((FK_Recipient_address_individual = ? and Recipient_IMPORTANT = 1)             
        or (FK_Sender_address = ? and SENDER_IMPORTANT = 1))  ; 
        and lower(subject) like '%'||lower('메일')||'%';
        order by SEND_TIME desc       ) V   ) T    where rno between ? and ?
        
        
        


select * 
from tbl_mail M
right join ;


rollback;



		    select rownum AS rno, V.*
		    from 
		    (
		        select M.MAIL_NO,M.FK_SENDER_ADDRESS,M.FK_RECIPIENT_ADDRESS
		        ,M.SUBJECT,M.contents,M.send_Time,M.SENDER_DELETE,M.SENDER_IMPORTANT
		        ,M.FILENAME, M.ORGFILENAME, M.FILESIZE,M.MAIL_PWD
		      
	
		        	,R.mail_recipient_no,R.FK_RECIPIENT_ADDRESS_individual
		        	,R.FK_REFERENCED_ADDRESS_individual,R.READ_CHECK
		        	,R.RECIPIENT_DELETE,RECIPIENT_IMPORTANT
		
			
			   from tbl_mail M  

				   right JOIN TBL_MAIL_Recipient R  
				   ON R.fk_mail_no = M.mail_no
	
		      where SEND_TIME <= sysdate
	

		        		and RECIPIENT_IMPORTANT =0    	
			    		and  ((FK_Recipient_address_individual ='kjsaj0525@groovy.com')
			    			  or (FK_REFERENCED_ADDRESS_individual = 'kjsaj0525@groovy.com'))
	
		        order by SEND_TIME desc
		    ) V;


SELECT EMPNO, DEPARTMENT, NAME, E.POSITION AS POSITION, POSITION_NO
		FROM TBL_EMPLOYEE E JOIN TBL_POSITION P 
		ON E.POSITION = P.POSITION;
        
        select * from TBL_EMPLOYEE;
        select * from TBL_POSITION;
        
        select * from tbl_bumun;
        select * from tbl_department;
        
        select * from tbl_mail;

        select '"'||department||' '||position||' '||name||'<![CDATA[<]]>'||cpemail||'<![CDATA[>]]>'||'"' as cpemail
		from tbl_employee
        where cpemail = lower('kjsaj0525@groovy.com');
        
        select to_char(department_no) as department_no, department, to_char(bumun_no) as bumun_no, bumun 
        from tbl_department D 
        left join tbl_bumun B
        on D.fk_bumun_no = B.bumun_no order by bumun_no;
        ;
        
   select *
		from 
		(
		    select rownum AS rno, V.*
		    from 
		    ( 
                select empno, cpemail, name, position, substr(jubun,0,6) as birth_date
                      ,empimg, bumun,fk_bumun_no,department, fk_department_no,mobile,joindate
                from TBL_EMPLOYEE
                where 1=1

                order by bumun_no, department_no
		    ) V
		) T 
		where rno between #{startRno} and #{endRno} 
    
    select count(*)
    from TBL_EMPLOYEE
    where 1=1
    and lower(bumun) like ('%'||lower('it')||'%');
    
    

create table tbl_important_organization 
(fk_user_empno number not null
, fk_important_empno number not null

,constraint Fk_tbl_important_organization_fk_user_empno foreign key(fk_user_empno) references tbl_EMPLOYEE(empno)
,constraint Fk_tbl_important_organization_fk_important_empno foreign key(fk_important_empno) references tbl_EMPLOYEE(empno)
);

commit;


        
select * from tbl_important_organization;


insert into tbl_important_organization(fk_user_empno, fk_important_empno) 
Values(12,1);
-- 12 kjsaj0525 17 kjskjskjs

select E.* , nvl(FK_IMPORTANT_EMPNO, 1,0) as important
from tbl_employee E 
left join 
(
select fk_user_empno,fk_important_empno
from tbl_important_organization 
where fk_user_empno = 12
)I
on E.empno = I.fk_important_empno
order by empno asc;

select * from tbl_employee;
select * from tbl_important_organization;




select 
    important = (select fk_important_empno
                   from tbl_important_organization
                   where fk_user_empno = e.empno)
from employee e;









create table tbl_chatroom 
(chatroom_no number not null
, chatroom_name VARCHAR2(50 BYTE) not null

,constraint Pk_tbl_chatroom_chatroom_no primary key(chatroom_no)
);

commit;


create table tbl_chatroom_member 
(fk_chatroom_no number not null
, fk_member_no number not null

,constraint Fk_tbl_chatroom_member_fk_member_no foreign key(fk_member_no) references tbl_EMPLOYEE(empno)
);

commit;


create table tbl_chatroom_message 
(fk_chatroom_no number not null
, fk_member_no number not null
, message varchar(200) not null

,constraint Fk_tbl_chatroom_message_fk_member_no foreign key(fk_member_no) references tbl_EMPLOYEE(empno)
);


create sequence seq_chatroom_no
start with 1                 
increment by 1              
nomaxvalue                   
nominvalue                   
nocycle                      
nocache;

select * from tbl_chatroom;
insert into tbl_chatroom(chatroom_no, chatroom_name)
values(,);
select * from tbl_chatroom_message order by send_time asc;
select * from tbl_chatroom_member;
select empno from tbl_employee;
commit;

select * 
from tbl_chatroom_member
where fk_chatroom_no = ;
select empno
		from tbl_employee
		where cpemail = lower('kjskjskjs@groovy.com');
 
select *
from
(
select chatroom_no, chatroom_name
,(select count(*)
    from tbl_chatroom_member
    where fk_chatroom_no= chatroom_no
    ) as cnt
from tbl_chatroom

)c
right join
(
select *
from tbl_chatroom_member
where FK_MEMBER_NO = 17
)m
on c.chatroom_no = m.FK_CHATROOM_NO
order by chatroom_no;
select * from tbl_employee;
select * from tbl_chatroom_message;
select * from tbl_chatroom;
select * from tbl_chatroom_member;

select fk_chatroom_no, fk_member_no, message, type, send_to, send_time
, (select name
   from tbl_employee
    where empno = fk_member_no) as name
from tbl_chatroom_message
order by send_time desc

select fk_chatroom_no, fk_member_no, message, type, send_to, send_time
		, (select name
		   from tbl_employee
		    where empno = fk_member_no) as name
		from tbl_chatroom_message
		where fk_chatroom_no=4
		order by send_time desc
        
        
select * from TBL_IMPORTANT_ORGANIZATION  ;   

commit;
MERGE 
		INTO TBL_IMPORTANT_ORGANIZATION
		USING dual
		
		 ON (FK_USER_EMPNO= 12 and FK_IMPORTANT_EMPNO = 1)
		 
		WHEN MATCHED THEN
		
        update SET IMPORTANT_delete=1
		delete where IMPORTANT_delete = 1
		WHEN NOT MATCHED THEN
		
		insert(FK_USER_EMPNO,FK_IMPORTANT_EMPNO)
		values(12,1)
        
        select FK_MEMBER_NO
		from tbl_chatroom_member
		where fk_chatroom_no = 11
        
        
        
        
        select empno, cpemail, name, position, substr(jubun,0,6) as birth_date
	                      ,empimg, bumun,department, mobile,joindate , nvl2(FK_IMPORTANT_EMPNO, 1,0) as important
			    from tbl_employee E 
			    left join 
			    (
			        select fk_user_empno,fk_important_empno
			        from tbl_important_organization 
			        where fk_user_empno = 12
			    )I
		    	on E.empno = I.fk_important_empno

			    	and DEPARTMENT like '%'||lower('경영')||'%'
		
		    	order by fk_bumun_no, fk_department_no,fk_position_no;
                
select * from tbl_chatroom_member;                
                
select '"'||department||' '||position||' '||name||'<![CDATA[<]]>'||cpemail||'<![CDATA[>]]>'||'"' as cpemail
		from tbl_employee e
		right join 
        (
        select *
        from tbl_chatroom_member 
        where fk_chatroom_no = 7
        )m
        on e.empno = m.fk_member_no;
        
        delete from tbl_tag 
	where FK_MAIL_ADDRESS='kjsaj0525@groovy.com'
	and tag_color='8ebadc'
	and tag_name='추가';
        
     delete from tbl_chatroom_member
   		where FK_MEMBER_NO in (12,1)
        
        rollback;
        
        
select * from TBL_MAIL_Recipient;

select *
from 
 (
select M.MAIL_NO,M.FK_SENDER_ADDRESS,M.FK_RECIPIENT_ADDRESS
		        ,M.SUBJECT,M.contents,M.send_Time,M.SENDER_DELETE,M.SENDER_IMPORTANT
		        ,M.FILENAME, M.ORGFILENAME, M.FILESIZE,M.MAIL_PWD 
                , case when(lag(M.MAIL_NO, 1) over(order by SEND_TIME desc) = M.MAIL_NO) then 0 else 1 end as ck
from tbl_mail M
right JOIN TBL_MAIL_Recipient R  
				   ON R.fk_mail_no = M.mail_no
where SEND_TIME <= sysdate  
	and ((FK_Recipient_address_individual = 'kjskjskjs@groovy.com' and Recipient_IMPORTANT = 1 and RECIPIENT_delete =0)
    			  or (FK_Sender_address = 'kjskjskjs@groovy.com' and SENDER_IMPORTANT = 1 and sender_delete = 0))
)L
where ck = 1;

	      
    	
 select count(*)
	    from
	    (
	    select * ,case when(lag(M.MAIL_NO, 1) over(order by SEND_TIME desc) = M.MAIL_NO) then 0 else 1 end as ck
	    from tbl_mail M  
	        
	    right JOIN TBL_MAIL_Recipient R  
   		ON R.fk_mail_no = M.mail_no
   		 
	     where SEND_TIME <= sysdate 	    
	
       	 
       	   
       		and RECIPIENT_delete =0  	
    		and  ((FK_Recipient_address_individual = :1 )
    			  or (FK_REFERENCED_ADDRESS_individual = :2 ))
    	 
    	 
    	 
		), OriginalSql = select count(*)
	    from
	    (
	    select M.MAIL_NO,M.FK_SENDER_ADDRESS,M.FK_RECIPIENT_ADDRESS
			        ,M.SUBJECT,M.contents,M.send_Time,M.SENDER_DELETE,M.SENDER_IMPORTANT
			        ,M.FILENAME, M.ORGFILENAME, M.FILESIZE,M.MAIL_PWD , case when(lag(M.MAIL_NO, 1) over(order by SEND_TIME desc) = M.MAIL_NO) then 0 else 1 end as ck
	    from tbl_mail M  ;
	        
	    right JOIN TBL_MAIL_Recipient R  
   		ON R.fk_mail_no = M.mail_no
   		 
	     where SEND_TIME <= sysdate 	    
	
       	 
       	   
       		and RECIPIENT_delete =0  	
    		and  ((FK_Recipient_address_individual = 'kjsaj0525@groovy.com')
    			  or (FK_REFERENCED_ADDRESS_individual = 'kjsaj0525@groovy.com'));

update
(
select *
from TBL_MAIL_Recipient r
join TBL_MAIL m
on r.fk_mail_no = m.mail_no and FK_RECIPIENT_ADDRESS_INDIVIDUAL = FK_SENDER_ADDRESS and mail_no = 76
)
set RECIPIENT_IMPORTANT=0
;

commit;

select * from TBL_MAIL_Recipient;


MERGE 
 INTO TBL_MAIL_Recipient r
USING  TBL_MAIL m
   ON (r.fk_mail_no = m.mail_no and FK_RECIPIENT_ADDRESS_INDIVIDUAL = FK_SENDER_ADDRESS
      and mail_no = 76)
 WHEN MATCHED THEN
      UPDATE
        SET 
        RECIPIENT_IMPORTANT =0
        RECIPIENT_IMPORTANT=SENDER_IMPORTANT;


select * from TBL_MAIL_Recipient;
rollback;

select *
from
    (
        select rownum AS rno, V.*
        from 
        (
            select  M.MAIL_NO,M.FK_SENDER_ADDRESS
                    ,M.SUBJECT,M.send_Time,M.SENDER_DELETE
                    ,R.mail_recipient_no,R.FK_RECIPIENT_ADDRESS_individual
                    ,R.FK_REFERENCED_ADDRESS_individual
    
            from 
            (
                select *
                from tbl_mail 
                where SEND_TIME <= sysdate
            ) M
            right JOIN 
            (
                select *
                from TBL_MAIL_Recipient
                where RECIPIENT_delete =0    	
                and  ((FK_Recipient_address_individual = 'kjsaj0525@groovy.com') or (FK_REFERENCED_ADDRESS_individual = 'kjsaj0525@groovy.com'))
            ) R  
            ON R.fk_mail_no = M.mail_no
            order by SEND_TIME desc;
        )V
    )
    where rno between 1 and 5