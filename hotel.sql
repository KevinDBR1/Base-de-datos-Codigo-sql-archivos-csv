DROP TABLE IF EXISTS invoice_details CASCADE;
DROP TABLE IF EXISTS invoices CASCADE;
DROP TABLE IF EXISTS reservation_guests CASCADE;
DROP TABLE IF EXISTS guests CASCADE;
DROP TABLE IF EXISTS reservation_details CASCADE;
DROP TABLE IF EXISTS reserves CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS equipments CASCADE;
DROP TABLE IF EXISTS rooms CASCADE;
DROP TABLE IF EXISTS cities CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS countries CASCADE;
DROP TABLE IF EXISTS rooms_types CASCADE;
DROP TABLE IF EXISTS positions CASCADE;
DROP TABLE IF EXISTS documents_types CASCADE;
DROP TABLE IF EXISTS payment_methods CASCADE;
DROP TABLE IF EXISTS hotels CASCADE;

CREATE TABLE hotels (
	hotel_id 		VARCHAR(2),
	location 		VARCHAR(100) NOT NULL,
	name 			VARCHAR(50)	 NOT NULL,
	phone_number	VARCHAR(15)  NOT NULL,
	email			VARCHAR(40)  NOT NULL,

	CONSTRAINT pk_hotels
		PRIMARY KEY (hotel_id)
);

-- Nomenclature used in payment methods statuses:
-- Character	Status
-- A			Active
-- I			Inactive
-- E			Expired
CREATE TABLE payment_methods (
	payment_method_id	VARCHAR(2),
	name 				VARCHAR(30)	NOT NULL,
	status				CHAR(1)		NOT NULL,
	description			VARCHAR(100),

	CONSTRAINT pk_payment_methods 
		PRIMARY KEY (payment_method_id),

	CONSTRAINT ck_status
		CHECK (status IN ('A', 'I', 'E'))
);

CREATE TABLE documents_types (
	doc_type_id		VARCHAR(2),
	name 			VARCHAR(25) NOT NULL,
	description 	VARCHAR(200),

	CONSTRAINT pk_documents_types
		PRIMARY KEY (doc_type_id)
);

CREATE TABLE positions (
	position_id		VARCHAR(2),
	name 			VARCHAR(40)  NOT NULL,
	description 	VARCHAR(400) NOT NULL,

	CONSTRAINT pk_positions
		PRIMARY KEY (position_id)
);

CREATE TABLE rooms_types (
	room_type_id	VARCHAR(2),
	name 			VARCHAR(50) NOT NULL,
	description 	VARCHAR(200),

	CONSTRAINT pk_rooms_types
		PRIMARY KEY (room_type_id)
);

CREATE TABLE countries (
	country_id 		CHAR(2), -- Standard ISO 3166-1 Alfa-2
	name			VARCHAR(100) NOT NULL UNIQUE,

	CONSTRAINT pk_countries
		PRIMARY KEY (country_id)
);

CREATE TABLE departments (
	department_id 	VARCHAR(6), -- Standard ISO 3166-2
	country_id		CHAR(2)	 	NOT NULL,
	name 			VARCHAR(100) NOT NULL,

	CONSTRAINT fk_countries_departments
		FOREIGN KEY (country_id)
		REFERENCES countries(country_id)
		ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT pk_departments
		PRIMARY KEY (department_id),
		
	CONSTRAINT uq_dept_per_country 
		UNIQUE (country_id, name)
);

CREATE TABLE cities (
	city_id			SERIAL,
	department_id	VARCHAR(6)	 NOT NULL,
	name 			VARCHAR(100) NOT NULL,

	CONSTRAINT fk_departments_cities
		FOREIGN KEY (department_id)
		REFERENCES departments (department_id)
		ON UPDATE CASCADE ON DELETE CASCADE,
 
	CONSTRAINT pk_cities 
		PRIMARY KEY (city_id),
		
	CONSTRAINT uq_city_per_department 
		UNIQUE (department_id, name)
);

-- Nomenclature used in room statuses:
-- Character	Status
-- A			Available
-- O			Occuped
-- R			Reserved
-- M			Maintenance
-- D			Dirty 
CREATE TABLE rooms (
	room_number		VARCHAR(3),
	hotel_id		VARCHAR(2)		NOT NULL,
	room_type_id	VARCHAR(2)		NOT NULL,
	status 			CHAR(1) 		NOT NULL DEFAULT 'A',
	price_per_night	NUMERIC(10, 2) 	NOT NULL,

	CONSTRAINT ck_status
		CHECK (status IN ('A', 'O', 'R', 'M', 'D')),

	CONSTRAINT fk_rooms_types_rooms
		FOREIGN KEY (room_type_id)
		REFERENCES rooms_types (room_type_id)
		ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT fk_hotels_rooms
		FOREIGN KEY (hotel_id)
		REFERENCES hotels (hotel_id)
		ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT pk_rooms
		PRIMARY KEY (room_number, hotel_id)
);

