(0.000)
SELECT
    VERSION(),
    @ @sql_mode,
    @ @default_storage_engine,
    @ @sql_auto_is_null,
    @ @lower_case_table_names,
    CONVERT_TZ('2001-01-01 01:00:00', 'UTC', 'UTC') IS NOT NULL;

args = None;

alias = default (0.000)
SET
    SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

args = None;

alias = default (0.003)
SELECT
    table_name,
    table_type,
    table_comment
FROM
    information_schema.tables
WHERE
    table_schema = DATABASE();

args = None;

alias = default (0.000)
SELECT
    `django_migrations`.`id`,
    `django_migrations`.`app`,
    `django_migrations`.`name`,
    `django_migrations`.`applied`
FROM
    `django_migrations`;

args =();

alias = default CREATE TABLE `hospital_billing` (
    `billing_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `date_issued` date NOT NULL,
    `initial_amount` numeric(10, 2) NOT NULL,
    `cover_amount` numeric(10, 2) NOT NULL,
    `final_amount` numeric(10, 2) NOT NULL,
    `due_date` date NOT NULL,
    `status` varchar(50) NOT NULL
);

(params None) CREATE TABLE `hospital_department` (
    `department_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(100) NOT NULL,
    `location` varchar(200) NOT NULL
);

(params None) CREATE TABLE `hospital_diagnostictest` (
    `test_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `test_name` varchar(200) NOT NULL,
    `description` longtext NOT NULL,
    `date` date NOT NULL,
    `results` longtext NOT NULL
);

(params None) CREATE TABLE `hospital_employee` (
    `employee_id` varchar(10) NOT NULL PRIMARY KEY,
    `name` varchar(100) NOT NULL,
    `gender` varchar(1) NOT NULL,
    `date_of_birth` date NOT NULL,
    `job_type` varchar(20) NOT NULL,
    `experience` integer UNSIGNED NOT NULL CHECK (`experience` >= 0),
    `salary` numeric(10, 2) NOT NULL,
    `contact_details` longtext NOT NULL,
    `start_date` date NOT NULL,
    `department_id` integer NULL
);

(params None) (0.002)
SELECT
    engine
FROM
    information_schema.tables
WHERE
    table_name = 'hospital_employee'
    AND table_schema = DATABASE();

args = ['hospital_employee'];

alias = default CREATE TABLE `hospital_insurance` (
    `insurance_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `policy_number` varchar(100) NOT NULL,
    `priority` integer UNSIGNED NOT NULL CHECK (`priority` >= 0),
    `provider` varchar(200) NOT NULL,
    `status` varchar(50) NOT NULL,
    `coverage_percentage` numeric(5, 2) NOT NULL,
    `coverage_limit` numeric(10, 2) NOT NULL
);

(params None) CREATE TABLE `hospital_patient` (
    `patient_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `first_name` varchar(100) NOT NULL,
    `last_name` varchar(100) NOT NULL,
    `gender` varchar(1) NOT NULL,
    `contact_info` varchar(100) NOT NULL,
    `home_address` longtext NOT NULL,
    `date_of_birth` date NOT NULL,
    `current_medications` longtext NOT NULL,
    `emergency_contact` varchar(100) NOT NULL
);

(params None) CREATE TABLE `hospital_surgery` (
    `surgery_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `type` varchar(200) NOT NULL,
    `date` date NOT NULL,
    `outcome` varchar(100) NOT NULL,
    `complications` longtext NOT NULL
);

(params None) CREATE TABLE `hospital_doctor` (
    `employee_id` varchar(10) NOT NULL PRIMARY KEY,
    `specialty` varchar(100) NOT NULL,
    `certificate` longtext NOT NULL
);

(params None) CREATE TABLE `hospital_nurse` (
    `employee_id` varchar(10) NOT NULL PRIMARY KEY,
    `specialty` varchar(100) NOT NULL
);

(params None) CREATE TABLE `hospital_technician` (
    `employee_id` varchar(10) NOT NULL PRIMARY KEY,
    `specialty` varchar(100) NOT NULL,
    `responsibility` longtext NOT NULL
);

