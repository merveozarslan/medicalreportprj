CREATE DATABASE SHMS_Project;
GO

CREATE TABLE [User](
    UserName nvarchar(50) PRIMARY KEY NOT NULL, 
    UserPassword varchar(20) NOT NULL
);

CREATE TABLE Admin(
    AdminMail nvarchar(50) PRIMARY KEY NOT NULL,
    AdminPassword varchar(20) NOT NULL,
    FOREIGN KEY (AdminMail) REFERENCES [User](UserName)
);

CREATE TABLE Student(
    StudentName varchar(100) NOT NULL,
    StudentNo  varchar(100) PRIMARY KEY NOT NULL,
    StudentMail nvarchar(50) UNIQUE NOT NULL,
    StudentPassword varchar(20) NOT NULL,
    FOREIGN KEY (StudentMail) REFERENCES [User](UserName)
);

CREATE TABLE Instructor(
    InstructorName varchar(100)  PRIMARY KEY NOT NULL,
    InstructorMail nvarchar(50) UNIQUE NOT NULL,  
    InstructorPassword varchar(20) NOT NULL,
    FOREIGN KEY (InstructorMail) REFERENCES [User](UserName)
);

CREATE TABLE FacultyHead(
    FacultyHeadName varchar(100) PRIMARY KEY NOT NULL,
	FacultyHeadMail nvarchar(50) UNIQUE NOT NULL,
    FacultyHeadPassword varchar(20) NOT NULL,
    FOREIGN KEY (FacultyHeadMail) REFERENCES [User](UserName)
);

CREATE TABLE MedicalReport(
    MedicalReportId int IDENTITY(1,1) PRIMARY KEY,
    StudentNo  varchar(100) NOT NULL,
    MedicalReportDate date NOT NULL,
    MedicalReportImage varbinary(max),
    MedicalReportStatus varchar(20) NOT NULL,
    FOREIGN KEY (StudentNo) REFERENCES Student(StudentNo) 
);

CREATE TABLE Course(
    CourseCode nvarchar(15) PRIMARY KEY NOT NULL,
    CourseName varchar(50) NOT NULL,
    InstructorName varchar(100) NOT NULL,
    CourseTermYear varchar(50) NOT NULL,
    CourseStatus varchar(20) NOT NULL,
    FOREIGN KEY (InstructorName) REFERENCES Instructor(InstructorName)
);

CREATE TABLE CourseList(
    CourseCode nvarchar(15) NOT NULL,
    StudentNo  varchar(100) NOT NULL,
    FOREIGN KEY (CourseCode) REFERENCES Course(CourseCode),
    FOREIGN KEY (StudentNo) REFERENCES Student(StudentNo)
);

CREATE TABLE Disease(
    DiseaseName varchar(50) PRIMARY KEY NOT NULL,
    IsDiseaseContagious varchar(30) NOT NULL
);

CREATE TABLE MedicalReportRecord(
    MedicalReportRecordId int IDENTITY(1,1) PRIMARY KEY,
    StudentNo  varchar(100) NOT NULL,
    CourseCode nvarchar(15) NOT NULL,
    InstructorName varchar(100) NOT NULL,
    DiseaseName varchar(50) NOT NULL,
    IsDiseaseContagious varchar(30) NOT NULL,
    MedicalReportStartDate date NOT NULL,
    MedicalReportEndDate date NOT NULL,
    MedicalReportImage nvarchar(max),
    MedicalReportStatus varchar(20) NOT NULL,
    FOREIGN KEY (StudentNo) REFERENCES Student(StudentNo),
    FOREIGN KEY (CourseCode) REFERENCES Course(CourseCode),
    FOREIGN KEY (InstructorName) REFERENCES Instructor(InstructorName),
    FOREIGN KEY (DiseaseName) REFERENCES Disease(DiseaseName)
);

CREATE TABLE CourseStatusChangeRequest(
    RequestId int IDENTITY(1,1) PRIMARY KEY,
    InstructorName varchar(100) NOT NULL,
    CourseCode nvarchar(15) NOT NULL,
    RequestedStatus varchar(20) NOT NULL,
    RequestDate date NOT NULL,
    ApprovalStatus varchar(20) NOT NULL,
    FOREIGN KEY (InstructorName) REFERENCES Instructor(InstructorName),
    FOREIGN KEY (CourseCode) REFERENCES Course(CourseCode),
);
