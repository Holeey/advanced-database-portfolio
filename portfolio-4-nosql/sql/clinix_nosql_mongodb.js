// Clinix Diagnostics Hospital Management System
// Portfolio 4: MongoDB document-oriented NoSQL implementation
// Run these commands in mongosh.

use clinix_nosql

db.createCollection("patients")

db.patients.insertMany([
  {
    patientId: 1,
    firstName: "John",
    lastName: "Okafor",
    gender: "Male",
    dateOfBirth: ISODate("1990-05-12"),
    phoneNumber: "08030000001",
    appointments: [
      {
        appointmentId: 1,
        doctorId: 1,
        appointmentDate: ISODate("2026-11-18"),
        status: "Scheduled",
        reason: "General consultation"
      },
      {
        appointmentId: 2,
        doctorId: 2,
        appointmentDate: ISODate("2026-11-25"),
        status: "Scheduled",
        reason: "Laboratory review"
      }
    ]
  },
  {
    patientId: 2,
    firstName: "Mary",
    lastName: "Adeyemi",
    gender: "Female",
    dateOfBirth: ISODate("1988-09-20"),
    phoneNumber: "08030000002",
    appointments: [
      {
        appointmentId: 3,
        doctorId: 3,
        appointmentDate: ISODate("2026-11-19"),
        status: "Completed",
        reason: "Medical checkup"
      }
    ]
  },
  {
    patientId: 3,
    firstName: "David",
    lastName: "Bello",
    gender: "Male",
    dateOfBirth: ISODate("1995-02-14"),
    phoneNumber: "08030000003",
    appointments: [
      {
        appointmentId: 4,
        doctorId: 1,
        appointmentDate: ISODate("2026-11-20"),
        status: "Scheduled",
        reason: "Follow-up"
      }
    ]
  }
])

// Read all patient documents
db.patients.find().pretty()

// Find patients with scheduled appointments
db.patients.find({"appointments.status": "Scheduled"}).pretty()

// Update the status of John's first appointment
db.patients.updateOne(
  {patientId: 1},
  {$set: {"appointments.0.status": "Completed"}}
)

// Verify the updated patient document
db.patients.findOne({patientId: 1})

// Count patient documents
db.patients.countDocuments()

// Count scheduled appointments across embedded arrays
db.patients.aggregate([
  {$unwind: "$appointments"},
  {$match: {"appointments.status": "Scheduled"}},
  {$count: "scheduledAppointments"}
])

// Inspect database and collection
show dbs
show collections
