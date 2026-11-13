-- Count appointments for every department, including departments with zero appointments.
SELECT d.department_name, COUNT(a.appointment_id) AS total_appointments FROM departments d LEFT JOIN doctors doc ON d.department_id = doc.department_id LEFT JOIN appointments a ON doc.doctor_id = a.doctor_id GROUP BY d.department_id, d.department_name ORDER BY total_appointments DESC, d.department_name;