-- Nomenclature used in equipments statuses:
-- Character	Status
-- O            Operational
-- D            Damaged
-- R            Under repair
CREATE TABLE equipments (
	equipment_id 	SERIAL,
	room_number		VARCHAR(3),
	hotel_id		VARCHAR(2),
	quantity		INTEGER		NOT NULL,
	name			VARCHAR(50) NOT NULL,
    status          VARCHAR(1)  NOT NULL,
	description		VARCHAR(200),

	CONSTRAINT fk_rooms_equipments
		FOREIGN KEY (room_number, hotel_id)
		REFERENCES rooms (room_number, hotel_id)
		ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT ck_status
		CHECK (status IN ('O', 'D', 'R')),

	CONSTRAINT pk_equipments
		PRIMARY KEY (equipment_id)
);

CREATE TABLE employees (
	employee_doc	VARCHAR(15),
	doc_type_id		VARCHAR(2)	 NOT NULL,
	position_id		VARCHAR(2)	 NOT NULL,
	hotel_id		VARCHAR(2)	 NOT NULL,	
	city_id			INTEGER		 NOT NULL, 
	fname			VARCHAR(20)	 NOT NULL,
	fsurname		VARCHAR(30)	 NOT NULL,
	mname			VARCHAR(20),
	ssurname		VARCHAR(30),
	phone_number	VARCHAR(15)	 NOT NULL,
	email			VARCHAR(40)	 NOT NULL,
	address			VARCHAR(100) NOT NULL,
	sex				CHAR(1)		 NOT NULL,
	date_birth		DATE 		 NOT NULL,
	hire_date		DATE		 NOT NULL,
	check_in 		TIME		 NOT NULL,
	check_out		TIME		 NOT NULL,
	salary			NUMERIC(10,2) NOT NULL,
	status			CHAR(1)		 NOT NULL DEFAULT 'A',
	termination_date DATE,
	
	CONSTRAINT fk_hotels_employees 
		FOREIGN KEY (hotel_id)
		REFERENCES hotels (hotel_id)
		ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT fk_positions_employees
		FOREIGN KEY (position_id)
		REFERENCES positions (position_id)
		ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT fk_documents_types_employees
		FOREIGN KEY (doc_type_id)
		REFERENCES documents_types (doc_type_id)
		ON UPDATE CASCADE ON DELETE CASCADE,
		
	CONSTRAINT fk_cities_employees
		FOREIGN KEY (city_id)
		REFERENCES cities (city_id)
		ON UPDATE CASCADE ON DELETE RESTRICT,

	CONSTRAINT pk_employees
		PRIMARY KEY (employee_doc),

	CONSTRAINT ck_salary
		CHECK (salary > 0.00),

	CONSTRAINT ck_sex
		CHECK (sex IN ('M', 'F')),
    
    -- Verify that the email format is valid
	CONSTRAINT ck_email_format
		CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),

	CONSTRAINT ck_employee_status
		CHECK (status IN ('A', 'I', 'L')),
		-- Active, Inactive, Leave 

	CONSTRAINT ck_termination_date
		CHECK ((termination_date IS NULL OR termination_date > hire_date))
);

