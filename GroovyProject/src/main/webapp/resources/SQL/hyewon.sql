show user;

select *
from user_tables;

select *
from tbl_employee;

SELECT * FROM user_scheduler_jobs;

select *
from tbl_attendance;

select to_char(workdate, 'hh24:mi:ss'), nvl(to_char(workend, 'hh24:mi:ss'), '00:00:00')
from tbl_attendance
where fk_empno = 6;

commit;

drop table tbl_attendance purge;

alter table tbl_attendance drop constraint PK_tbl_attendance_fk_empno_workdate;

alter table tbl_attendance add workstart date default sysdate;

ALTER TABLE tbl_attendance ADD CONSTRAINT PK_tbl_attendance_fk_empno_workdate PRIMARY KEY (fk_empno, workdate);

commit;
create table tbl_attendance
( fk_empno       number  not null                -- 사원번호
, workdate       date default sysdate not null   -- 날짜
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

-- 기간별 누적 근무시간
select nvl(round( sum((workend-workstart)*24), 1 ), 0) as worktime
     , nvl(to_char( round( sum((tripend-tripstart)*24), 1) ),'0') as triptime
     , nvl(to_char( round( sum((workend-extendstart)*24), 1) ),'0') as extendtime
     , sum(decode(dayoff, 'Y', 1, 'N', 0)) as dayoffcnt     
from tbl_attendance 
where fk_empno = 6 and workdate between to_date('2022.11.21', 'yyyy.mm.dd') and to_date('2022.11.25', 'yyyy.mm.dd')

select sum(decode(dayoff, 'Y', 1, 'N', 0))
from tbl_attendance 
where fk_empno = 6 and workdate between to_date('2022.11.10', 'yyyy.mm.dd') and to_date('2022.11.25', 'yyyy.mm.dd')

insert into tbl_attendance (fk_empno, workdate, workend ) values (13, to_date('2022-11-22 12:00', 'yyyy-mm-dd hh24:mi'), to_date('2022-11-22 20:00', 'yyyy-mm-dd hh24:mi'));

commit

select *
from tbl_employee
where department='인사총무팀'

select department
from tbl_employee
where empno = 6

select *
from tbl_attendance
order by workdate;

update tbl_attendance set workend = to_date('2022-11-24 19:01:00', 'yyyy-mm-dd hh24:mi:ss')
where fk_empno = 6 and to_char(workdate, 'yyyy-mm-dd') = (select to_date('2022-11-24', 'yyyy-mm-dd') from dual );

select round((sysdate - to_date('2022-11-20 14:00:00', 'yyyy-mm-dd hh24:mi:ss'))*24, 2) from dual


rollback;

SELECT
      SYSDATE - 7 AS "7일전"
    , TRUNC(SYSDATE, 'w') AS 매월1일_요일_기준 --매월1일 요일을 기준한 주초일자
    , TRUNC(SYSDATE, 'ww') AS 매년1월1일_요일_기준 --매년 1월1일 요일을 기준한 주초일자.
    , TRUNC(SYSDATE, 'iw') AS 월요일_기준
    , TRUNC(SYSDATE, 'dy') AS 일요일_기준
    , TRUNC(SYSDATE, 'iw') - 2 AS 항상_전주토요일1
    , TRUNC(SYSDATE, 'dy') - 1 AS 항상_전주토요일2
FROM dual
;

select *
from tbl_attendance 
where fk_empno = 6 and workdate between(select TRUNC(to_date('2022-11', 'yyyy-mm'), 'iw') from dual ) and (select TRUNC(to_date('2022-10', 'yyyy-mm'), 'iw')+5 from dual )

-- 매달 첫번째주의 첫번째 날과 마지막 주의 금요일
select *
from tbl_attendance 
where fk_empno = 6 and workdate between( select TRUNC(to_date('2022-10', 'yyyy-mm'), 'iw') from dual ) and (select last_day(sysdate) from dual )


delete from tbl_attendance
where fk_empno = 6 and to_char(workdate, 'yyyy-mm-dd') = '2022-11-19';

commit;

delete from tbl_employee
where empno = 16 ;

select *
from tbl_employee

select fk_empno, workdate, workend, trip, tripstart, tripend, triptime, dayoff, extendstart
from 
(
    select rownum AS RNO, fk_empno, to_char(workdate, 'yyyy-mm-dd hh24:mi:ss dy') as workdate, to_char(workend, 'yyyy-mm-dd hh24:mi:ss') as workend, trip
         , nvl(to_char(tripstart), '-') as tripstart, nvl(to_char(tripend), '-') as tripend, nvl(to_char(round((tripend-tripstart)*24,2)), '-') as triptime, dayoff
         , nvl(to_char(round((workend-extendstart)*24,2)), '-') as extendstart
    from 
    (
        select *
        from tbl_attendance 
        where fk_empno = 6 and workdate between( select TRUNC(to_date('2022-11', 'yyyy-mm'), 'iw') from dual ) and (select next_day((last_day(to_date('2022-11', 'yyyy-mm'))),'금') from dual )
        order by workdate
    ) V
) T;

select fk_empno, workdate, workend, trip, tripstart, tripend, triptime, dayoff, extendstart, worktime
from 
(
    select rownum AS RNO, fk_empno, trip
					 , to_char(workdate, 'mm.dd dy') as workdate
					 , workstart
			         , nvl(to_char(workend, 'hh24:mi:ss'), '-') as workend
			         , nvl(to_char(tripstart), '-') as tripstart, nvl(to_char(tripend), '-') as tripend
			         , nvl(to_char(round((tripend-tripstart)*24,2)), '-') as triptime, dayoff
			         , nvl(to_char(round((workend-extendstart)*24,2)), '-') as extendstart
			         , NVL(trunc((((workend - workstart)*24)*60)/60), 0)|| '시간 ' ||  NVL(round(mod((((workend - workstart)*24)*60), 60)), 0) || '분' as worktime
		    from 
    (
        select *
        from tbl_attendance 
        where fk_empno = 6 and workdate between( select TRUNC(to_date('2022-11', 'yyyy-mm'), 'iw') from dual ) and (select next_day((last_day(to_date('2022-11', 'yyyy-mm'))),'금') from dual )
        order by workdate
    ) V
) T;
to_char(workstart, 'hh24:mi:ss')
 -- 이번주 누적근무시간
select nvl(round( sum((workend-workdate)*24), 1 ), 0) as weeklywork
     , 40-nvl(to_char(round( sum((workend-workdate)*24), 1 )), 0) as remainwork
     , 
     , nvl(to_char( round( sum((workend-extendstart)*24), 1) ),'0') as weeklyextend
from tbl_attendance 
where fk_empno = 6 and workdate between( select TRUNC(sysdate, 'iw') from dual ) and ( select TRUNC(sysdate, 'iw')+5 from dual )

select trunc((sum((workend-workdate)*24)*60)/60)|| '시간 ' ||  round(mod(sum(((workend-workdate)*24)*60), 60)) || '분' as weeklywork
     , trunc(((40-NVL(round(sum((workend-workdate)*24), 2), 0))*60)/60)|| '시간 ' ||  round(mod(((40-NVL(round(sum((workend-workdate)*24), 2), 0))*60), 60)) || '분' as remainwork
     , NVL(trunc((sum((workend-extendstart)*24)*60)/60), 0)|| '시간 ' ||  NVL(round(mod(sum(((workend-extendstart)*24)*60), 60)), 0) || '분' as weeklyextend
from tbl_attendance 
where fk_empno = 6 and workdate between( select TRUNC(sysdate, 'iw') from dual ) and ( select TRUNC(sysdate, 'iw')+5 from dual )

 -- 이번달 누적근무시간
select nvl(round( sum((workend-workdate)*24), 1 ), 0) as monthlywork
     , nvl(to_char( round( sum((workend-extendstart)*24), 1) ),'0') as monthlyextend
from tbl_attendance 
where fk_empno = 6 and workdate between( SELECT TRUNC(SYSDATE, 'MM') FROM DUAL ) and  (select last_day(sysdate) from dual ) 

select trunc((sum((workend-workdate)*24)*60)/60)|| '시간 ' ||  round(mod((sum((workend-workdate)*24)*60), 60)) || '분' as monthlywork
     , trunc((sum((workend-extendstart)*24)*60)/60)|| '시간 ' ||  round(mod((sum((workend-extendstart)*24)*60), 60)) || '분' as monthlyextend
from tbl_attendance 
where fk_empno = 6 and workdate between( SELECT TRUNC(SYSDATE, 'MM') FROM DUAL ) and  (select last_day(sysdate) from dual ) 

---------------------------------------------------------------------

select 8.6 , 8.6*60, trunc((8.6*60)/60) || '시간' || mod(8.6*60, 60) || '분'  as time
from dual;

---------------------------------------------------------------------

select to_char(workdate, 'hh24:mi:ss')
from tbl_attendance 
where fk_empno = 6 and to_char(workdate, 'yyyy-mm-dd') = (select to_char(sysdate-1, 'yyyy-mm-dd') from dual )


select nvl(to_char(workdate, 'hh24:mi:ss'), '-') as workdate, nvl(to_char(workend, 'hh24:mi:ss'), '-') as workend
from tbl_attendance
where fk_empno = 6 and to_char(workdate, 'yyyy-mm-dd') = (select to_char(sysdate, 'yyyy-mm-dd') from dual )

create sequence seq_attendance_request
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

drop table tbl_attendance_request purge;

create table tbl_attendance_request
( requestid         number        not null         --  근태신청번호 attend_request_seq
, fk_empno          number        not null         --  사원번호
, attend_index      Nvarchar2(10) not null         --   근태종류
, starttime         date          not null         --  시작시간 (ex. 2022-10-10 11:00)
, endtime           date                           --  종료시간 (ex. 2022-10-10 11:00)
, place             Nvarchar2(100)                 --  장소
, reason            Nvarchar2(200)                 --  사유
, registerdate      date default sysdate not null  --  신청일자
, constraint PK_tbl_attendance_request_requestid primary key(requestid)
, constraint FK_tbl_attendance_request_fk_empno Foreign key(fk_empno) references tbl_employee(empno)
);
-- Table TBL_ATTENDANCE_REQUEST이(가) 생성되었습니다.

select *
from tbl_attendance_request;

INSERT INTO tbl_attendance_request (requestid, fk_empno, attend_index, starttime  )
VALUES(seq_attendance_request.nextval, 6, 'dayoff', to_date('2022-12-2','yyyy-mm-dd'))
      
commit;

delete from tbl_attendance_request
where requestid = 2
            
rollback;

commit;
            
-- 신청내역
select attend_index, to_char(starttime, 'yyyy-mm-dd hh24:mi') as starttime
     , to_char(endtime, 'yyyy-mm-dd hh24:mi') as endtime
     , nvl(place, '-') as place, nvl(reason, '-') as reason
     , to_char(registerdate, 'yyyy-mm-dd') as registerdate
from tbl_attendance_request
where fk_empno = 6 and starttime > to_date('2022.11.21 00:00:01', 'yyyy.mm.dd hh24:mi:ss') and endtime  < to_date('2022.11.25 23:59:59', 'yyyy.mm.dd hh24:mi:ss');

where fk_empno = 6 and starttime > to_date('2022.11.21 00:00:01', 'yyyy.mm.dd hh24:mi:ss') and endtime  < to_date('2022.11.25 23:59:59', 'yyyy.mm.dd hh24:mi:ss');

-- 사용내역
select attend_index, to_char(starttime, 'yyyy-mm-dd hh24:mi') as starttime
     , to_char(endtime, 'yyyy-mm-dd hh24:mi') as endtime
     , nvl(place, '-') as place, nvl(reason, '-') as reason
     , to_char(registerdate, 'yyyy-mm-dd') as registerdate
from tbl_attendance_request
where fk_empno = 6 and starttime > to_date('2022-11-21', 'yyyy-mm-dd') and endtime < sysdate;


commit;

select *
from tbl_employee
where department='인사총무팀';

INSERT INTO tbl_attendance_request (requestid, fk_empno, attend_index, starttime, endtime  )
VALUES(seq_attendance_request.nextval, 6, 'trip', to_date('2022-11-25 15:00:00', 'yyyy-mm-dd hh24:mi:ss'), to_date('2022-11-25 18:00:00', 'yyyy-mm-dd hh24:mi:ss'));

update tbl_attendance set workstart = to_date('2022-11-22 10:10:00', 'yyyy-mm-dd hh24:mi:ss')
where fk_empno = 9 and to_char(workdate, 'yyyy-mm-dd') = '2022-11-22';



INSERT INTO tbl_attendance_request (requestid, fk_empno, attend_index, starttime, endtime  )
VALUES(seq_attendance_request.nextval, 6, 'trip', to_date('2022-12-01 10:00', 'yyyy-mm-dd hh24:mi'), to_date('2022-12-01 13:00', 'yyyy-mm-dd hh24:mi'));

select *
from tbl_attendance_request;

delete from tbl_attendance_request
where to_char(registerdate, 'yyyy-mm-dd') = '2022-11-24' ;

commit;

select *
from user_tables;

commit;
INSERT INTO tbl_employee 
(empno,cpemail,name,pwd,position,jubun,postcode,bumun,department,pvemail
,mobile,depttel,joindate,empstauts,bank,account,annualcnt)
VALUES(SEQ_TBL_EMPLOYEE.NEXTVAL, 'hyewon@groovy.com', '김혜원', 'qwer1234$',
'부문장', '960319-2222222', '12345', '경영지원부문','인사총무팀','hwon319@daum.net',
'01022223333','101','2022/11/18','1','국민은행','210123456789',15);

rollback;

commit;

update tbl_employee set empimg = 'jaeseok.jpg'
where empno = 10;

select *
from tbl_attendance

select NVL(trunc((sum((workend-workstart)*24)*60)/60), 0)|| '시간 ' ||  NVL(round(mod((sum((workend-workstart)*24)*60), 60)),0) || '분' as worktime
		     , nvl(to_char( round( sum((tripend-tripstart)*24), 1) ),'0') as triptime
		     , nvl(to_char( round( sum((workend-extendstart)*24), 1) ),'0') as extendtime
		     , sum(decode(dayoff, 'Y', 1, 'N', 0)) as dayoffcnt     
		from tbl_attendance 
		where fk_empno = 6 and workdate between to_date('2022.11.28', 'yyyy.mm.dd') and to_date('2022.12.02', 'yyyy.mm.dd')
        
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
-- 부서별 근태조회 (부서 근태조회 - 일별)
select name, department, workstarttime, workendtime, worktime, worktimecom, triptime, worktimeback, extendstart, extendtime, dayoff
from tbl_employee E
LEFT JOIN
(
select fk_empno, NVL(to_char(workdate, 'hh24:mi'), '-') as workstarttime
     , NVL(to_char(workend, 'hh24:mi'), '-') as workendtime
     , NVL(to_char(round((workend-workdate)*24, 1)), '-') as worktime
     , NVL(to_char(round((tripstart-workdate)*24, 1)), '-') as worktimecom     
     , NVL(to_char(round((tripend-tripstart)*24, 1)), '-') as triptime
     , NVL(round((workend-tripend)*24, 1), -999) as worktimeback
     , NVL(to_char(extendstart, 'hh24:mi'), '-') as extendstart
     , NVL(to_char(round((workend-extendstart)*24, 1)), '-') as extendtime
     , decode(dayoff, 'N', '-', 'Y', '연차') as dayoff
from tbl_attendance
) A
on E.empno = A.fk_empno
where department = ( select department from tbl_employee where empno = '6' ) and to_char(workdate, 'yyyy.mm.dd') between '2022.11.21' and '2022.11.25'
order by empno




--------------------------------------------------------------------------------------------------------------------
-- 부서별 근태조회 (부서 근태조회 - 주별)

-- 부서 박스 조회
select empno, department, name, position, bumun
from tbl_employee
where department = ( select department from tbl_employee where empno = '6' )
order by empno

-- 개인정보 박스 조회
select name, department, position, worksum
from 
(
    select fk_empno, trunc((sum((workend-workdate)*24)*60)/60)|| '시간 ' ||  round(mod((sum((workend-workdate)*24)*60), 60)) || '분' as worksum
    from tbl_attendance
    where workdate between to_date('2022.11.07', 'yyyy.mm.dd') and to_date('2022.11.11', 'yyyy.mm.dd')+1
    group by fk_empno
) A
JOIN
(
    select empno, department, position, name, NVL(empimg, '없음') as empimg
    from tbl_employee 
) E
on E.empno = A.fk_empno
where fk_empno = 6

-- 주별 근무 조회
select NVL(to_char(workstart, 'yyyy.mm.dd hh24:mi dy'), to_char(to_date(workdate, 'yyyy.mm.dd'), 'yyyy.mm.dd hh24:mi dy')) as workstart
		     , NVL(to_char(workend, 'hh24:mi'), '-') as workend
		     , NVL(trunc((((workend-extendstart)*24)*60)/60), 0)|| '시간 ' ||  NVL(round(mod((((workend-extendstart)*24)*60), 60)), 0) || '분' as extendtime
		     , trunc((((workend-workstart)*24)*60)/60)|| '시간 ' ||  round(mod((((workend-workstart)*24)*60), 60)) || '분' as worksum
		     , decode(dayoff, 'Y', '연차 ', 'N', ' ' ) as dayoff
		     , decode(trip, 'Y', '외근 ', 'N', ' ' ) as trip
		     , NVL(to_char(tripstart, 'hh24:mi ~'), ' ') as tripstart, NVL(to_char(tripend, 'hh24:mi'), ' ') as tripend
from tbl_attendance
where fk_empno = 6 and workdate between to_date('2022.11.28', 'yyyy.mm.dd') and to_date('2022.11.30', 'yyyy.mm.dd')+1



select name, department, workstarttime, workendtime, worktime, worktimecom, triptime, worktimeback, extendstart, extendtime, dayoff
from tbl_employee E
LEFT JOIN
(
select fk_empno, NVL(to_char(workdate, 'hh24:mi'), '-') as workstarttime
     , NVL(to_char(workend, 'hh24:mi'), '-') as workendtime
     , NVL(to_char(round((workend-workdate)*24, 1)), '-') as worktime
     , NVL(to_char(round((tripstart-workdate)*24, 1)), '-') as worktimecom     
     , NVL(to_char(round((tripend-tripstart)*24, 1)), '-') as triptime
     , NVL(round((workend-tripend)*24, 1), -999) as worktimeback
     , NVL(to_char(extendstart, 'hh24:mi'), '-') as extendstart
     , NVL(to_char(round((workend-extendstart)*24, 1)), '-') as extendtime
     , decode(dayoff, 'N', '-', 'Y', '연차') as dayoff
from tbl_attendance
) A
on E.empno = A.fk_empno
where department = ( select department from tbl_employee where empno = '6' ) -- and to_char(workdate, 'yyyy.mm.dd') between '2022.11.21' and '2022.11.25'
order by empno

insert into (fk_userid, workdate)
values (, sysdate)

select *
from tbl_attendance
where fk_empno = 6 and to_char(workdate, 'yyyy-mm-dd') = '2022-12-07'

ALTER TABLE tbl_attendance MODIFY workstart DEFAULT NULL;

insert into tbl_attendance (fk_empno, workdate)
values (6, sysdate+3);

rollback;
-------------------------------------------------------------------------------------------------
select empno from tbl_employee

select to_char(workdate, 'yyyy-mm-dd hh24:mi') from tbl_attendance
where fk_empno = 6

select * from tbl_attendance_request
order by requestid

delete from tbl_attendance
where to_char(workdate, 'yyyy-mm-dd hh24:mi') = '2022-12-08 09:22';

select * from tbl_employee
order by empno;

commit;


-- 프로시저 생성
create or replace procedure pcd_insert_daily_attendance2
is
    cursor cur_empno
    is
        select empno
        from tbl_employee
        order by empno asc;
 
begin
    for v_rcd in cur_empno loop
        update tbl_attendance set workstart = to_date('2022-12-07 09:00', 'yyyy-mm-dd hh24:mi')
             , workend = to_date('2022-12-07 18:00', 'yyyy-mm-dd hh24:mi')
        where fk_empno = v_rcd.empno and to_char(workdate, 'yyyy-mm-dd') = '2022-12-07';
    end loop;
    
    
end pcd_insert_daily_attendance2;

exec pcd_insert_daily_attendance2;

rollback;

commit;

update tbl_attendance set fk_empno = 1
     , workstart = to_date('2022-11-28 09:00', 'yyyy-mm-dd hh24:mi')
     , workend = to_date('2022-11-28 18:00', 'yyyy-mm-dd hh24:mi')
where to_char(workdate, 'yyyy-mm-dd') = '2022-11-28';


grant create any job to FINAL_ORAUSER4;

show user;


create or replace procedure pcd_insert_attendance_request
is
    cursor cur_empno
    is
        select empno
        from tbl_employee
        order by empno asc;
 
begin
    for v_rcd in cur_empno loop
        insert into tbl_attendance(fk_empno, workdate)
        values(v_rcd.empno, sysdate);
    end loop;
    
    commit;
    
end pcd_insert_attendance_request;

select fk_empno, attend_index
     , to_char(starttime, 'yyyy-mm-dd hh24:mi') as starttime
     , to_char(endtime, 'yyyy-mm-dd hh24:mi') as endtime
from tbl_attendance_request
where to_char(starttime, 'yyyy-mm-dd') = to_char(sysdate, 'yyyy-mm-dd');

select fk_
from tbl_attendance

-- dayoff 라면
update tbl_attendance set dayoff = 'Y'
where fk_empno = 6 and to_char(workdate, 'yyyy-mm-dd') = to_char(sysdate, 'yyyy-mm-dd');

-- 연장근무라면
update tbl_attendance set extendstart = starttime, workend = endtime
where fk_empno = 6 and to_char(workdate, 'yyyy-mm-dd') = to_char(sysdate, 'yyyy-mm-dd');

-- 외근이라면
update tbl_attendance set tripstart = starttime, tripend = endtime, trip = 'Y'
where fk_empno = 6 and to_char(workdate, 'yyyy-mm-dd') = to_char(sysdate, 'yyyy-mm-dd');


create or replace procedure pcd_insert_attendance_request
is
    cursor cur_request
    is
        select fk_empno, attend_index
             , to_char(starttime, 'yyyy-mm-dd hh24:mi') as starttime
             , to_char(endtime, 'yyyy-mm-dd hh24:mi') as endtime
        from tbl_attendance_request
        where to_char(starttime, 'yyyy-mm-dd') = to_char(sysdate, 'yyyy-mm-dd');
 
begin
    for v_rcd in cur_request loop
        IF v_rcd.attend_index = 'dayoff' THEN
            update tbl_attendance set dayoff = 'Y'
            where fk_empno = v_rcd.fk_empno and to_char(workdate, 'yyyy-mm-dd') = to_char(sysdate, 'yyyy-mm-dd');
        ELSIF v_rcd.attend_index = 'extend' THEN
            update tbl_attendance set extendstart = to_date(v_rcd.starttime, 'yyyy-mm-dd hh24:mi'), workend = to_date(v_rcd.endtime, 'yyyy-mm-dd hh24:mi')
            where fk_empno = v_rcd.fk_empno and to_char(workdate, 'yyyy-mm-dd') = to_char(sysdate, 'yyyy-mm-dd');
        ELSE
            update tbl_attendance set tripstart = to_date(v_rcd.starttime, 'yyyy-mm-dd hh24:mi'), tripend = to_date(v_rcd.endtime, 'yyyy-mm-dd hh24:mi'), trip = 'Y'
            where fk_empno = v_rcd.fk_empno and to_char(workdate, 'yyyy-mm-dd') = to_char(sysdate, 'yyyy-mm-dd');
        END IF;
    end loop;
    
    commit;
    
end pcd_insert_attendance_request;

exec pcd_insert_attendance_request;

select *
from tbl_attendance
where fk_empno = 6 and to_char(workdate, 'yyyy-mm-dd') = '2022-11-25'

rollback;

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

select fk_empno, starttime, endtime
from tbl_attendance_request;

select *
from tbl_employee

-- 부서 근태 관리
select name, department, workdate, workstart, workend, dayoff, trip, extend
from 
(
select E.name as name, E.department as department
     , to_char(workdate, 'yyyy-mm-dd') as workdate
     , decode(A.workstart, null, '출근미등록', to_char(A.workstart, 'hh24:mi')) as workstart
     , decode(A.workend, null, '퇴근미등록', to_char(A.workend, 'hh24:mi')) as workend 
     , decode(A.dayoff, 'N', ' ', 'Y', '연차') as dayoff
     , decode(A.trip, 'Y', '외근' || ' ' ||NVL(to_char(A.tripstart, 'hh24:mi'), ' ') || '~' || NVL(to_char(A.tripend, 'hh24:mi'), ' '), 'N', null) as trip
     , decode(A.extendstart, null, null, '연장 '|| to_char(A.extendstart, 'hh24:mi') || '~' || to_char(A.workend, 'hh24:mi') ) as extend
from tbl_attendance A
JOIN tbl_employee E
on A.fk_empno = E.empno
where E.department = '인사총무팀' and E.name = '김혜원'
) C
where 1=1 and to_date(workdate) between to_date('2022.10.01', 'yyyy.mm.dd') and to_date('2022.11.25', 'yyyy.mm.dd')+1
        and 
        ( trip like '%외근%' -- 외근
        or workstart = '출근미등록'
        or workend = '퇴근미등록'
        or dayoff = '연차'
        or extend like '%연장%')

-- 페이징처리
select boardno, subject, userid, REGISTERDAY -- (T. 생략되어있음)
    from 
    (
        select rownum AS RNO, boardno, subject, userid, REGISTERDAY
        from 
        (
            select boardno
                 , subject
                 , userid
                 , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') as REGISTERDAY
            from tbl_board
            order by boardno desc
        ) V
    ) T
    where RNO between 3 and 4;

select name, department, workdate, workstart, workend, dayoff, trip, extend
from
(
    select rownum AS RNO, name, department, workdate, workstart, workend, dayoff, trip, extend
    from 
    (
        select E.name as name, E.department as department
             , to_char(workdate, 'yyyy-mm-dd') as workdate
             , decode(A.workstart, null, '출근미등록', to_char(A.workstart, 'hh24:mi')) as workstart
             , decode(A.workend, null, '퇴근미등록', to_char(A.workend, 'hh24:mi')) as workend 
             , decode(A.dayoff, 'N', ' ', 'Y', '연차') as dayoff
             , decode(A.trip, 'Y', '외근' || ' ' ||NVL(to_char(A.tripstart, 'hh24:mi'), ' ') || '~' || NVL(to_char(A.tripend, 'hh24:mi'), ' '), 'N', null) as trip
             , decode(A.extendstart, null, null, '연장 '|| to_char(A.extendstart, 'hh24:mi') || '~' || to_char(A.workend, 'hh24:mi') ) as extend
        from tbl_attendance A
        JOIN tbl_employee E
        on A.fk_empno = E.empno
        where E.department = '인사총무팀' -- and E.name = '김혜원'
    ) C
    where 1=1 and to_date(workdate) between to_date('2022.10.01', 'yyyy.mm.dd') and to_date('2022.11.30', 'yyyy.mm.dd')+1
            and 
            ( trip like '%외근%' -- 외근
            or workstart = '출근미등록'
            or workend = '퇴근미등록'
            or dayoff = '연차'
            or extend like '%연장%')
)T
where RNO between 1 and 10
order by workdate;

-- 부서 근태 관리 상단박스
-- 출근 미체크
select count(decode(workstart, null, ' ')) as cntstartnochk
from tbl_attendance A
JOIN tbl_employee E
on A.fk_empno = E.empno
where E.department = '인사총무팀' and workdate between to_date('2022.11.07', 'yyyy.mm.dd') and to_date('2022.11.30', 'yyyy.mm.dd')+1
    and A.workstart is null

-- 퇴근 미체크
select count(decode(workend, null, ' ')) as cntendnochk
from tbl_attendance A
JOIN tbl_employee E
on A.fk_empno = E.empno
where E.department = '인사총무팀' and workdate between to_date('2022.11.07', 'yyyy.mm.dd') and to_date('2022.11.11', 'yyyy.mm.dd')+1
    and A.workend is null

-- 무단결근
select count(decode(workend, null, ' ')) as cntabsent
from tbl_attendance A
JOIN tbl_employee E
on A.fk_empno = E.empno
where E.department = '인사총무팀' and workdate between to_date('2022.11.07', 'yyyy.mm.dd') and to_date('2022.11.11', 'yyyy.mm.dd')+1
    and A.workstart is null and A.workend is null

-- 연차
select count(dayoff) as cntdayoff
from tbl_attendance A
JOIN tbl_employee E
on A.fk_empno = E.empno
where E.department = '인사총무팀' and workdate between to_date('2022.11.07', 'yyyy.mm.dd') and to_date('2022.11.11', 'yyyy.mm.dd')+1 
    and A.dayoff = 'Y'

-- 연장근무(시간)
select NVL(trunc((sum((workend-extendstart)*24)*60)/60), 0)|| '시간 ' ||  NVL(round(mod(sum(((workend-extendstart)*24)*60), 60)), 0) || '분' as sumextend
from tbl_attendance A
JOIN tbl_employee E
on A.fk_empno = E.empno
where E.department = '인사총무팀' and workdate between to_date('2022.11.07', 'yyyy.mm.dd') and to_date('2022.11.11', 'yyyy.mm.dd')+1

select * 
from tbl_employee




-- 출퇴근 미체크
select decode(A.workstart, null, '미등록', to_char(A.workstart, 'hh24:mi')) as workstart
     , decode(A.workend, null, '미등록', to_char(A.workend, 'hh24:mi')) as workend 
     , decode(A.dayoff, 'N', ' ', 'Y', '연차') as dayoff
     , decode(A.trip, 'Y', '외근' || ' ' ||NVL(to_char(A.tripstart, 'hh24:mi'), ' ') || '~' || NVL(to_char(A.tripend, 'hh24:mi'), ' '), 'N', null) as trip
     , decode(A.extendstart, null, null, to_char(A.extendstart, 'hh24:mi') || '~' || to_char(A.workend, 'hh24:mi') ) as extend
from tbl_attendance A
JOIN tbl_employee E
on A.fk_empno = E.empno
where E.department = '인사총무팀' and E.name = '김혜원'




select *
from tbl_attendance