(params None)
ALTER TABLE
    `hospital_department`
ADD
    COLUMN `manager_id` varchar(10) NOT NULL UNIQUE,
ADD
    CONSTRAINT `hospital_department_manager_id_66d35066_fk_hospital_` FOREIGN KEY (`manager_id`) REFERENCES `hospital_employee`(`employee_id`);

(params None) CREATE TABLE `hospital_equipment` (
    `equipment_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(100) NOT NULL,
    `type` varchar(100) NOT NULL,
    `status` varchar(50) NOT NULL,
    `technician_id` varchar(10) NULL
);

(params None) (0.001)
SELECT
    engine
FROM
    information_schema.tables
WHERE
    table_name = 'hospital_equipment'
    AND table_schema = DATABASE();

args = ['hospital_equipment'];

alias = default CREATE TABLE `hospital_insurancebilling` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `billing_id` integer NOT NULL,
    `insurance_id` integer NOT NULL
);

(params None) (0.001)
SELECT
    engine
FROM
    information_schema.tables
WHERE
    table_name = 'hospital_insurancebilling'
    AND table_schema = DATABASE();

args = ['hospital_insurancebilling'];

alias = default (0.000)
SELECT
    engine
FROM
    information_schema.tables
WHERE
    table_name = 'hospital_insurancebilling'
    AND table_schema = DATABASE();

args = ['hospital_insurancebilling'];

alias = default
ALTER TABLE
    `hospital_insurance`
ADD
    COLUMN `patient_id` integer NOT NULL,
ADD
    CONSTRAINT `hospital_insurance_patient_id_152862b5_fk_hospital_` FOREIGN KEY (`patient_id`) REFERENCES `hospital_patient`(`patient_id`);

(params None) (0.001)
SELECT
    engine
FROM
    information_schema.tables
WHERE
    table_name = 'hospital_insurance'
    AND table_schema = DATABASE();

args = ['hospital_insurance'];

alias = default
ALTER TABLE
    `hospital_billing`
ADD
    COLUMN `patient_id` integer NOT NULL,
ADD
    CONSTRAINT `hospital_billing_patient_id_83aae0a4_fk_hospital_` FOREIGN KEY (`patient_id`) REFERENCES `hospital_patient`(`patient_id`);

(params None) (0.001)
SELECT
    engine
FROM
    information_schema.tables
WHERE
    table_name = 'hospital_billing'
    AND table_schema = DATABASE();

args = ['hospital_billing'];

alias = default CREATE TABLE `hospital_payment` (
    `payment_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `payment_date` date NOT NULL,
    `method` varchar(50) NOT NULL,
    `amount_paid` numeric(10, 2) NOT NULL,
    `receipt_number` varchar(100) NOT NULL,
    `notes` longtext NOT NULL,
    `billing_id` integer NOT NULL
);

(params None) (0.001)
SELECT
    engine
FROM
    information_schema.tables
WHERE
    table_name = 'hospital_payment'
    AND table_schema = DATABASE();

args = ['hospital_payment'];

alias = default CREATE TABLE `hospital_room` (
    `room_number` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `room_type` varchar(100) NOT NULL,
    `room_name` varchar(100) NOT NULL,
    `status` varchar(50) NOT NULL,
    `department_id` integer NOT NULL
);

(params None) (0.001)
SELECT
    engine
FROM
    information_schema.tables
WHERE
    table_name = 'hospital_room'
    AND table_schema = DATABASE();

args = ['hospital_room'];

alias = default CREATE TABLE `hospital_surgeryassignment` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `doctor_id` varchar(10) NOT NULL,
    `patient_id` integer NOT NULL,
    `surgery_id` integer NOT NULL
);

(params None) (0.001)
SELECT
    engine
FROM
    information_schema.tables
WHERE
    table_name = 'hospital_surgeryassignment'
    AND table_schema = DATABASE();

args = ['hospital_surgeryassignment'];

alias = default (0.000)
SELECT
    engine