CREATE TABLE customers (
	customer_doc	VARCHAR(15),
	doc_type_id		VARCHAR(2)	 NOT NULL,	
	city_id			INTEGER  	 NOT NULL, 
	fname			VARCHAR(20)	 NOT NULL,
	fsurname		VARCHAR(30)	 NOT NULL,
	mname			VARCHAR(20),
	ssurname		VARCHAR(30),
	phone_number	VARCHAR(15)	 NOT NULL,
	email			VARCHAR(40)	 NOT NULL,
	address			VARCHAR(100) NOT NULL,
	sex				CHAR(1)		 NOT NULL,
	date_birth		DATE 		 NOT NULL,
	doc_issue_date	DATE		 NOT NULL,

	CONSTRAINT fk_documents_types_customers
		FOREIGN KEY (doc_type_id)
		REFERENCES documents_types (doc_type_id)
		ON UPDATE CASCADE ON DELETE CASCADE,
		
	CONSTRAINT fk_cities_customers
		FOREIGN KEY (city_id)
		REFERENCES cities (city_id)
		ON UPDATE CASCADE ON DELETE RESTRICT,

	CONSTRAINT pk_customers
		PRIMARY KEY (customer_doc),

	CONSTRAINT ck_sex
		CHECK (sex IN ('M', 'F')),

    -- Verify that the email format is valid
	CONSTRAINT ck_email_format
		CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

-- Nomenclature used in reserve statuses:
-- Character	Status
-- P			Pending
-- C			Confirmed
-- X			Cancelled
-- I			The guest arrived and is occupying the room
-- O			The guest has checked out and the account is closed
CREATE TABLE reserves (
	reserve_id		SERIAL,
	customer_doc	VARCHAR(15) NOT NULL,
	employee_doc	VARCHAR(15) NOT NULL,
	status			CHAR(1)		NOT NULL,
	source			CHAR(1)		NOT NULL, -- Reservation method
	creation_date	TIMESTAMP	NOT NULL,
	limit_date		TIMESTAMP	NOT NULL,
	total			NUMERIC (10,2),

	CONSTRAINT fk_customers_reserves
		FOREIGN KEY (customer_doc)
		REFERENCES customers (customer_doc)
		ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT fk_employees_reserves
		FOREIGN KEY (employee_doc)
		REFERENCES employees (employee_doc)
		ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT pk_reserves
		PRIMARY KEY (reserve_id),

	CONSTRAINT ck_reserves
		CHECK (status IN ('P', 'C', 'X', 'I', 'O')),

	CONSTRAINT ck_source
		CHECK (source IN ('P', 'O', 'T'))
		-- Meanings: Physical, Online, Telephone
);

CREATE TABLE reservation_details (
	line_number		SERIAL,
	reserve_id		INTEGER		NOT NULL,
	room_number		VARCHAR(3) 	NOT NULL,
	hotel_id		VARCHAR(2)	NOT NULL,
	check_in		DATE		NOT NULL,
	check_out		DATE		NOT NULL,
	subtotal		NUMERIC (10,2),

	CONSTRAINT pk_reservation_details
		PRIMARY KEY (line_number),

	CONSTRAINT fk_reserves_reservation_details
		FOREIGN KEY (reserve_id)
		REFERENCES reserves (reserve_id)
		ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT fk_rooms_reservation_details
		FOREIGN KEY (room_number, hotel_id)
		REFERENCES rooms (room_number, hotel_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE guests (
	guest_doc		VARCHAR(15) NOT NULL,
	city_id			SERIAL		NOT NULL, 
	fname			VARCHAR(20)	NOT NULL,
	fsurname		VARCHAR(30)	NOT NULL,
	mname			VARCHAR(20),
	ssurname		VARCHAR(30),
	date_birth		DATE		NOT NULL,

	CONSTRAINT pk_guests
		PRIMARY KEY (guest_doc),

	CONSTRAINT fk_countries_guests
		FOREIGN KEY (country_id)
		REFERENCES countries (country_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE reservation_guests (
	line_number 	INTEGER		NOT NULL,
	guest_doc		VARCHAR(15)	NOT NULL,

	CONSTRAINT pk_reservation_guests
		PRIMARY KEY (line_number, guest_doc),

	CONSTRAINT fk_reservation_details_reservation_guests
		FOREIGN KEY (line_number)
		REFERENCES reservation_details (line_number)
		ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT fk_guests_reservation_guests
		FOREIGN KEY (guest_doc)
		REFERENCES guests (guest_doc)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE invoices (
	invoice_id			SERIAL,
	reserve_id			INTEGER 	NOT NULL,
	employee_doc		VARCHAR(15)	NOT NULL,
	customer_doc		VARCHAR(15)	NOT NULL,
	payment_method_id	VARCHAR(2)	NOT NULL,
	creation_date 		TIMESTAMP 	NOT NULL,
	total				NUMERIC(10,2),
	discount			NUMERIC(10,2) DEFAULT 0.00,

	CONSTRAINT pk_invoices
		PRIMARY KEY (invoice_id),

	CONSTRAINT fk_reserves_invoices
		FOREIGN KEY (reserve_id)
		REFERENCES reserves (reserve_id)
		ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT fk_employees_invoices
		FOREIGN KEY (employee_doc)
		REFERENCES employees (employee_doc)
		ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT fk_customers_invoices
		FOREIGN KEY (customer_doc)
		REFERENCES customers (customer_doc)
		ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT fk_payment_methods_invoices
		FOREIGN KEY (payment_method_id)
		REFERENCES payment_methods (payment_method_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE invoice_details (
	line_number		SERIAL,
	invoice_id		INTEGER			NOT NULL,
	amount 			NUMERIC(10,2) 	NOT NULL,
	description		VARCHAR(200)	NOT NULL,

	CONSTRAINT pk_invoice_details
		PRIMARY KEY (line_number),

	CONSTRAINT fk_invoices_to_invoices_details
		FOREIGN KEY (invoice_id)
		REFERENCES invoices (invoice_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);
