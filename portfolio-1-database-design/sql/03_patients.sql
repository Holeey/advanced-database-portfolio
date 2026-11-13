-- =====================================================
-- CLINIX DIAGNOSTICS HOSPITAL MANAGEMENT SYSTEM
-- Portfolio 1: Database Design and Modelling
-- File: 03_patients.sql
-- Description: Creates and populates the Patients table
-- =====================================================

CREATE TABLE patients (
    patient_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(20) NOT NULL
        CHECK (gender IN ('Male', 'Female')),
    phone_number VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    address VARCHAR(255),
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE
);

-- Insert fictional patient records

INSERT INTO patients
(first_name, last_name, date_of_birth, gender,
 phone_number, email, address)
VALUES
('John', 'Okafor', '1990-05-12', 'Male',
 '08060000001', 'john@gmail.test', 'Ikeja, Lagos'),

('Mary', 'Adeyemi', '1985-09-20', 'Female',
 '08060000002', 'mary@gmail.test', 'Yaba, Lagos'),

('David', 'Bello', '2000-03-15', 'Male',
 '08060000003', NULL, 'Surulere, Lagos'),

('Grace', 'Okoro', '1995-11-08', 'Female',
 '08060000004', 'grace@gmail.test', 'Lekki, Lagos'),

('Peter', 'Musa', '1978-07-25', 'Male',
 '08060000005', NULL, 'Egbeda, Lagos');

-- Retrieve patient records

SELECT * FROM patients;