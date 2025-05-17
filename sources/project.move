module MedicalRecords::PrescriptionHistory {
    use std::string::String;
    use std::vector;
    use aptos_framework::account;
    use aptos_framework::signer;
    use aptos_framework::timestamp;

    /// Error codes
    const E_NOT_AUTHORIZED: u64 = 1;

    /// Struct representing a prescription
    struct Prescription has store {
        patient_address: address,
        medication: String,
        dosage: String,
        timestamp: u64,
        doctor_address: address
    }

    /// Resource: patient record
    struct PatientRecord has key {
        prescription_count: u64
    }

    /// Resource: stores prescriptions
    struct PrescriptionStore has key {
        prescriptions: vector<Prescription>
    }

    /// Patient initializes their account to receive prescriptions
    public fun initialize_patient(patient: &signer) {
        let addr = signer::address_of(patient);

        if (!exists<PatientRecord>(addr)) {
            move_to(patient, PatientRecord { prescription_count: 0 });
        };

        if (!exists<PrescriptionStore>(addr)) {
            move_to(patient, PrescriptionStore {
                prescriptions: vector::empty<Prescription>()
            });
        };
    }

    /// Doctor adds a prescription for the patient
    public fun add_prescription(
        doctor: &signer,
        patient_address: address,
        medication: String,
        dosage: String
    ) acquires PatientRecord, PrescriptionStore {
        let doctor_addr = signer::address_of(doctor);

        // Ensure patient initialized
        assert!(exists<PatientRecord>(patient_address), E_NOT_AUTHORIZED);
        assert!(exists<PrescriptionStore>(patient_address), E_NOT_AUTHORIZED);

        let prescription = Prescription {
            patient_address,
            medication,
            dosage,
            timestamp: timestamp::now_seconds(),
            doctor_address: doctor_addr
        };

        let patient_record = borrow_global_mut<PatientRecord>(patient_address);
        patient_record.prescription_count = patient_record.prescription_count + 1;

        let store = borrow_global_mut<PrescriptionStore>(patient_address);
        vector::push_back(&mut store.prescriptions, prescription);
    }
}
