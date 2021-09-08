/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     2020/9/22 17:28:59                           */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Contract') and o.name = 'FK_CONTRACT_RELATIONS_EMP2')
alter table Contract
   drop constraint FK_CONTRACT_RELATIONS_EMP2
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Contract') and o.name = 'FK_CONTRACT_RELATIONS_EMP3')
alter table Contract
   drop constraint FK_CONTRACT_RELATIONS_EMP3
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Contract') and o.name = 'FK_CONTRACT_RELATIONS_CUSTOMER')
alter table Contract
   drop constraint FK_CONTRACT_RELATIONS_CUSTOMER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Contract') and o.name = 'FK_CONTRACT_RELATIONS_EMP1')
alter table Contract
   drop constraint FK_CONTRACT_RELATIONS_EMP1
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Contract_Product') and o.name = 'FK_CONTRACT_RELATIONS_CONTRACT')
alter table Contract_Product
   drop constraint FK_CONTRACT_RELATIONS_CONTRACT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Contract_Product') and o.name = 'FK_CONTRACT_RELATIONS_PRODUCT')
alter table Contract_Product
   drop constraint FK_CONTRACT_RELATIONS_PRODUCT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Emp') and o.name = 'FK_EMP_RELATIONS_DEPT')
alter table Emp
   drop constraint FK_EMP_RELATIONS_DEPT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Employee_Service') and o.name = 'FK_EMPLOYEE_RELATIONS_SERVICE_')
alter table Employee_Service
   drop constraint FK_EMPLOYEE_RELATIONS_SERVICE_
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Employee_Service') and o.name = 'FK_EMPLOYEE_RELATIONS_EMP')
alter table Employee_Service
   drop constraint FK_EMPLOYEE_RELATIONS_EMP
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Payment') and o.name = 'FK_PAYMENT_RELATIONS_CONTRACT')
alter table Payment
   drop constraint FK_PAYMENT_RELATIONS_CONTRACT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Payment_Paid') and o.name = 'FK_PAYMENT__RELATIONS_PAID')
alter table Payment_Paid
   drop constraint FK_PAYMENT__RELATIONS_PAID
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Payment_Paid') and o.name = 'FK_PAYMENT__RELATIONS_PAYMENT')
alter table Payment_Paid
   drop constraint FK_PAYMENT__RELATIONS_PAYMENT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Product') and o.name = 'FK_PRODUCT_RELATIONS_VENDER')
alter table Product
   drop constraint FK_PRODUCT_RELATIONS_VENDER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Product_Service') and o.name = 'FK_PRODUCT__RELATIONS_SERVICE_')
alter table Product_Service
   drop constraint FK_PRODUCT__RELATIONS_SERVICE_
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Product_Service') and o.name = 'FK_PRODUCT__RELATIONS_CONTRACT')
alter table Product_Service
   drop constraint FK_PRODUCT__RELATIONS_CONTRACT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Service_After_Sale') and o.name = 'FK_SERVICE__RELATIONS_SERVICE_')
