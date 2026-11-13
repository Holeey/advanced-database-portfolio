# Portfolio 1: Relational Schema, Keys, Constraints and Normalisation

## 1. Relational schema

The Clinix Diagnostics Hospital Management System database is organised into four relational tables: `departments`, `doctors`, `patients`, and `appointments`.

The relational schema is represented as follows:

```text
DEPARTMENTS(
    department_id PK,
    department_name
)

DOCTORS(
    doctor_id PK,
    first_name,
    last_name,
    specialization,
    phone_number,
    email,
    department_id FK → DEPARTMENTS.department_id
)

PATIENTS(
    patient_id PK,
    first_name,
    last_name,
    date_of_birth,
    gender,
    phone_number,
    email,
    address,
    registration_date
)

APPOINTMENTS(
    appointment_id PK,
    patient_id FK → PATIENTS.patient_id,
    doctor_id FK → DOCTORS.doctor_id,
    appointment_date,
    appointment_time,
    appointment_status,
    reason
)
```

`PK` means Primary Key and `FK` means Foreign Key.

## 2. Primary keys and foreign keys

| Table | Primary key | Foreign key |
|---|---|---|
| `departments` | `department_id` | None |
| `doctors` | `doctor_id` | `department_id` references `departments.department_id` |
| `patients` | `patient_id` | None |
| `appointments` | `appointment_id` | `patient_id` references `patients.patient_id`; `doctor_id` references `doctors.doctor_id` |

Each primary key uniquely identifies a row in its table. The foreign keys establish relationships between related records and help maintain referential integrity.

## 3. Integrity constraints

The database uses the following constraints:

| Table | Attribute | Constraint and purpose |
|---|---|---|
| `departments` | `department_id` | Primary key generated automatically as an identity value. |
| `departments` | `department_name` | Required and unique; prevents duplicate department names. |
| `doctors` | `doctor_id` | Primary key generated automatically as an identity value. |
| `doctors` | `first_name`, `last_name` | Required fields (`NOT NULL`). |
| `doctors` | `phone_number`, `email` | Required and unique. |
| `doctors` | `department_id` | Required foreign key referencing an existing department. |
| `patients` | `patient_id` | Primary key generated automatically as an identity value. |
| `patients` | `first_name`, `last_name`, `date_of_birth`, `gender`, `phone_number` | Required fields (`NOT NULL`). |
| `patients` | `gender` | CHECK constraint permits only `Male` or `Female`. |
| `patients` | `phone_number` | Required and unique. |
| `patients` | `email` | Optional; when supplied, it must be unique. |
| `patients` | `registration_date` | Defaults to the current date when a value is not supplied. |
| `appointments` | `appointment_id` | Primary key generated automatically as an identity value. |
| `appointments` | `patient_id`, `doctor_id` | Required foreign keys referencing existing patients and doctors. |
| `appointments` | `appointment_date`, `appointment_time` | Required fields (`NOT NULL`). |
| `appointments` | `appointment_status` | Defaults to `Scheduled`; CHECK constraint permits `Scheduled`, `Completed`, `Cancelled`, or `No-show`. |

The `specialization` field in `doctors`, the `address` and `email` fields in `patients`, and the `reason` field in `appointments` may contain NULL values, as permitted by the implemented table definitions.

## 4. Normalisation

Normalisation organises data to reduce unnecessary duplication and prevent insertion, update, and deletion anomalies.

### First Normal Form (1NF)

The tables satisfy 1NF because each column stores a single value for each row. The design does not use repeating groups or lists of values in a single field. For example, a patient's phone number is stored in the `patients` table, while appointment details are stored as separate appointment records.

### Second Normal Form (2NF)

The tables satisfy 2NF because they satisfy 1NF and use single-column primary keys. Therefore, there are no partial dependencies on only part of a composite primary key. Each non-key attribute in a table is associated with that table's primary key.

### Third Normal Form (3NF)

The design is structured to satisfy 3NF because it satisfies 2NF and keeps attributes about separate entities in their respective tables. For example, department names are stored in `departments`, while `doctors` stores `department_id` as a foreign key. The department name is therefore not repeatedly stored in every doctor's record. Patient details, doctor details, and appointment details are also kept in separate tables.

## 5. Summary

The four-table relational design separates departments, doctors, patients, and appointments into related entities. Primary keys provide unique identification, while foreign keys connect related records. NOT NULL, UNIQUE, CHECK, and DEFAULT constraints help enforce data quality and consistency. The design uses normalisation principles to limit duplication and support reliable updates.

*Case-study note: This is an academic database simulation based on a hospital context and uses fictional sample records.*
