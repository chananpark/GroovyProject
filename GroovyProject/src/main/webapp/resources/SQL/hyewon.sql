show user;

select *
from user_tables;


create table tbl_attendance
( fk_userid      varchar2(20)  not null   --  userid
, date           varchar2(100) not null   --  날짜
, workstart      varchar2(10)             -- 출근시간
, workend        varchar2(10)             -- 퇴근시간
, trip           varchar2(2)              -- 출장여부
, tripstart      varchar2(20)             -- 출장시작 (ex. 2022-10-10 11:00)
, tripend        varchar2(20)             -- 출장종료 (ex. 2022-10-10 11:00)
, dayoff         varchar2(2)              -- 연차여부
, extendstart    varchar2(10)              -- 연장근무시작시간 
,constraint FK_tbl_attendance_fk_userid Foreign key(fk_userid) references tbl_member(userid)
,constraint UQ_tbl_attendance_fk_userid_date unique(fk_userid, date)
);

create table tbl_attendance_request
( PK_requestid      varchar2(20)  not null   --  근태신청번호 attend_request_seq
, fk_userid         varchar2(100) not null   --  사원번호
, attend_index      varchar2(10)  not null   --  근태종류
, starttime         varchar2(2)   not null   --  시작시간 (ex. 2022-10-10 11:00)
, endtime           varchar2(20)  not null   --  종료시간 (ex. 2022-10-10 11:00)
, place             varchar2(20)             --  장소
, reason            varchar2(2)              --  사유
, registerdate      varchar2(10)  not null   --  신청일자
, constraint PK_tbl_attendance_request_PK_requestid primary key(PK_requestid)
, constraint FK_tbl_attendance_request_fk_userid Foreign key(fk_userid) references tbl_member(userid)
);