alter table Service_After_Sale
   drop constraint FK_SERVICE__RELATIONS_SERVICE_
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Service_After_Sale') and o.name = 'FK_SERVICE__RELATIONS_CONTRACT')
alter table Service_After_Sale
   drop constraint FK_SERVICE__RELATIONS_CONTRACT
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Contract')
            and   name  = 'Relationship_11_FK'
            and   indid > 0
            and   indid < 255)
   drop index Contract.Relationship_11_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Contract')
            and   name  = 'Relationship_10_FK'
            and   indid > 0
            and   indid < 255)
   drop index Contract.Relationship_10_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Contract')
            and   name  = 'Relationship_4_FK'
            and   indid > 0
            and   indid < 255)
   drop index Contract.Relationship_4_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Contract')
            and   name  = 'Relationship_3_FK'
            and   indid > 0
            and   indid < 255)
   drop index Contract.Relationship_3_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Contract')
            and   type = 'U')
   drop table Contract
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Contract_Product')
            and   name  = 'Relationship_6_FK'
            and   indid > 0
            and   indid < 255)
   drop index Contract_Product.Relationship_6_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Contract_Product')
            and   name  = 'Relationship_5_FK'
            and   indid > 0
            and   indid < 255)
   drop index Contract_Product.Relationship_5_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Contract_Product')
            and   type = 'U')
   drop table Contract_Product
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Customer')
            and   type = 'U')
   drop table Customer
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Dept')
            and   type = 'U')
   drop table Dept
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Emp')
            and   name  = 'Relationship_1_FK'
            and   indid > 0
            and   indid < 255)
   drop index Emp.Relationship_1_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Emp')
            and   type = 'U')
   drop table Emp
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Employee_Service')
            and   name  = 'Relationship_13_FK'
            and   indid > 0
            and   indid < 255)
   drop index Employee_Service.Relationship_13_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Employee_Service')
            and   name  = 'Relationship_12_FK'
            and   indid > 0
            and   indid < 255)
   drop index Employee_Service.Relationship_12_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Employee_Service')
            and   type = 'U')
   drop table Employee_Service
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Paid')
            and   type = 'U')
   drop table Paid
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Payment')
            and   name  = 'Relationship_7_FK'
            and   indid > 0
            and   indid < 255)
   drop index Payment.Relationship_7_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Payment')
            and   type = 'U')
   drop table Payment
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Payment_Paid')
            and   name  = 'Relationship_9_FK'
            and   indid > 0
            and   indid < 255)
   drop index Payment_Paid.Relationship_9_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Payment_Paid')
            and   name  = 'Relationship_8_FK'
            and   indid > 0
            and   indid < 255)
   drop index Payment_Paid.Relationship_8_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Payment_Paid')
            and   type = 'U')
   drop table Payment_Paid
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Product')
            and   name  = 'Relationship_2_FK'
            and   indid > 0
            and   indid < 255)
   drop index Product.Relationship_2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Product')
            and   type = 'U')
   drop table Product
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Product_Service')
            and   name  = 'Relationship_15_FK'
            and   indid > 0
            and   indid < 255)
   drop index Product_Service.Relationship_15_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Product_Service')
            and   name  = 'Relationship_14_FK'
            and   indid > 0
            and   indid < 255)
   drop index Product_Service.Relationship_14_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Product_Service')
            and   type = 'U')
   drop table Product_Service
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Service_After_Sale')
            and   name  = 'Relationship_17_FK'
            and   indid > 0
            and   indid < 255)
   drop index Service_After_Sale.Relationship_17_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Service_After_Sale')
            and   name  = 'Relationship_16_FK'
            and   indid > 0
            and   indid < 255)
   drop index Service_After_Sale.Relationship_16_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Service_After_Sale')
            and   type = 'U')
   drop table Service_After_Sale
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Vender')
            and   type = 'U')
   drop table Vender
go

/*==============================================================*/
/* Table: Contract                                              */
/*==============================================================*/
create table Contract (
   Contract_ID          int                  not null,
   Customer_ID          int                  null,
   Sale_ID              int                  not null,
   Business_ID          int                  null,
   Technical_ID         int                  null,
   Code                 char(64)             not null,
   Name                 varchar(256)         not null,
   constraint PK_CONTRACT primary key nonclustered (Contract_ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Contract') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Contract' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Contract', 
   'user', @CurrentUser, 'table', 'Contract'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Contract')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Contract_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Contract', 'column', 'Contract_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Contract_ID',
   'user', @CurrentUser, 'table', 'Contract', 'column', 'Contract_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Contract')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Customer_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Contract', 'column', 'Customer_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Customer_ID',
   'user', @CurrentUser, 'table', 'Contract', 'column', 'Customer_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Contract')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Sale_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Contract', 'column', 'Sale_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Sale_ID',
   'user', @CurrentUser, 'table', 'Contract', 'column', 'Sale_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Contract')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Business_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Contract', 'column', 'Business_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Business_ID',
   'user', @CurrentUser, 'table', 'Contract', 'column', 'Business_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Contract')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Technical_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Contract', 'column', 'Technical_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Technical_ID',
   'user', @CurrentUser, 'table', 'Contract', 'column', 'Technical_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Contract')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Code')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Contract', 'column', 'Code'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Code',
   'user', @CurrentUser, 'table', 'Contract', 'column', 'Code'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Contract')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Contract', 'column', 'Name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Name',
   'user', @CurrentUser, 'table', 'Contract', 'column', 'Name'