FROM
    information_schema.tables
WHERE
    table_name = 'hospital_surgeryassignment'
    AND table_schema = DATABASE();

args = ['hospital_surgeryassignment'];

alias = default (0.000)
SELECT
    engine
FROM
    information_schema.tables
WHERE
    table_name = 'hospital_surgeryassignment'
    AND table_schema = DATABASE();

args = ['hospital_surgeryassignment'];

alias = default CREATE TABLE `hospital_testassignment` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `nurse_id` varchar(10) NOT NULL,
    `patient_id` integer NOT NULL,
    `test_id` integer NOT NULL
);

(params None) (0.001)
SELECT
    engine
FROM
    information_schema.tables
WHERE
    table_name = 'hospital_testassignment'
    AND table_schema = DATABASE();

args = ['hospital_testassignment'];

alias = default (0.000)
SELECT
    engine
FROM
    information_schema.tables
WHERE
    table_name = 'hospital_testassignment'
    AND table_schema = DATABASE();

args = ['hospital_testassignment'];

alias = default (0.000)
SELECT
    engine
FROM
    information_schema.tables
WHERE
    table_name = 'hospital_testassignment'
    AND table_schema = DATABASE();

args = ['hospital_testassignment'];

alias = default CREATE TABLE `hospital_medicalhistory` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `type` varchar(200) NOT NULL,
    `description` longtext NOT NULL,
    `treatment` longtext NOT NULL,
    `stage` varchar(100) NOT NULL,
    `patient_id` integer NOT NULL
);

(params None) (0.001)
SELECT
    engine
FROM
    information_schema.tables
WHERE
    table_name = 'hospital_medicalhistory'
    AND table_schema = DATABASE();

args = ['hospital_medicalhistory'];

alias = default CREATE TABLE `hospital_allergy` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `allergy` varchar(200) NOT NULL,
    `patient_id` integer NOT NULL
);

(params None) (0.001)
SELECT
    engine
FROM
    information_schema.tables
WHERE
    table_name = 'hospital_allergy'
    AND table_schema = DATABASE();

args = ['hospital_allergy'];

alias = default CREATE TABLE `hospital_bed` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `bed_number` varchar(10) NOT NULL,
    `status` varchar(50) NOT NULL,
    `room_id` integer NOT NULL
);

(params None) (0.001)
SELECT
    engine
FROM
    information_schema.tables
WHERE
    table_name = 'hospital_bed'
    AND table_schema = DATABASE();

args = ['hospital_bed'];

alias = default
ALTER TABLE
    `hospital_employee`
ADD
    CONSTRAINT `hospital_employee_department_id_22c5804a_fk_hospital_` FOREIGN KEY (`department_id`) REFERENCES `hospital_department` (`department_id`);

(params None)
ALTER TABLE
    `hospital_doctor`
ADD
    CONSTRAINT `hospital_doctor_employee_id_d85a845e_fk_hospital_` FOREIGN KEY (`employee_id`) REFERENCES `hospital_employee` (`employee_id`);

(params None)
ALTER TABLE
    `hospital_nurse`
ADD
    CONSTRAINT `hospital_nurse_employee_id_0d59947a_fk_hospital_` FOREIGN KEY (`employee_id`) REFERENCES `hospital_employee` (`employee_id`);

(params None)
ALTER TABLE
    `hospital_technician`
ADD
    CONSTRAINT `hospital_technician_employee_id_93856a52_fk_hospital_` FOREIGN KEY (`employee_id`) REFERENCES `hospital_employee` (`employee_id`);

(params None)
ALTER TABLE
    `hospital_equipment`
ADD
    CONSTRAINT `hospital_equipment_technician_id_29b491a0_fk_hospital_` FOREIGN KEY (`technician_id`) REFERENCES `hospital_employee` (`employee_id`);

(params None)
ALTER TABLE
    `hospital_insurancebilling`
ADD
    CONSTRAINT `hospital_insurancebi_billing_id_9657c83a_fk_hospital_` FOREIGN KEY (`billing_id`) REFERENCES `hospital_billing` (`billing_id`);

