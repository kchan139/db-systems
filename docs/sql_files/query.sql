-- ============================================================================
-- PATIENTS
-- ============================================================================
-- Assuming patient_id for John Doe becomes 5 (if auto-incrementing)
INSERT INTO
    `hospital_patient` (
        `first_name`,
        `last_name`,
        `gender`,
        `contact_info`,
        `home_address`,
        `date_of_birth`,
        `current_medications`,
        `emergency_contact`
    )
VALUES
    (
        'John',
        'Doe',
        'M',
        'john.doe@example.com',
        '123 Main St, Anytown',
        '1985-06-15',
        'Lisinopril 10mg',
        'Jane Doe - 555-0100'
    );

-- Assuming patient_id for Alice Smith becomes 2 (if auto-incrementing)
INSERT INTO
    `hospital_patient` (
        `first_name`,
        `last_name`,
        `gender`,
        `contact_info`,
        `home_address`,
        `date_of_birth`,
        `current_medications`,
        `emergency_contact`
    )
VALUES
    (
        'Alice',
        'Smith',
        'F',
        'alice.smith@example.com',
        '456 Oak Ave, Anytown',
        '1990-03-22',
        'Amoxicillin 250mg',
        'Bob Smith - 555-0101'
    );

-- ============================================================================
-- EMPLOYEES (Potential Managers & Other Roles)
-- ============================================================================
-- Employee: Dr. Emily Carter (Doctor, Potential Manager for Cardiology)
INSERT INTO
    `hospital_employee` (
        `employee_id`,
        `name`,
        `gender`,
        `date_of_birth`,
        `job_type`,
        `experience`,
        `salary`,
        `contact_details`,
        `start_date`,
        `department_id`
    )
VALUES
    (
        'doc001',
        'Dr. Emily Carter',
        'F',
        '1975-09-01',
        'doctor',
        15,
        120000.00,
        'ecarter@hospital.com | 555-0102',
        '2010-07-15',
        NULL -- Department will be assigned after Department creation
    );

-- Employee: Dr. Robert Davis (Doctor, Potential Manager for Pediatrics)
INSERT INTO
    `hospital_employee` (
        `employee_id`,
        `name`,
        `gender`,
        `date_of_birth`,
        `job_type`,
        `experience`,
        `salary`,
        `contact_details`,
        `start_date`,
        `department_id`
    )
VALUES
    (
        'doc002',
        'Dr. Robert Davis',
        'M',
        '1980-04-10',
        'doctor',
        12,
        115000.00,
        'rdavis@hospital.com | 555-0105',
        '2012-08-20',
        NULL -- Department will be assigned after Department creation
    );

-- Employee: Michael Brown (Nurse)
INSERT INTO
    `hospital_employee` (
        `employee_id`,
        `name`,
        `gender`,
        `date_of_birth`,
        `job_type`,
        `experience`,
        `salary`,
        `contact_details`,
        `start_date`,
        `department_id`
    )
VALUES
    (
        'nurse001',
        'Michael Brown',
        'M',
        '1988-12-10',
        'nurse',
        8,
        75000.00,
        'mbrown@hospital.com | 555-0103',
        '2015-03-01',
        NULL -- Department will be assigned after Department creation
    );

-- Employee: Sarah Lee (Technician)
INSERT INTO
    `hospital_employee` (
        `employee_id`,
        `name`,
        `gender`,
        `date_of_birth`,
        `job_type`,
        `experience`,
        `salary`,
        `contact_details`,
        `start_date`,
        `department_id`
    )
VALUES
    (
        'tech001',
        'Sarah Lee',
        'F',
        '1992-07-20',
        'technician',
        5,
        60000.00,
        'slee@hospital.com | 555-0104',
        '2018-01-10',
        NULL -- Department will be assigned after Department creation
    );

-- ============================================================================
-- DEPARTMENTS
-- ============================================================================
-- Assuming department_id for Cardiology becomes 1 (if auto-incrementing)
INSERT INTO
    `hospital_department` (`name`, `location`, `manager_id`)