go

/*==============================================================*/
/* Index: Relationship_3_FK                                     */
/*==============================================================*/
create index Relationship_3_FK on Contract (
Customer_ID ASC
)
go

/*==============================================================*/
/* Index: Relationship_4_FK                                     */
/*==============================================================*/
create index Relationship_4_FK on Contract (
Sale_ID ASC
)
go

/*==============================================================*/
/* Index: Relationship_10_FK                                    */
/*==============================================================*/
create index Relationship_10_FK on Contract (
Business_ID ASC
)
go

/*==============================================================*/
/* Index: Relationship_11_FK                                    */
/*==============================================================*/
create index Relationship_11_FK on Contract (
Technical_ID ASC
)
go

/*==============================================================*/
/* Table: Contract_Product                                      */
/*==============================================================*/
create table Contract_Product (
   Contract_ID          int                  not null,
   Product_ID           int                  not null,
   Amount               int                  not null,
   Price                numeric              not null,
   Discount             numeric              not null,
   Service_Deadline     datetime             not null,
   constraint PK_CONTRACT_PRODUCT primary key nonclustered (Contract_ID, Product_ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Contract_Product') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Contract_Product' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Contract_Product', 
   'user', @CurrentUser, 'table', 'Contract_Product'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Contract_Product')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Contract_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Contract_Product', 'column', 'Contract_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Contract_ID',
   'user', @CurrentUser, 'table', 'Contract_Product', 'column', 'Contract_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Contract_Product')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Product_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Contract_Product', 'column', 'Product_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Product_ID',
   'user', @CurrentUser, 'table', 'Contract_Product', 'column', 'Product_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Contract_Product')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Amount')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Contract_Product', 'column', 'Amount'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Amount',
   'user', @CurrentUser, 'table', 'Contract_Product', 'column', 'Amount'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Contract_Product')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Price')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Contract_Product', 'column', 'Price'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Price',
   'user', @CurrentUser, 'table', 'Contract_Product', 'column', 'Price'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Contract_Product')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Discount')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Contract_Product', 'column', 'Discount'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Discount',
   'user', @CurrentUser, 'table', 'Contract_Product', 'column', 'Discount'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Contract_Product')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Service_Deadline')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Contract_Product', 'column', 'Service_Deadline'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Service_Deadline',
   'user', @CurrentUser, 'table', 'Contract_Product', 'column', 'Service_Deadline'
go

/*==============================================================*/
/* Index: Relationship_5_FK                                     */
/*==============================================================*/
create index Relationship_5_FK on Contract_Product (
Contract_ID ASC
)
go

/*==============================================================*/
/* Index: Relationship_6_FK                                     */
/*==============================================================*/
create index Relationship_6_FK on Contract_Product (
Product_ID ASC
)
go