(params None)
ALTER TABLE
    `hospital_insurancebilling`
ADD
    CONSTRAINT `hospital_insurancebi_insurance_id_538da1f8_fk_hospital_` FOREIGN KEY (`insurance_id`) REFERENCES `hospital_insurance` (`insurance_id`);

(params None)
ALTER TABLE
    `hospital_payment`
ADD
    CONSTRAINT `hospital_payment_billing_id_22409c0b_fk_hospital_` FOREIGN KEY (`billing_id`) REFERENCES `hospital_billing` (`billing_id`);

(params None)
ALTER TABLE
    `hospital_room`
ADD
    CONSTRAINT `hospital_room_department_id_c091305e_fk_hospital_` FOREIGN KEY (`department_id`) REFERENCES `hospital_department` (`department_id`);

(params None)
ALTER TABLE
    `hospital_surgeryassignment`
ADD
    CONSTRAINT `hospital_surgeryassi_doctor_id_df605ab6_fk_hospital_` FOREIGN KEY (`doctor_id`) REFERENCES `hospital_employee` (`employee_id`);

(params None)
ALTER TABLE
    `hospital_surgeryassignment`
ADD
    CONSTRAINT `hospital_surgeryassi_patient_id_14a26095_fk_hospital_` FOREIGN KEY (`patient_id`) REFERENCES `hospital_patient` (`patient_id`);

(params None)
ALTER TABLE
    `hospital_surgeryassignment`
ADD
    CONSTRAINT `hospital_surgeryassi_surgery_id_c2860aa0_fk_hospital_` FOREIGN KEY (`surgery_id`) REFERENCES `hospital_surgery` (`surgery_id`);

(params None)
ALTER TABLE
    `hospital_testassignment`
ADD
    CONSTRAINT `hospital_testassignm_nurse_id_a6575c18_fk_hospital_` FOREIGN KEY (`nurse_id`) REFERENCES `hospital_employee` (`employee_id`);

(params None)
ALTER TABLE
    `hospital_testassignment`
ADD
    CONSTRAINT `hospital_testassignm_patient_id_42f91e47_fk_hospital_` FOREIGN KEY (`patient_id`) REFERENCES `hospital_patient` (`patient_id`);

(params None)
ALTER TABLE
    `hospital_testassignment`
ADD
    CONSTRAINT `hospital_testassignm_test_id_de7683fe_fk_hospital_` FOREIGN KEY (`test_id`) REFERENCES `hospital_diagnostictest` (`test_id`);

(params None)
ALTER TABLE
    `hospital_medicalhistory`
ADD
    CONSTRAINT `hospital_medicalhistory_patient_id_type_17cebdbd_uniq` UNIQUE (`patient_id`, `type`);

(params None)
ALTER TABLE
    `hospital_medicalhistory`
ADD
    CONSTRAINT `hospital_medicalhist_patient_id_01a6b682_fk_hospital_` FOREIGN KEY (`patient_id`) REFERENCES `hospital_patient` (`patient_id`);

(params None)
ALTER TABLE
    `hospital_allergy`
ADD
    CONSTRAINT `hospital_allergy_patient_id_allergy_da67a72b_uniq` UNIQUE (`patient_id`, `allergy`);

(params None)
ALTER TABLE
    `hospital_allergy`
ADD
    CONSTRAINT `hospital_allergy_patient_id_3fae2f2c_fk_hospital_` FOREIGN KEY (`patient_id`) REFERENCES `hospital_patient` (`patient_id`);

(params None)
ALTER TABLE
    `hospital_bed`
ADD
    CONSTRAINT `hospital_bed_room_id_bed_number_943916d8_uniq` UNIQUE (`room_id`, `bed_number`);

(params None)
ALTER TABLE
    `hospital_bed`
ADD
    CONSTRAINT `hospital_bed_room_id_f1f9e298_fk_hospital_room_room_number` FOREIGN KEY (`room_id`) REFERENCES `hospital_room` (`room_number`);

