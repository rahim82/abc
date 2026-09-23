create table student154(
    sname varchar2(50) constraint not_null_sname not null,
    dob date constraint not_null_dob not null,
    mob_no number(10) constraint not_null_mob not null,
    roll_no number(10) constraint pk_roll_no PRIMARY KEY,
    email varchar2(50) constraint not_null_email not null,
    pincode number(6) constraint not_null_pincode not null,
    house_no number(3) constraint not_null_house_no not null,
    city varchar2(50) constraint not_null_city not null,
    constraint ck_sname_address unique(sname, pincode,house_no, city),
    constraint ck_email unique(email),
    constraint ck_mobile unique(mob_no)
    
    );
    
create table section154(
    batch number(4) constraint not_null_batch not null,
    sec_id varchar2(2) CONSTRAINT pk_sec_id PRIMARY KEY
    
);

create table faculty154(
    fname varchar2(20) constraint not_null_fname not null,
    salary NUMBER(10,2) constraint not_null_salary not null,
    emp_id varchar2(20) constraint pk_emp_id PRIMARY key,
    fmob number(10) constraint not_null_fmob not null,
    constraint ck_fmob unique(fmob) 
);

INSERT INTO faculty154 (fname, salary, emp_id, fmob)
VALUES ('F1', 60000, 'E101', 90001);

INSERT INTO faculty154 (fname, salary, emp_id, fmob)
VALUES ('F2', 50000, 'E102', 90002);

INSERT INTO faculty154 (fname, salary, emp_id, fmob)
VALUES ('F3', 70000, 'E103', 90003);

INSERT INTO faculty154 (fname, salary, emp_id, fmob)
VALUES ('F4', 55000, 'E104', 90004);

INSERT INTO faculty154 (fname, salary, emp_id, fmob)
VALUES ('F5', 75000, 'E105', 90005);
SELECT * FROM faculty154;

create table department154(
        dname varchar2(10) constraint not_null_dname not null,
        yos NUMBER(4) constraint not_null_yos not null,
        offloc varchar2(50) constraint not_null_offloc not null,
        hod varchar2(30) constraint not_null_hod not null,
        constraint ck_hod unique(hod),
        constraint fk_hod FOREIGN KEY(hod) references faculty154(emp_id),
        constraint ck_dname unique(dname)
    );
--delete from department154;
alter table department154 drop constraint not_null_yos;
alter table department154 add dep_id varchar2(20) constraint pk_dep_id PRIMARY key;

INSERT INTO department154 VALUES
('CSE', 2000, 'HITK ICT', 'E101', 'Dep1');

INSERT INTO department154 VALUES
('ECE', 2001, 'HITK CB', 'E102', 'Dep2');

INSERT INTO department154 VALUES
('AIML', 2002, 'HITK CME', 'E103', 'Dep3');

INSERT INTO department154 VALUES
('IT', 2003, 'HITK ICTB', 'E104', 'Dep4');

INSERT INTO department154 VALUES
('BT', 2004, 'HITK CMEB', 'E105', 'Dep5');

select * from department154;


alter table faculty154 add wud varchar2(20);
alter table faculty154 add supervised_by varchar2(20);

   
update faculty154 set wud = 'Dep1' where emp_id in('E101', 'E102');
update faculty154 set wud = 'Dep2' where emp_id in('E103', 'E104');
update faculty154 set wud = 'Dep3' where emp_id in('E105');

update faculty154 set supervised_by='E101' where emp_id IN('E101','E102','E103');
update faculty154 set supervised_by='E104' where emp_id IN('E104','E105');

alter table faculty154 add constraint fk_wud FOREIGN KEY(wud) references department154(dep_id);
ALTER TABLE faculty154 modify wud varchar2(20) constraint not_null_wud not null;

alter table faculty154 add constraint fk_supervised_by FOREIGN key(supervised_by) references faculty154(emp_id);

alter table student154
    add belongs_to_sec varchar(2) constraint not_null_btsec not null;

alter table student154 add constraint fk_belongs_to_sec FOREIGN KEY(belongs_to_sec)  references section154(sec_id);

create table course154(
    cid varchar(20) constraint pk_cid primary key,
    cname varchar(50) constraint not_null_cname not null,
    discipline varchar(50) constraint not_null_discipline not null,
    offeredby_dep varchar(10) constraint not_null_offdep not null,
    constraint fk_offdep foreign key(offeredby_dep) references department154(dep_id),
    constraint ck_cname_discipline unique(cname,discipline)
    
    
);

create table subject154(
    papercode varchar(20) constraint pk_pcode primary key,
    pname varchar(20) constraint not_null_pname not null,
    credit number(2) constraint not_null_cred not null
);


create table contains154(
    ccid varchar(20),
    cpapcode varchar(20),
    semester number(1),
    constraint pk_contains primary key(ccid, cpapcode, semester),
    constraint fk_ccid foreign key(ccid) references course154(cid),
    constraint fk_cpap foreign key(cpapcode) references subject154(papercode)
);

--DROP TABLE contains154 CASCADE CONSTRAINTS;

create table exam154(
    perfby_roll number(10),
    epapcode varchar(20),
    esession number(3),
    marks number(3) constraint not_null_marks not null,
    constraint pk_exam primary key(perfby_roll, epapcode, esession),
    constraint fk_perfbyroll foreign key(perfby_roll) references student154(roll_no),
    CONSTRAINT fk_epapcode FOREIGN key(epapcode) references subject154(papercode)
);

