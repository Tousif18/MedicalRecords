# MedicalRecords::PrescriptionHistory

A Move smart contract module for the Aptos blockchain to manage secure, on-chain prescription histories for patients. This module allows patients to initialize their records and authorized doctors to add prescriptions safely and transparently.

---

## Features

- **Patient Initialization:** Patients can initialize their account to create their prescription history.
- **Prescription Management:** Authorized doctors can add prescriptions with details such as medication, dosage, timestamp, and doctor address.
- **On-chain Storage:** All prescriptions and patient records are securely stored on-chain using Aptos resources.
- **Access Control:** Only authorized interactions allowed via assertions.

---

## Module Overview

### Structs

- `Prescription`  
  Stores data about a single prescription, including:
  - `patient_address`: The patient's blockchain address
  - `medication`: Name of the medication prescribed
  - `dosage`: Dosage information
  - `timestamp`: Prescription creation time
  - `doctor_address`: Address of the prescribing doctor

- `PatientRecord`  
  Tracks the total count of prescriptions for a patient.

- `PrescriptionStore`  
  Holds a vector (list) of all prescriptions for a patient.

---

## Public Functions

- `initialize_patient(patient: &signer)`  
  Initializes the patient's records on-chain, creating empty prescription lists and counters.

- `add_prescription(doctor: &signer, patient_address: address, medication: String, dosage: String)`  
  Adds a new prescription for the patient, updating their record and prescription list. Requires the patient to be initialized.

---

## Error Codes

- `E_NOT_AUTHORIZED (1)`  
  Returned if operations are attempted on uninitialized patient accounts.

---

## Usage

1. **Patient** calls `initialize_patient` once to set up their prescription history.
2. **Doctor** calls `add_prescription` to add new prescriptions to the patient's history.

---

## Build & Deployment

- Requires [Aptos CLI](https://aptos.dev/tools/cli-tool/install) and Rust toolchain.
- Compile and deploy using Aptos Move commands.

---

## License

This project is open source and available under the MIT License.

---

## Author

Tousif Azim

GitHub: [https://github.com/Tousif18](https://github.com/Tousif18)

contact address:0x14f1c50a46022c9d5a0bea90aac7b92269d66f223b64ea31865b9956be0af421