(params None) --
-- Create model Billing
--
CREATE TABLE `hospital_billing` (
    `billing_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `date_issued` date NOT NULL,
    `initial_amount` numeric(10, 2) NOT NULL,
    `cover_amount` numeric(10, 2) NOT NULL,
    `final_amount` numeric(10, 2) NOT NULL,
    `due_date` date NOT NULL,
    `status` varchar(50) NOT NULL
);

--
-- Create model Department
--
CREATE TABLE `hospital_department` (
    `department_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(100) NOT NULL,
    `location` varchar(200) NOT NULL
);

--
-- Create model DiagnosticTest
--
CREATE TABLE `hospital_diagnostictest` (
    `test_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `test_name` varchar(200) NOT NULL,
    `description` longtext NOT NULL,
    `date` date NOT NULL,
    `results` longtext NOT NULL
);

--
-- Create model Employee
--
CREATE TABLE `hospital_employee` (
    `employee_id` varchar(10) NOT NULL PRIMARY KEY,
    `name` varchar(100) NOT NULL,
    `gender` varchar(1) NOT NULL,
    `date_of_birth` date NOT NULL,
    `job_type` varchar(20) NOT NULL,
    `experience` integer UNSIGNED NOT NULL CHECK (`experience` >= 0),
    `salary` numeric(10, 2) NOT NULL,
    `contact_details` longtext NOT NULL,
    `start_date` date NOT NULL,
    `department_id` integer NULL
);

--
-- Create model Insurance
--
CREATE TABLE `hospital_insurance` (
    `insurance_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `policy_number` varchar(100) NOT NULL,
    `priority` integer UNSIGNED NOT NULL CHECK (`priority` >= 0),
    `provider` varchar(200) NOT NULL,
    `status` varchar(50) NOT NULL,
    `coverage_percentage` numeric(5, 2) NOT NULL,
    `coverage_limit` numeric(10, 2) NOT NULL
);

--
-- Create model Patient
--
CREATE TABLE `hospital_patient` (
    `patient_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `first_name` varchar(100) NOT NULL,
    `last_name` varchar(100) NOT NULL,
    `gender` varchar(1) NOT NULL,
    `contact_info` varchar(100) NOT NULL,
    `home_address` longtext NOT NULL,
    `date_of_birth` date NOT NULL,
    `current_medications` longtext NOT NULL,
    `emergency_contact` varchar(100) NOT NULL
);

--
-- Create model Surgery
--
CREATE TABLE `hospital_surgery` (
    `surgery_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `type` varchar(200) NOT NULL,
    `date` date NOT NULL,
    `outcome` varchar(100) NOT NULL,
    `complications` longtext NOT NULL
);

--
-- Create model Doctor
--
CREATE TABLE `hospital_doctor` (
    `employee_id` varchar(10) NOT NULL PRIMARY KEY,
    `specialty` varchar(100) NOT NULL,
    `certificate` longtext NOT NULL
);

--
-- Create model Nurse
--
CREATE TABLE `hospital_nurse` (
    `employee_id` varchar(10) NOT NULL PRIMARY KEY,
    `specialty` varchar(100) NOT NULL
);

--
-- Create model Technician
--
CREATE TABLE `hospital_technician` (
    `employee_id` varchar(10) NOT NULL PRIMARY KEY,
    `specialty` varchar(100) NOT NULL,
    `responsibility` longtext NOT NULL
);

--
-- Add field manager to department
--
ALTER TABLE
    `hospital_department`
ADD
    COLUMN `manager_id` varchar(10) NOT NULL UNIQUE,
ADD
    CONSTRAINT `hospital_department_manager_id_66d35066_fk_hospital_` FOREIGN KEY (`manager_id`) REFERENCES `hospital_employee`(`employee_id`);

