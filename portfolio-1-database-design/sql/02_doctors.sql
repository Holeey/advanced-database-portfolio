-- =====================================================
-- CLINIX DIAGNOSTICS HOSPITAL MANAGEMENT SYSTEM
-- Portfolio 1: Database Design and Modelling
-- File: 02_doctors.sql
-- Description: Creates and populates the Doctors table
-- =====================================================

CREATE TABLE doctors (
    doctor_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100),
    phone_number VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    department_id INT NOT NULL,

    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

-- Insert fictional doctors

INSERT INTO doctors
(first_name, last_name, specialization, phone_number, email, department_id)
VALUES
('James', 'Okafor', 'Cardiologist', '08011111111', 'james@clinix.test', 1),
('Sarah', 'Adeyemi', 'Cardiologist', '08022222222', 'sarah@clinix.test', 1),
('Peter', 'Bello', 'General Surgeon', '08033333333', 'peter@clinix.test', 2),
('Grace', 'Okoro', 'Radiologist', '08044444444', 'grace@clinix.test', 4),
('David', 'Musa', 'Neurologist', '08055555555', 'david@clinix.test', 8);

SELECT * FROM doctors;