VALUES
    ('Cardiology', 'Building A, Floor 1', 'doc001');

-- Assuming department_id for Pediatrics becomes 2 (if auto-incrementing)
INSERT INTO
    `hospital_department` (`name`, `location`, `manager_id`)
VALUES
    ('Pediatrics', 'Building B, Floor 2', 'doc002');

-- Update employees with their department_id (assuming department_ids are 1 for Cardiology, 2 for Pediatrics)
UPDATE
    `hospital_employee`
SET
    `department_id` = 2
WHERE
    `employee_id` = 'doc001';

UPDATE
    `hospital_employee`
SET
    `department_id` = 3
WHERE
    `employee_id` = 'doc002';

UPDATE
    `hospital_employee`
SET
    `department_id` = 2
WHERE
    `employee_id` = 'nurse001';

UPDATE
    `hospital_employee`
SET
    `department_id` = 2
WHERE
    `employee_id` = 'tech001';

-- ============================================================================
-- DOCTOR, NURSE, TECHNICIAN (Specific Role Details)
-- ============================================================================
INSERT INTO
    `hospital_doctor` (`employee_id`, `specialty`, `certificate`)
VALUES
    (
        'doc001',
        'Interventional Cardiology',
        'Board Certified in Cardiology, Cert# XYZ123'
    );

INSERT INTO
    `hospital_doctor` (`employee_id`, `specialty`, `certificate`)
VALUES
    (
        'doc002',
        'General Pediatrics',
        'Board Certified in Pediatrics, Cert# ABC789'
    );

INSERT INTO
    `hospital_nurse` (`employee_id`, `specialty`)
VALUES
    ('nurse001', 'Cardiac Care Nursing');

INSERT INTO
    `hospital_technician` (`employee_id`, `specialty`, `responsibility`)
VALUES
    (
        'tech001',
        'Radiology Technician',
        'Operates X-Ray and CT scan equipment.'
    );

-- ============================================================================
-- ROOMS
-- ============================================================================
-- Cardiology, room_number becomes 2
INSERT INTO
    `hospital_room` (
        `department_id`,
        `room_type`,
        `room_name`,
        `status`
    )
VALUES
    (2, 'Standard Ward', 'CW-101', 'Available');

-- Pediatrics, room_number becomes 3
INSERT INTO
    `hospital_room` (
        `department_id`,
        `room_type`,
        `room_name`,
        `status`
    )
VALUES
    (3, 'Pediatric ICU', 'PICU-01', 'Occupied');

-- ============================================================================
-- BEDS
-- ============================================================================
INSERT INTO
    `hospital_bed` (`room_id`, `bed_number`, `status`)
VALUES
    (2, 'A', 'Available');

INSERT INTO
    `hospital_bed` (`room_id`, `bed_number`, `status`)
VALUES
    (2, 'B', 'Maintenance');

INSERT INTO
    `hospital_bed` (`room_id`, `bed_number`, `status`)
VALUES
    (3, 'P1', 'Occupied');

-- ============================================================================
-- EQUIPMENT
-- ============================================================================
INSERT INTO
    `hospital_equipment` (`name`, `type`, `status`, `technician_id`)
VALUES
    (
        'ECG Machine Model X',
        'Diagnostic',
        'Operational',
        'tech001'
    );

INSERT INTO
    `hospital_equipment` (`name`, `type`, `status`, `technician_id`)
VALUES
    (
        'Portable X-Ray Unit',
        'Imaging',
        'Under Maintenance',
        'tech001'
    );

-- ============================================================================
-- SURGERIES
-- ============================================================================
-- surgery_id becomes 1
INSERT INTO
    `hospital_surgery` (`type`, `date`, `outcome`, `complications`)
VALUES
    (
        'Coronary Artery Bypass Grafting',
        '2025-05-10',
        'Successful',
        'Minor post-operative infection.'
    );

-- surgery_id becomes 2
INSERT INTO
    `hospital_surgery` (`type`, `date`, `outcome`, `complications`)