--
-- Create model Equipment
--
CREATE TABLE `hospital_equipment` (
    `equipment_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(100) NOT NULL,
    `type` varchar(100) NOT NULL,
    `status` varchar(50) NOT NULL,
    `technician_id` varchar(10) NULL
);

--
-- Create model InsuranceBilling
--
CREATE TABLE `hospital_insurancebilling` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `billing_id` integer NOT NULL,
    `insurance_id` integer NOT NULL
);

--
-- Add field patient to insurance
--
ALTER TABLE
    `hospital_insurance`
ADD
    COLUMN `patient_id` integer NOT NULL,
ADD
    CONSTRAINT `hospital_insurance_patient_id_152862b5_fk_hospital_` FOREIGN KEY (`patient_id`) REFERENCES `hospital_patient`(`patient_id`);

--
-- Add field patient to billing
--
ALTER TABLE
    `hospital_billing`
ADD
    COLUMN `patient_id` integer NOT NULL,
ADD
    CONSTRAINT `hospital_billing_patient_id_83aae0a4_fk_hospital_` FOREIGN KEY (`patient_id`) REFERENCES `hospital_patient`(`patient_id`);

--
-- Create model Payment
--
CREATE TABLE `hospital_payment` (
    `payment_id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `payment_date` date NOT NULL,
    `method` varchar(50) NOT NULL,
    `amount_paid` numeric(10, 2) NOT NULL,
    `receipt_number` varchar(100) NOT NULL,
    `notes` longtext NOT NULL,
    `billing_id` integer NOT NULL
);

--
-- Create model Room
--
CREATE TABLE `hospital_room` (
    `room_number` integer AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `room_type` varchar(100) NOT NULL,
    `room_name` varchar(100) NOT NULL,
    `status` varchar(50) NOT NULL,
    `department_id` integer NOT NULL
);

--
-- Create model SurgeryAssignment
--
CREATE TABLE `hospital_surgeryassignment` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `doctor_id` varchar(10) NOT NULL,
    `patient_id` integer NOT NULL,
    `surgery_id` integer NOT NULL
);

--
-- Create model TestAssignment
--
CREATE TABLE `hospital_testassignment` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `nurse_id` varchar(10) NOT NULL,
    `patient_id` integer NOT NULL,
    `test_id` integer NOT NULL
);

--
-- Create model MedicalHistory
--
CREATE TABLE `hospital_medicalhistory` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `type` varchar(200) NOT NULL,
    `description` longtext NOT NULL,
    `treatment` longtext NOT NULL,
    `stage` varchar(100) NOT NULL,
    `patient_id` integer NOT NULL
);

--
-- Create model Allergy
--
CREATE TABLE `hospital_allergy` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `allergy` varchar(200) NOT NULL,
    `patient_id` integer NOT NULL
);

--
-- Create model Bed
--
CREATE TABLE `hospital_bed` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `bed_number` varchar(10) NOT NULL,
    `status` varchar(50) NOT NULL,
    `room_id` integer NOT NULL
);

ALTER TABLE
    `hospital_employee`
ADD
    CONSTRAINT `hospital_employee_department_id_22c5804a_fk_hospital_` FOREIGN KEY (`department_id`) REFERENCES `hospital_department` (`department_id`);

ALTER TABLE
    `hospital_doctor`
ADD
    CONSTRAINT `hospital_doctor_employee_id_d85a845e_fk_hospital_` FOREIGN KEY (`employee_id`) REFERENCES `hospital_employee` (`employee_id`);

ALTER TABLE
    `hospital_nurse`
ADD
    CONSTRAINT `hospital_nurse_employee_id_0d59947a_fk_hospital_` FOREIGN KEY (`employee_id`) REFERENCES `hospital_employee` (`employee_id`);

ALTER TABLE
    `hospital_technician`
ADD
    CONSTRAINT `hospital_technician_employee_id_93856a52_fk_hospital_` FOREIGN KEY (`employee_id`) REFERENCES `hospital_employee` (`employee_id`);

ALTER TABLE
    `hospital_equipment`
ADD
    CONSTRAINT `hospital_equipment_technician_id_29b491a0_fk_hospital_` FOREIGN KEY (`technician_id`) REFERENCES `hospital_employee` (`employee_id`);

