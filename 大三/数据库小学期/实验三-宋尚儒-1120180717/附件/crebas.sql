/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     2020/9/25 11:37:37                           */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Class') and o.name = 'FK_CLASS_RELATIONS_COURSE')
alter table Class
   drop constraint FK_CLASS_RELATIONS_COURSE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Class') and o.name = 'FK_CLASS_RELATIONS_TEACHER')
alter table Class
   drop constraint FK_CLASS_RELATIONS_TEACHER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Selected_Class') and o.name = 'FK_SELECTED_RELATIONS_STUDENT')
alter table Selected_Class
   drop constraint FK_SELECTED_RELATIONS_STUDENT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Selected_Class') and o.name = 'FK_SELECTED_RELATIONS_CLASS')
alter table Selected_Class
   drop constraint FK_SELECTED_RELATIONS_CLASS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Submited') and o.name = 'FK_SUBMITED_RELATIONS_STUDENT')
alter table Submited
   drop constraint FK_SUBMITED_RELATIONS_STUDENT
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Class')
            and   name  = 'Relationship_4_FK'
            and   indid > 0
            and   indid < 255)
   drop index Class.Relationship_4_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Class')
            and   name  = 'Relationship_2_FK'
            and   indid > 0
            and   indid < 255)
   drop index Class.Relationship_2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Class')
            and   type = 'U')
   drop table Class
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Course')
            and   type = 'U')
   drop table Course
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Selected_Class')
            and   name  = 'Relationship_6_FK'
            and   indid > 0
            and   indid < 255)
   drop index Selected_Class.Relationship_6_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Selected_Class')
            and   name  = 'Relationship_5_FK'
            and   indid > 0
            and   indid < 255)
   drop index Selected_Class.Relationship_5_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Selected_Class')
            and   type = 'U')
   drop table Selected_Class
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Student')
            and   type = 'U')
   drop table Student
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Submited')
            and   type = 'U')
   drop table Submited
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Teacher')
            and   type = 'U')
   drop table Teacher
go

/*==============================================================*/
/* Table: Class                                                 */
/*==============================================================*/
create table Class (
   Class_ID             int                  not null,
   Course_ID            int                  not null,
   Teacher_ID           int                  not null,
   Time                 varchar(256)         null,
   constraint PK_CLASS primary key nonclustered (Class_ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Class') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Class' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Class', 
   'user', @CurrentUser, 'table', 'Class'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Class')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Class_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Class', 'column', 'Class_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Class_ID',
   'user', @CurrentUser, 'table', 'Class', 'column', 'Class_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Class')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Course_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Class', 'column', 'Course_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Course_ID',
   'user', @CurrentUser, 'table', 'Class', 'column', 'Course_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Class')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Teacher_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Class', 'column', 'Teacher_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Teacher_ID',
   'user', @CurrentUser, 'table', 'Class', 'column', 'Teacher_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Class')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Time')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Class', 'column', 'Time'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Time',
   'user', @CurrentUser, 'table', 'Class', 'column', 'Time'
go

/*==============================================================*/
/* Index: Relationship_2_FK                                     */
/*==============================================================*/
create index Relationship_2_FK on Class (
Course_ID ASC
)
go

/*==============================================================*/
/* Index: Relationship_4_FK                                     */
/*==============================================================*/
create index Relationship_4_FK on Class (
Teacher_ID ASC
)
go

/*==============================================================*/
/* Table: Course                                                */
/*==============================================================*/
create table Course (
   Course_ID            int                  not null,
   Name                 varchar(64)          not null,
   Credit               int                  not null,
   constraint PK_COURSE primary key nonclustered (Course_ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Course') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Course' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Course', 
   'user', @CurrentUser, 'table', 'Course'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Course')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Course_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Course', 'column', 'Course_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Course_ID',
   'user', @CurrentUser, 'table', 'Course', 'column', 'Course_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Course')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Course', 'column', 'Name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Name',
   'user', @CurrentUser, 'table', 'Course', 'column', 'Name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Course')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Credit')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Course', 'column', 'Credit'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Credit',
   'user', @CurrentUser, 'table', 'Course', 'column', 'Credit'