VALUES
    ('Appendectomy', '2025-05-12', 'Pending', '');

-- ============================================================================
-- SURGERY ASSIGNMENTS
-- ============================================================================
-- CABG for John Doe by Dr. Carter
INSERT INTO
    `hospital_surgeryassignment` (`surgery_id`, `doctor_id`, `patient_id`)
VALUES
    (1, 'doc001', 1);

-- Appendectomy for Alice Smith by Dr. Davis
INSERT INTO
    `hospital_surgeryassignment` (`surgery_id`, `doctor_id`, `patient_id`)
VALUES
    (2, 'doc002', 2);

-- ============================================================================
-- DIAGNOSTIC TESTS
-- ============================================================================
-- test_id becomes 1
INSERT INTO
    `hospital_diagnostictest` (`test_name`, `description`, `date`, `results`)
VALUES
    (
        'Full Blood Count',
        'Routine blood panel for John Doe',
        '2025-05-08',
        'Results pending.'
    );

-- test_id becomes 2
INSERT INTO
    `hospital_diagnostictest` (`test_name`, `description`, `date`, `results`)
VALUES
    (
        'Chest X-Ray',
        'Pre-operative check for Alice Smith',
        '2025-05-09',
        'Clear.'
    );

-- ============================================================================
-- TEST ASSIGNMENTS
-- ============================================================================
-- Blood Count for John Doe by Michael Brown
INSERT INTO
    `hospital_testassignment` (`test_id`, `nurse_id`, `patient_id`)
VALUES
    (2, 'nurse001', 5);

-- Chest X-Ray for Alice Smith by Michael Brown
INSERT INTO
    `hospital_testassignment` (`test_id`, `nurse_id`, `patient_id`)
VALUES
    (3, 'nurse001', 6);

-- ============================================================================
-- INSURANCE
-- ============================================================================
-- John Doe, insurance_id becomes 1
INSERT INTO
    `hospital_insurance` (
        `policy_number`,
        `priority`,
        `provider`,
        `status`,
        `coverage_percentage`,
        `coverage_limit`,
        `patient_id`
    )
VALUES
    (
        'POL98765JD',
        1,
        'MediCare Plus',
        'Active',
        80.00,
        50000.00,
        5
    );

-- Alice Smith, insurance_id becomes 2
INSERT INTO
    `hospital_insurance` (
        `policy_number`,
        `priority`,
        `provider`,
        `status`,
        `coverage_percentage`,
        `coverage_limit`,
        `patient_id`
    )
VALUES
    (
        'POL12345AS',
        1,
        'HealthGuard Basic',
        'Active',
        70.00,
        25000.00,
        2
    );

-- ============================================================================
-- BILLING
-- ============================================================================
-- John Doe, billing_id becomes 1
INSERT INTO
    `hospital_billing` (
        `date_issued`,
        `initial_amount`,
        `cover_amount`,
        `final_amount`,
        `due_date`,
        `status`,
        `patient_id`
    )
VALUES
    (
        '2025-05-15',
        15000.00,
        12000.00,
        3000.00,
        '2025-06-15',
        'Partially Paid',
        5
    );

-- Alice Smith, billing_id becomes 2
INSERT INTO
    `hospital_billing` (
        `date_issued`,
        `initial_amount`,
        `cover_amount`,
        `final_amount`,
        `due_date`,
        `status`,
        `patient_id`
    )
VALUES
    (
        '2025-05-14',
        3000.00,
        2100.00,
        900.00,
        '2025-06-14',
        'Issued',
        6
    );

-- ============================================================================
-- INSURANCE BILLING (Junction Table)
-- ============================================================================
INSERT INTO
    `hospital_insurancebilling` (`insurance_id`, `billing_id`)
VALUES
    (1, 1);

INSERT INTO
    `hospital_insurancebilling` (`insurance_id`, `billing_id`)
VALUES
    (2, 2);

