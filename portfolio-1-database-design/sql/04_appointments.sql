-- =====================================================
-- CLINIX DIAGNOSTICS HOSPITAL MANAGEMENT SYSTEM
-- Portfolio 1: Database Design and Modelling
-- File: 04_appointments.sql
-- Description: Creates and populates Appointments table
-- =====================================================

CREATE TABLE appointments (
    appointment_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,

    appointment_status VARCHAR(20) NOT NULL DEFAULT 'Scheduled'
        CHECK (
            appointment_status IN (
                'Scheduled',
                'Completed',
                'Cancelled',
                'No-show'
            )
        ),

    reason TEXT,

    FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id),

    FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)
);

-- Insert fictional appointment records

INSERT INTO appointments
(patient_id, doctor_id, appointment_date,
 appointment_time, appointment_status, reason)
VALUES
(1, 1, '2026-11-14', '09:00:00',
 'Scheduled', 'Cardiac consultation'),

(2, 2, '2026-11-14', '10:30:00',
 'Scheduled', 'Heart examination'),

(3, 3, '2026-11-10', '11:00:00',
 'Completed', 'General surgical consultation'),

(4, 4, '2026-11-12', '12:00:00',
 'Cancelled', 'Radiology examination'),

(5, 5, '2026-11-11', '14:00:00',
 'No-show', 'Neurological consultation');

-- Retrieve appointment records

SELECT * FROM appointments;