go

/*==============================================================*/
/* Table: Selected_Class                                        */
/*==============================================================*/
create table Selected_Class (
   Student_ID           int                  not null,
   Class_ID             int                  not null,
   constraint PK_SELECTED_CLASS primary key nonclustered (Student_ID, Class_ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Selected_Class') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Selected_Class' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Selected_Class', 
   'user', @CurrentUser, 'table', 'Selected_Class'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Selected_Class')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Student_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Selected_Class', 'column', 'Student_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Student_ID',
   'user', @CurrentUser, 'table', 'Selected_Class', 'column', 'Student_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Selected_Class')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Class_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Selected_Class', 'column', 'Class_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Class_ID',
   'user', @CurrentUser, 'table', 'Selected_Class', 'column', 'Class_ID'
go

/*==============================================================*/
/* Index: Relationship_5_FK                                     */
/*==============================================================*/
create index Relationship_5_FK on Selected_Class (
Student_ID ASC
)
go

/*==============================================================*/
/* Index: Relationship_6_FK                                     */
/*==============================================================*/
create index Relationship_6_FK on Selected_Class (
Class_ID ASC
)
go

/*==============================================================*/
/* Table: Student                                               */
/*==============================================================*/
create table Student (
   Student_ID           int                  not null,
   Name                 varchar(64)          not null,
   constraint PK_STUDENT primary key nonclustered (Student_ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Student') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Student' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Student', 
   'user', @CurrentUser, 'table', 'Student'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Student')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Student_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Student', 'column', 'Student_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Student_ID',
   'user', @CurrentUser, 'table', 'Student', 'column', 'Student_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Student')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Student', 'column', 'Name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Name',
   'user', @CurrentUser, 'table', 'Student', 'column', 'Name'
go

/*==============================================================*/
/* Table: Submited                                              */
/*==============================================================*/
create table Submited (
   Student_ID           int                  not null,
   constraint PK_SUBMITED primary key nonclustered (Student_ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Submited') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Submited' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Submited', 
   'user', @CurrentUser, 'table', 'Submited'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Submited')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Student_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Submited', 'column', 'Student_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Student_ID',
   'user', @CurrentUser, 'table', 'Submited', 'column', 'Student_ID'
go

/*==============================================================*/
/* Table: Teacher                                               */
/*==============================================================*/
create table Teacher (
   Teacher_ID           int                  not null,
   Name                 varchar(64)          not null,
   constraint PK_TEACHER primary key nonclustered (Teacher_ID)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Teacher') and minor_id = 0)
begin 
   declare @CurrentUser sysname 
select @CurrentUser = user_name() 
execute sp_dropextendedproperty 'MS_Description',  
   'user', @CurrentUser, 'table', 'Teacher' 
 
end 


select @CurrentUser = user_name() 
execute sp_addextendedproperty 'MS_Description',  
   'Teacher', 
   'user', @CurrentUser, 'table', 'Teacher'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Teacher')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Teacher_ID')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Teacher', 'column', 'Teacher_ID'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Teacher_ID',
   'user', @CurrentUser, 'table', 'Teacher', 'column', 'Teacher_ID'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Teacher')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_dropextendedproperty 'MS_Description', 
   'user', @CurrentUser, 'table', 'Teacher', 'column', 'Name'

end


select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Name',
   'user', @CurrentUser, 'table', 'Teacher', 'column', 'Name'
go

alter table Class
   add constraint FK_CLASS_RELATIONS_COURSE foreign key (Course_ID)
      references Course (Course_ID)
go

alter table Class
   add constraint FK_CLASS_RELATIONS_TEACHER foreign key (Teacher_ID)
      references Teacher (Teacher_ID)
go

alter table Selected_Class
   add constraint FK_SELECTED_RELATIONS_STUDENT foreign key (Student_ID)
      references Student (Student_ID)
go

alter table Selected_Class
   add constraint FK_SELECTED_RELATIONS_CLASS foreign key (Class_ID)
      references Class (Class_ID)
go

alter table Submited
   add constraint FK_SUBMITED_RELATIONS_STUDENT foreign key (Student_ID)
      references Student (Student_ID)
go

