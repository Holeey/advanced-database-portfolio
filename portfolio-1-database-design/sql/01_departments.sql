-- =====================================================
-- CLINIX DIAGNOSTICS HOSPITAL MANAGEMENT SYSTEM
-- Portfolio 1: Database Design and Modelling
-- File: 01_departments.sql
-- Description: Creates and populates the Departments table
-- =====================================================

-- Create Departments table

CREATE TABLE departments (
    department_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

-- Insert sample hospital departments

INSERT INTO departments (department_name)
VALUES
('Cardiology'),
('Surgery'),
('Laboratory'),
('Radiology'),
('Pharmacy'),
('Emergency'),
('Paediatrics'),
('Neurology');

-- Retrieve department records

SELECT * FROM departments;