-- ============================================================================
-- PAYMENTS
-- ============================================================================
INSERT INTO
    `hospital_payment` (
        `payment_date`,
        `method`,
        `amount_paid`,
        `receipt_number`,
        `notes`,
        `billing_id`
    )
VALUES
    (
        '2025-05-20',
        'Credit Card',
        3000.00,
        'RCPT001JD',
        'Co-payment for surgery.',
        1
    );

INSERT INTO
    `hospital_payment` (
        `payment_date`,
        `method`,
        `amount_paid`,
        `receipt_number`,
        `notes`,
        `billing_id`
    )
VALUES
    (
        '2025-05-18',
        'Insurance Direct',
        2100.00,
        'RCPT002AS_INS',
        'Payment from HealthGuard Basic.',
        2
    );

-- ============================================================================
-- ALLERGIES
-- ============================================================================
INSERT INTO
    `hospital_allergy` (`patient_id`, `allergy`)
VALUES
    (5, 'Penicillin');

INSERT INTO
    `hospital_allergy` (`patient_id`, `allergy`)
VALUES
    (5, 'Dust Mites');

INSERT INTO
    `hospital_allergy` (`patient_id`, `allergy`)
VALUES
    (6, 'Peanuts');

-- ============================================================================
-- MEDICAL HISTORY
-- ============================================================================
INSERT INTO
    `hospital_medicalhistory` (
        `patient_id`,
        `type`,
        `description`,
        `treatment`,
        `stage`
    )
VALUES
    (
        5,
        'Hypertension',
        'Diagnosed in 2020.',
        'Lisinopril 10mg daily.',
        'Chronic - Stable'
    );

INSERT INTO
    `hospital_medicalhistory` (
        `patient_id`,
        `type`,
        `description`,
        `treatment`,
        `stage`
    )
VALUES
    (
        6,
        'Asthma',
        'Childhood asthma.',
        'Albuterol inhaler PRN.',
        'Intermittent'
    );

