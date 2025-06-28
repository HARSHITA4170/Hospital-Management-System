CREATE DATABASE HMS;
USE HMS;

CREATE TABLE Patient(
    Patient_ID INT NOT NULL PRIMARY KEY,
    Patient_email VARCHAR(50) UNIQUE,
    Patient_name VARCHAR(50) NOT NULL,
    password VARCHAR(30) NOT NULL,
    Patient_address VARCHAR(60) NOT NULL,
    Patient_gender VARCHAR(20) NOT NULL
);

CREATE TABLE MedicalHistory(
    Record_ID INT NOT NULL PRIMARY KEY, 
    Patient_ID INT NOT NULL,
    Allergies VARCHAR(50), 
    Pre_Conditions VARCHAR(50), 
    surgeries VARCHAR(100) NOT NULL, 
    medication VARCHAR(100) NOT NULL,
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID)
);

CREATE TABLE Doctor(
    Doctor_ID INT NOT NULL PRIMARY KEY,
    Doctor_email VARCHAR(50) UNIQUE,
    Doctor_name VARCHAR(50) NOT NULL,
    password VARCHAR(30) NOT NULL,
    gender VARCHAR(20) NOT NULL,
    Qualifications VARCHAR(15) NOT NULL,
    Area_Of_Expertise VARCHAR(20) NOT NULL
);

CREATE TABLE Appointment(
    Appt_ID INT NOT NULL PRIMARY KEY,
    date DATE NOT NULL,
    starttime TIME NOT NULL,
    endtime TIME NOT NULL,
    Doctor_ID INT NOT NULL, 
    Patient_ID INT NOT NULL,
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor (Doctor_ID), 
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID)
);

CREATE TABLE PatientsAttendedAppointments(
    patient_email VARCHAR(50) NOT NULL,
    appt INT NOT NULL,
    concerns VARCHAR(40) NOT NULL,
    symptoms VARCHAR(40) NOT NULL,
    PRIMARY KEY (patient_email, appt),
    FOREIGN KEY (patient_email) REFERENCES Patient (Patient_email) ON DELETE CASCADE,
    FOREIGN KEY (appt) REFERENCES Appointment (Appt_ID) ON DELETE CASCADE
);
CREATE TABLE Schedule(
    id INT NOT NULL,
    starttime TIME NOT NULL,
    endtime TIME NOT NULL,
    breaktime TIME NOT NULL,
    day VARCHAR(20) NOT NULL,
    PRIMARY KEY (id, starttime, endtime, breaktime, day)
);

CREATE TABLE PatientsFillHistory(
    patient_email VARCHAR(50) NOT NULL,
    history_id INT NOT NULL,
    PRIMARY KEY (patient_email, history_id),
    FOREIGN KEY (patient_email) REFERENCES Patient (Patient_email) ON DELETE CASCADE,
    FOREIGN KEY (history_id) REFERENCES MedicalHistory (Record_ID) ON DELETE CASCADE
);

CREATE TABLE Diagnose(
    appt INT NOT NULL,
    doctor_id INT NOT NULL,
    diagnosis VARCHAR(100) NOT NULL,
    prescription VARCHAR(100),
    PRIMARY KEY (appt, doctor_id),
    FOREIGN KEY (appt) REFERENCES Appointment (Appt_ID),
    FOREIGN KEY (doctor_id) REFERENCES Doctor (Doctor_ID)
);


CREATE TABLE Department(
    Dept_ID INT NOT NULL PRIMARY KEY,
    Dept_Name VARCHAR(50) NOT NULL UNIQUE,
    Location VARCHAR(50) NOT NULL
);


CREATE TABLE Nurse(
    Nurse_ID INT NOT NULL PRIMARY KEY,
    Nurse_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES Department(Dept_ID)
);


CREATE TABLE Treatment(
    Treatment_ID INT NOT NULL PRIMARY KEY,
    Appt_ID INT NOT NULL,
    Treatment_Desc VARCHAR(100) NOT NULL,
    Cost DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Appt_ID) REFERENCES Appointment(Appt_ID)
);

CREATE TABLE Pharmacy(
    Medicine_ID INT NOT NULL PRIMARY KEY,
    Medicine_Name VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    Expiry_Date DATE NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);

CREATE TABLE Billing(
    Bill_ID INT NOT NULL PRIMARY KEY,
    Patient_ID INT NOT NULL,
    Appt_ID INT NOT NULL,
    Treatment_ID INT,
    Amount DECIMAL(10,2) NOT NULL,
    Billing_Date DATE NOT NULL,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Appt_ID) REFERENCES Appointment(Appt_ID),
    FOREIGN KEY (Treatment_ID) REFERENCES Treatment(Treatment_ID)
);