ALTER TABLE
    `hospital_insurancebilling`
ADD
    CONSTRAINT `hospital_insurancebi_billing_id_9657c83a_fk_hospital_` FOREIGN KEY (`billing_id`) REFERENCES `hospital_billing` (`billing_id`);

ALTER TABLE
    `hospital_insurancebilling`
ADD
    CONSTRAINT `hospital_insurancebi_insurance_id_538da1f8_fk_hospital_` FOREIGN KEY (`insurance_id`) REFERENCES `hospital_insurance` (`insurance_id`);

ALTER TABLE
    `hospital_payment`
ADD
    CONSTRAINT `hospital_payment_billing_id_22409c0b_fk_hospital_` FOREIGN KEY (`billing_id`) REFERENCES `hospital_billing` (`billing_id`);

ALTER TABLE
    `hospital_room`
ADD
    CONSTRAINT `hospital_room_department_id_c091305e_fk_hospital_` FOREIGN KEY (`department_id`) REFERENCES `hospital_department` (`department_id`);

ALTER TABLE
    `hospital_surgeryassignment`
ADD
    CONSTRAINT `hospital_surgeryassi_doctor_id_df605ab6_fk_hospital_` FOREIGN KEY (`doctor_id`) REFERENCES `hospital_employee` (`employee_id`);

ALTER TABLE
    `hospital_surgeryassignment`
ADD
    CONSTRAINT `hospital_surgeryassi_patient_id_14a26095_fk_hospital_` FOREIGN KEY (`patient_id`) REFERENCES `hospital_patient` (`patient_id`);

ALTER TABLE
    `hospital_surgeryassignment`
ADD
    CONSTRAINT `hospital_surgeryassi_surgery_id_c2860aa0_fk_hospital_` FOREIGN KEY (`surgery_id`) REFERENCES `hospital_surgery` (`surgery_id`);

ALTER TABLE
    `hospital_testassignment`
ADD
    CONSTRAINT `hospital_testassignm_nurse_id_a6575c18_fk_hospital_` FOREIGN KEY (`nurse_id`) REFERENCES `hospital_employee` (`employee_id`);

ALTER TABLE
    `hospital_testassignment`
ADD
    CONSTRAINT `hospital_testassignm_patient_id_42f91e47_fk_hospital_` FOREIGN KEY (`patient_id`) REFERENCES `hospital_patient` (`patient_id`);

ALTER TABLE
    `hospital_testassignment`
ADD
    CONSTRAINT `hospital_testassignm_test_id_de7683fe_fk_hospital_` FOREIGN KEY (`test_id`) REFERENCES `hospital_diagnostictest` (`test_id`);

ALTER TABLE
    `hospital_medicalhistory`
ADD
    CONSTRAINT `hospital_medicalhistory_patient_id_type_17cebdbd_uniq` UNIQUE (`patient_id`, `type`);

ALTER TABLE
    `hospital_medicalhistory`
ADD
    CONSTRAINT `hospital_medicalhist_patient_id_01a6b682_fk_hospital_` FOREIGN KEY (`patient_id`) REFERENCES `hospital_patient` (`patient_id`);

ALTER TABLE
    `hospital_allergy`
ADD
    CONSTRAINT `hospital_allergy_patient_id_allergy_da67a72b_uniq` UNIQUE (`patient_id`, `allergy`);

ALTER TABLE
    `hospital_allergy`
ADD
    CONSTRAINT `hospital_allergy_patient_id_3fae2f2c_fk_hospital_` FOREIGN KEY (`patient_id`) REFERENCES `hospital_patient` (`patient_id`);

ALTER TABLE
    `hospital_bed`
ADD
    CONSTRAINT `hospital_bed_room_id_bed_number_943916d8_uniq` UNIQUE (`room_id`, `bed_number`);

ALTER TABLE
    `hospital_bed`
ADD
    CONSTRAINT `hospital_bed_room_id_f1f9e298_fk_hospital_room_room_number` FOREIGN KEY (`room_id`) REFERENCES `hospital_room` (`room_number`);