-- ============================================================================
-- DELETE AND SELECT QUERIES
-- ============================================================================
-- Example: Delete 'Dust Mites' allergy for Patient ID 5 (John Doe)
-- Assume 'Dust Mites' allergy for patient_id 5 has a primary key `id` = 2 in `hospital_allergy`.
-- 1. ORM loads the patient data (e.g., when on the patient's edit page).
SELECT
    `hospital_patient`.`patient_id`,
    `hospital_patient`.`first_name`,
    `hospital_patient`.`last_name`,
    `hospital_patient`.`gender`,
    `hospital_patient`.`contact_info`,
    `hospital_patient`.`home_address`,
    `hospital_patient`.`date_of_birth`,
    `hospital_patient`.`current_medications`,
    `hospital_patient`.`emergency_contact`
FROM
    `hospital_patient`
WHERE
    `hospital_patient`.`patient_id` = 5
LIMIT
    21;

-- 2. ORM finds the allergy data (e.g., when on the patient's edit page).
SELECT
    `hospital_allergy`.`id`,
    `hospital_allergy`.`patient_id`,
    `hospital_allergy`.`allergy`
FROM
    `hospital_allergy`
WHERE
    `hospital_allergy`.`id` = 12
LIMIT
    21;

-- 3. ORM deletes allergy data with id = 12
DELETE FROM
    `hospital_allergy`
WHERE
    `hospital_allergy`.`id` IN (12);

-- 1. ORM find all data relating to the patient
-- The patient
SELECT
    *
FROM
    `hospital_patient`
WHERE
    `hospital_patient`.`patient_id` = 5;

-- The patient's surgery assignment
SELECT
    *
FROM
    `hospital_surgeryassignment`
    INNER JOIN `hospital_patient` ON (
        `hospital_surgeryassignment`.`patient_id` = `hospital_patient`.`patient_id`
    )
WHERE
    `hospital_surgeryassignment`.`patient_id` IN (5);

-- The patient's test assignment
SELECT
    *
FROM
    `hospital_testassignment`
    INNER JOIN `hospital_patient` ON (
        `hospital_testassignment`.`patient_id` = `hospital_patient`.`patient_id`
    )
WHERE
    `hospital_testassignment`.`patient_id` IN (5);

-- The patient's insurance
SELECT
    *
FROM
    `hospital_insurance`
    INNER JOIN `hospital_patient` ON (
        `hospital_insurance`.`patient_id` = `hospital_patient`.`patient_id`
    )
WHERE
    `hospital_insurance`.`patient_id` IN (5);

-- The patient's insurance billing
SELECT
    *
FROM
    `hospital_insurancebilling`
    INNER JOIN `hospital_insurance` ON (
        `hospital_insurancebilling`.`insurance_id` = `hospital_insurance`.`insurance_id`
    )
WHERE
    `hospital_insurancebilling`.`insurance_id` IN (1);

-- The patient's billing
SELECT
    *
FROM
    `hospital_billing`
    INNER JOIN `hospital_patient` ON (
        `hospital_billing`.`patient_id` = `hospital_patient`.`patient_id`
    )
WHERE
    `hospital_billing`.`patient_id` IN (5);

-- The patient's insurance billing
SELECT
    *
FROM
    `hospital_insurancebilling`
    INNER JOIN `hospital_billing` ON (
        `hospital_insurancebilling`.`billing_id` = `hospital_billing`.`billing_id`
    )
WHERE
    `hospital_insurancebilling`.`billing_id` IN (1);

-- The billing's payment
SELECT
    *
FROM
    `hospital_payment`
    INNER JOIN `hospital_billing` ON (
        `hospital_payment`.`billing_id` = `hospital_billing`.`billing_id`
    )
WHERE
    `hospital_payment`.`billing_id` IN (1);

-- The patient's allergy
SELECT
    *
FROM
    `hospital_allergy`
    INNER JOIN `hospital_patient` ON (
        `hospital_allergy`.`patient_id` = `hospital_patient`.`patient_id`
    )
WHERE
    `hospital_allergy`.`patient_id` IN (5);

-- The patient's medical history
SELECT
    *
FROM
    `hospital_medicalhistory`
    INNER JOIN `hospital_patient` ON (
        `hospital_medicalhistory`.`patient_id` = `hospital_patient`.`patient_id`
    )
WHERE
    `hospital_medicalhistory`.`patient_id` IN (5);

-- Billing id for deleting junction table 
SELECT
    `hospital_billing`.`billing_id`
FROM
    `hospital_billing`
WHERE
    `hospital_billing`.`patient_id` IN (5);

-- Insurance id for deleting junction table
SELECT
    `hospital_insurance`.`insurance_id`
FROM
    `hospital_insurance`
WHERE
    `hospital_insurance`.`patient_id` IN (5);

-- 2. ORM delete all patient data
DELETE FROM
    `hospital_insurancebilling`
WHERE
    `hospital_insurancebilling`.`insurance_id` IN (1);

DELETE FROM
    `hospital_insurancebilling`
WHERE
    `hospital_insurancebilling`.`billing_id` IN (1);

DELETE FROM
    `hospital_payment`
WHERE
    `hospital_payment`.`billing_id` IN (1);

DELETE FROM
    `hospital_surgeryassignment`
WHERE
    `hospital_surgeryassignment`.`patient_id` IN (5);

DELETE FROM
    `hospital_testassignment`
WHERE
    `hospital_testassignment`.`patient_id` IN (5);

DELETE FROM
    `hospital_allergy`
WHERE
    `hospital_allergy`.`patient_id` IN (5);

DELETE FROM
    `hospital_medicalhistory`
WHERE
    `hospital_medicalhistory`.`patient_id` IN (5);

DELETE FROM
    `hospital_insurance`
WHERE
    `hospital_insurance`.`insurance_id` IN (1);

DELETE FROM
    `hospital_billing`
WHERE
    `hospital_billing`.`billing_id` IN (1);

DELETE FROM
    `hospital_patient`
WHERE
    `hospital_patient`.`patient_id` IN (5);