-- =====================================================
-- CLINIX DIAGNOSTICS HOSPITAL MANAGEMENT SYSTEM
-- Portfolio 1: Database Design and Modelling
-- File: 05_relationship_queries.sql
-- Description: Demonstrates relational JOIN operations
-- =====================================================


-- 1. INNER JOIN
-- Retrieve doctors and their departments

SELECT
    doc.first_name,
    doc.last_name,
    doc.specialization,
    d.department_name
FROM doctors doc
INNER JOIN departments d
ON doc.department_id = d.department_id;


-- 2. LEFT JOIN
-- Retrieve all departments, including those without doctors

SELECT
    d.department_id,
    d.department_name,
    doc.doctor_id,
    doc.first_name,
    doc.last_name
FROM departments d
LEFT JOIN doctors doc
ON d.department_id = doc.department_id
ORDER BY d.department_id, doc.doctor_id;


-- 3. RIGHT JOIN
-- Retrieve all doctors and their departments

SELECT
    d.department_name,
    doc.first_name,
    doc.last_name
FROM departments d
RIGHT JOIN doctors doc
ON d.department_id = doc.department_id;


-- 4. FULL OUTER JOIN
-- Retrieve all departments and all doctors

SELECT
    d.department_name,
    doc.first_name,
    doc.last_name
FROM departments d
FULL OUTER JOIN doctors doc
ON d.department_id = doc.department_id;


-- 5. MULTIPLE-TABLE JOIN
-- Retrieve appointment information across four tables

SELECT
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    doc.first_name AS doctor_first_name,
    doc.last_name AS doctor_last_name,
    doc.specialization,
    d.department_name,
    a.appointment_date,
    a.appointment_time,
    a.appointment_status
FROM appointments a
INNER JOIN patients p
ON a.patient_id = p.patient_id
INNER JOIN doctors doc
ON a.doctor_id = doc.doctor_id
INNER JOIN departments d
ON doc.department_id = d.department_id
ORDER BY a.appointment_date;