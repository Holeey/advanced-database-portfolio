# Portfolio 4: NoSQL and Advanced Data Models

## Case study and implementation

This practical uses the Clinix Diagnostics Hospital Management System (CDHMS), the same simulated hospital case study used in the relational database portfolios. MongoDB was selected to demonstrate a document-oriented NoSQL data model. The implementation uses fictional patient and appointment records.

The MongoDB database is named `clinix_nosql`, and the collection created for the exercise is `patients`. Three patient documents were inserted. Each document stores patient attributes and an embedded `appointments` array. Each appointment subdocument contains an appointment identifier, doctor identifier, appointment date, status, and reason.

## Document model

The patient is the main document. Appointment information is embedded within the patient document because appointments are naturally associated with a patient and can be retrieved together with the patient's details. This reduces the need for a separate lookup for the demonstrated patient-and-appointment access pattern.

The model is flexible: appointment subdocuments can contain their own fields, and the document structure can be extended as the hospital's requirements evolve. For a production hospital system, document size, update patterns, data duplication, access control, auditing, and the need to reference shared doctor records would need further evaluation. The exercise uses `doctorId` as a reference value rather than embedding full doctor records.

## Operations demonstrated

The MongoDB implementation demonstrates:
1. Creating the `clinix_nosql` database and `patients` collection.
2. Inserting three patient documents with embedded appointment subdocuments.
3. Retrieving all patient documents.
4. Finding patients with scheduled appointments using the nested field `appointments.status`.
5. Updating an embedded appointment status using `updateOne`.
6. Counting patient documents using `countDocuments`.
7. Aggregating embedded appointments with `$unwind`, `$match`, and `$count`.

The observed implementation results were:
- Three patient documents were stored.
- The update operation acknowledged the request, matched one document, and modified one document.
- The aggregation returned two scheduled appointments before the update was reflected in the later verification query.
- The `clinix_nosql` database and `patients` collection were visible using `show dbs` and `show collections`.

## Suitability and limitations

A document database is suitable for demonstrating patient records that contain related, patient-specific information such as appointment history. Embedding appointments allows the application to retrieve a patient's information and associated appointments in one document read. MongoDB also supports flexible document structures and aggregation operations for reporting.

However, embedding is not automatically the best choice for every hospital dataset. If appointments are queried independently at very high volume, shared across multiple entities, or grow without bound, a separate appointments collection with references may be more appropriate. A real healthcare deployment would also require strong security controls, access management, backups, audit logging, validation, and compliance with applicable privacy requirements. This portfolio is an academic simulation using fictional records, not a production clinical system.

## Evidence

The `evidence/Screenshots` folder contains screenshots of the MongoDB query, update, aggregation, database, and collection operations. The JavaScript implementation is in `sql/clinix_nosql_mongodb.js`.

## Conclusion

The practical demonstrates how MongoDB can represent Clinix patient information as BSON documents with embedded appointment subdocuments. The successful insert, query, update, count, and aggregation operations provide implementation evidence for the selected document-oriented NoSQL model.
