CREATE DATABASE hotel;
USE hotel;

-- TABLE: users

CREATE TABLE users (
    user_id        VARCHAR(50)  PRIMARY KEY,
    name           VARCHAR(100) NOT NULL,
    phone_number   VARCHAR(15),
    mail_id        VARCHAR(100),
    billing_address TEXT
);

-- TABLE: bookings

CREATE TABLE bookings (
    booking_id   VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME    NOT NULL,
    room_no      VARCHAR(50),
    user_id      VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


-- TABLE: items

CREATE TABLE items (
    item_id   VARCHAR(50)    PRIMARY KEY,
    item_name VARCHAR(100)   NOT NULL,
    item_rate DECIMAL(10, 2) NOT NULL
);


-- TABLE: booking_commercials

CREATE TABLE booking_commercials (
    id            VARCHAR(50) PRIMARY KEY,
    booking_id    VARCHAR(50),
    bill_id       VARCHAR(50),
    bill_date     DATETIME,
    item_id       VARCHAR(50),
    item_quantity DECIMAL(10, 2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id)    REFERENCES items(item_id)
);


-- SAMPLE DATA

INSERT INTO users (user_id, name, phone_number, mail_id, billing_address) VALUES
('usr-001', 'John Doe',   '9700000001', 'john.doe@example.com',   '10, Street A, Mumbai'),
('usr-002', 'Jane Smith', '9700000002', 'jane.smith@example.com', '22, Road B, Delhi'),
('usr-003', 'Raj Patel',  '9700000003', 'raj.patel@example.com',  '5, Lane C, Chennai'),
('usr-004', 'Sara Khan',  '9700000004', 'sara.khan@example.com',  '8, Block D, Pune'),
('usr-005', 'Amit Roy',   '9700000005', 'amit.roy@example.com',   '14, Sector E, Kolkata');

INSERT INTO items (item_id, item_name, item_rate) VALUES
('itm-001', 'Tawa Paratha',  18.00),
('itm-002', 'Mix Veg',       89.00),
('itm-003', 'Dal Tadka',     75.00),
('itm-004', 'Paneer Butter Masala', 150.00),
('itm-005', 'Masala Chai',   25.00),
('itm-006', 'Cold Coffee',   60.00),
('itm-007', 'Veg Biryani',  130.00),
('itm-008', 'Coke',          40.00);

INSERT INTO bookings (booking_id, booking_date, room_no, user_id) VALUES
('bk-001', '2021-09-23 07:36:48', 'rm-101', 'usr-001'),
('bk-002', '2021-10-05 09:00:00', 'rm-102', 'usr-002'),
('bk-003', '2021-10-12 11:30:00', 'rm-103', 'usr-001'),
('bk-004', '2021-10-20 14:00:00', 'rm-104', 'usr-003'),
('bk-005', '2021-11-03 08:15:00', 'rm-105', 'usr-002'),
('bk-006', '2021-11-10 10:45:00', 'rm-101', 'usr-004'),
('bk-007', '2021-11-18 16:00:00', 'rm-102', 'usr-005'),
('bk-008', '2021-12-01 07:00:00', 'rm-103', 'usr-003'),
('bk-009', '2021-07-14 12:00:00', 'rm-106', 'usr-004'),
('bk-010', '2021-08-22 09:30:00', 'rm-107', 'usr-005');

INSERT INTO booking_commercials (id, booking_id, bill_id, bill_date, item_id, item_quantity) VALUES
('bc-001', 'bk-001', 'bl-001', '2021-09-23 12:03:22', 'itm-001', 3),
('bc-002', 'bk-001', 'bl-001', '2021-09-23 12:03:22', 'itm-002', 1),
('bc-003', 'bk-002', 'bl-002', '2021-10-05 13:00:00', 'itm-003', 2),
('bc-004', 'bk-002', 'bl-002', '2021-10-05 13:00:00', 'itm-004', 1),
('bc-005', 'bk-003', 'bl-003', '2021-10-12 15:00:00', 'itm-005', 4),
('bc-006', 'bk-003', 'bl-003', '2021-10-12 15:00:00', 'itm-007', 3),
('bc-007', 'bk-004', 'bl-004', '2021-10-20 18:00:00', 'itm-004', 5),
('bc-008', 'bk-004', 'bl-004', '2021-10-20 18:00:00', 'itm-006', 2),
('bc-009', 'bk-004', 'bl-005', '2021-10-20 20:00:00', 'itm-008', 3),
('bc-010', 'bk-004', 'bl-005', '2021-10-20 20:00:00', 'itm-001', 6),
('bc-023', 'bk-004', 'bl-999', '2021-10-21 19:00:00', 'itm-004', 5),
('bc-024', 'bk-004', 'bl-999', '2021-10-21 19:00:00', 'itm-007', 3),
('bc-011', 'bk-005', 'bl-006', '2021-11-03 09:00:00', 'itm-002', 2),
('bc-012', 'bk-005', 'bl-006', '2021-11-03 09:00:00', 'itm-003', 3),
('bc-013', 'bk-006', 'bl-007', '2021-11-10 12:00:00', 'itm-004', 4),
('bc-014', 'bk-006', 'bl-007', '2021-11-10 12:00:00', 'itm-007', 2),
('bc-015', 'bk-007', 'bl-008', '2021-11-18 17:00:00', 'itm-005', 5),
('bc-016', 'bk-007', 'bl-008', '2021-11-18 17:00:00', 'itm-008', 4),
('bc-017', 'bk-008', 'bl-009', '2021-12-01 08:00:00', 'itm-006', 2),
('bc-018', 'bk-008', 'bl-009', '2021-12-01 08:00:00', 'itm-001', 5),
('bc-019', 'bk-009', 'bl-010', '2021-07-14 13:00:00', 'itm-003', 1),
('bc-020', 'bk-009', 'bl-010', '2021-07-14 13:00:00', 'itm-004', 2),
('bc-021', 'bk-010', 'bl-011', '2021-08-22 10:00:00', 'itm-007', 3),
('bc-022', 'bk-010', 'bl-011', '2021-08-22 10:00:00', 'itm-005', 2);