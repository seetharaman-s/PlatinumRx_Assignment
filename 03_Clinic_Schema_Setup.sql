CREATE DATABASE clinic;
USE clinic;

-- TABLE: clinics

CREATE TABLE clinics (
    cid         VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100) NOT NULL,
    city        VARCHAR(100),
    state       VARCHAR(100),
    country     VARCHAR(100)
);


-- TABLE: customer

CREATE TABLE customer (
    uid    VARCHAR(50) PRIMARY KEY,
    name   VARCHAR(100) NOT NULL,
    mobile VARCHAR(15)
);


-- TABLE: clinic_sales

CREATE TABLE clinic_sales (
    oid           VARCHAR(50) PRIMARY KEY,
    uid           VARCHAR(50),
    cid           VARCHAR(50),
    amount        DECIMAL(12, 2) NOT NULL,
    datetime      DATETIME       NOT NULL,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);


-- TABLE: expenses

CREATE TABLE expenses (
    eid         VARCHAR(50) PRIMARY KEY,
    cid         VARCHAR(50),
    description VARCHAR(200),
    amount      DECIMAL(12, 2) NOT NULL,
    datetime    DATETIME       NOT NULL,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);


-- SAMPLE DATA


INSERT INTO clinics (cid, clinic_name, city, state, country) VALUES
('cnc-001', 'Apollo Clinic North',   'Mumbai',    'Maharashtra', 'India'),
('cnc-002', 'Apollo Clinic South',   'Mumbai',    'Maharashtra', 'India'),
('cnc-003', 'Sunshine Clinic',       'Pune',      'Maharashtra', 'India'),
('cnc-004', 'City Health Centre',    'Chennai',   'Tamil Nadu',  'India'),
('cnc-005', 'Metro Care Clinic',     'Chennai',   'Tamil Nadu',  'India'),
('cnc-006', 'Green Cross Clinic',    'Bengaluru', 'Karnataka',   'India'),
('cnc-007', 'HealthFirst Clinic',    'Bengaluru', 'Karnataka',   'India');

INSERT INTO customer (uid, name, mobile) VALUES
('cust-001', 'Ravi Kumar',    '9810000001'),
('cust-002', 'Priya Sharma',  '9810000002'),
('cust-003', 'Arjun Mehta',   '9810000003'),
('cust-004', 'Sneha Pillai',  '9810000004'),
('cust-005', 'Karan Nair',    '9810000005'),
('cust-006', 'Deepa Iyer',    '9810000006'),
('cust-007', 'Vikram Singh',  '9810000007'),
('cust-008', 'Ananya Rao',    '9810000008'),
('cust-009', 'Suresh Menon',  '9810000009'),
('cust-010', 'Meena Das',     '9810000010');

INSERT INTO clinic_sales (oid, uid, cid, amount, datetime, sales_channel) VALUES
('ord-001', 'cust-001', 'cnc-001', 24999, '2021-01-05 10:00:00', 'online'),
('ord-002', 'cust-002', 'cnc-001', 15000, '2021-01-10 11:00:00', 'walk-in'),
('ord-003', 'cust-003', 'cnc-002', 8000,  '2021-01-15 12:00:00', 'online'),
('ord-004', 'cust-004', 'cnc-003', 5500,  '2021-01-20 14:00:00', 'referral'),
('ord-005', 'cust-005', 'cnc-004', 12000, '2021-01-22 09:30:00', 'walk-in'),
('ord-006', 'cust-001', 'cnc-001', 18000, '2021-02-03 10:00:00', 'online'),
('ord-007', 'cust-006', 'cnc-002', 9500,  '2021-02-08 11:00:00', 'referral'),
('ord-008', 'cust-007', 'cnc-004', 22000, '2021-02-14 15:00:00', 'online'),
('ord-009', 'cust-002', 'cnc-005', 7000,  '2021-02-18 13:00:00', 'walk-in'),
('ord-010', 'cust-003', 'cnc-006', 31000, '2021-03-01 10:00:00', 'online'),
('ord-011', 'cust-008', 'cnc-001', 14000, '2021-03-05 09:00:00', 'walk-in'),
('ord-012', 'cust-009', 'cnc-003', 6000,  '2021-03-10 16:00:00', 'referral'),
('ord-013', 'cust-010', 'cnc-007', 19500, '2021-03-15 11:00:00', 'online'),
('ord-014', 'cust-004', 'cnc-005', 11000, '2021-03-22 14:00:00', 'walk-in'),
('ord-015', 'cust-005', 'cnc-006', 28000, '2021-04-02 10:00:00', 'online'),
('ord-016', 'cust-001', 'cnc-002', 9000,  '2021-04-08 11:00:00', 'walk-in'),
('ord-017', 'cust-006', 'cnc-004', 16000, '2021-04-12 12:00:00', 'referral'),
('ord-018', 'cust-007', 'cnc-007', 23000, '2021-04-20 15:00:00', 'online'),
('ord-019', 'cust-008', 'cnc-001', 17500, '2021-05-01 09:00:00', 'online'),
('ord-020', 'cust-009', 'cnc-006', 12500, '2021-05-07 13:00:00', 'walk-in'),
('ord-021', 'cust-002', 'cnc-003', 7800,  '2021-05-14 10:00:00', 'referral'),
('ord-022', 'cust-010', 'cnc-005', 9200,  '2021-05-20 14:00:00', 'online');

INSERT INTO expenses (eid, cid, description, amount, datetime) VALUES
('exp-001', 'cnc-001', 'First-aid supplies',   5000,  '2021-01-05 07:36:48'),
('exp-002', 'cnc-001', 'Staff salaries',        30000, '2021-01-31 18:00:00'),
('exp-003', 'cnc-002', 'Equipment maintenance', 8000,  '2021-01-12 09:00:00'),
('exp-004', 'cnc-003', 'Utilities',             3000,  '2021-01-28 10:00:00'),
('exp-005', 'cnc-004', 'Medicines restock',     7000,  '2021-01-15 11:00:00'),
('exp-006', 'cnc-001', 'Staff salaries',        30000, '2021-02-28 18:00:00'),
('exp-007', 'cnc-002', 'Utilities',             3500,  '2021-02-20 10:00:00'),
('exp-008', 'cnc-004', 'Equipment purchase',    15000, '2021-02-10 09:00:00'),
('exp-009', 'cnc-005', 'Medicines restock',     5000,  '2021-02-15 11:00:00'),
('exp-010', 'cnc-001', 'Staff salaries',        30000, '2021-03-31 18:00:00'),
('exp-011', 'cnc-003', 'Utilities',             3200,  '2021-03-20 10:00:00'),
('exp-012', 'cnc-006', 'Equipment maintenance', 9000,  '2021-03-08 09:00:00'),
('exp-013', 'cnc-007', 'First-aid supplies',    4000,  '2021-03-12 11:00:00'),
('exp-014', 'cnc-001', 'Staff salaries',        30000, '2021-04-30 18:00:00'),
('exp-015', 'cnc-002', 'Medicines restock',     6000,  '2021-04-10 10:00:00'),
('exp-016', 'cnc-006', 'Staff salaries',        20000, '2021-04-30 18:00:00'),
('exp-017', 'cnc-001', 'Staff salaries',        30000, '2021-05-31 18:00:00'),
('exp-018', 'cnc-003', 'Utilities',             3100,  '2021-05-20 10:00:00'),
('exp-019', 'cnc-006', 'Equipment maintenance', 7000,  '2021-05-14 09:00:00');