create table teaches154(
    tempid varchar(20),
    tpapcode varchar(10)    ,
    tsession number(3),
    constraint pk_teaches primary key(tempid, tpapcode, tsession),
    constraint fk_tid foreign key(tempid) references faculty154(emp_id),
    constraint fk_tpap foreign key(tpapcode) references subject154(papercode)
);
alter table student154
    add enroll_cid varchar(10) constraint not_null_ecid not null;
    
alter table student154
    add constraint fk_encid foreign key(enroll_cid) references course154(cid);

alter table student154
    add yoa number(4) constraint not_null_yoa not null;
   
alter table section154
    add studying_cid varchar(10) constraint not_null_scid not null;
    
alter table section154
    add constraint fk_scid foreign key(studying_cid) references course154(cid);




create table instructed154(
    inssecid varchar(2),
    insempid varchar(20),
    isession number(3),
    constraint pk_ins primary key(inssecid, insempid, isession),
    constraint fk_isecid foreign key(inssecid) references section154(sec_id),
    constraint fk_iempid foreign key(insempid) references faculty154(emp_id)
);

INSERT INTO course154
VALUES ('C01', 'BTECH', 'CSE', 'Dep1');

INSERT INTO course154
VALUES ('C02', 'MTECH', 'ECE', 'Dep2');

INSERT INTO course154
VALUES ('C03', 'Diploma', 'AIML', 'Dep3');

INSERT INTO course154
VALUES ('C04', 'BSC', 'IT', 'Dep4');

INSERT INTO course154
VALUES ('C05', 'MSC', 'BT', 'Dep5');


INSERT ALL
    INTO subject154 VALUES ('P01', 'DSA', 4)
    INTO subject154 VALUES ('P02', 'DAA', 3)
    INTO subject154 VALUES ('P03', 'ECE', 4)
    INTO subject154 VALUES ('P04', 'DS', 4)
    INTO subject154 VALUES ('P05', 'AI', 4)
SELECT * FROM dual;


INSERT ALL
    INTO contains154 VALUES ('C01', 'P01', 2)
    INTO contains154 VALUES ('C02', 'P02', 4)
    INTO contains154 VALUES ('C03', 'P03', 3)
    INTO contains154 VALUES ('C04', 'P04', 5)
    INTO contains154 VALUES ('C05', 'P05', 6)
SELECT * FROM dual;

insert all
into teaches154 values('E101','P01',2)
into teaches154 values('E102','P02',3)
into teaches154 values('E103','P03',3)
into teaches154 values('E104','P04',4)
into teaches154 values('E105','P05',1)
select * from dual;

insert all
into section154 values(2020,'S1','C01')
into section154 values(2021,'S2','C02')
into section154 values(2022,'S3','C03')
into section154 values(2023,'S4','C04')
into section154 values(2024,'S5','C05')
select * from dual;

insert all
into instructed154 values('S1','E101',2)
into instructed154 values('S2','E102',3)
into instructed154 values('S3','E103',3)
into instructed154 values('S4','E104',4)
into instructed154 values('S5','E105',1)
select * from dual;


INSERT ALL
    INTO student154
    (dob, mob_no, email, roll_no, sname, pincode, house_no, city, belongs_to_sec, enroll_cid, yoa)
    VALUES (TO_DATE('20-JUL-2004','DD-MON-YYYY'), 6574783824, 'mohan@gmail.com', 2251145, 'Mohan', 354627, 598, 'kolkata', 'S1', 'C01', 2022)

    INTO student154
    (dob, mob_no, email, roll_no, sname, pincode, house_no, city, belongs_to_sec, enroll_cid, yoa)
    VALUES (TO_DATE('06-JUN-2003','DD-MON-YYYY'), 6574784563, 'ram@gmail.com', 2351145, 'Ram', 354546, 521, 'howrah', 'S2', 'C02', 2023)

    INTO student154
    (dob, mob_no, email, roll_no, sname, pincode, house_no, city, belongs_to_sec, enroll_cid, yoa)
    VALUES (TO_DATE('12-JAN-2005','DD-MON-YYYY'), 657478000, 'vishal@gmail.com', 2451145, 'Vishal', 354878, 592, 'patna', 'S3', 'C03', 2024)

    INTO student154
    (dob, mob_no, email, roll_no, sname, pincode, house_no, city, belongs_to_sec, enroll_cid, yoa)
    VALUES (TO_DATE('06-OCT-2004','DD-MON-YYYY'), 6574781111, 'ramesh@gmail.com', 2551145, 'ramesh', 354000, 590, 'sasaram', 'S4', 'C04', 2025)

    INTO student154
    (dob, mob_no, email, roll_no, sname, pincode, house_no, city, belongs_to_sec, enroll_cid, yoa)
    VALUES (TO_DATE('28-JUL-2004','DD-MON-YYYY'), 6574782222, 'raghav@gmail.com', 2651145, 'raghav', 323227, 500, 'ranchi', 'S5', 'C05', 2026)

SELECT * FROM dual;


INSERT ALL
    INTO exam154 VALUES (2251145, 'P01', 2, 86)
    INTO exam154 VALUES (2351145, 'P02', 3, 88)
    INTO exam154 VALUES (2451145, 'P03', 3, 90)
    INTO exam154 VALUES (2551145, 'P04', 4, 91)
    INTO exam154 VALUES (2651145, 'P05', 1, 92)
SELECT * FROM dual;


select lt.table_name, rt.column_name, lt.constraint_name, lt.constraint_type, lt.search_condition
from user_constraints lt, user_cons_columns rt
where lt.constraint_name = rt.constraint_name
and to_char(last_change,'DD-MON-YYYY') >= '21-AUG-2026'
order by lt.table_name;




commit;