/*==============================================================*/
/* Table: Customer                                              */
/*==============================================================*/
create table Customer (
   Customer_ID          int                  not null,
   Name                 varchar(128)         not null,
   constraint PK_CUSTOMER primary key nonclustered (Customer_ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Customer') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Customer' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Customer', 
   'user', @CurrentUser, 'table', 'Customer'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Customer')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Customer_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Customer', 'column', 'Customer_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Customer_ID',
   'user', @CurrentUser, 'table', 'Customer', 'column', 'Customer_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Customer')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Customer', 'column', 'Name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Name',
   'user', @CurrentUser, 'table', 'Customer', 'column', 'Name'
go

/*==============================================================*/
/* Table: Dept                                                  */
/*==============================================================*/
create table Dept (
   Dept_ID              int                  not null,
   Name                 varchar(128)         not null,
   Phone                char(11)             null,
   constraint PK_DEPT primary key nonclustered (Dept_ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Dept') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Dept' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Dept', 
   'user', @CurrentUser, 'table', 'Dept'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Dept')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Dept_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Dept', 'column', 'Dept_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Dept_ID',
   'user', @CurrentUser, 'table', 'Dept', 'column', 'Dept_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Dept')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Dept', 'column', 'Name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Name',
   'user', @CurrentUser, 'table', 'Dept', 'column', 'Name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Dept')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Phone')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Dept', 'column', 'Phone'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Phone',
   'user', @CurrentUser, 'table', 'Dept', 'column', 'Phone'
go

/*==============================================================*/
/* Table: Emp                                                   */
/*==============================================================*/
create table Emp (
   Emp_ID               int                  not null,
   Dept_ID              int                  not null,
   Name                 varchar(64)          not null,
   constraint PK_EMP primary key nonclustered (Emp_ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Emp') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Emp' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Emp', 
   'user', @CurrentUser, 'table', 'Emp'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Emp')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Emp_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Emp', 'column', 'Emp_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Emp_ID',
   'user', @CurrentUser, 'table', 'Emp', 'column', 'Emp_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Emp')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Dept_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Emp', 'column', 'Dept_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Dept_ID',
   'user', @CurrentUser, 'table', 'Emp', 'column', 'Dept_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Emp')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Emp', 'column', 'Name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Name',
   'user', @CurrentUser, 'table', 'Emp', 'column', 'Name'
go

/*==============================================================*/
/* Index: Relationship_1_FK                                     */
/*==============================================================*/
create index Relationship_1_FK on Emp (
Dept_ID ASC
)
go

/*==============================================================*/
/* Table: Employee_Service                                      */
/*==============================================================*/
create table Employee_Service (
   Service_ID           int                  not null,
   Emp_ID               int                  not null,
   constraint PK_EMPLOYEE_SERVICE primary key nonclustered (Service_ID, Emp_ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Employee_Service') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Employee_Service' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Employee_Service', 
   'user', @CurrentUser, 'table', 'Employee_Service'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Employee_Service')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Service_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Employee_Service', 'column', 'Service_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Service_ID',
   'user', @CurrentUser, 'table', 'Employee_Service', 'column', 'Service_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Employee_Service')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Emp_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Employee_Service', 'column', 'Emp_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Emp_ID',
   'user', @CurrentUser, 'table', 'Employee_Service', 'column', 'Emp_ID'
go

/*==============================================================*/
/* Index: Relationship_12_FK                                    */
/*==============================================================*/
create index Relationship_12_FK on Employee_Service (
Service_ID ASC
)
go

/*==============================================================*/
/* Index: Relationship_13_FK                                    */
/*==============================================================*/
create index Relationship_13_FK on Employee_Service (
Emp_ID ASC
)
go

/*==============================================================*/
/* Table: Paid                                                  */
/*==============================================================*/
create table Paid (
   Paid_ID              int                  not null,
   Amount               numeric              not null,
   Paid_date            datetime             not null,
   constraint PK_PAID primary key nonclustered (Paid_ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Paid') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Paid' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Paid', 
   'user', @CurrentUser, 'table', 'Paid'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Paid')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Paid_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Paid', 'column', 'Paid_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Paid_ID',
   'user', @CurrentUser, 'table', 'Paid', 'column', 'Paid_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Paid')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Amount')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Paid', 'column', 'Amount'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Amount',
   'user', @CurrentUser, 'table', 'Paid', 'column', 'Amount'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Paid')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Paid_date')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Paid', 'column', 'Paid_date'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Paid_date',
   'user', @CurrentUser, 'table', 'Paid', 'column', 'Paid_date'
go

/*==============================================================*/
/* Table: Payment                                               */
/*==============================================================*/
create table Payment (
   Payment_ID           int                  not null,
   Contract_ID          int                  not null,
   Amount               numeric              not null,
   Payment_Date         datetime             not null,
   constraint PK_PAYMENT primary key nonclustered (Payment_ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Payment') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Payment' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Payment', 
   'user', @CurrentUser, 'table', 'Payment'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Payment')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Payment_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Payment', 'column', 'Payment_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Payment_ID',
   'user', @CurrentUser, 'table', 'Payment', 'column', 'Payment_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Payment')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Contract_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Payment', 'column', 'Contract_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Contract_ID',
   'user', @CurrentUser, 'table', 'Payment', 'column', 'Contract_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Payment')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Amount')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Payment', 'column', 'Amount'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Amount',
   'user', @CurrentUser, 'table', 'Payment', 'column', 'Amount'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Payment')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Payment_Date')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Payment', 'column', 'Payment_Date'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Payment_Date',
   'user', @CurrentUser, 'table', 'Payment', 'column', 'Payment_Date'
go

/*==============================================================*/
/* Index: Relationship_7_FK                                     */
/*==============================================================*/
create index Relationship_7_FK on Payment (
Contract_ID ASC
)
go

/*==============================================================*/
/* Table: Payment_Paid                                          */
/*==============================================================*/
create table Payment_Paid (
   Paid_ID              int                  not null,
   Payment_ID           int                  not null,
   constraint PK_PAYMENT_PAID primary key nonclustered (Paid_ID, Payment_ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Payment_Paid') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Payment_Paid' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Payment_Paid', 
   'user', @CurrentUser, 'table', 'Payment_Paid'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Payment_Paid')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Paid_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Payment_Paid', 'column', 'Paid_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Paid_ID',
   'user', @CurrentUser, 'table', 'Payment_Paid', 'column', 'Paid_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Payment_Paid')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Payment_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Payment_Paid', 'column', 'Payment_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Payment_ID',
   'user', @CurrentUser, 'table', 'Payment_Paid', 'column', 'Payment_ID'
go

/*==============================================================*/
/* Index: Relationship_8_FK                                     */
/*==============================================================*/
create index Relationship_8_FK on Payment_Paid (
Paid_ID ASC
)
go

/*==============================================================*/
/* Index: Relationship_9_FK                                     */
/*==============================================================*/
create index Relationship_9_FK on Payment_Paid (
Payment_ID ASC
)
go

/*==============================================================*/
/* Table: Product                                               */
/*==============================================================*/
create table Product (
   Product_ID           int                  not null,
   Vender_ID            int                  not null,
   Name                 varchar(128)         not null,
   Price                numeric              not null,
   constraint PK_PRODUCT primary key nonclustered (Product_ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Product') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Product' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Product', 
   'user', @CurrentUser, 'table', 'Product'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Product')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Product_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Product', 'column', 'Product_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Product_ID',
   'user', @CurrentUser, 'table', 'Product', 'column', 'Product_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Product')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Vender_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Product', 'column', 'Vender_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Vender_ID',
   'user', @CurrentUser, 'table', 'Product', 'column', 'Vender_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Product')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Product', 'column', 'Name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Name',
   'user', @CurrentUser, 'table', 'Product', 'column', 'Name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Product')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Price')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Product', 'column', 'Price'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Price',
   'user', @CurrentUser, 'table', 'Product', 'column', 'Price'
go

/*==============================================================*/
/* Index: Relationship_2_FK                                     */
/*==============================================================*/
create index Relationship_2_FK on Product (
Vender_ID ASC
)
go

/*==============================================================*/
/* Table: Product_Service                                       */
/*==============================================================*/
create table Product_Service (
   Service_ID           int                  not null,
   Contract_ID          int                  not null,
   Product_ID           int                  not null,
   constraint PK_PRODUCT_SERVICE primary key nonclustered (Service_ID, Contract_ID, Product_ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Product_Service') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Product_Service' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Product_Service', 
   'user', @CurrentUser, 'table', 'Product_Service'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Product_Service')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Service_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Product_Service', 'column', 'Service_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Service_ID',
   'user', @CurrentUser, 'table', 'Product_Service', 'column', 'Service_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Product_Service')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Contract_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Product_Service', 'column', 'Contract_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Contract_ID',
   'user', @CurrentUser, 'table', 'Product_Service', 'column', 'Contract_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Product_Service')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Product_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Product_Service', 'column', 'Product_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Product_ID',
   'user', @CurrentUser, 'table', 'Product_Service', 'column', 'Product_ID'
go

/*==============================================================*/
/* Index: Relationship_14_FK                                    */
/*==============================================================*/
create index Relationship_14_FK on Product_Service (
Service_ID ASC
)
go

/*==============================================================*/
/* Index: Relationship_15_FK                                    */
/*==============================================================*/
create index Relationship_15_FK on Product_Service (
Contract_ID ASC,
Product_ID ASC
)
go

/*==============================================================*/
/* Table: Service_After_Sale                                    */
/*==============================================================*/
create table Service_After_Sale (
   Service_ID           int                  not null,
   Parent_Service_ID    int                  null,
   Contract_ID          int                  not null,
   Service_Begin_Date   datetime             not null,
   Service_End_Date     datetime             not null,
   Service_Type         char(16)             not null,
   Service_Detail       varchar(256)         null,
   Contact_Name         varchar(64)          not null,
   Contact_Phone        char(11)             not null,
   constraint PK_SERVICE_AFTER_SALE primary key nonclustered (Service_ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Service_After_Sale') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Service_After_Sale' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Service_After_Sale', 
   'user', @CurrentUser, 'table', 'Service_After_Sale'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Service_After_Sale')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Service_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Service_After_Sale', 'column', 'Service_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Service_ID',
   'user', @CurrentUser, 'table', 'Service_After_Sale', 'column', 'Service_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Service_After_Sale')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Parent_Service_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Service_After_Sale', 'column', 'Parent_Service_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Parent_Service_ID',
   'user', @CurrentUser, 'table', 'Service_After_Sale', 'column', 'Parent_Service_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Service_After_Sale')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Contract_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Service_After_Sale', 'column', 'Contract_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Contract_ID',
   'user', @CurrentUser, 'table', 'Service_After_Sale', 'column', 'Contract_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Service_After_Sale')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Service_Begin_Date')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Service_After_Sale', 'column', 'Service_Begin_Date'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Service_Begin_Date',
   'user', @CurrentUser, 'table', 'Service_After_Sale', 'column', 'Service_Begin_Date'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Service_After_Sale')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Service_End_Date')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Service_After_Sale', 'column', 'Service_End_Date'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Service_End_Date',
   'user', @CurrentUser, 'table', 'Service_After_Sale', 'column', 'Service_End_Date'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Service_After_Sale')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Service_Type')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Service_After_Sale', 'column', 'Service_Type'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Service_Type',
   'user', @CurrentUser, 'table', 'Service_After_Sale', 'column', 'Service_Type'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Service_After_Sale')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Service_Detail')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Service_After_Sale', 'column', 'Service_Detail'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Service_Detail',
   'user', @CurrentUser, 'table', 'Service_After_Sale', 'column', 'Service_Detail'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Service_After_Sale')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Contact_Name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Service_After_Sale', 'column', 'Contact_Name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Contact_Name',
   'user', @CurrentUser, 'table', 'Service_After_Sale', 'column', 'Contact_Name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Service_After_Sale')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Contact_Phone')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Service_After_Sale', 'column', 'Contact_Phone'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Contact_Phone',
   'user', @CurrentUser, 'table', 'Service_After_Sale', 'column', 'Contact_Phone'
