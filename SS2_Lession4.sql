use ss2_Lession3;

drop table if exists Enrollment;
drop table if exists Subject;
drop table if exists Student;
drop table if exists Teacher;

create table Student(
	StudentId int primary key,
    FullName varchar(20) not null
);

create table Teacher(
	TeacherId int primary key,
    FullName varchar(30) not null,
    Email varchar(30) unique
);

create table Subject(
	SubjectId int primary key,
    SubjectName varchar(50) not null,
    Credit int not null,
    TeacherId int not null,
    constraint checkCredit check(Credit > 0),
    constraint FK_Subject_Teacher foreign key (TeacherId)
		references Teacher(TeacherId)
        on update cascade
        on delete restrict
);

create table Enrollment(
	StudentId int not null,
    SubjectId int not null,
    EnrollmentDate Date not null,
    primary key (StudentId, SubjectId),
    constraint FK_Enrollment_Student foreign key (StudentId)
		references Student(StudentId)
        on update restrict
        on delete cascade,
	constraint FK_Enrollment_Subject foreign key (SubjectId)
		references Subject(SubjectId)
        on update restrict
        on delete cascade
);