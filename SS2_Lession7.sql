drop database if exists VPBank_Rikkei;
create database VPBank_Rikkei;
use VPBank_Rikkei;

create table Partner(
    PartnerId int primary key auto_increment,
    PartnerName varchar(100) not null,
    PartnerCode varchar(20) not null unique,
    Email varchar(100) not null,
    Phone varchar(15) not null,
    Address varchar(200),
    CreatedDate timestamp default current_timestamp
);

create table Customer(
    CustomerId int primary key auto_increment,
    FullName varchar(100) not null,
    IdentityCard varchar(12) not null unique,
    DateOfBirth date not null,
    Phone varchar(15) not null unique,
    Email varchar(100),
    Address varchar(200),
    CreatedDate timestamp default current_timestamp
);

-- Bảng 3: Tài khoản (Account)
create table Account(
    AccountId int primary key auto_increment,
    CustomerId int not null,
    AccountNumber varchar(20) not null unique,
    Balance decimal(15,2) not null default 0,
    Status varchar(20) default 'Active',
    OpenedDate timestamp default current_timestamp,
    
    constraint FK_Account_Customer foreign key (CustomerId)
        references Customer(CustomerId)
        on update cascade
        on delete restrict,
    
    constraint CK_Balance check (Balance >= 0)
);

create table TuitionBill(
    BillId int primary key auto_increment,
    PartnerId int not null,
    BillCode varchar(50) not null unique,
    StudentCode varchar(20) not null,
    StudentName varchar(100) not null,
    CourseName varchar(100) not null,
    Amount decimal(15,2) not null,
    DueDate date not null,
    Status varchar(20) default 'Unpaid',
    CreatedDate timestamp default current_timestamp,
    
    constraint FK_Bill_Partner foreign key (PartnerId)
        references Partner(PartnerId)
        on update cascade
        on delete restrict,
    
    constraint CK_Amount check (Amount > 0)
);

create table Transaction(
    TransactionId int primary key auto_increment,
    AccountId int not null,
    BillId int not null,
    TransactionCode varchar(50) not null unique,
    Amount decimal(15,2) not null,
    Status varchar(20) default 'Pending',
    Description varchar(255),
    CreatedDate timestamp default current_timestamp,
    
    constraint FK_Transaction_Account foreign key (AccountId)
        references Account(AccountId)
        on update cascade
        on delete restrict,
    
    constraint FK_Transaction_Bill foreign key (BillId)
        references TuitionBill(BillId)
        on update cascade
        on delete restrict,
    
    constraint CK_TransactionAmount check (Amount > 0)
);