go

/*==============================================================*/
/* Index: Relationship_16_FK                                    */
/*==============================================================*/
create index Relationship_16_FK on Service_After_Sale (
Parent_Service_ID ASC
)
go

/*==============================================================*/
/* Index: Relationship_17_FK                                    */
/*==============================================================*/
create index Relationship_17_FK on Service_After_Sale (
Contract_ID ASC
)
go

/*==============================================================*/
/* Table: Vender                                                */
/*==============================================================*/
create table Vender (
   Vender_ID            int                  not null,
   Name                 varchar(128)         not null,
   constraint PK_VENDER primary key nonclustered (Vender_ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Vender') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Vender' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Vender', 
   'user', @CurrentUser, 'table', 'Vender'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Vender')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Vender_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Vender', 'column', 'Vender_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Vender_ID',
   'user', @CurrentUser, 'table', 'Vender', 'column', 'Vender_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Vender')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Vender', 'column', 'Name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Name',
   'user', @CurrentUser, 'table', 'Vender', 'column', 'Name'
go

alter table Contract
   add constraint FK_CONTRACT_RELATIONS_EMP2 foreign key (Business_ID)
      references Emp (Emp_ID)
go

alter table Contract
   add constraint FK_CONTRACT_RELATIONS_EMP3 foreign key (Technical_ID)
      references Emp (Emp_ID)
go

alter table Contract
   add constraint FK_CONTRACT_RELATIONS_CUSTOMER foreign key (Customer_ID)
      references Customer (Customer_ID)
go

alter table Contract
   add constraint FK_CONTRACT_RELATIONS_EMP1 foreign key (Sale_ID)
      references Emp (Emp_ID)
go

alter table Contract_Product
   add constraint FK_CONTRACT_RELATIONS_CONTRACT foreign key (Contract_ID)
      references Contract (Contract_ID)
go

alter table Contract_Product
   add constraint FK_CONTRACT_RELATIONS_PRODUCT foreign key (Product_ID)
      references Product (Product_ID)
go

alter table Emp
   add constraint FK_EMP_RELATIONS_DEPT foreign key (Dept_ID)
      references Dept (Dept_ID)
go

alter table Employee_Service
   add constraint FK_EMPLOYEE_RELATIONS_SERVICE_ foreign key (Service_ID)
      references Service_After_Sale (Service_ID)
go

alter table Employee_Service
   add constraint FK_EMPLOYEE_RELATIONS_EMP foreign key (Emp_ID)
      references Emp (Emp_ID)
go

alter table Payment
   add constraint FK_PAYMENT_RELATIONS_CONTRACT foreign key (Contract_ID)
      references Contract (Contract_ID)
go

alter table Payment_Paid
   add constraint FK_PAYMENT__RELATIONS_PAID foreign key (Paid_ID)
      references Paid (Paid_ID)
go

alter table Payment_Paid
   add constraint FK_PAYMENT__RELATIONS_PAYMENT foreign key (Payment_ID)
      references Payment (Payment_ID)
go

alter table Product
   add constraint FK_PRODUCT_RELATIONS_VENDER foreign key (Vender_ID)
      references Vender (Vender_ID)
go

alter table Product_Service
   add constraint FK_PRODUCT__RELATIONS_SERVICE_ foreign key (Service_ID)
      references Service_After_Sale (Service_ID)
go

alter table Product_Service
   add constraint FK_PRODUCT__RELATIONS_CONTRACT foreign key (Contract_ID, Product_ID)
      references Contract_Product (Contract_ID, Product_ID)
go

alter table Service_After_Sale
   add constraint FK_SERVICE__RELATIONS_SERVICE_ foreign key (Parent_Service_ID)
      references Service_After_Sale (Service_ID)
go

alter table Service_After_Sale
   add constraint FK_SERVICE__RELATIONS_CONTRACT foreign key (Contract_ID)
      references Contract (Contract_ID)
go

