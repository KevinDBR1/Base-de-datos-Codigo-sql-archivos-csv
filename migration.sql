--
-- PostgreSQL database dump
--

-- Dumped from database version 17.10 (Debian 17.10-0+deb13u1)
-- Dumped by pg_dump version 17.10 (Debian 17.10-0+deb13u1)

-- Started on 2026-05-22 20:33:31 -05

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 225 (class 1259 OID 18426)
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    city_id integer NOT NULL,
    department_id character varying(6) NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 18425)
-- Name: cities_city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cities_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cities_city_id_seq OWNER TO postgres;

--
-- TOC entry 4259 (class 0 OID 0)
-- Dependencies: 224
-- Name: cities_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cities_city_id_seq OWNED BY public.cities.city_id;


--
-- TOC entry 222 (class 1259 OID 18406)
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries (
    country_id character(2) NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.countries OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 18497)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    customer_doc character varying(15) NOT NULL,
    doc_type_id character varying(2) NOT NULL,
    city_id integer NOT NULL,
    fname character varying(20) NOT NULL,
    fsurname character varying(30) NOT NULL,
    mname character varying(20),
    ssurname character varying(30),
    phone_number character varying(15) NOT NULL,
    email character varying(40) NOT NULL,
    address character varying(100) NOT NULL,
    sex character(1) NOT NULL,
    date_birth date NOT NULL,
    CONSTRAINT ck_email_format CHECK (((email)::text ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'::text)),
    CONSTRAINT ck_sex CHECK ((sex = ANY (ARRAY['M'::bpchar, 'F'::bpchar])))
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 18413)
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    department_id character varying(6) NOT NULL,
    country_id character(2) NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17795)
-- Name: documents_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents_types (
    doc_type_id character varying(2) NOT NULL,
    name character varying(25) NOT NULL,
    description character varying(200)
);


ALTER TABLE public.documents_types OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 18663)
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    employee_doc character varying(15) NOT NULL,
    doc_type_id character varying(2) NOT NULL,
    position_id character varying(2) NOT NULL,
    hotel_id character varying(2) NOT NULL,
    city_id integer NOT NULL,
    fname character varying(20) NOT NULL,
    fsurname character varying(30) NOT NULL,
    mname character varying(20),
    ssurname character varying(30),
    phone_number character varying(15) NOT NULL,
    email character varying(40) NOT NULL,
    address character varying(100) NOT NULL,
    sex character(1) NOT NULL,
    date_birth date NOT NULL,
    hire_date date NOT NULL,
    check_in time without time zone NOT NULL,
    check_out time without time zone NOT NULL,
    salary numeric(10,2) NOT NULL,
    status character(1) DEFAULT 'A'::bpchar NOT NULL,
    termination_date date,
    CONSTRAINT ck_email_format CHECK (((email)::text ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'::text)),
    CONSTRAINT ck_employee_status CHECK ((status = ANY (ARRAY['A'::bpchar, 'I'::bpchar, 'L'::bpchar]))),
    CONSTRAINT ck_salary CHECK ((salary > 0.00)),
    CONSTRAINT ck_sex CHECK ((sex = ANY (ARRAY['M'::bpchar, 'F'::bpchar]))),
    CONSTRAINT ck_termination_date CHECK (((termination_date IS NULL) OR (termination_date > hire_date)))
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 18457)
-- Name: equipments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equipments (
    equipment_id integer NOT NULL,
    room_number character varying(3),
    hotel_id character varying(2),
    quantity integer NOT NULL,
    name character varying(50) NOT NULL,
    status character varying(1) NOT NULL,
    description character varying(200),
    CONSTRAINT ck_status CHECK (((status)::text = ANY ((ARRAY['O'::character varying, 'D'::character varying, 'R'::character varying])::text[])))
);


ALTER TABLE public.equipments OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 18456)
-- Name: equipments_equipment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.equipments_equipment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.equipments_equipment_id_seq OWNER TO postgres;

--
-- TOC entry 4260 (class 0 OID 0)
-- Dependencies: 226
-- Name: equipments_equipment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.equipments_equipment_id_seq OWNED BY public.equipments.equipment_id;


--
-- TOC entry 233 (class 1259 OID 18550)
-- Name: guests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guests (
    guest_doc character varying(15) NOT NULL,
    country_id character(2) NOT NULL,
    fname character varying(20) NOT NULL,
    fsurname character varying(30) NOT NULL,
    mname character varying(20),
    ssurname character varying(30),
    date_birth date NOT NULL
);


ALTER TABLE public.guests OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17784)
-- Name: hotels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hotels (
    hotel_id character varying(2) NOT NULL,
    location character varying(100) NOT NULL,
    name character varying(50) NOT NULL,
    phone_number character varying(15) NOT NULL,
    email character varying(40) NOT NULL
);


ALTER TABLE public.hotels OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 18604)
-- Name: invoice_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice_details (
    line_number integer NOT NULL,
    invoice_id integer NOT NULL,
    amount numeric(10,2) NOT NULL,
    description character varying(200) NOT NULL
);


ALTER TABLE public.invoice_details OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 18603)
-- Name: invoice_details_line_number_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invoice_details_line_number_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invoice_details_line_number_seq OWNER TO postgres;

--
-- TOC entry 4261 (class 0 OID 0)
-- Dependencies: 237
-- Name: invoice_details_line_number_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invoice_details_line_number_seq OWNED BY public.invoice_details.line_number;


--
-- TOC entry 236 (class 1259 OID 18576)
-- Name: invoices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoices (
    invoice_id integer NOT NULL,
    reserve_id integer NOT NULL,
    employee_doc character varying(15) NOT NULL,
    customer_doc character varying(15) NOT NULL,
    payment_method_id character varying(2) NOT NULL,
    creation_date timestamp without time zone NOT NULL,
    total numeric(10,2),
    discount numeric(10,2) DEFAULT 0.00
);


ALTER TABLE public.invoices OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 18575)
-- Name: invoices_invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invoices_invoice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invoices_invoice_id_seq OWNER TO postgres;

--
-- TOC entry 4262 (class 0 OID 0)
-- Dependencies: 235
-- Name: invoices_invoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invoices_invoice_id_seq OWNED BY public.invoices.invoice_id;


--
-- TOC entry 218 (class 1259 OID 17789)
-- Name: payment_methods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_methods (
    payment_method_id character varying(2) NOT NULL,
    name character varying(30) NOT NULL,
    status character(1) NOT NULL,
    description character varying(100),
    CONSTRAINT ck_status CHECK ((status = ANY (ARRAY['A'::bpchar, 'I'::bpchar, 'E'::bpchar])))
);


ALTER TABLE public.payment_methods OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17800)
-- Name: positions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.positions (
    position_id character varying(2) NOT NULL,
    name character varying(40) NOT NULL,
    description character varying(400) NOT NULL
);


ALTER TABLE public.positions OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 18534)
-- Name: reservation_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservation_details (
    line_number integer NOT NULL,
    reserve_id integer NOT NULL,
    room_number character varying(3) NOT NULL,
    hotel_id character varying(2) NOT NULL,
    check_in date NOT NULL,
    check_out date NOT NULL,
    subtotal numeric(10,2)
);


ALTER TABLE public.reservation_details OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 18533)
-- Name: reservation_details_line_number_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservation_details_line_number_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reservation_details_line_number_seq OWNER TO postgres;

--
-- TOC entry 4263 (class 0 OID 0)
-- Dependencies: 231
-- Name: reservation_details_line_number_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservation_details_line_number_seq OWNED BY public.reservation_details.line_number;


--
-- TOC entry 234 (class 1259 OID 18560)
-- Name: reservation_guests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservation_guests (
    line_number integer NOT NULL,
    guest_doc character varying(15) NOT NULL
);


ALTER TABLE public.reservation_guests OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 18515)
-- Name: reserves; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reserves (
    reserve_id integer NOT NULL,
    customer_doc character varying(15) NOT NULL,
    employee_doc character varying(15) NOT NULL,
    status character(1) NOT NULL,
    source character(1) NOT NULL,
    creation_date timestamp without time zone NOT NULL,
    limit_date timestamp without time zone NOT NULL,
    total numeric(10,2),
    CONSTRAINT ck_reserves CHECK ((status = ANY (ARRAY['P'::bpchar, 'C'::bpchar, 'X'::bpchar, 'I'::bpchar, 'O'::bpchar]))),
    CONSTRAINT ck_source CHECK ((source = ANY (ARRAY['P'::bpchar, 'O'::bpchar, 'T'::bpchar])))
);


ALTER TABLE public.reserves OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 18514)
-- Name: reserves_reserve_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reserves_reserve_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reserves_reserve_id_seq OWNER TO postgres;

--
-- TOC entry 4264 (class 0 OID 0)
-- Dependencies: 229
-- Name: reserves_reserve_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reserves_reserve_id_seq OWNED BY public.reserves.reserve_id;


--
-- TOC entry 239 (class 1259 OID 18615)
-- Name: rooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rooms (
    room_number character varying(3) NOT NULL,
    hotel_id character varying(2) NOT NULL,
    room_type_id character varying(2) NOT NULL,
    status character(1) DEFAULT 'A'::bpchar NOT NULL,
    price_per_night numeric(10,2) NOT NULL,
    CONSTRAINT ck_status CHECK ((status = ANY (ARRAY['A'::bpchar, 'O'::bpchar, 'R'::bpchar, 'M'::bpchar, 'D'::bpchar])))
);


ALTER TABLE public.rooms OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17805)
-- Name: rooms_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rooms_types (
    room_type_id character varying(2) NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(200)
);


ALTER TABLE public.rooms_types OWNER TO postgres;

--
-- TOC entry 4003 (class 2604 OID 18429)
-- Name: cities city_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities ALTER COLUMN city_id SET DEFAULT nextval('public.cities_city_id_seq'::regclass);


--
-- TOC entry 4004 (class 2604 OID 18460)
-- Name: equipments equipment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipments ALTER COLUMN equipment_id SET DEFAULT nextval('public.equipments_equipment_id_seq'::regclass);


--
-- TOC entry 4009 (class 2604 OID 18607)
-- Name: invoice_details line_number; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_details ALTER COLUMN line_number SET DEFAULT nextval('public.invoice_details_line_number_seq'::regclass);


--
-- TOC entry 4007 (class 2604 OID 18579)
-- Name: invoices invoice_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices ALTER COLUMN invoice_id SET DEFAULT nextval('public.invoices_invoice_id_seq'::regclass);


--
-- TOC entry 4006 (class 2604 OID 18537)
-- Name: reservation_details line_number; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation_details ALTER COLUMN line_number SET DEFAULT nextval('public.reservation_details_line_number_seq'::regclass);


--
-- TOC entry 4005 (class 2604 OID 18518)
-- Name: reserves reserve_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserves ALTER COLUMN reserve_id SET DEFAULT nextval('public.reserves_reserve_id_seq'::regclass);


--
-- TOC entry 4238 (class 0 OID 18426)
-- Dependencies: 225
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cities (city_id, department_id, name) VALUES (1, 'CO-NSA', 'Cúcuta');
INSERT INTO public.cities (city_id, department_id, name) VALUES (2, 'CO-NSA', 'Ocaña');
INSERT INTO public.cities (city_id, department_id, name) VALUES (3, 'CO-CUN', 'Bogotá');
INSERT INTO public.cities (city_id, department_id, name) VALUES (4, 'CO-CUN', 'Soacha');
INSERT INTO public.cities (city_id, department_id, name) VALUES (5, 'CO-ANT', 'Medellín');
INSERT INTO public.cities (city_id, department_id, name) VALUES (6, 'CO-ANT', 'Envigado');
INSERT INTO public.cities (city_id, department_id, name) VALUES (7, 'CO-VAL', 'Cali');
INSERT INTO public.cities (city_id, department_id, name) VALUES (8, 'CO-VAL', 'Palmira');
INSERT INTO public.cities (city_id, department_id, name) VALUES (9, 'CO-BOL', 'Cartagena');
INSERT INTO public.cities (city_id, department_id, name) VALUES (10, 'CO-BOL', 'Mompox');
INSERT INTO public.cities (city_id, department_id, name) VALUES (11, 'CO-ATL', 'Barranquilla');
INSERT INTO public.cities (city_id, department_id, name) VALUES (12, 'VE-A', 'Caracas');
INSERT INTO public.cities (city_id, department_id, name) VALUES (13, 'EC-P', 'Quito');
INSERT INTO public.cities (city_id, department_id, name) VALUES (14, 'US-CA', 'Los Ángeles');
INSERT INTO public.cities (city_id, department_id, name) VALUES (15, 'MX-JAL', 'Guadalajara');


--
-- TOC entry 4235 (class 0 OID 18406)
-- Dependencies: 222
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.countries (country_id, name) VALUES ('CO', 'Colombia');
INSERT INTO public.countries (country_id, name) VALUES ('VE', 'Venezuela');
INSERT INTO public.countries (country_id, name) VALUES ('EC', 'Ecuador');
INSERT INTO public.countries (country_id, name) VALUES ('US', 'United States');
INSERT INTO public.countries (country_id, name) VALUES ('MX', 'México');
INSERT INTO public.countries (country_id, name) VALUES ('AR', 'Argentina');
INSERT INTO public.countries (country_id, name) VALUES ('BR', 'Brasil');
INSERT INTO public.countries (country_id, name) VALUES ('PE', 'Perú');
INSERT INTO public.countries (country_id, name) VALUES ('CL', 'Chile');
INSERT INTO public.countries (country_id, name) VALUES ('ES', 'España');


--
-- TOC entry 4241 (class 0 OID 18497)
-- Dependencies: 228
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('87186069', 'CE', 1, 'Alberto', 'Rivera', 'Nicolás', 'López', '3131637275', 'alberto669@correo.com', 'Av 12 #36-33', 'M', '1978-07-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('33032191', 'NI', 6, 'Juan', 'Jiménez', 'Miguel', 'Flores', '3198336655', 'juan968@correo.com', 'Av 1 #16-39', 'M', '1997-12-14');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('87453221', 'CE', 8, 'Fernando', 'Reyes', 'Alejandro', 'Herrera', '3152001565', 'fernando712@correo.com', 'Av 67 #23-78', 'M', '2003-12-31');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('83799431', 'CC', 7, 'Carolina', 'Mendoza', 'Sandra', 'Suárez', '3161241954', 'carolina267@correo.com', 'Av 21 #26-59', 'F', '1982-11-15');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('19470140', 'CE', 9, 'Sebastián', 'Molina', 'Santiago', 'González', '3196647103', 'sebastian649@correo.com', 'Av 25 #46-48', 'M', '1984-03-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('91014793', 'CC', 7, 'Santiago', 'Rivera', 'Luis', 'Ortiz', '3146255595', 'santiago80@correo.com', 'Av 16 #35-15', 'M', '1982-03-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('1004899453', 'CC', 2, 'Yorly', 'Quintero', NULL, NULL, '3173586784', 'yquinteropa@ufpso.edu.co', 'Calle 3 #14 a 54', 'M', '2002-07-14');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('32917330', 'CC', 15, 'Alejandra', 'Suárez', 'Carolina', 'López', '3162286305', 'alejandra970@correo.com', 'Av 24 #23-95', 'F', '1988-07-12');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('34575873', 'TI', 7, 'Ricardo', 'Reyes', 'Daniel', 'Suárez', '3172903261', 'ricardo363@correo.com', 'Av 65 #19-36', 'M', '1999-05-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('51025192', 'CC', 14, 'Fernanda', 'Flores', 'Valentina', 'Cruz', '3151974837', 'fernanda790@correo.com', 'Av 12 #41-11', 'F', '1996-06-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('16832563', 'PP', 9, 'Jorge', 'Morales', 'Juan', 'González', '3160881238', 'jorge508@correo.com', 'Av 22 #24-15', 'M', '1997-12-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('74843897', 'PP', 5, 'Valentina', 'Álvarez', 'Alejandra', 'López', '3138597227', 'valentina272@correo.com', 'Av 1 #48-81', 'F', '1986-05-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('10927505', 'TI', 2, 'Fernando', 'González', 'Pedro', 'Ortiz', '3198131849', 'fernando788@correo.com', 'Av 33 #15-61', 'M', '1973-12-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('81998064', 'CE', 15, 'Natalia', 'Morales', 'Sofía', 'Ortiz', '3168864146', 'natalia112@correo.com', 'Av 57 #11-18', 'F', '1984-03-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('25944033', 'PP', 8, 'Laura', 'Reyes', 'Paola', 'Sánchez', '3183836349', 'laura501@correo.com', 'Av 64 #44-92', 'F', '1997-10-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('27638581', 'TI', 15, 'Felipe', 'Jiménez', 'Camilo', 'Mendoza', '3124479352', 'felipe981@correo.com', 'Av 3 #9-20', 'M', '1969-11-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('30467629', 'NI', 4, 'Catalina', 'Álvarez', 'Ana', 'Ortiz', '3143482865', 'catalina192@correo.com', 'Av 36 #50-15', 'F', '2005-11-12');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('77422120', 'CC', 12, 'Valentina', 'Sánchez', 'Juliana', 'Ramos', '3189349010', 'valentina194@correo.com', 'Av 20 #15-16', 'F', '1976-04-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('55121027', 'CE', 4, 'Fernanda', 'Molina', 'Sofía', 'Cruz', '3118234220', 'fernanda491@correo.com', 'Av 66 #28-83', 'F', '1998-03-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('66112969', 'PP', 5, 'Alejandro', 'Torres', 'Miguel', 'Morales', '3116382911', 'alejandro328@correo.com', 'Av 24 #3-1', 'M', '1982-02-26');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('24276138', 'CC', 7, 'Valentina', 'Sánchez', 'Carolina', 'Medina', '3190776943', 'valentina645@correo.com', 'Av 16 #3-76', 'F', '1971-09-15');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('56022986', 'NI', 9, 'David', 'López', 'Nicolás', 'Martínez', '3173645847', 'david743@correo.com', 'Av 26 #35-93', 'M', '1987-01-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('12935999', 'NI', 9, 'Santiago', 'Ramos', 'Juan', 'Ortiz', '3146795607', 'santiago614@correo.com', 'Av 17 #19-6', 'M', '1974-12-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('20064387', 'NI', 9, 'David', 'Ramos', 'Camilo', 'Reyes', '3178354185', 'david449@correo.com', 'Av 50 #36-50', 'M', '1974-11-06');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('25985787', 'NI', 5, 'Sofía', 'Flores', 'Valentina', 'Molina', '3116122001', 'sofia230@correo.com', 'Av 69 #16-38', 'F', '1975-05-08');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('96223229', 'CC', 14, 'Luis', 'González', 'Sebastián', 'Torres', '3138182016', 'luis844@correo.com', 'Av 69 #8-1', 'M', '1982-05-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('94530413', 'NI', 4, 'Nicolás', 'Rivera', 'Daniel', 'Torres', '3169868610', 'nicolas160@correo.com', 'Av 30 #47-93', 'M', '1995-06-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('62908270', 'CE', 15, 'Alejandro', 'Flores', 'Carlos', 'Pérez', '3129263245', 'alejandro72@correo.com', 'Av 10 #28-32', 'M', '1976-11-07');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('90972685', 'CC', 3, 'Gabriela', 'Mendoza', 'Claudia', 'Jiménez', '3161538339', 'gabriela387@correo.com', 'Av 3 #8-2', 'F', '1968-12-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('94206105', 'CE', 5, 'Luis', 'Álvarez', 'Daniel', 'Martínez', '3111261132', 'luis812@correo.com', 'Av 14 #35-95', 'M', '1961-03-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('69636452', 'NI', 13, 'Ana', 'González', 'Diana', 'Ramos', '3154527579', 'ana315@correo.com', 'Av 62 #10-32', 'F', '1974-08-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('15976158', 'CC', 2, 'Alberto', 'Cruz', 'Sebastián', 'Herrera', '3149827566', 'alberto558@correo.com', 'Av 14 #33-54', 'M', '1969-03-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('57957055', 'PP', 2, 'Hernando', 'López', 'Jorge', 'Ramírez', '3154791783', 'hernando631@correo.com', 'Av 16 #24-11', 'M', '1966-11-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('90478491', 'PP', 9, 'Pedro', 'Pérez', 'Luis', 'Ortiz', '3167075357', 'pedro696@correo.com', 'Av 20 #43-88', 'M', '1976-04-08');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('98816127', 'TI', 5, 'Yolanda', 'Morales', 'Sofía', 'López', '3145621515', 'yolanda956@correo.com', 'Av 10 #1-20', 'F', '1993-02-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('81641483', 'NI', 8, 'Daniel', 'Ortiz', 'Camilo', 'Herrera', '3181969231', 'daniel546@correo.com', 'Av 30 #25-11', 'M', '2004-03-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('60661928', 'CE', 12, 'Andrés', 'López', 'Luis', 'Molina', '3167003442', 'andres713@correo.com', 'Av 48 #4-90', 'M', '1962-05-13');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('14051460', 'CE', 14, 'Roberto', 'Ramos', 'Juan', 'Suárez', '3128961944', 'roberto375@correo.com', 'Av 11 #16-10', 'M', '1973-03-06');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('28805567', 'TI', 3, 'Roberto', 'González', 'Santiago', 'Álvarez', '3165233612', 'roberto482@correo.com', 'Av 44 #29-83', 'M', '1986-11-14');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('50226291', 'CE', 4, 'Miguel', 'Ramírez', NULL, 'Rodríguez', '3128013093', 'miguel981@correo.com', 'Av 78 #36-28', 'M', '1979-04-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('91090807', 'CC', 15, 'Alejandro', 'González', 'Miguel', 'Rodríguez', '3131521650', 'alejandro516@correo.com', 'Av 2 #26-55', 'M', '1975-07-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('66864059', 'CE', 5, 'Alejandra', 'Medina', 'Carolina', 'Jiménez', '3122339511', 'alejandra279@correo.com', 'Av 67 #25-17', 'F', '1974-01-25');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('91212919', 'NI', 3, 'Camilo', 'Ramírez', 'Andrés', 'Castro', '3172872428', 'camilo837@correo.com', 'Av 62 #21-84', 'M', '1966-12-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('18766990', 'CC', 9, 'María', 'Flores', 'Valentina', 'Pérez', '3111473309', 'maria612@correo.com', 'Av 40 #13-71', 'F', '1979-01-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('16022958', 'NI', 10, 'Andrés', 'Torres', 'Daniel', 'Martínez', '3116449014', 'andres47@correo.com', 'Av 41 #6-40', 'M', '2003-05-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('15370440', 'TI', 10, 'Sandra', 'Flores', 'Isabella', 'Morales', '3138027431', 'sandra245@correo.com', 'Av 79 #39-10', 'F', '1994-10-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('48470165', 'PP', 1, 'Sandra', 'Medina', 'Claudia', 'Ramos', '3193172511', 'sandra419@correo.com', 'Av 17 #29-47', 'F', '1995-12-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('45276100', 'TI', 9, 'Natalia', 'Reyes', 'Ana', 'Ortiz', '3196418337', 'natalia636@correo.com', 'Av 8 #48-32', 'F', '1963-10-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('63590510', 'NI', 3, 'Luis', 'Flores', 'Miguel', 'Castro', '3162106408', 'luis229@correo.com', 'Av 60 #43-12', 'M', '1966-07-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('24645711', 'TI', 15, 'Daniela', 'Cruz', 'Yolanda', 'Herrera', '3124542266', 'daniela185@correo.com', 'Av 51 #50-56', 'F', '1967-09-13');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('52974720', 'CE', 11, 'Alberto', 'Ramos', 'Luis', 'González', '3161040965', 'alberto616@correo.com', 'Av 8 #24-56', 'M', '1962-10-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('46218400', 'TI', 13, 'Diana', 'Sánchez', 'Laura', 'García', '3133636496', 'diana651@correo.com', 'Av 11 #10-9', 'F', '1982-08-12');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('80434503', 'TI', 8, 'Gabriela', 'Flores', 'Ana', 'Molina', '3144822417', 'gabriela686@correo.com', 'Av 24 #4-12', 'F', '1979-03-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('74642647', 'TI', 6, 'Isabella', 'Pérez', 'Sofía', 'Sánchez', '3131567333', 'isabella549@correo.com', 'Av 56 #23-89', 'F', '2002-08-29');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('45272780', 'TI', 13, 'Sandra', 'Rivera', 'Catalina', 'López', '3126873477', 'sandra462@correo.com', 'Av 58 #41-75', 'F', '1960-04-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('32293702', 'NI', 7, 'Andrés', 'Mendoza', 'David', 'Sánchez', '3156719252', 'andres222@correo.com', 'Av 27 #13-87', 'M', '1993-11-14');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('77388734', 'PP', 15, 'Ricardo', 'García', 'Pedro', 'Flores', '3176992183', 'ricardo717@correo.com', 'Av 59 #27-53', 'M', '1971-03-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('25217605', 'PP', 13, 'Natalia', 'Ortiz', 'Alejandra', 'Jiménez', '3167496675', 'natalia470@correo.com', 'Av 48 #12-71', 'F', '1975-10-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('61147669', 'NI', 8, 'Juliana', 'Ramírez', 'Diana', 'Álvarez', '3173025187', 'juliana201@correo.com', 'Av 16 #23-60', 'F', '1970-04-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('45917890', 'PP', 9, 'Gabriela', 'Morales', 'María', 'Ramírez', '3165662309', 'gabriela315@correo.com', 'Av 31 #1-54', 'F', '1983-09-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('95399182', 'CE', 7, 'Diana', 'Rodríguez', 'Gabriela', 'Medina', '3133315937', 'diana746@correo.com', 'Av 52 #21-67', 'F', '1995-01-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('77680235', 'CE', 13, 'Santiago', 'López', 'Daniel', 'Molina', '3187434736', 'santiago647@correo.com', 'Av 51 #49-81', 'M', '1970-08-14');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('13441373', 'CC', 2, 'Alejandra', 'Rivera', 'Paola', 'Sánchez', '3194408740', 'alejandra12@correo.com', 'Av 76 #10-4', 'F', '1999-03-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('22452337', 'CE', 15, 'Miguel', 'Flores', 'Luis', 'Torres', '3158505926', 'miguel507@correo.com', 'Av 27 #26-13', 'M', '1966-12-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('38225447', 'CC', 11, 'María', 'Martínez', 'Juliana', 'Ramos', '3152088657', 'maria385@correo.com', 'Av 58 #11-24', 'F', '1997-09-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('61411543', 'NI', 2, 'Yolanda', 'Rivera', 'Carolina', 'Suárez', '3186120515', 'yolanda205@correo.com', 'Av 46 #24-81', 'F', '1998-07-07');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('65003534', 'NI', 5, 'Nicolás', 'Rodríguez', 'Jorge', 'Jiménez', '3196583583', 'nicolas619@correo.com', 'Av 68 #23-51', 'M', '1986-04-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('58015656', 'CE', 13, 'Miguel', 'Rivera', 'Jorge', 'Ortiz', '3138881529', 'miguel75@correo.com', 'Av 48 #24-19', 'M', '1982-01-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('47319033', 'NI', 2, 'Sofía', 'Jiménez', 'Diana', 'Sánchez', '3196740906', 'sofia588@correo.com', 'Av 54 #44-97', 'F', '1966-09-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('76927800', 'TI', 13, 'Isabella', 'Sánchez', 'Yolanda', 'Rodríguez', '3166537506', 'isabella282@correo.com', 'Av 16 #8-58', 'F', '1964-03-13');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('12854636', 'NI', 4, 'Pedro', 'Medina', 'Felipe', 'Castro', '3196391469', 'pedro19@correo.com', 'Av 74 #1-60', 'M', '1985-07-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('15250630', 'NI', 15, 'Sandra', 'Rodríguez', 'Gabriela', 'Herrera', '3112184030', 'sandra661@correo.com', 'Av 9 #31-13', 'F', '1990-04-08');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('20706173', 'TI', 6, 'Sofía', 'Rivera', 'Carolina', 'Álvarez', '3192184286', 'sofia506@correo.com', 'Av 7 #26-39', 'F', '1988-02-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('82149862', 'PP', 12, 'Valentina', 'Martínez', 'Paola', 'Sánchez', '3117045220', 'valentina957@correo.com', 'Av 34 #3-15', 'F', '1960-06-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('60943206', 'NI', 12, 'Alejandro', 'Torres', 'Juan', 'Rivera', '3132862463', 'alejandro716@correo.com', 'Av 18 #38-59', 'M', '1984-03-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('40310459', 'TI', 12, 'Catalina', 'Rivera', 'Carolina', 'Álvarez', '3149759879', 'catalina271@correo.com', 'Av 11 #23-72', 'F', '1968-03-27');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('11762024', 'CE', 1, 'David', 'Martínez', 'Juan', 'Ramos', '3161681908', 'david480@correo.com', 'Av 25 #32-14', 'M', '1979-05-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('63714593', 'CE', 9, 'Ricardo', 'Vargas', 'Camilo', 'Suárez', '3147290843', 'ricardo71@correo.com', 'Av 55 #11-88', 'M', '1976-11-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('24790683', 'CC', 15, 'Marcela', 'González', 'Claudia', 'Vargas', '3171853813', 'marcela17@correo.com', 'Av 24 #18-4', 'F', '1981-07-31');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('21283250', 'NI', 2, 'Fernanda', 'Morales', 'Daniela', 'Torres', '3138463020', 'fernanda442@correo.com', 'Av 20 #26-65', 'F', '1991-10-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('23128198', 'PP', 5, 'Fernanda', 'Rodríguez', 'Isabella', 'Vargas', '3161341304', 'fernanda665@correo.com', 'Av 55 #13-38', 'F', '1964-05-29');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('76252048', 'NI', 9, 'Camilo', 'Suárez', 'Jorge', 'Torres', '3116693632', 'camilo112@correo.com', 'Av 32 #8-29', 'M', '1998-11-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('81421511', 'CC', 4, 'Andrés', 'Medina', 'Pedro', 'Torres', '3140395619', 'andres283@correo.com', 'Av 80 #45-92', 'M', '1969-01-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('99393218', 'CC', 3, 'Jorge', 'Rivera', 'Pedro', 'Vargas', '3154835989', 'jorge439@correo.com', 'Av 3 #12-34', 'M', '2002-07-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('10135086', 'NI', 8, 'Jorge', 'Suárez', 'Carlos', 'Morales', '3143220287', 'jorge895@correo.com', 'Av 61 #8-6', 'M', '2003-10-22');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('29674031', 'CE', 9, 'Roberto', 'Ramírez', 'Alejandro', 'Jiménez', '3150883024', 'roberto103@correo.com', 'Av 43 #29-63', 'M', '1968-06-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('71572485', 'PP', 5, 'Alejandra', 'Reyes', 'Carolina', 'Ramos', '3157328711', 'alejandra848@correo.com', 'Av 39 #46-43', 'F', '1961-03-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('29850853', 'CC', 12, 'Claudia', 'Reyes', 'Carolina', 'Jiménez', '3139562206', 'claudia877@correo.com', 'Av 19 #23-64', 'F', '1996-10-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('37690126', 'PP', 7, 'Daniel', 'Mendoza', 'Roberto', 'Molina', '3160704539', 'daniel199@correo.com', 'Av 14 #18-81', 'M', '1968-01-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('62482651', 'PP', 6, 'Fernanda', 'Torres', 'Paola', 'Reyes', '3147077262', 'fernanda968@correo.com', 'Av 40 #13-6', 'F', '1997-06-08');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('48709538', 'PP', 10, 'Yolanda', 'Ortiz', 'Claudia', 'Vargas', '3111118688', 'yolanda993@correo.com', 'Av 64 #44-19', 'F', '1969-11-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('50754622', 'CE', 9, 'Sandra', 'Flores', 'Fernanda', 'Suárez', '3118672678', 'sandra296@correo.com', 'Av 38 #1-59', 'F', '2003-09-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('57597933', 'TI', 1, 'Marcela', 'Flores', 'Ana', 'Ramírez', '3195502685', 'marcela832@correo.com', 'Av 50 #28-52', 'F', '1982-04-25');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('50935883', 'PP', 4, 'Sebastián', 'Ortiz', 'Luis', 'Herrera', '3186056500', 'sebastian305@correo.com', 'Av 60 #35-24', 'M', '1967-09-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('54759391', 'CC', 14, 'Laura', 'Rodríguez', 'Ana', 'Torres', '3149000574', 'laura842@correo.com', 'Av 73 #31-89', 'F', '1968-09-26');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('17116259', 'NI', 11, 'Laura', 'Mendoza', 'Claudia', 'Medina', '3129347740', 'laura529@correo.com', 'Av 72 #48-64', 'F', '1978-05-25');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('13309323', 'TI', 2, 'Fernando', 'Ramírez', 'Miguel', 'Sánchez', '3162440731', 'fernando455@correo.com', 'Av 8 #8-39', 'M', '2005-05-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('73908898', 'CE', 9, 'Jorge', 'Mendoza', 'Fernando', 'Molina', '3148849191', 'jorge297@correo.com', 'Av 13 #38-64', 'M', '2003-02-07');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('38290431', 'NI', 9, 'Carolina', 'Pérez', 'María', 'Morales', '3180471776', 'carolina925@correo.com', 'Av 50 #33-9', 'F', '1991-04-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('78045733', 'NI', 3, 'Gabriela', 'Suárez', 'Catalina', 'Reyes', '3153496826', 'gabriela133@correo.com', 'Av 76 #38-45', 'F', '1983-04-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('33362909', 'CC', 14, 'Nicolás', 'Suárez', 'Ricardo', 'Cruz', '3170332161', 'nicolas111@correo.com', 'Av 49 #9-82', 'M', '1988-10-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('14461288', 'CE', 2, 'Roberto', 'Cruz', 'Carlos', 'Reyes', '3110702802', 'roberto915@correo.com', 'Av 47 #50-53', 'M', '1972-08-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('76595544', 'NI', 15, 'Felipe', 'Reyes', 'Jorge', 'Mendoza', '3137846793', 'felipe853@correo.com', 'Av 74 #31-65', 'M', '1977-01-21');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('42399944', 'NI', 9, 'Ana', 'Flores', 'Paola', 'Martínez', '3163582355', 'ana320@correo.com', 'Av 80 #4-70', 'F', '2004-11-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('55371664', 'CC', 1, 'Roberto', 'Torres', 'Hernando', 'Cruz', '3136912165', 'roberto268@correo.com', 'Av 43 #49-8', 'M', '1997-10-21');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('67917038', 'PP', 11, 'Andrés', 'Jiménez', 'Hernando', 'Ramírez', '3140568777', 'andres311@correo.com', 'Av 3 #4-4', 'M', '2002-11-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('59353022', 'NI', 2, 'Alejandra', 'López', 'Sandra', 'Vargas', '3156053543', 'alejandra199@correo.com', 'Av 56 #4-31', 'F', '1991-07-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('40942008', 'NI', 14, 'Carolina', 'Sánchez', 'Ana', 'González', '3184217795', 'carolina760@correo.com', 'Av 27 #8-48', 'F', '1987-05-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('61531052', 'NI', 14, 'Sofía', 'Rodríguez', 'Ana', 'Torres', '3161350116', 'sofia20@correo.com', 'Av 50 #29-6', 'F', '2004-06-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('82853994', 'CE', 2, 'Carlos', 'Reyes', 'Sebastián', 'Torres', '3186649413', 'carlos346@correo.com', 'Av 51 #3-79', 'M', '1986-07-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('11656128', 'NI', 13, 'Natalia', 'Reyes', 'Carolina', 'Torres', '3186294869', 'natalia315@correo.com', 'Av 42 #17-23', 'F', '1971-02-25');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('58147073', 'CC', 8, 'Daniela', 'Vargas', 'María', 'García', '3184706716', 'daniela654@correo.com', 'Av 28 #27-8', 'F', '2003-01-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('44629107', 'CE', 8, 'Sebastián', 'Rivera', 'Alberto', 'Martínez', '3176428236', 'sebastian266@correo.com', 'Av 17 #15-81', 'M', '1984-10-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('34730353', 'CC', 11, 'Luis', 'Ramírez', 'Andrés', 'López', '3169097257', 'luis882@correo.com', 'Av 75 #21-6', 'M', '2005-06-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('82536810', 'PP', 11, 'Andrés', 'Torres', 'Sebastián', 'García', '3141500479', 'andres615@correo.com', 'Av 45 #7-10', 'M', '1964-01-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('54961030', 'PP', 13, 'Sandra', 'Rivera', 'María', 'Suárez', '3197507034', 'sandra919@correo.com', 'Av 48 #31-38', 'F', '1996-08-12');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('89353203', 'CE', 15, 'Jorge', 'Rodríguez', 'Ricardo', 'Flores', '3191743716', 'jorge109@correo.com', 'Av 28 #21-66', 'M', '1962-04-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('61148988', 'CE', 11, 'Diana', 'Medina', 'Gabriela', 'Rodríguez', '3120376565', 'diana979@correo.com', 'Av 29 #37-65', 'F', '1967-01-14');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('52253938', 'TI', 4, 'Felipe', 'Álvarez', 'Daniel', 'Morales', '3142352710', 'felipe710@correo.com', 'Av 57 #47-53', 'M', '1970-05-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('99375941', 'NI', 11, 'Alberto', 'Álvarez', 'Daniel', 'Ortiz', '3144934049', 'alberto621@correo.com', 'Av 37 #22-41', 'M', '1972-05-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('76330432', 'NI', 3, 'Juan', 'Ortiz', 'Santiago', 'Jiménez', '3134147877', 'juan922@correo.com', 'Av 59 #1-22', 'M', '1977-10-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('23555369', 'TI', 12, 'Santiago', 'Álvarez', 'Sebastián', 'Herrera', '3114573558', 'santiago891@correo.com', 'Av 56 #2-89', 'M', '1971-05-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('16071701', 'CC', 10, 'Felipe', 'Medina', 'Pedro', 'Suárez', '3157641606', 'felipe757@correo.com', 'Av 58 #27-81', 'M', '1966-08-13');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('34622346', 'CE', 12, 'Juliana', 'Álvarez', 'Sofía', 'Ramos', '3130435507', 'juliana86@correo.com', 'Av 1 #38-76', 'F', '2005-09-12');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('48286573', 'TI', 9, 'Laura', 'Jiménez', 'Marcela', 'Medina', '3152758855', 'laura394@correo.com', 'Av 23 #10-6', 'F', '1988-12-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('52193677', 'NI', 15, 'Santiago', 'Torres', 'Fernando', 'Medina', '3148223995', 'santiago356@correo.com', 'Av 22 #8-37', 'M', '1968-12-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('91358784', 'PP', 5, 'Catalina', 'Ramírez', 'Daniela', 'Pérez', '3141094836', 'catalina947@correo.com', 'Av 36 #10-13', 'F', '1969-07-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('15334488', 'NI', 1, 'Alberto', 'Álvarez', 'Fernando', 'Pérez', '3175547360', 'alberto7@correo.com', 'Av 4 #24-27', 'M', '1977-07-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('79297448', 'CC', 15, 'Sofía', 'Sánchez', 'Sandra', 'Cruz', '3168293280', 'sofia4@correo.com', 'Av 9 #32-72', 'F', '1979-03-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('61041690', 'NI', 5, 'Jorge', 'Ortiz', 'Andrés', 'Molina', '3156802228', 'jorge654@correo.com', 'Av 62 #34-85', 'M', '1981-01-21');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('53674052', 'TI', 7, 'Daniel', 'Álvarez', 'Miguel', 'Flores', '3167024453', 'daniel679@correo.com', 'Av 15 #12-60', 'M', '1982-03-12');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('74926313', 'CE', 12, 'Claudia', 'Molina', 'Natalia', 'Castro', '3165298095', 'claudia616@correo.com', 'Av 31 #2-38', 'F', '2003-11-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('45112062', 'PP', 9, 'Fernanda', 'Ortiz', 'Diana', 'Rodríguez', '3162529918', 'fernanda422@correo.com', 'Av 57 #28-52', 'F', '1988-06-29');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('95398202', 'PP', 4, 'Laura', 'Ramos', 'Carolina', 'Mendoza', '3170080733', 'laura316@correo.com', 'Av 53 #15-74', 'F', '1964-02-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('91973665', 'NI', 2, 'Alberto', 'Álvarez', 'David', 'Cruz', '3191196518', 'alberto133@correo.com', 'Av 70 #2-93', 'M', '1989-07-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('84208202', 'PP', 6, 'Camilo', 'Álvarez', 'Juan', 'Molina', '3116605553', 'camilo671@correo.com', 'Av 67 #14-47', 'M', '1965-09-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('31663301', 'PP', 4, 'Jorge', 'Castro', 'Alberto', 'Molina', '3165484975', 'jorge340@correo.com', 'Av 28 #36-94', 'M', '1993-07-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('77310099', 'CC', 9, 'Carlos', 'García', 'Andrés', 'Álvarez', '3175082169', 'carlos811@correo.com', 'Av 6 #11-37', 'M', '1995-09-13');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('50554420', 'CC', 9, 'Diana', 'Rivera', 'Sofía', 'Ortiz', '3137201463', 'diana470@correo.com', 'Av 13 #17-84', 'F', '1984-08-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('24536356', 'NI', 6, 'María', 'Mendoza', 'Catalina', 'Castro', '3187561671', 'maria230@correo.com', 'Av 4 #26-99', 'F', '2000-07-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('54618734', 'PP', 2, 'Nicolás', 'Ramos', 'Ricardo', 'Medina', '3194545602', 'nicolas830@correo.com', 'Av 11 #7-72', 'M', '1972-11-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('64115926', 'CE', 2, 'David', 'Medina', 'Hernando', 'Ramírez', '3186053026', 'david536@correo.com', 'Av 30 #4-99', 'M', '2002-06-25');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('80126092', 'PP', 15, 'Claudia', 'Flores', 'Juliana', 'Mendoza', '3159879577', 'claudia630@correo.com', 'Av 73 #42-22', 'F', '1988-12-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('59828775', 'NI', 13, 'Alejandro', 'Reyes', 'Fernando', 'Sánchez', '3172126724', 'alejandro484@correo.com', 'Av 27 #22-96', 'M', '1982-07-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('18201748', 'CC', 6, 'David', 'Herrera', 'Miguel', 'Vargas', '3130998769', 'david609@correo.com', 'Av 9 #23-82', 'M', '2002-01-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('88446018', 'TI', 5, 'Ricardo', 'Sánchez', 'Carlos', 'Torres', '3193819096', 'ricardo377@correo.com', 'Av 52 #17-72', 'M', '1987-06-06');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('47579022', 'CE', 12, 'Juan', 'González', 'Roberto', 'López', '3185653133', 'juan270@correo.com', 'Av 14 #9-67', 'M', '1975-12-31');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('42315990', 'CC', 13, 'Catalina', 'Flores', 'Isabella', 'Jiménez', '3161744941', 'catalina387@correo.com', 'Av 61 #23-40', 'F', '1995-04-12');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('29177565', 'PP', 3, 'Fernanda', 'Suárez', 'Ana', 'Sánchez', '3169276832', 'fernanda574@correo.com', 'Av 63 #45-33', 'F', '1999-03-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('59081701', 'CC', 3, 'Alberto', 'Cruz', 'Santiago', 'Morales', '3199931125', 'alberto790@correo.com', 'Av 45 #47-55', 'M', '2001-10-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('14083774', 'NI', 1, 'Laura', 'Torres', 'Carolina', 'Cruz', '3194857827', 'laura623@correo.com', 'Av 59 #32-23', 'F', '2002-03-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('47242488', 'NI', 14, 'Nicolás', 'Rivera', 'Andrés', 'López', '3192410193', 'nicolas671@correo.com', 'Av 3 #22-87', 'M', '1977-06-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('72579321', 'PP', 2, 'Alejandro', 'Herrera', 'Sebastián', 'Morales', '3172143529', 'alejandro580@correo.com', 'Av 12 #8-12', 'M', '1967-09-22');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('32727871', 'CC', 11, 'Juan', 'Rivera', 'Jorge', 'Medina', '3195623611', 'juan223@correo.com', 'Av 48 #30-11', 'M', '1960-12-08');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('37843059', 'PP', 13, 'Santiago', 'Cruz', 'Ricardo', 'Reyes', '3177614227', 'santiago717@correo.com', 'Av 71 #48-35', 'M', '1990-09-12');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('14543241', 'NI', 7, 'Marcela', 'Morales', 'Isabella', 'Medina', '3124040914', 'marcela719@correo.com', 'Av 46 #1-21', 'F', '1988-12-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('80341559', 'NI', 15, 'Jorge', 'Pérez', 'Fernando', 'Flores', '3186234095', 'jorge975@correo.com', 'Av 18 #9-85', 'M', '1977-10-21');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('71567486', 'PP', 3, 'Laura', 'Flores', 'Ana', 'Álvarez', '3171819038', 'laura170@correo.com', 'Av 1 #43-19', 'F', '1995-07-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('39755270', 'CC', 10, 'Ricardo', 'Reyes', 'Hernando', 'Mendoza', '3141562316', 'ricardo787@correo.com', 'Av 48 #24-44', 'M', '1975-12-25');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('61917499', 'PP', 5, 'Gabriela', 'Ortiz', 'Paola', 'González', '3145033443', 'gabriela36@correo.com', 'Av 54 #12-21', 'F', '2003-02-14');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('98029193', 'CC', 6, 'Fernanda', 'Vargas', 'Claudia', 'Martínez', '3111640743', 'fernanda823@correo.com', 'Av 21 #21-17', 'F', '1996-04-14');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('44606236', 'NI', 15, 'Ana', 'García', 'Sandra', 'Rivera', '3192479493', 'ana528@correo.com', 'Av 59 #28-7', 'F', '1977-09-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('12351359', 'TI', 6, 'Alberto', 'Pérez', 'Sebastián', 'Flores', '3149954382', 'alberto333@correo.com', 'Av 5 #39-15', 'M', '2000-01-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('21280578', 'CE', 4, 'Laura', 'Mendoza', 'Alejandra', 'Castro', '3129413831', 'laura130@correo.com', 'Av 64 #28-36', 'F', '1968-06-25');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('15454740', 'TI', 10, 'Daniela', 'Mendoza', 'Valentina', 'Jiménez', '3160035742', 'daniela335@correo.com', 'Av 5 #10-78', 'F', '1966-11-12');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('92621946', 'PP', 5, 'Santiago', 'Sánchez', 'Miguel', 'Medina', '3116554015', 'santiago711@correo.com', 'Av 48 #37-61', 'M', '1981-11-13');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('47158689', 'CE', 13, 'Santiago', 'Mendoza', 'Sebastián', 'Molina', '3116139411', 'santiago688@correo.com', 'Av 78 #26-24', 'M', '2004-12-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('98209607', 'TI', 1, 'Carolina', 'Ortiz', 'María', 'Sánchez', '3145843284', 'carolina282@correo.com', 'Av 60 #39-82', 'F', '1971-08-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('11686744', 'NI', 8, 'Yolanda', 'Herrera', 'Isabella', 'Castro', '3152901731', 'yolanda349@correo.com', 'Av 45 #29-20', 'F', '1990-10-07');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('44318479', 'TI', 3, 'Catalina', 'Herrera', 'Diana', 'Molina', '3198677450', 'catalina34@correo.com', 'Av 74 #6-81', 'F', '1996-02-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('77418191', 'PP', 13, 'Natalia', 'Reyes', 'Claudia', 'Cruz', '3164219394', 'natalia231@correo.com', 'Av 64 #49-60', 'F', '1995-03-08');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('81493180', 'CC', 5, 'Daniela', 'Pérez', 'Paola', 'Castro', '3172279909', 'daniela782@correo.com', 'Av 23 #44-13', 'F', '1989-12-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('93064126', 'CC', 11, 'Marcela', 'Ortiz', 'Juliana', 'Sánchez', '3191833362', 'marcela142@correo.com', 'Av 80 #33-11', 'F', '1980-02-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('42120359', 'PP', 8, 'Alejandra', 'Sánchez', 'Fernanda', 'Pérez', '3136814729', 'alejandra484@correo.com', 'Av 42 #9-38', 'F', '1975-09-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('10923862', 'CC', 8, 'Pedro', 'Pérez', 'Felipe', 'Ramírez', '3164538931', 'pedro699@correo.com', 'Av 67 #31-50', 'M', '1962-11-25');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('42624124', 'CE', 6, 'Jorge', 'Ortiz', 'Ricardo', 'Reyes', '3145501623', 'jorge216@correo.com', 'Av 13 #22-83', 'M', '2003-04-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('55961908', 'PP', 13, 'Nicolás', 'Álvarez', 'Hernando', 'Ramírez', '3169682874', 'nicolas706@correo.com', 'Av 43 #29-90', 'M', '1986-06-29');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('29867441', 'CE', 13, 'Marcela', 'Suárez', 'Carolina', 'Rodríguez', '3139665008', 'marcela27@correo.com', 'Av 48 #37-47', 'F', '1985-11-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('69037325', 'TI', 5, 'Sofía', 'Medina', 'Paola', 'Cruz', '3127254103', 'sofia159@correo.com', 'Av 19 #39-38', 'F', '1986-06-15');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('29912993', 'PP', 10, 'Carolina', 'García', 'Valentina', 'Sánchez', '3158876968', 'carolina266@correo.com', 'Av 66 #48-67', 'F', '1961-01-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('77255871', 'NI', 3, 'Catalina', 'Morales', 'Paola', 'Cruz', '3160246095', 'catalina536@correo.com', 'Av 49 #32-83', 'F', '1988-03-12');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('11910266', 'TI', 15, 'Fernando', 'Pérez', 'Hernando', 'Ramos', '3140175524', 'fernando351@correo.com', 'Av 40 #14-29', 'M', '1965-10-22');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('19019126', 'NI', 6, 'Laura', 'Cruz', 'Gabriela', 'López', '3181773449', 'laura567@correo.com', 'Av 69 #6-8', 'F', '1984-05-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('97349865', 'CE', 13, 'Marcela', 'Ramírez', 'Fernanda', 'Torres', '3171212149', 'marcela234@correo.com', 'Av 23 #3-78', 'F', '1981-12-27');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('27790417', 'CC', 4, 'Alejandra', 'Martínez', 'Carolina', 'Mendoza', '3137881323', 'alejandra63@correo.com', 'Av 30 #16-75', 'F', '1987-02-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('36363828', 'CC', 6, 'Daniela', 'Herrera', 'Claudia', 'Rodríguez', '3169310555', 'daniela120@correo.com', 'Av 11 #31-26', 'F', '2002-11-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('90712387', 'TI', 13, 'Roberto', 'García', 'Nicolás', 'Torres', '3194708592', 'roberto505@correo.com', 'Av 23 #22-65', 'M', '1984-04-15');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('43423167', 'NI', 5, 'Fernanda', 'Cruz', 'Sofía', 'Flores', '3185331621', 'fernanda282@correo.com', 'Av 65 #20-81', 'F', '1990-08-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('91809287', 'PP', 11, 'Isabella', 'Ramos', 'Fernanda', 'López', '3130749745', 'isabella585@correo.com', 'Av 42 #11-25', 'F', '1978-11-12');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('79318932', 'PP', 3, 'Paola', 'Suárez', 'Yolanda', 'Reyes', '3189890370', 'paola670@correo.com', 'Av 54 #50-93', 'F', '2002-07-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('51101815', 'CE', 6, 'Valentina', 'Ramos', 'Carolina', 'Flores', '3157504159', 'valentina745@correo.com', 'Av 41 #29-40', 'F', '1989-12-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('17423236', 'TI', 1, 'Marcela', 'Álvarez', 'Gabriela', 'Ortiz', '3196676830', 'marcela363@correo.com', 'Av 18 #30-99', 'F', '1996-09-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('49566968', 'PP', 12, 'María', 'Sánchez', 'Diana', 'Reyes', '3153197411', 'maria25@correo.com', 'Av 55 #25-42', 'F', '1993-07-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('17961369', 'TI', 10, 'Catalina', 'Torres', 'Valentina', 'Suárez', '3195849506', 'catalina58@correo.com', 'Av 44 #18-69', 'F', '1969-02-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('53559761', 'CC', 3, 'Daniela', 'López', 'Sofía', 'Ramos', '3130370571', 'daniela845@correo.com', 'Av 20 #38-39', 'F', '1997-02-13');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('34714856', 'CE', 8, 'Juan', 'Morales', 'Felipe', 'Álvarez', '3140558998', 'juan480@correo.com', 'Av 59 #24-43', 'M', '1988-10-27');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('85874195', 'CC', 12, 'Marcela', 'Cruz', 'Isabella', 'Martínez', '3184932501', 'marcela998@correo.com', 'Av 15 #35-21', 'F', '1968-04-07');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('67840690', 'CC', 4, 'Roberto', 'Suárez', 'Nicolás', 'Cruz', '3170570928', 'roberto477@correo.com', 'Av 20 #42-43', 'M', '1984-11-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('12883470', 'TI', 9, 'Jorge', 'Rivera', 'Roberto', 'Vargas', '3149435019', 'jorge589@correo.com', 'Av 1 #40-50', 'M', '1996-01-07');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('39915787', 'PP', 3, 'Carlos', 'Rivera', 'Daniel', 'Ortiz', '3171438610', 'carlos546@correo.com', 'Av 26 #50-74', 'M', '1989-04-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('51403708', 'CE', 3, 'Marcela', 'Sánchez', 'Sandra', 'Álvarez', '3113519791', 'marcela104@correo.com', 'Av 69 #39-6', 'F', '1976-04-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('58102338', 'NI', 12, 'Jorge', 'López', 'David', 'Ramos', '3135633055', 'jorge426@correo.com', 'Av 27 #6-65', 'M', '1988-06-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('10973829', 'CC', 8, 'Catalina', 'Jiménez', 'Carolina', 'López', '3166373318', 'catalina823@correo.com', 'Av 52 #7-46', 'F', '1994-02-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('21334884', 'CE', 5, 'Sofía', 'Ortiz', 'Ana', 'Cruz', '3173265064', 'sofia897@correo.com', 'Av 3 #18-94', 'F', '1994-12-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('27172930', 'CC', 10, 'Laura', 'Ramírez', 'Sandra', 'Pérez', '3173057193', 'laura144@correo.com', 'Av 5 #4-77', 'F', '1973-12-21');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('51079324', 'CE', 8, 'Ricardo', 'Pérez', 'Miguel', 'García', '3160087924', 'ricardo641@correo.com', 'Av 34 #40-42', 'M', '1996-03-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('22364660', 'CE', 15, 'Jorge', 'García', 'Miguel', 'Morales', '3125087493', 'jorge68@correo.com', 'Av 61 #30-54', 'M', '1997-09-01');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('27206526', 'PP', 8, 'Sandra', 'Flores', 'María', 'Ramos', '3182475706', 'sandra673@correo.com', 'Av 47 #40-86', 'F', '1988-12-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('39435441', 'CE', 4, 'Hernando', 'Mendoza', 'Pedro', 'Medina', '3129138848', 'hernando825@correo.com', 'Av 29 #43-11', 'M', '1971-08-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('27677427', 'PP', 15, 'Marcela', 'Jiménez', 'Fernanda', 'Medina', '3160300871', 'marcela433@correo.com', 'Av 19 #38-95', 'F', '1989-06-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('95178684', 'CE', 1, 'Camilo', 'Sánchez', 'Andrés', 'Pérez', '3141920912', 'camilo856@correo.com', 'Av 21 #26-42', 'M', '1963-01-22');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('55265544', 'PP', 9, 'Claudia', 'Cruz', 'Carolina', 'Álvarez', '3155765962', 'claudia262@correo.com', 'Av 63 #50-71', 'F', '1976-09-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('59046143', 'CC', 5, 'Claudia', 'Álvarez', 'Isabella', 'Jiménez', '3113411007', 'claudia658@correo.com', 'Av 70 #9-13', 'F', '1998-04-07');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('32381271', 'NI', 12, 'Alberto', 'Herrera', 'Ricardo', 'Ramírez', '3123440304', 'alberto163@correo.com', 'Av 22 #41-82', 'M', '1993-08-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('47369085', 'CE', 14, 'Luis', 'Suárez', 'Alberto', 'Ortiz', '3163804242', 'luis983@correo.com', 'Av 38 #25-67', 'M', '1964-05-21');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('10047461', 'PP', 12, 'Catalina', 'Rivera', 'Daniela', 'González', '3184592492', 'catalina258@correo.com', 'Av 40 #14-94', 'F', '1966-09-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('42542841', 'CE', 14, 'Andrés', 'González', 'Santiago', 'Ramos', '3131400078', 'andres806@correo.com', 'Av 54 #26-76', 'M', '1995-02-06');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('63880436', 'CE', 5, 'Daniel', 'Martínez', 'Ricardo', 'Ramírez', '3188642156', 'daniel744@correo.com', 'Av 20 #14-57', 'M', '1971-01-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('30626125', 'TI', 10, 'Sofía', 'Herrera', 'Claudia', 'Mendoza', '3155818870', 'sofia902@correo.com', 'Av 35 #3-49', 'F', '1966-04-25');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('49071710', 'TI', 3, 'Claudia', 'Ortiz', 'Daniela', 'Medina', '3123831159', 'claudia536@correo.com', 'Av 12 #47-78', 'F', '1980-02-25');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('95638951', 'CC', 7, 'Valentina', 'Molina', 'Catalina', 'Ortiz', '3147608285', 'valentina886@correo.com', 'Av 36 #17-82', 'F', '1969-06-08');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('44026103', 'TI', 12, 'Claudia', 'Ortiz', 'Sofía', 'García', '3156177572', 'claudia839@correo.com', 'Av 46 #16-36', 'F', '1992-03-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('31554308', 'PP', 11, 'Laura', 'Vargas', 'Isabella', 'Molina', '3183454371', 'laura572@correo.com', 'Av 42 #48-52', 'F', '1978-10-13');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('82240647', 'NI', 6, 'Paola', 'Martínez', 'Catalina', 'Rivera', '3151048501', 'paola325@correo.com', 'Av 13 #47-12', 'F', '1980-06-01');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('37131995', 'TI', 13, 'Isabella', 'Cruz', 'Catalina', 'Pérez', '3175154738', 'isabella877@correo.com', 'Av 45 #22-57', 'F', '1983-09-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('99011879', 'NI', 2, 'Camilo', 'Sánchez', 'Juan', 'Martínez', '3145348929', 'camilo873@correo.com', 'Av 19 #46-44', 'M', '1996-04-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('92331842', 'PP', 14, 'Gabriela', 'Castro', 'Sandra', 'López', '3140175481', 'gabriela332@correo.com', 'Av 57 #3-32', 'F', '1967-05-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('42930552', 'CE', 14, 'Sebastián', 'Ramos', 'Carlos', 'Ramírez', '3196959001', 'sebastian451@correo.com', 'Av 28 #10-2', 'M', '1980-04-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('41501680', 'PP', 6, 'Carolina', 'Torres', 'Natalia', 'Ortiz', '3157925684', 'carolina554@correo.com', 'Av 10 #45-18', 'F', '1988-09-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('68770044', 'NI', 8, 'Nicolás', 'Medina', 'Sebastián', 'Rodríguez', '3168543659', 'nicolas606@correo.com', 'Av 9 #11-3', 'M', '2004-08-07');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('18559981', 'CE', 14, 'Alejandra', 'Morales', 'Laura', 'Ramos', '3147056223', 'alejandra67@correo.com', 'Av 73 #17-94', 'F', '1991-10-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('63183240', 'CE', 13, 'Pedro', 'Ortiz', 'Hernando', 'Molina', '3170681408', 'pedro678@correo.com', 'Av 40 #35-90', 'M', '1979-04-22');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('82425578', 'CE', 7, 'Isabella', 'Medina', 'Valentina', 'Jiménez', '3110909370', 'isabella884@correo.com', 'Av 79 #4-92', 'F', '1988-03-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('54532115', 'CC', 12, 'Jorge', 'Cruz', 'Carlos', 'Ramos', '3164164273', 'jorge97@correo.com', 'Av 74 #45-88', 'M', '1967-12-29');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('34560448', 'PP', 3, 'Juliana', 'Molina', 'Gabriela', 'Ramos', '3157668359', 'juliana319@correo.com', 'Av 23 #46-56', 'F', '1968-08-07');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('40419133', 'CE', 7, 'Catalina', 'Pérez', 'Ana', 'Torres', '3194960805', 'catalina663@correo.com', 'Av 11 #22-58', 'F', '1991-07-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('17938468', 'NI', 1, 'Fernando', 'García', 'Sebastián', 'Suárez', '3132617447', 'fernando98@correo.com', 'Av 1 #34-2', 'M', '1993-06-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('82154087', 'CC', 10, 'Fernando', 'Vargas', 'Luis', 'García', '3151831014', 'fernando827@correo.com', 'Av 38 #7-45', 'M', '1970-10-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('91000851', 'CE', 8, 'Roberto', 'Pérez', 'Fernando', 'López', '3155284617', 'roberto628@correo.com', 'Av 59 #43-71', 'M', '1973-12-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('43047380', 'PP', 2, 'Daniela', 'Reyes', 'Claudia', 'Herrera', '3142138616', 'daniela145@correo.com', 'Av 63 #13-52', 'F', '1992-10-22');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('23258076', 'NI', 12, 'Ricardo', 'Ramos', 'Andrés', 'Reyes', '3197886323', 'ricardo680@correo.com', 'Av 42 #34-73', 'M', '1968-02-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('88848869', 'PP', 2, 'Laura', 'Rodríguez', 'Fernanda', 'Sánchez', '3152097877', 'laura657@correo.com', 'Av 7 #35-4', 'F', '1975-07-21');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('52991351', 'CE', 15, 'David', 'Vargas', 'Miguel', 'Pérez', '3137327834', 'david732@correo.com', 'Av 64 #14-74', 'M', '1966-07-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('65517801', 'TI', 1, 'Diana', 'Ortiz', 'Carolina', 'Molina', '3135433791', 'diana285@correo.com', 'Av 63 #17-77', 'F', '1993-10-31');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('98981391', 'CE', 8, 'Camilo', 'Molina', 'Andrés', 'Álvarez', '3195576828', 'camilo73@correo.com', 'Av 15 #8-21', 'M', '1980-01-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('63446108', 'PP', 3, 'Ana', 'Herrera', 'Paola', 'Rivera', '3148445186', 'ana550@correo.com', 'Av 37 #37-34', 'F', '1985-07-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('36949332', 'TI', 9, 'Miguel', 'Sánchez', 'Camilo', 'Martínez', '3114790926', 'miguel531@correo.com', 'Av 61 #31-14', 'M', '1971-05-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('38243618', 'CE', 13, 'Yolanda', 'Reyes', 'Laura', 'Jiménez', '3186343225', 'yolanda45@correo.com', 'Av 2 #10-44', 'F', '1988-07-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('62520989', 'CC', 15, 'Paola', 'Vargas', 'Natalia', 'Sánchez', '3149165484', 'paola157@correo.com', 'Av 65 #5-29', 'F', '1994-02-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('69127002', 'CC', 8, 'David', 'Reyes', 'Felipe', 'Mendoza', '3142987512', 'david864@correo.com', 'Av 78 #34-37', 'M', '1966-03-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('65019090', 'CC', 2, 'Luis', 'Rivera', 'Alberto', 'Rodríguez', '3132805637', 'luis634@correo.com', 'Av 42 #24-5', 'M', '1961-07-26');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('86704340', 'TI', 11, 'Roberto', 'Martínez', 'Alberto', 'García', '3192684709', 'roberto290@correo.com', 'Av 50 #29-96', 'M', '1994-08-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('30553823', 'TI', 8, 'Hernando', 'Morales', 'Sebastián', 'Cruz', '3158336521', 'hernando550@correo.com', 'Av 29 #10-37', 'M', '2000-09-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('67946703', 'CC', 12, 'Camilo', 'Pérez', 'Sebastián', 'Morales', '3115711620', 'camilo148@correo.com', 'Av 59 #27-91', 'M', '1986-11-25');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('66524541', 'TI', 4, 'Camilo', 'Cruz', 'Luis', 'Morales', '3170708263', 'camilo472@correo.com', 'Av 57 #25-60', 'M', '1997-06-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('37637454', 'NI', 3, 'Isabella', 'Reyes', 'Yolanda', 'Castro', '3135630898', 'isabella223@correo.com', 'Av 73 #13-94', 'F', '1982-01-26');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('46684386', 'CE', 11, 'María', 'Castro', 'Diana', 'Medina', '3163938948', 'maria657@correo.com', 'Av 74 #13-20', 'F', '1973-12-25');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('52441605', 'TI', 3, 'Isabella', 'Ramírez', 'Daniela', 'Mendoza', '3123027791', 'isabella693@correo.com', 'Av 9 #6-3', 'F', '1963-03-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('48888385', 'CE', 12, 'Marcela', 'Ramos', 'Daniela', 'Rivera', '3185415271', 'marcela104@correo.com', 'Av 21 #10-21', 'F', '1987-03-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('84131297', 'NI', 3, 'Claudia', 'Suárez', 'Alejandra', 'Ortiz', '3147746670', 'claudia717@correo.com', 'Av 32 #8-85', 'F', '2002-02-15');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('24894384', 'CE', 15, 'Luis', 'Reyes', 'Alejandro', 'Castro', '3195123938', 'luis985@correo.com', 'Av 42 #19-92', 'M', '1977-09-07');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('66067933', 'NI', 15, 'Ricardo', 'García', 'Hernando', 'Suárez', '3143918937', 'ricardo374@correo.com', 'Av 25 #33-36', 'M', '1975-03-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('78797888', 'PP', 6, 'Laura', 'Molina', 'Carolina', 'Castro', '3155919735', 'laura417@correo.com', 'Av 17 #23-93', 'F', '1998-01-31');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('70381095', 'CC', 5, 'Alejandra', 'Ramos', 'Diana', 'Flores', '3199418882', 'alejandra825@correo.com', 'Av 41 #33-15', 'F', '1967-08-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('94691777', 'TI', 11, 'Felipe', 'González', 'Juan', 'Medina', '3199246477', 'felipe805@correo.com', 'Av 14 #40-16', 'M', '1989-09-07');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('22292455', 'CC', 3, 'Luis', 'Mendoza', 'David', 'Martínez', '3141282897', 'luis444@correo.com', 'Av 27 #4-92', 'M', '1960-05-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('36481124', 'TI', 4, 'Camilo', 'Cruz', 'Felipe', 'Jiménez', '3134973205', 'camilo620@correo.com', 'Av 61 #19-94', 'M', '2004-06-08');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('93194239', 'CC', 15, 'Andrés', 'Ramos', 'Juan', 'Morales', '3169851981', 'andres82@correo.com', 'Av 2 #48-87', 'M', '1998-08-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('72226540', 'TI', 15, 'Juliana', 'Vargas', 'Daniela', 'Rivera', '3130493013', 'juliana464@correo.com', 'Av 19 #48-97', 'F', '2001-08-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('46358251', 'CE', 8, 'David', 'García', 'Miguel', 'Castro', '3112909930', 'david203@correo.com', 'Av 64 #26-21', 'M', '1990-04-06');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('48832122', 'NI', 8, 'Claudia', 'Rivera', 'Ana', 'Molina', '3179627150', 'claudia241@correo.com', 'Av 64 #14-54', 'F', '1972-09-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('93011005', 'PP', 6, 'María', 'Cruz', 'Sofía', 'Pérez', '3126354079', 'maria627@correo.com', 'Av 77 #9-68', 'F', '1998-06-27');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('73555187', 'NI', 6, 'Isabella', 'Molina', 'Natalia', 'González', '3170005821', 'isabella19@correo.com', 'Av 48 #27-32', 'F', '1965-08-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('47652279', 'TI', 15, 'Felipe', 'Rivera', 'Daniel', 'Cruz', '3154434217', 'felipe592@correo.com', 'Av 25 #9-42', 'M', '1990-07-27');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('12603460', 'TI', 10, 'Roberto', 'Ramírez', 'Daniel', 'Ramos', '3122828887', 'roberto524@correo.com', 'Av 50 #49-19', 'M', '1988-02-14');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('57804163', 'PP', 1, 'Laura', 'Ramírez', 'Catalina', 'Cruz', '3129611920', 'laura576@correo.com', 'Av 35 #21-63', 'F', '2003-04-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('50020641', 'CC', 14, 'Valentina', 'Ortiz', 'Gabriela', 'Molina', '3129335352', 'valentina210@correo.com', 'Av 38 #2-4', 'F', '1983-06-01');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('69953058', 'CE', 15, 'Ana', 'Vargas', 'Natalia', 'Álvarez', '3131069286', 'ana569@correo.com', 'Av 77 #29-98', 'F', '1994-04-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('70845390', 'NI', 4, 'Claudia', 'Vargas', 'Carolina', 'Torres', '3188716058', 'claudia167@correo.com', 'Av 17 #21-3', 'F', '1985-07-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('52314652', 'CE', 6, 'Andrés', 'Herrera', 'Felipe', 'Ramos', '3113417889', 'andres564@correo.com', 'Av 56 #42-42', 'M', '1993-08-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('76096285', 'CC', 13, 'Isabella', 'Ortiz', 'Ana', 'Rivera', '3118341692', 'isabella559@correo.com', 'Av 68 #27-83', 'F', '1995-12-08');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('41227854', 'CE', 1, 'Andrés', 'Ramos', 'Daniel', 'Rodríguez', '3128478172', 'andres978@correo.com', 'Av 65 #21-42', 'M', '1973-09-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('20821631', 'PP', 1, 'David', 'Medina', 'Daniel', 'Ramos', '3132035756', 'david522@correo.com', 'Av 51 #14-20', 'M', '1993-01-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('62132821', 'NI', 6, 'Pedro', 'Torres', 'Alejandro', 'Herrera', '3137056403', 'pedro855@correo.com', 'Av 78 #17-43', 'M', '1974-05-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('70619406', 'PP', 11, 'Felipe', 'Castro', 'Sebastián', 'López', '3190982662', 'felipe457@correo.com', 'Av 66 #50-52', 'M', '1962-08-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('53937353', 'TI', 12, 'Jorge', 'Sánchez', 'Felipe', 'Ramos', '3190773970', 'jorge401@correo.com', 'Av 22 #32-62', 'M', '2001-01-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('38898236', 'PP', 1, 'Gabriela', 'Pérez', 'Marcela', 'López', '3166796333', 'gabriela995@correo.com', 'Av 48 #5-36', 'F', '1977-02-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('50540480', 'CC', 15, 'María', 'Álvarez', 'Sofía', 'Rodríguez', '3171327790', 'maria270@correo.com', 'Av 27 #8-82', 'F', '1972-09-21');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('71101892', 'CE', 2, 'Hernando', 'García', 'Jorge', 'López', '3113027810', 'hernando277@correo.com', 'Av 73 #31-9', 'M', '1984-07-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('14987687', 'CC', 7, 'David', 'Castro', 'Juan', 'Reyes', '3172505408', 'david443@correo.com', 'Av 53 #12-2', 'M', '2004-08-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('37205749', 'TI', 12, 'Juan', 'Molina', 'Sebastián', 'Flores', '3146502180', 'juan25@correo.com', 'Av 25 #16-89', 'M', '1983-12-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('41074206', 'TI', 9, 'María', 'Medina', 'Laura', 'Ortiz', '3158859923', 'maria294@correo.com', 'Av 12 #39-48', 'F', '1964-03-29');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('32048771', 'NI', 8, 'Felipe', 'Cruz', 'Ricardo', 'Vargas', '3177961532', 'felipe352@correo.com', 'Av 19 #39-44', 'M', '1963-11-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('66234015', 'CC', 7, 'Roberto', 'Sánchez', 'Luis', 'Molina', '3183014006', 'roberto514@correo.com', 'Av 6 #34-14', 'M', '1970-01-14');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('54949481', 'CE', 12, 'Sebastián', 'Reyes', 'Alberto', 'Pérez', '3153686165', 'sebastian120@correo.com', 'Av 48 #36-51', 'M', '2003-11-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('40308351', 'CC', 7, 'Valentina', 'Morales', 'Marcela', 'Mendoza', '3135277376', 'valentina160@correo.com', 'Av 1 #33-14', 'F', '2000-09-12');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('50648859', 'TI', 4, 'Sandra', 'Molina', 'Ana', 'Flores', '3195664279', 'sandra555@correo.com', 'Av 13 #13-4', 'F', '1978-10-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('18995520', 'CC', 3, 'Carlos', 'López', 'Alejandro', 'Sánchez', '3125965592', 'carlos464@correo.com', 'Av 55 #23-85', 'M', '1982-09-26');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('44330502', 'CC', 6, 'Hernando', 'Ramos', 'Andrés', 'Rivera', '3161506760', 'hernando882@correo.com', 'Av 69 #50-13', 'M', '2002-06-27');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('46875132', 'TI', 3, 'Fernando', 'Martínez', 'Nicolás', 'Jiménez', '3181895460', 'fernando821@correo.com', 'Av 7 #17-75', 'M', '1994-10-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('97761151', 'TI', 1, 'Juan', 'Ramos', 'David', 'Ramírez', '3160562450', 'juan792@correo.com', 'Av 6 #20-24', 'M', '1975-11-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('25581274', 'TI', 12, 'Felipe', 'Ramos', 'Roberto', 'Ramírez', '3128683820', 'felipe169@correo.com', 'Av 17 #48-78', 'M', '1969-02-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('80487824', 'CC', 7, 'Nicolás', 'Morales', 'Hernando', 'Molina', '3182945272', 'nicolas651@correo.com', 'Av 14 #27-61', 'M', '1993-01-15');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('35070625', 'NI', 2, 'Luis', 'García', 'Miguel', 'Pérez', '3198565173', 'luis457@correo.com', 'Av 70 #24-72', 'M', '1977-08-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('15759135', 'TI', 1, 'Natalia', 'Torres', 'Valentina', 'Ortiz', '3162966186', 'natalia800@correo.com', 'Av 4 #13-86', 'F', '1988-10-01');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('28423710', 'NI', 10, 'Marcela', 'Reyes', 'Alejandra', 'Suárez', '3122212161', 'marcela346@correo.com', 'Av 63 #22-69', 'F', '2002-02-07');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('47382608', 'TI', 11, 'Sofía', 'Rivera', 'Diana', 'Jiménez', '3166887930', 'sofia613@correo.com', 'Av 25 #50-79', 'F', '1983-09-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('34572290', 'PP', 13, 'Alejandro', 'Sánchez', 'Daniel', 'Suárez', '3142968412', 'alejandro384@correo.com', 'Av 51 #31-92', 'M', '2004-08-01');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('91333763', 'PP', 3, 'Marcela', 'Herrera', 'Daniela', 'Rivera', '3126700614', 'marcela259@correo.com', 'Av 49 #36-51', 'F', '1966-06-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('88327265', 'NI', 8, 'Juan', 'Torres', 'David', 'Ramos', '3186162338', 'juan524@correo.com', 'Av 54 #13-35', 'M', '1984-11-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('46025956', 'NI', 9, 'Andrés', 'Torres', 'Juan', 'López', '3122870221', 'andres803@correo.com', 'Av 55 #14-6', 'M', '1971-06-07');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('75264320', 'PP', 10, 'Jorge', 'Medina', 'Juan', 'Mendoza', '3143043458', 'jorge98@correo.com', 'Av 53 #15-31', 'M', '1971-03-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('10425250', 'CC', 5, 'Yolanda', 'Pérez', 'Paola', 'Ramírez', '3151405395', 'yolanda688@correo.com', 'Av 56 #38-77', 'F', '1981-06-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('68606209', 'TI', 4, 'María', 'Álvarez', 'Alejandra', 'Torres', '3112780428', 'maria330@correo.com', 'Av 64 #33-79', 'F', '1990-09-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('60928119', 'CE', 5, 'Gabriela', 'Ramírez', 'Carolina', 'Molina', '3113258266', 'gabriela984@correo.com', 'Av 73 #16-83', 'F', '2002-02-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('74227310', 'PP', 6, 'Carolina', 'Ramírez', 'Natalia', 'Torres', '3139412039', 'carolina173@correo.com', 'Av 75 #42-67', 'F', '1974-03-08');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('22075904', 'CE', 13, 'Andrés', 'Morales', 'Camilo', 'Rodríguez', '3192604294', 'andres95@correo.com', 'Av 71 #4-33', 'M', '1974-03-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('68504671', 'CE', 5, 'Fernando', 'Vargas', 'Sebastián', 'González', '3134967191', 'fernando892@correo.com', 'Av 30 #27-40', 'M', '1984-12-26');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('86854285', 'CC', 10, 'Fernando', 'Ramírez', 'Juan', 'Martínez', '3183543067', 'fernando296@correo.com', 'Av 61 #28-22', 'M', '1975-10-14');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('27755795', 'CE', 8, 'Camilo', 'Pérez', 'Luis', 'Rodríguez', '3191734449', 'camilo883@correo.com', 'Av 48 #37-36', 'M', '1981-09-14');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('80259009', 'PP', 7, 'Yolanda', 'Molina', 'Marcela', 'Mendoza', '3177531991', 'yolanda171@correo.com', 'Av 64 #9-5', 'F', '1996-07-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('70389982', 'CE', 11, 'Carlos', 'Ortiz', 'David', 'Álvarez', '3150530014', 'carlos665@correo.com', 'Av 51 #16-19', 'M', '1972-07-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('17129557', 'PP', 5, 'Daniel', 'Cruz', 'Luis', 'López', '3161882781', 'daniel477@correo.com', 'Av 56 #5-77', 'M', '1991-06-13');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('19094010', 'TI', 1, 'Natalia', 'Herrera', 'Fernanda', 'Ramos', '3135968352', 'natalia340@correo.com', 'Av 40 #33-22', 'F', '1991-08-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('66047853', 'CE', 10, 'María', 'Sánchez', 'Sandra', 'Ortiz', '3183424609', 'maria438@correo.com', 'Av 73 #17-27', 'F', '1973-08-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('18870325', 'TI', 12, 'Juan', 'Rodríguez', 'Jorge', 'Torres', '3132226983', 'juan480@correo.com', 'Av 64 #8-11', 'M', '1979-08-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('83541296', 'NI', 10, 'Isabella', 'Ramos', 'Natalia', 'Torres', '3199246937', 'isabella647@correo.com', 'Av 42 #34-20', 'F', '1989-08-29');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('84492729', 'CE', 2, 'Laura', 'Flores', 'Marcela', 'Torres', '3139387314', 'laura865@correo.com', 'Av 32 #30-20', 'F', '1980-01-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('66276356', 'TI', 12, 'Alberto', 'Morales', 'Fernando', 'Ortiz', '3120888977', 'alberto307@correo.com', 'Av 32 #11-80', 'M', '1989-09-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('30675696', 'TI', 7, 'Ana', 'Rodríguez', 'Isabella', 'Ortiz', '3114106460', 'ana485@correo.com', 'Av 43 #24-16', 'F', '1997-02-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('64400820', 'CE', 10, 'Valentina', 'Ramos', 'Catalina', 'Castro', '3141556108', 'valentina870@correo.com', 'Av 37 #16-79', 'F', '1998-08-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('54310874', 'PP', 15, 'Marcela', 'Rodríguez', 'Ana', 'Pérez', '3188230615', 'marcela40@correo.com', 'Av 11 #3-79', 'F', '1968-12-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('89640794', 'PP', 2, 'David', 'Castro', 'Jorge', 'Ramos', '3180610268', 'david631@correo.com', 'Av 10 #40-37', 'M', '1986-02-22');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('49413474', 'PP', 9, 'Paola', 'Vargas', 'Catalina', 'Morales', '3141557954', 'paola429@correo.com', 'Av 40 #43-42', 'F', '1995-12-26');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('62451520', 'CE', 6, 'Diana', 'Cruz', 'Catalina', 'Rodríguez', '3118865799', 'diana354@correo.com', 'Av 7 #3-33', 'F', '1977-03-06');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('70345934', 'PP', 7, 'Paola', 'Vargas', 'Catalina', 'Reyes', '3153876873', 'paola836@correo.com', 'Av 55 #43-41', 'F', '1971-12-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('29838164', 'CE', 4, 'Miguel', 'Álvarez', 'Hernando', 'Jiménez', '3198404605', 'miguel697@correo.com', 'Av 65 #18-68', 'M', '1989-10-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('44110350', 'NI', 15, 'Sofía', 'Ramírez', 'Laura', 'Reyes', '3110575125', 'sofia272@correo.com', 'Av 68 #15-6', 'F', '1995-06-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('20214735', 'CC', 7, 'Nicolás', 'Castro', 'Daniel', 'García', '3183356152', 'nicolas549@correo.com', 'Av 54 #2-65', 'M', '1984-07-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('98756651', 'NI', 4, 'Yolanda', 'Ramos', 'Laura', 'Medina', '3125552030', 'yolanda799@correo.com', 'Av 31 #25-72', 'F', '1985-10-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('20694051', 'TI', 1, 'Paola', 'Cruz', 'Alejandra', 'Sánchez', '3142963378', 'paola663@correo.com', 'Av 62 #2-13', 'F', '1989-06-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('65777619', 'PP', 11, 'Sebastián', 'Reyes', 'Jorge', 'Flores', '3167237068', 'sebastian928@correo.com', 'Av 27 #47-21', 'M', '1974-07-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('95768162', 'NI', 12, 'Claudia', 'Flores', 'Sofía', 'Herrera', '3130880066', 'claudia79@correo.com', 'Av 16 #1-31', 'F', '1966-02-25');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('31520447', 'PP', 3, 'Pedro', 'Martínez', 'Juan', 'Pérez', '3194767925', 'pedro491@correo.com', 'Av 45 #2-44', 'M', '1977-06-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('38502474', 'TI', 13, 'Juliana', 'Jiménez', 'Claudia', 'Álvarez', '3193359286', 'juliana195@correo.com', 'Av 62 #50-76', 'F', '1975-01-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('53246831', 'TI', 8, 'Daniel', 'Herrera', 'Hernando', 'Álvarez', '3115632397', 'daniel204@correo.com', 'Av 5 #29-25', 'M', '1993-02-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('97069298', 'PP', 15, 'Roberto', 'García', 'Ricardo', 'Reyes', '3110998284', 'roberto426@correo.com', 'Av 41 #30-11', 'M', '1990-05-22');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('19985429', 'TI', 6, 'Sebastián', 'González', 'Camilo', 'Torres', '3176878955', 'sebastian77@correo.com', 'Av 40 #48-39', 'M', '1992-08-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('28444834', 'CC', 3, 'María', 'Flores', 'Yolanda', 'Rivera', '3125216825', 'maria372@correo.com', 'Av 13 #17-99', 'F', '1968-12-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('98301804', 'NI', 5, 'Alberto', 'Molina', 'Roberto', 'Herrera', '3164176956', 'alberto103@correo.com', 'Av 6 #20-54', 'M', '1986-09-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('32732400', 'CE', 12, 'Carlos', 'Sánchez', 'Hernando', 'Mendoza', '3164748819', 'carlos245@correo.com', 'Av 1 #44-67', 'M', '2005-09-22');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('67676460', 'CC', 4, 'Marcela', 'Ramos', 'Diana', 'Herrera', '3199507425', 'marcela628@correo.com', 'Av 50 #13-68', 'F', '1978-12-06');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('48609441', 'NI', 7, 'Natalia', 'Castro', 'Sandra', 'Medina', '3192729773', 'natalia256@correo.com', 'Av 16 #46-54', 'F', '1984-03-01');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('11846825', 'CC', 12, 'Roberto', 'Cruz', 'Carlos', 'Sánchez', '3155816159', 'roberto110@correo.com', 'Av 27 #29-19', 'M', '1997-01-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('43837801', 'CC', 7, 'Diana', 'Ramos', 'Valentina', 'Torres', '3172220991', 'diana444@correo.com', 'Av 21 #4-8', 'F', '1960-04-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('28884147', 'PP', 2, 'Fernanda', 'Sánchez', 'Sofía', 'Ortiz', '3133764601', 'fernanda287@correo.com', 'Av 55 #50-2', 'F', '1985-06-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('12301266', 'CE', 15, 'Paola', 'Ramírez', 'Catalina', 'Vargas', '3175216738', 'paola661@correo.com', 'Av 50 #15-71', 'F', '1981-01-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('43836123', 'PP', 4, 'María', 'Medina', 'Ana', 'López', '3199717427', 'maria776@correo.com', 'Av 72 #40-74', 'F', '1981-12-01');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('53582517', 'CE', 4, 'Claudia', 'Ramos', 'Gabriela', 'Suárez', '3155117017', 'claudia879@correo.com', 'Av 46 #31-98', 'F', '1964-02-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('12205381', 'NI', 7, 'Alberto', 'Ramos', 'Felipe', 'Ramírez', '3185854351', 'alberto106@correo.com', 'Av 18 #15-53', 'M', '1966-11-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('64913597', 'NI', 1, 'Ricardo', 'Rodríguez', 'Miguel', 'Torres', '3196304579', 'ricardo288@correo.com', 'Av 76 #29-27', 'M', '1970-10-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('46675397', 'PP', 6, 'Ana', 'Cruz', NULL, 'Martínez', '3140301728', 'ana890@correo.com', 'Av 36 #1-13', 'F', '1973-02-15');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('89031028', 'PP', 9, 'Valentina', 'López', NULL, 'Pérez', '3180995825', 'valentina98@correo.com', 'Av 45 #45-74', 'F', '2003-12-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('30869686', 'NI', 1, 'Catalina', 'González', NULL, 'Torres', '3160841764', 'catalina147@correo.com', 'Av 73 #48-35', 'F', '1971-05-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('72150455', 'CC', 14, 'Diana', 'Cruz', NULL, 'Jiménez', '3157747160', 'diana59@correo.com', 'Av 1 #40-59', 'F', '2003-10-21');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('35443261', 'CC', 4, 'Juliana', 'Morales', NULL, 'Molina', '3127942270', 'juliana42@correo.com', 'Av 51 #27-96', 'F', '1985-07-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('67217417', 'CE', 15, 'Camilo', 'Torres', NULL, 'Sánchez', '3136795696', 'camilo632@correo.com', 'Av 12 #4-49', 'M', '1961-08-01');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('23524006', 'NI', 5, 'Felipe', 'Flores', NULL, 'Ramos', '3143858172', 'felipe190@correo.com', 'Av 63 #24-43', 'M', '1998-08-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('85208373', 'PP', 9, 'Andrés', 'Sánchez', NULL, 'Ortiz', '3159125302', 'andres917@correo.com', 'Av 58 #41-92', 'M', '1991-02-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('86758847', 'CE', 1, 'Yolanda', 'Sánchez', NULL, 'Pérez', '3111189346', 'yolanda607@correo.com', 'Av 66 #30-65', 'F', '1979-07-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('45438604', 'NI', 12, 'Yolanda', 'Rivera', NULL, 'Martínez', '3192071729', 'yolanda419@correo.com', 'Av 38 #21-8', 'F', '1971-12-27');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('12098962', 'PP', 3, 'Ricardo', 'Mendoza', NULL, 'Torres', '3161268618', 'ricardo740@correo.com', 'Av 33 #41-82', 'M', '1969-07-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('29780540', 'TI', 7, 'Carlos', 'García', NULL, 'Ramírez', '3148499846', 'carlos672@correo.com', 'Av 29 #44-50', 'M', '1991-09-12');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('19034683', 'TI', 12, 'Felipe', 'Castro', NULL, 'Vargas', '3167371791', 'felipe592@correo.com', 'Av 36 #10-12', 'M', '1970-02-25');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('21710526', 'CE', 13, 'Fernanda', 'Álvarez', NULL, 'Molina', '3110384682', 'fernanda371@correo.com', 'Av 27 #2-47', 'F', '1981-02-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('49553600', 'CE', 6, 'Sandra', 'Rodríguez', NULL, 'Morales', '3184021128', 'sandra148@correo.com', 'Av 54 #16-27', 'F', '2001-04-21');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('36136297', 'TI', 11, 'Gabriela', 'Rodríguez', NULL, 'Morales', '3124012339', 'gabriela112@correo.com', 'Av 10 #24-78', 'F', '1984-03-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('31615365', 'CE', 11, 'Juan', 'Sánchez', NULL, 'Reyes', '3191703555', 'juan529@correo.com', 'Av 67 #50-44', 'M', '2005-01-01');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('83435357', 'PP', 3, 'Roberto', 'López', NULL, 'García', '3122631766', 'roberto511@correo.com', 'Av 59 #21-22', 'M', '1967-10-27');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('21976146', 'PP', 6, 'Paola', 'Torres', NULL, 'Medina', '3171839630', 'paola184@correo.com', 'Av 34 #31-33', 'F', '1966-05-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('83112925', 'NI', 12, 'Carlos', 'López', NULL, 'Ramos', '3169606543', 'carlos649@correo.com', 'Av 65 #38-5', 'M', '1968-12-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('29296419', 'CC', 5, 'Camilo', 'Reyes', NULL, 'Rodríguez', '3187759654', 'camilo654@correo.com', 'Av 14 #8-59', 'M', '1962-01-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('14221211', 'NI', 11, 'María', 'Reyes', NULL, 'Medina', '3156544523', 'maria352@correo.com', 'Av 62 #40-77', 'F', '1970-07-07');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('35883252', 'CC', 15, 'Jorge', 'Mendoza', NULL, 'Torres', '3113092131', 'jorge549@correo.com', 'Av 67 #33-98', 'M', '1962-08-26');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('38692049', 'PP', 1, 'Claudia', 'Rivera', NULL, 'Molina', '3153159218', 'claudia582@correo.com', 'Av 30 #36-9', 'F', '2001-10-01');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('51852500', 'PP', 9, 'Diana', 'Álvarez', NULL, 'Jiménez', '3130669385', 'diana672@correo.com', 'Av 65 #7-17', 'F', '2000-09-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('51046667', 'TI', 1, 'David', 'Medina', NULL, 'López', '3157278935', 'david441@correo.com', 'Av 1 #4-33', 'M', '1960-06-15');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('68494269', 'NI', 3, 'Sebastián', 'Suárez', NULL, 'Flores', '3187600317', 'sebastian824@correo.com', 'Av 18 #44-99', 'M', '1988-12-06');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('68939010', 'NI', 5, 'Catalina', 'Ramírez', NULL, 'Herrera', '3129628855', 'catalina443@correo.com', 'Av 3 #12-19', 'F', '1971-01-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('14574615', 'PP', 10, 'Claudia', 'Castro', NULL, 'García', '3157610634', 'claudia44@correo.com', 'Av 18 #30-93', 'F', '1999-11-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('22957438', 'CE', 3, 'Ana', 'García', NULL, 'Mendoza', '3173943071', 'ana512@correo.com', 'Av 42 #49-30', 'F', '1969-07-12');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('18639582', 'TI', 13, 'Miguel', 'Mendoza', NULL, 'Castro', '3143619373', 'miguel627@correo.com', 'Av 15 #3-96', 'M', '1965-07-22');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('40265633', 'PP', 11, 'David', 'Ramos', NULL, 'Vargas', '3131755295', 'david760@correo.com', 'Av 56 #34-25', 'M', '1978-01-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('41624005', 'CC', 15, 'David', 'Mendoza', NULL, 'Rivera', '3185679497', 'david75@correo.com', 'Av 79 #45-98', 'M', '2004-04-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('20817074', 'NI', 12, 'Ricardo', 'Ortiz', NULL, 'Suárez', '3127376441', 'ricardo970@correo.com', 'Av 35 #47-6', 'M', '2002-12-14');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('74716210', 'NI', 1, 'Alberto', 'Reyes', NULL, 'Mendoza', '3160630659', 'alberto397@correo.com', 'Av 17 #28-90', 'M', '1964-09-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('86242194', 'NI', 7, 'Juan', 'García', NULL, 'Ramírez', '3111999650', 'juan822@correo.com', 'Av 32 #4-10', 'M', '1964-02-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('56931572', 'PP', 1, 'Luis', 'Pérez', NULL, 'Flores', '3127410219', 'luis300@correo.com', 'Av 78 #26-62', 'M', '1981-11-29');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('57910133', 'TI', 4, 'Juan', 'Torres', NULL, 'Herrera', '3150630244', 'juan455@correo.com', 'Av 47 #50-71', 'M', '1979-10-06');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('25332850', 'TI', 11, 'Andrés', 'Molina', NULL, 'Vargas', '3114530678', 'andres511@correo.com', 'Av 35 #18-76', 'M', '1961-11-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('17014171', 'NI', 7, 'David', 'Pérez', NULL, 'Reyes', '3182685498', 'david33@correo.com', 'Av 45 #2-78', 'M', '1987-05-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('93420414', 'PP', 1, 'Carolina', 'Sánchez', NULL, 'Álvarez', '3167384680', 'carolina887@correo.com', 'Av 8 #7-71', 'F', '1998-12-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('79647305', 'NI', 10, 'Sofía', 'Vargas', NULL, 'Ortiz', '3161176016', 'sofia167@correo.com', 'Av 60 #48-31', 'F', '1983-05-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('98476025', 'TI', 10, 'Alejandra', 'Jiménez', NULL, 'Rodríguez', '3146129093', 'alejandra325@correo.com', 'Av 25 #37-38', 'F', '1999-07-26');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('57562437', 'TI', 15, 'Juan', 'Jiménez', NULL, 'Castro', '3184751326', 'juan412@correo.com', 'Av 31 #46-38', 'M', '1971-06-08');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('88930879', 'NI', 3, 'Daniela', 'Rivera', NULL, 'Vargas', '3123005510', 'daniela968@correo.com', 'Av 30 #20-64', 'F', '1985-01-21');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('70914632', 'CE', 9, 'Marcela', 'Mendoza', NULL, 'Vargas', '3124712259', 'marcela941@correo.com', 'Av 16 #29-56', 'F', '1986-06-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('57475650', 'CC', 12, 'Carolina', 'González', NULL, 'Torres', '3139855629', 'carolina763@correo.com', 'Av 10 #21-21', 'F', '1967-02-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('52253072', 'CC', 9, 'Carolina', 'Cruz', NULL, 'Mendoza', '3123480667', 'carolina444@correo.com', 'Av 67 #21-25', 'F', '1963-06-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('94560859', 'TI', 8, 'Alejandro', 'Flores', NULL, 'Reyes', '3157932891', 'alejandro613@correo.com', 'Av 70 #31-38', 'M', '1995-03-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('12705048', 'TI', 12, 'Sebastián', 'Martínez', NULL, 'Jiménez', '3182705468', 'sebastian761@correo.com', 'Av 78 #10-13', 'M', '1961-04-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('14900250', 'CE', 6, 'Carolina', 'Flores', NULL, 'Mendoza', '3185874940', 'carolina706@correo.com', 'Av 77 #27-1', 'F', '1988-11-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('97511116', 'PP', 8, 'Diana', 'Ramos', NULL, 'Herrera', '3171924305', 'diana330@correo.com', 'Av 62 #33-72', 'F', '1981-02-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('11828652', 'CE', 7, 'Miguel', 'Molina', NULL, 'Martínez', '3126304459', 'miguel533@correo.com', 'Av 22 #13-57', 'M', '1974-07-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('92662979', 'PP', 10, 'Isabella', 'Álvarez', NULL, 'Medina', '3132561918', 'isabella215@correo.com', 'Av 1 #15-28', 'F', '2002-06-21');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('53397675', 'CC', 8, 'Pedro', 'González', NULL, 'Pérez', '3117004714', 'pedro918@correo.com', 'Av 18 #33-57', 'M', '1966-12-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('11432428', 'CE', 6, 'Pedro', 'Sánchez', NULL, 'Castro', '3158451442', 'pedro453@correo.com', 'Av 68 #13-1', 'M', '1977-07-27');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('30561048', 'NI', 1, 'Alejandra', 'Rodríguez', NULL, 'Morales', '3127669523', 'alejandra892@correo.com', 'Av 11 #27-16', 'F', '1975-11-14');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('91675383', 'PP', 1, 'Sebastián', 'Pérez', NULL, 'Vargas', '3177842475', 'sebastian706@correo.com', 'Av 53 #12-82', 'M', '1977-10-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('51672868', 'CE', 12, 'Alejandro', 'Mendoza', NULL, 'Álvarez', '3148530763', 'alejandro389@correo.com', 'Av 23 #18-18', 'M', '1964-10-13');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('33771581', 'CE', 15, 'Juliana', 'Sánchez', NULL, 'Torres', '3169001888', 'juliana266@correo.com', 'Av 34 #6-63', 'F', '1986-06-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('14220885', 'PP', 8, 'Fernando', 'Torres', NULL, 'Sánchez', '3198359849', 'fernando530@correo.com', 'Av 24 #31-18', 'M', '1970-05-06');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('35113682', 'CC', 15, 'Catalina', 'Rivera', NULL, 'Cruz', '3131843350', 'catalina314@correo.com', 'Av 60 #35-24', 'F', '1992-02-13');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('24476095', 'NI', 15, 'Sofía', 'Ramírez', NULL, 'Álvarez', '3146153018', 'sofia437@correo.com', 'Av 74 #26-76', 'F', '1997-10-07');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('83796808', 'TI', 2, 'María', 'Pérez', NULL, 'Morales', '3138520176', 'maria716@correo.com', 'Av 61 #43-49', 'F', '1995-05-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('77102111', 'CE', 4, 'Pedro', 'Martínez', NULL, 'Cruz', '3138351125', 'pedro46@correo.com', 'Av 39 #28-12', 'M', '1976-11-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('66701227', 'TI', 11, 'Daniela', 'Ramos', NULL, 'Cruz', '3167040011', 'daniela311@correo.com', 'Av 34 #48-82', 'F', '1964-11-21');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('54971462', 'TI', 13, 'Pedro', 'Jiménez', NULL, 'Morales', '3134003439', 'pedro115@correo.com', 'Av 55 #35-98', 'M', '1992-09-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('16720752', 'PP', 8, 'Sofía', 'López', NULL, 'Ramos', '3167136827', 'sofia259@correo.com', 'Av 44 #44-38', 'F', '1993-02-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('66711004', 'PP', 6, 'Camilo', 'Mendoza', NULL, 'Martínez', '3134686713', 'camilo23@correo.com', 'Av 33 #47-84', 'M', '1995-12-14');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('39669864', 'PP', 12, 'Claudia', 'Ramírez', NULL, 'García', '3148632064', 'claudia627@correo.com', 'Av 78 #30-76', 'F', '1965-09-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('59552038', 'NI', 12, 'Alejandra', 'Martínez', NULL, 'Sánchez', '3152323961', 'alejandra299@correo.com', 'Av 58 #44-60', 'F', '1987-04-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('26575085', 'NI', 7, 'Valentina', 'Herrera', NULL, 'González', '3139300452', 'valentina406@correo.com', 'Av 28 #8-74', 'F', '1968-09-12');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('64830114', 'NI', 7, 'Paola', 'Álvarez', NULL, 'Mendoza', '3139226259', 'paola770@correo.com', 'Av 54 #39-36', 'F', '1991-08-01');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('93952534', 'NI', 3, 'María', 'Suárez', NULL, 'Ramírez', '3122209308', 'maria701@correo.com', 'Av 48 #2-96', 'F', '2002-05-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('96850860', 'NI', 2, 'Santiago', 'Molina', NULL, 'Herrera', '3174532898', 'santiago450@correo.com', 'Av 8 #19-51', 'M', '1962-02-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('67524179', 'TI', 11, 'Ricardo', 'Molina', NULL, 'Jiménez', '3129593605', 'ricardo107@correo.com', 'Av 34 #49-75', 'M', '1971-02-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('34515629', 'NI', 11, 'Claudia', 'Rivera', NULL, 'Cruz', '3124591037', 'claudia798@correo.com', 'Av 30 #14-40', 'F', '1977-05-14');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('42633405', 'CC', 2, 'David', 'Vargas', NULL, 'Torres', '3174381921', 'david334@correo.com', 'Av 76 #31-6', 'M', '1974-05-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('83361416', 'NI', 6, 'Alberto', 'Vargas', NULL, 'Ramírez', '3181273301', 'alberto571@correo.com', 'Av 38 #45-3', 'M', '1983-05-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('28826712', 'CC', 15, 'Sebastián', 'Suárez', NULL, 'Mendoza', '3165133817', 'sebastian658@correo.com', 'Av 55 #26-63', 'M', '1970-09-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('40884016', 'PP', 14, 'Alberto', 'Martínez', NULL, 'Rivera', '3150658510', 'alberto207@correo.com', 'Av 21 #28-35', 'M', '1978-09-25');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('26523557', 'TI', 15, 'David', 'García', NULL, 'González', '3169586290', 'david27@correo.com', 'Av 27 #25-7', 'M', '1993-08-26');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('26730148', 'NI', 7, 'Daniela', 'Sánchez', NULL, 'Álvarez', '3133501092', 'daniela993@correo.com', 'Av 65 #38-93', 'F', '1968-04-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('66269326', 'CE', 14, 'Alejandro', 'Suárez', NULL, 'Ortiz', '3179605270', 'alejandro179@correo.com', 'Av 20 #48-86', 'M', '1975-06-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('64446341', 'NI', 4, 'Roberto', 'Ramos', NULL, 'Morales', '3170826614', 'roberto220@correo.com', 'Av 80 #17-70', 'M', '2000-07-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('26951598', 'PP', 12, 'Nicolás', 'López', NULL, 'Herrera', '3170742222', 'nicolas315@correo.com', 'Av 56 #36-11', 'M', '1991-03-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('12244018', 'CE', 14, 'Camilo', 'Sánchez', NULL, 'González', '3157504552', 'camilo752@correo.com', 'Av 68 #39-20', 'M', '1977-10-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('51763267', 'NI', 2, 'Sebastián', 'García', NULL, 'Cruz', '3194361980', 'sebastian791@correo.com', 'Av 77 #31-30', 'M', '1969-03-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('75169251', 'CC', 1, 'Juliana', 'Morales', NULL, 'Martínez', '3176434565', 'juliana600@correo.com', 'Av 29 #38-56', 'F', '1981-10-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('60442020', 'NI', 14, 'Claudia', 'Herrera', NULL, 'Suárez', '3190753748', 'claudia44@correo.com', 'Av 14 #38-83', 'F', '1994-04-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('87862664', 'PP', 4, 'Roberto', 'López', NULL, 'Álvarez', '3162847572', 'roberto835@correo.com', 'Av 6 #23-83', 'M', '1997-11-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('99800835', 'TI', 7, 'Daniela', 'Jiménez', NULL, 'Rodríguez', '3186092056', 'daniela222@correo.com', 'Av 24 #2-81', 'F', '1962-04-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('88094160', 'CE', 2, 'Paola', 'Rivera', NULL, 'García', '3177930179', 'paola931@correo.com', 'Av 72 #19-97', 'F', '1987-11-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('65636716', 'TI', 14, 'Valentina', 'Suárez', NULL, 'Ramos', '3134972287', 'valentina423@correo.com', 'Av 67 #38-52', 'F', '1977-03-31');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('81104791', 'CC', 10, 'Marcela', 'Álvarez', NULL, 'Martínez', '3131636866', 'marcela748@correo.com', 'Av 25 #16-77', 'F', '1997-02-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('85613530', 'NI', 13, 'Felipe', 'Flores', NULL, 'García', '3119313264', 'felipe880@correo.com', 'Av 23 #13-82', 'M', '1993-08-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('90492828', 'CE', 2, 'Paola', 'Sánchez', NULL, 'Morales', '3133746912', 'paola588@correo.com', 'Av 57 #46-99', 'F', '1993-07-26');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('36580682', 'TI', 3, 'Alejandra', 'Flores', NULL, 'Rivera', '3194065834', 'alejandra967@correo.com', 'Av 55 #26-56', 'F', '1986-04-13');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('10636028', 'PP', 2, 'Andrés', 'Sánchez', NULL, 'Molina', '3154392606', 'andres676@correo.com', 'Av 23 #25-30', 'M', '1981-07-26');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('99728954', 'NI', 4, 'Gabriela', 'González', NULL, 'Suárez', '3166752704', 'gabriela904@correo.com', 'Av 74 #46-81', 'F', '1983-03-01');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('42447383', 'CC', 2, 'Daniel', 'Castro', NULL, 'Pérez', '3159781610', 'daniel631@correo.com', 'Av 57 #48-19', 'M', '1999-02-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('38657321', 'PP', 6, 'Daniela', 'Álvarez', NULL, 'Ortiz', '3173113531', 'daniela145@correo.com', 'Av 14 #35-84', 'F', '1995-03-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('84046990', 'PP', 4, 'Sofía', 'Rodríguez', NULL, 'Sánchez', '3161578597', 'sofia676@correo.com', 'Av 67 #28-24', 'F', '1974-01-22');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('73459898', 'TI', 3, 'Nicolás', 'Álvarez', NULL, 'Rodríguez', '3132878479', 'nicolas489@correo.com', 'Av 3 #38-89', 'M', '1994-01-13');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('76003853', 'CC', 8, 'Daniela', 'Medina', NULL, 'Pérez', '3155604049', 'daniela907@correo.com', 'Av 11 #24-9', 'F', '1990-11-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('51156003', 'CE', 11, 'Hernando', 'Pérez', NULL, 'Rodríguez', '3168109521', 'hernando460@correo.com', 'Av 44 #3-35', 'M', '1983-08-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('11433160', 'NI', 3, 'Ana', 'Herrera', NULL, 'Rodríguez', '3161092812', 'ana310@correo.com', 'Av 26 #31-49', 'F', '1961-09-21');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('18718672', 'PP', 3, 'Luis', 'Ramírez', NULL, 'Martínez', '3141802263', 'luis586@correo.com', 'Av 12 #5-2', 'M', '1973-10-25');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('36537596', 'CE', 2, 'Nicolás', 'Jiménez', NULL, 'García', '3182745798', 'nicolas148@correo.com', 'Av 74 #13-90', 'M', '1983-08-14');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('18842104', 'NI', 12, 'Felipe', 'Álvarez', NULL, 'Morales', '3152824042', 'felipe745@correo.com', 'Av 58 #23-96', 'M', '1983-07-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('63609010', 'CE', 7, 'Juliana', 'González', NULL, 'Rivera', '3168301666', 'juliana15@correo.com', 'Av 23 #10-76', 'F', '1992-10-22');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('18982581', 'PP', 10, 'Ana', 'Ramos', NULL, 'Vargas', '3135928411', 'ana399@correo.com', 'Av 36 #46-19', 'F', '2000-04-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('80166422', 'CC', 3, 'Hernando', 'Martínez', NULL, 'González', '3141542991', 'hernando963@correo.com', 'Av 12 #49-47', 'M', '1974-08-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('76372099', 'CE', 5, 'Natalia', 'Morales', NULL, 'Álvarez', '3167943314', 'natalia369@correo.com', 'Av 12 #39-33', 'F', '1996-08-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('50773548', 'CE', 6, 'María', 'Rivera', NULL, 'Castro', '3189146958', 'maria635@correo.com', 'Av 62 #41-79', 'F', '1998-06-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('15190410', 'TI', 1, 'Marcela', 'Reyes', NULL, 'Ramos', '3121653940', 'marcela778@correo.com', 'Av 61 #17-70', 'F', '2003-09-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('71026948', 'CC', 11, 'Juan', 'Mendoza', NULL, 'Molina', '3155282739', 'juan768@correo.com', 'Av 31 #39-61', 'M', '1994-01-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('39065567', 'TI', 12, 'Felipe', 'Herrera', NULL, 'Álvarez', '3111381630', 'felipe98@correo.com', 'Av 17 #38-87', 'M', '1996-11-01');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('18747686', 'CC', 7, 'Sebastián', 'Herrera', NULL, 'Molina', '3199214834', 'sebastian270@correo.com', 'Av 46 #31-52', 'M', '1967-10-29');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('25549100', 'TI', 10, 'Catalina', 'Reyes', NULL, 'Pérez', '3137172012', 'catalina238@correo.com', 'Av 19 #20-18', 'F', '1963-07-26');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('25133395', 'CC', 13, 'María', 'Rodríguez', NULL, 'Jiménez', '3181205095', 'maria600@correo.com', 'Av 2 #20-18', 'F', '1983-11-08');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('74254637', 'TI', 8, 'Valentina', 'Sánchez', NULL, 'Reyes', '3133141548', 'valentina102@correo.com', 'Av 50 #36-82', 'F', '1979-03-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('74339388', 'CE', 12, 'Gabriela', 'Suárez', NULL, 'Ramírez', '3164563778', 'gabriela911@correo.com', 'Av 21 #16-77', 'F', '2005-09-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('18903195', 'TI', 1, 'Catalina', 'Ortiz', NULL, 'Suárez', '3129537240', 'catalina722@correo.com', 'Av 6 #24-36', 'F', '1967-08-12');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('40580466', 'NI', 10, 'Sebastián', 'Torres', NULL, 'Flores', '3153508602', 'sebastian950@correo.com', 'Av 31 #37-25', 'M', '1988-02-01');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('84209410', 'NI', 12, 'Alejandro', 'Reyes', NULL, 'Morales', '3172101258', 'alejandro210@correo.com', 'Av 75 #34-23', 'M', '1988-10-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('61926784', 'TI', 8, 'Santiago', 'Suárez', NULL, 'López', '3128753889', 'santiago123@correo.com', 'Av 24 #8-47', 'M', '1988-02-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('88399260', 'NI', 1, 'Alejandra', 'Ramírez', NULL, 'González', '3139510761', 'alejandra781@correo.com', 'Av 22 #25-27', 'F', '1988-05-31');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('64832587', 'CC', 14, 'Daniela', 'Ramírez', NULL, 'López', '3130184404', 'daniela454@correo.com', 'Av 50 #40-97', 'F', '1999-11-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('90658619', 'CC', 12, 'Daniela', 'Morales', NULL, 'González', '3164224809', 'daniela173@correo.com', 'Av 27 #14-41', 'F', '1993-11-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('23624482', 'CC', 2, 'Carlos', 'Suárez', NULL, 'Molina', '3133988814', 'carlos837@correo.com', 'Av 69 #8-60', 'M', '1984-02-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('31754935', 'CE', 2, 'Valentina', 'Pérez', NULL, 'Molina', '3160657139', 'valentina69@correo.com', 'Av 18 #1-37', 'F', '1963-10-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('82674732', 'NI', 7, 'Fernanda', 'Reyes', NULL, 'Álvarez', '3180471123', 'fernanda911@correo.com', 'Av 60 #42-67', 'F', '1996-03-26');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('61347982', 'TI', 10, 'Juan', 'Flores', NULL, 'López', '3160146886', 'juan307@correo.com', 'Av 4 #21-63', 'M', '1993-09-22');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('72438718', 'TI', 7, 'Daniel', 'Torres', NULL, 'Ramos', '3137473351', 'daniel904@correo.com', 'Av 60 #9-54', 'M', '1993-05-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('18037892', 'PP', 9, 'Miguel', 'Mendoza', NULL, 'Molina', '3139352584', 'miguel522@correo.com', 'Av 67 #24-4', 'M', '1962-03-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('86014287', 'NI', 1, 'Catalina', 'Álvarez', NULL, 'Jiménez', '3130579604', 'catalina69@correo.com', 'Av 49 #22-85', 'F', '2005-05-22');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('22507696', 'CE', 15, 'Carolina', 'González', NULL, 'Álvarez', '3162935392', 'carolina283@correo.com', 'Av 29 #3-6', 'F', '1994-06-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('87748344', 'PP', 6, 'Luis', 'Flores', NULL, 'Álvarez', '3174638823', 'luis736@correo.com', 'Av 56 #27-16', 'M', '1981-06-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('11238177', 'CC', 7, 'Carolina', 'Mendoza', NULL, 'Pérez', '3156031713', 'carolina729@correo.com', 'Av 79 #24-44', 'F', '1992-05-12');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('71062690', 'CC', 7, 'Fernanda', 'Suárez', NULL, 'Sánchez', '3171261852', 'fernanda552@correo.com', 'Av 6 #19-43', 'F', '1986-01-13');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('26299272', 'PP', 8, 'Sebastián', 'López', NULL, 'Álvarez', '3181751708', 'sebastian785@correo.com', 'Av 60 #33-16', 'M', '2004-11-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('82085863', 'PP', 4, 'Claudia', 'Cruz', NULL, 'Rivera', '3115226275', 'claudia301@correo.com', 'Av 14 #4-39', 'F', '1998-03-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('20581573', 'NI', 4, 'Isabella', 'Pérez', NULL, 'Medina', '3147113201', 'isabella51@correo.com', 'Av 40 #49-71', 'F', '1980-10-08');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('43229057', 'NI', 10, 'Alejandra', 'Torres', NULL, 'Pérez', '3132599555', 'alejandra343@correo.com', 'Av 24 #42-73', 'F', '1967-05-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('35657723', 'NI', 7, 'Yolanda', 'García', NULL, 'López', '3127205509', 'yolanda708@correo.com', 'Av 74 #12-83', 'F', '1982-09-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('16249742', 'CE', 4, 'Daniel', 'Molina', NULL, 'Rodríguez', '3162978256', 'daniel701@correo.com', 'Av 18 #14-36', 'M', '1966-06-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('96469773', 'PP', 6, 'Fernanda', 'Medina', NULL, 'Vargas', '3136967563', 'fernanda461@correo.com', 'Av 36 #31-50', 'F', '1980-02-15');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('23265355', 'PP', 9, 'Miguel', 'Mendoza', NULL, 'Morales', '3198354700', 'miguel883@correo.com', 'Av 67 #20-96', 'M', '1984-05-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('84339493', 'PP', 1, 'Hernando', 'García', NULL, 'González', '3155808008', 'hernando582@correo.com', 'Av 1 #31-25', 'M', '1997-08-27');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('48366253', 'CC', 1, 'Daniel', 'Pérez', 'Juan', NULL, '3111435415', 'daniel828@correo.com', 'Av 55 #44-66', 'M', '2004-03-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('26735821', 'NI', 11, 'Hernando', 'Jiménez', 'Pedro', NULL, '3192716588', 'hernando15@correo.com', 'Av 25 #48-1', 'M', '1996-05-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('91764582', 'NI', 11, 'Alejandra', 'Ramírez', 'Natalia', NULL, '3170217057', 'alejandra622@correo.com', 'Av 22 #44-98', 'F', '1963-10-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('63964665', 'CE', 6, 'Sofía', 'López', 'Natalia', NULL, '3123601326', 'sofia10@correo.com', 'Av 56 #32-26', 'F', '1991-10-22');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('62430988', 'PP', 4, 'Ricardo', 'Castro', 'Alejandro', NULL, '3127383462', 'ricardo998@correo.com', 'Av 13 #22-53', 'M', '1991-12-04');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('74015552', 'TI', 13, 'Fernando', 'García', 'Luis', NULL, '3131638985', 'fernando298@correo.com', 'Av 20 #44-60', 'M', '1963-05-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('75269412', 'NI', 6, 'Camilo', 'Martínez', 'Felipe', NULL, '3173917095', 'camilo720@correo.com', 'Av 15 #18-59', 'M', '1979-01-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('92746890', 'NI', 2, 'María', 'Suárez', 'Alejandra', NULL, '3199129018', 'maria332@correo.com', 'Av 41 #1-20', 'F', '1972-12-21');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('95108432', 'TI', 14, 'Alberto', 'Castro', 'Santiago', NULL, '3193265522', 'alberto719@correo.com', 'Av 13 #6-14', 'M', '1985-05-30');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('90523345', 'NI', 14, 'Carlos', 'González', 'Pedro', NULL, '3132872143', 'carlos344@correo.com', 'Av 74 #28-31', 'M', '1988-06-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('70895423', 'CE', 12, 'Roberto', 'García', 'Camilo', NULL, '3142174926', 'roberto192@correo.com', 'Av 29 #20-25', 'M', '1992-02-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('40066698', 'CC', 2, 'Catalina', 'Morales', 'Claudia', NULL, '3111395331', 'catalina846@correo.com', 'Av 18 #7-42', 'F', '1964-04-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('95483760', 'TI', 10, 'Luis', 'González', 'Felipe', NULL, '3126424667', 'luis685@correo.com', 'Av 67 #34-31', 'M', '2000-01-31');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('76460815', 'PP', 12, 'Gabriela', 'López', 'Yolanda', NULL, '3137323438', 'gabriela176@correo.com', 'Av 45 #41-37', 'F', '1978-06-15');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('73989419', 'NI', 15, 'María', 'Pérez', 'Claudia', NULL, '3142026965', 'maria874@correo.com', 'Av 22 #21-88', 'F', '1987-05-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('30808715', 'NI', 13, 'Ricardo', 'Jiménez', 'Alejandro', NULL, '3146328564', 'ricardo731@correo.com', 'Av 19 #47-26', 'M', '1967-09-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('77620927', 'PP', 8, 'Juliana', 'González', 'Claudia', NULL, '3157539093', 'juliana480@correo.com', 'Av 55 #30-54', 'F', '1992-01-29');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('75089577', 'CC', 5, 'Daniel', 'Flores', 'Luis', NULL, '3119011655', 'daniel118@correo.com', 'Av 1 #10-78', 'M', '1978-01-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('71670595', 'PP', 10, 'Luis', 'Cruz', 'Ricardo', NULL, '3198374850', 'luis286@correo.com', 'Av 39 #26-9', 'M', '1972-07-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('93949256', 'TI', 8, 'Natalia', 'González', 'Alejandra', NULL, '3119511690', 'natalia895@correo.com', 'Av 73 #6-17', 'F', '1993-09-28');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('77571298', 'NI', 12, 'Valentina', 'Torres', 'Fernanda', NULL, '3156524622', 'valentina56@correo.com', 'Av 53 #46-80', 'F', '1969-05-13');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('97688458', 'PP', 2, 'Ana', 'Herrera', 'Natalia', NULL, '3140917031', 'ana620@correo.com', 'Av 58 #27-30', 'F', '2003-06-08');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('85295643', 'TI', 4, 'Gabriela', 'Ortiz', 'Sofía', NULL, '3148174606', 'gabriela495@correo.com', 'Av 69 #33-32', 'F', '1984-12-27');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('75389988', 'NI', 11, 'Andrés', 'Ramos', 'Santiago', NULL, '3183428512', 'andres767@correo.com', 'Av 54 #26-2', 'M', '1972-07-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('65875235', 'PP', 1, 'Jorge', 'Molina', 'Fernando', NULL, '3173148560', 'jorge154@correo.com', 'Av 9 #1-40', 'M', '1976-01-29');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('99187054', 'CC', 9, 'Paola', 'Mendoza', 'Marcela', NULL, '3199620191', 'paola427@correo.com', 'Av 8 #5-25', 'F', '1996-03-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('70354107', 'NI', 11, 'Marcela', 'Morales', 'Natalia', NULL, '3188547299', 'marcela38@correo.com', 'Av 50 #10-69', 'F', '1975-04-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('73561767', 'TI', 7, 'Nicolás', 'Medina', 'Pedro', NULL, '3160092039', 'nicolas259@correo.com', 'Av 77 #22-62', 'M', '1981-11-07');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('37289414', 'CE', 3, 'Jorge', 'Flores', 'Alejandro', NULL, '3142847443', 'jorge93@correo.com', 'Av 20 #44-72', 'M', '1999-03-01');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('63671462', 'CE', 6, 'Valentina', 'Castro', 'Claudia', NULL, '3148009735', 'valentina920@correo.com', 'Av 55 #39-51', 'F', '1989-05-06');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('67919082', 'NI', 6, 'Luis', 'Pérez', 'Roberto', NULL, '3113141814', 'luis784@correo.com', 'Av 37 #36-96', 'M', '1997-04-07');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('90966708', 'CE', 8, 'Carlos', 'Medina', 'David', NULL, '3133740148', 'carlos248@correo.com', 'Av 60 #33-83', 'M', '1999-10-20');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('71649116', 'TI', 6, 'Sebastián', 'Cruz', 'Miguel', NULL, '3180345971', 'sebastian861@correo.com', 'Av 30 #48-26', 'M', '1961-02-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('73150290', 'NI', 6, 'Claudia', 'Ramos', 'Paola', NULL, '3133997481', 'claudia168@correo.com', 'Av 9 #49-56', 'F', '2004-06-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('10280147', 'CC', 3, 'Catalina', 'Molina', NULL, NULL, '3114386856', 'catalina182@correo.com', 'Av 18 #19-47', 'F', '2002-04-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('68680918', 'NI', 1, 'Fernando', 'Jiménez', 'Andrés', NULL, '3177674129', 'fernando983@correo.com', 'Av 42 #35-63', 'M', '1962-11-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('43644452', 'CE', 4, 'Camilo', 'Suárez', 'Alejandro', NULL, '3198499057', 'camilo748@correo.com', 'Av 39 #22-91', 'M', '1976-07-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('73852434', 'NI', 2, 'Valentina', 'Medina', 'Alejandra', NULL, '3191079800', 'valentina108@correo.com', 'Av 30 #47-45', 'F', '1988-02-15');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('68224195', 'CC', 9, 'Alejandro', 'Sánchez', 'Camilo', NULL, '3133929694', 'alejandro537@correo.com', 'Av 66 #24-88', 'M', '2005-08-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('81209329', 'CE', 12, 'Diana', 'Torres', 'Juliana', NULL, '3143778330', 'diana671@correo.com', 'Av 37 #49-21', 'F', '1960-08-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('83271725', 'PP', 8, 'Natalia', 'Flores', 'Catalina', NULL, '3188816559', 'natalia234@correo.com', 'Av 22 #3-89', 'F', '1977-01-26');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('76993019', 'NI', 8, 'Alejandra', 'Ramírez', 'Carolina', NULL, '3131450764', 'alejandra446@correo.com', 'Av 63 #43-8', 'F', '1998-10-31');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('91212652', 'NI', 4, 'Yolanda', 'Sánchez', 'Alejandra', NULL, '3118128621', 'yolanda303@correo.com', 'Av 25 #34-65', 'F', '1970-10-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('25468478', 'CE', 8, 'Sandra', 'Martínez', 'Alejandra', NULL, '3142113655', 'sandra233@correo.com', 'Av 8 #42-88', 'F', '1983-05-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('13155879', 'TI', 5, 'Gabriela', 'Jiménez', 'María', NULL, '3119121643', 'gabriela564@correo.com', 'Av 6 #13-76', 'F', '1997-03-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('37592908', 'CC', 13, 'Jorge', 'Rodríguez', 'Miguel', NULL, '3186531884', 'jorge778@correo.com', 'Av 39 #45-87', 'M', '1977-12-15');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('86080861', 'CE', 1, 'Roberto', 'Morales', 'Alejandro', NULL, '3178598598', 'roberto223@correo.com', 'Av 4 #20-2', 'M', '1982-08-21');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('14187584', 'CC', 15, 'Valentina', 'Suárez', 'Ana', NULL, '3111504836', 'valentina878@correo.com', 'Av 36 #1-39', 'F', '1964-06-27');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('83957197', 'PP', 11, 'Catalina', 'Pérez', 'Alejandra', NULL, '3195807297', 'catalina329@correo.com', 'Av 45 #27-23', 'F', '1973-01-26');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('15344079', 'CE', 5, 'Fernando', 'Pérez', 'Hernando', NULL, '3154481849', 'fernando616@correo.com', 'Av 55 #8-88', 'M', '1986-01-16');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('91241436', 'NI', 5, 'Carolina', 'Cruz', 'Daniela', NULL, '3151358100', 'carolina942@correo.com', 'Av 61 #33-63', 'F', '1989-05-06');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('61133053', 'PP', 6, 'Nicolás', 'Castro', 'Carlos', NULL, '3168558100', 'nicolas503@correo.com', 'Av 58 #28-12', 'M', '1961-11-02');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('53684898', 'CC', 4, 'Paola', 'Herrera', 'Sandra', NULL, '3146552513', 'paola785@correo.com', 'Av 66 #2-65', 'F', '1975-05-31');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('53828083', 'NI', 6, 'Gabriela', 'Suárez', 'Isabella', NULL, '3116833876', 'gabriela377@correo.com', 'Av 67 #38-16', 'F', '1985-07-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('46532526', 'TI', 7, 'Yolanda', 'Ramírez', 'Valentina', NULL, '3178294681', 'yolanda963@correo.com', 'Av 39 #32-93', 'F', '1989-06-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('21123747', 'TI', 10, 'Felipe', 'Suárez', 'Jorge', NULL, '3121047495', 'felipe85@correo.com', 'Av 2 #10-70', 'M', '1969-01-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('20664018', 'CC', 3, 'Daniel', 'González', 'Nicolás', NULL, '3125799861', 'daniel602@correo.com', 'Av 19 #7-58', 'M', '1965-04-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('54903382', 'TI', 2, 'Carlos', 'Torres', 'Jorge', NULL, '3128836248', 'carlos44@correo.com', 'Av 31 #33-78', 'M', '1973-04-17');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('57411092', 'CC', 13, 'Yolanda', 'Martínez', 'Carolina', NULL, '3135407437', 'yolanda398@correo.com', 'Av 70 #17-93', 'F', '1975-10-29');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('22658740', 'CC', 3, 'Felipe', 'Mendoza', 'Sebastián', NULL, '3174018781', 'felipe110@correo.com', 'Av 6 #31-47', 'M', '1960-05-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('46918544', 'NI', 7, 'Miguel', 'Rivera', 'Ricardo', NULL, '3137051440', 'miguel680@correo.com', 'Av 19 #14-50', 'M', '1999-10-12');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('46499378', 'PP', 7, 'Miguel', 'Mendoza', 'Alejandro', NULL, '3163949308', 'miguel644@correo.com', 'Av 78 #37-73', 'M', '1977-11-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('55921387', 'CC', 4, 'Fernanda', 'Álvarez', NULL, NULL, '3111077619', 'fernanda612@correo.com', 'Av 56 #31-38', 'F', '1998-07-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('27489655', 'NI', 11, 'Claudia', 'Reyes', NULL, NULL, '3158504268', 'claudia370@correo.com', 'Av 76 #34-78', 'F', '1989-09-18');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('71658297', 'CE', 8, 'Natalia', 'Ramos', NULL, NULL, '3133637158', 'natalia836@correo.com', 'Av 25 #37-63', 'F', '1976-08-06');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('76331270', 'PP', 6, 'Sandra', 'Álvarez', NULL, NULL, '3165558669', 'sandra493@correo.com', 'Av 78 #41-43', 'F', '1998-01-09');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('28597882', 'PP', 1, 'David', 'López', NULL, NULL, '3126989313', 'david86@correo.com', 'Av 35 #18-62', 'M', '1979-09-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('72685550', 'PP', 11, 'Juan', 'Molina', NULL, NULL, '3178807596', 'juan447@correo.com', 'Av 52 #13-33', 'M', '2004-06-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('51820248', 'NI', 10, 'David', 'Castro', NULL, NULL, '3137626276', 'david814@correo.com', 'Av 63 #28-58', 'M', '1974-11-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('21868737', 'TI', 13, 'Daniela', 'Herrera', NULL, NULL, '3150586096', 'daniela630@correo.com', 'Av 32 #38-66', 'F', '1972-08-11');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('26902822', 'TI', 1, 'Sandra', 'Medina', NULL, NULL, '3110798977', 'sandra687@correo.com', 'Av 60 #49-67', 'F', '1996-02-24');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('72272153', 'CC', 13, 'Carolina', 'Castro', NULL, NULL, '3167020114', 'carolina834@correo.com', 'Av 19 #2-37', 'F', '1997-05-26');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('82549785', 'NI', 1, 'Claudia', 'Ramos', NULL, NULL, '3140067619', 'claudia24@correo.com', 'Av 38 #17-50', 'F', '1989-09-08');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('86553214', 'PP', 4, 'Claudia', 'Martínez', NULL, NULL, '3165830504', 'claudia850@correo.com', 'Av 10 #42-55', 'F', '1993-04-25');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('36263497', 'CE', 7, 'Carlos', 'González', NULL, NULL, '3130325007', 'carlos482@correo.com', 'Av 63 #12-94', 'M', '1983-10-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('14533608', 'CE', 12, 'María', 'Cruz', NULL, NULL, '3126595059', 'maria768@correo.com', 'Av 49 #42-52', 'F', '1984-06-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('91439883', 'CC', 9, 'Isabella', 'Morales', NULL, NULL, '3196868145', 'isabella35@correo.com', 'Av 36 #42-62', 'F', '1984-06-29');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('86414081', 'PP', 8, 'Alberto', 'Sánchez', NULL, NULL, '3167680826', 'alberto596@correo.com', 'Av 15 #47-57', 'M', '1960-11-10');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('64714435', 'CE', 1, 'Carlos', 'García', NULL, NULL, '3160605018', 'carlos553@correo.com', 'Av 77 #47-68', 'M', '1964-03-03');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('85330101', 'PP', 2, 'Ana', 'García', NULL, NULL, '3162185014', 'ana625@correo.com', 'Av 40 #32-99', 'F', '2003-06-07');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('17840669', 'NI', 1, 'Miguel', 'García', NULL, NULL, '3186095382', 'miguel788@correo.com', 'Av 16 #15-98', 'M', '1994-10-07');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('37247147', 'PP', 15, 'Andrés', 'Martínez', NULL, NULL, '3138589967', 'andres981@correo.com', 'Av 40 #5-47', 'M', '1973-07-05');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('31800123', 'CE', 13, 'Juan', 'Pérez', NULL, NULL, '3189498261', 'juan651@correo.com', 'Av 38 #39-53', 'M', '1995-05-29');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('53488444', 'PP', 1, 'Paola', 'Suárez', NULL, NULL, '3178680335', 'paola905@correo.com', 'Av 8 #47-92', 'F', '1963-07-14');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('74114251', 'CC', 14, 'Luis', 'Jiménez', NULL, NULL, '3132110051', 'luis580@correo.com', 'Av 32 #41-97', 'M', '1966-07-06');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('48143081', 'PP', 12, 'Carlos', 'Rivera', NULL, NULL, '3140935620', 'carlos247@correo.com', 'Av 29 #40-78', 'M', '1998-07-23');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('22901033', 'NI', 3, 'Juan', 'Suárez', NULL, NULL, '3140036841', 'juan622@correo.com', 'Av 37 #3-51', 'M', '2004-07-14');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('72215698', 'TI', 8, 'Santiago', 'Cruz', NULL, NULL, '3152302682', 'santiago946@correo.com', 'Av 76 #15-58', 'M', '1980-09-19');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('28222781', 'NI', 2, 'Miguel', 'Herrera', NULL, NULL, '3184300929', 'miguel507@correo.com', 'Av 71 #47-98', 'M', '2002-06-22');
INSERT INTO public.customers (customer_doc, doc_type_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth) VALUES ('23772773', 'CC', 12, 'David', 'Ortiz', NULL, NULL, '3128216197', 'david736@correo.com', 'Av 29 #48-28', 'M', '1999-08-03');


--
-- TOC entry 4236 (class 0 OID 18413)
-- Dependencies: 223
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.departments (department_id, country_id, name) VALUES ('CO-NSA', 'CO', 'Norte de Santander');
INSERT INTO public.departments (department_id, country_id, name) VALUES ('CO-CUN', 'CO', 'Cundinamarca');
INSERT INTO public.departments (department_id, country_id, name) VALUES ('CO-ANT', 'CO', 'Antioquia');
INSERT INTO public.departments (department_id, country_id, name) VALUES ('CO-VAL', 'CO', 'Valle del Cauca');
INSERT INTO public.departments (department_id, country_id, name) VALUES ('CO-BOL', 'CO', 'Bolívar');
INSERT INTO public.departments (department_id, country_id, name) VALUES ('CO-ATL', 'CO', 'Atlántico');
INSERT INTO public.departments (department_id, country_id, name) VALUES ('VE-A', 'VE', 'Distrito Capital');
INSERT INTO public.departments (department_id, country_id, name) VALUES ('EC-P', 'EC', 'Pichincha');
INSERT INTO public.departments (department_id, country_id, name) VALUES ('US-CA', 'US', 'California');
INSERT INTO public.departments (department_id, country_id, name) VALUES ('MX-JAL', 'MX', 'Jalisco');


--
-- TOC entry 4232 (class 0 OID 17795)
-- Dependencies: 219
-- Data for Name: documents_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.documents_types (doc_type_id, name, description) VALUES ('CC', 'Cédula de Ciudadanía', NULL);
INSERT INTO public.documents_types (doc_type_id, name, description) VALUES ('CE', 'Cédula de Extranjería', 'Extranjeros residentes en Colombia');
INSERT INTO public.documents_types (doc_type_id, name, description) VALUES ('PP', 'Pasaporte', 'Documento internacional');
INSERT INTO public.documents_types (doc_type_id, name, description) VALUES ('TI', 'Tarjeta de Identidad', 'Menores de edad colombianos');
INSERT INTO public.documents_types (doc_type_id, name, description) VALUES ('NI', 'NIT', 'Número de identificación tributaria');


--
-- TOC entry 4253 (class 0 OID 18663)
-- Dependencies: 240
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('28566572', 'CC', 'CO', 'H4', 6, 'Marcela', 'Medina', 'Juliana', 'Castro', '3166661351', 'marcela.medina30@gmail.com', 'Calle 77 #5-50', 'F', '1992-11-09', '2021-09-10', '06:00:00', '14:15:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('82070937', 'CC', 'GE', 'H5', 11, 'Fernanda', 'Herrera', 'Carolina', 'García', '3110435578', 'fernanda.herrera68@gmail.com', 'Calle 93 #47-34', 'F', '1981-12-20', '2021-11-25', '08:00:00', '16:45:00', 1500000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('27232410', 'CC', 'CA', 'H3', 9, 'Juan', 'Martínez', 'Hernando', 'Álvarez', '3136998038', 'juan.martinez79@gmail.com', 'Calle 92 #20-52', 'M', '1999-08-06', '2021-09-01', '07:30:00', '18:45:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('82374753', 'CC', 'CO', 'H4', 8, 'Fernando', 'Torres', 'Daniel', 'Reyes', '3123009833', 'fernando.torres22@gmail.com', 'Calle 85 #28-46', 'M', '1975-12-08', '2021-10-20', '09:15:00', '17:45:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('18135295', 'CC', 'GE', 'H4', 11, 'Daniela', 'Reyes', 'Laura', 'Cruz', '3128814949', 'daniela.reyes67@gmail.com', 'Calle 55 #12-36', 'F', '1988-01-23', '2021-06-23', '06:15:00', '15:15:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('22517517', 'CC', 'RE', 'H4', 1, 'Juan', 'Herrera', 'Nicolás', 'López', '3117869910', 'juan.herrera61@gmail.com', 'Calle 22 #25-1', 'M', '1980-08-08', '2021-03-27', '09:45:00', '17:15:00', 5000000.00, 'I', '2022-08-10');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('41568532', 'CC', 'GE', 'H3', 2, 'Andrés', 'Martínez', 'Fernando', 'Pérez', '3188339168', 'andres.martinez94@gmail.com', 'Calle 73 #34-41', 'M', '1988-02-11', '2021-03-03', '07:00:00', '18:00:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('71367643', 'CC', 'SE', 'H3', 3, 'Felipe', 'Torres', 'Daniel', 'Castro', '3138609087', 'felipe.torres78@gmail.com', 'Calle 65 #17-17', 'M', '1984-03-08', '2021-02-07', '06:45:00', '18:00:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('92097999', 'CC', 'SE', 'H3', 8, 'Daniel', 'Flores', 'Ricardo', 'Pérez', '3124366125', 'daniel.flores24@gmail.com', 'Calle 96 #36-20', 'M', '1999-05-03', '2021-09-28', '06:30:00', '14:15:00', 1800000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('93303777', 'CC', 'MA', 'H3', 9, 'Daniel', 'Morales', 'Miguel', 'Álvarez', '3165259205', 'daniel.morales52@gmail.com', 'Calle 86 #48-32', 'M', '1976-12-07', '2021-05-02', '07:15:00', '17:00:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('87925434', 'CC', 'CA', 'H2', 5, 'Alejandra', 'García', 'Isabella', 'López', '3178642041', 'alejandra.garcia87@gmail.com', 'Calle 15 #25-74', 'F', '1981-11-28', '2021-01-20', '06:45:00', '16:30:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('76354180', 'CC', 'MA', 'H2', 4, 'Nicolás', 'Cruz', 'Santiago', 'Medina', '3179519112', 'nicolas.cruz32@gmail.com', 'Calle 60 #4-72', 'M', '1987-12-05', '2021-05-05', '07:00:00', '14:45:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('69401199', 'CC', 'AD', 'H5', 9, 'Nicolás', 'Vargas', 'Luis', 'Reyes', '3143183955', 'nicolas.vargas43@gmail.com', 'Calle 82 #18-99', 'M', '1997-06-25', '2021-09-16', '09:45:00', '15:45:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('66390708', 'CC', 'CO', 'H5', 1, 'Isabella', 'Vargas', 'Alejandra', 'Ortiz', '3162343121', 'isabella.vargas48@gmail.com', 'Calle 54 #35-96', 'F', '1987-06-22', '2021-10-27', '06:45:00', '17:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('14164775', 'CC', 'RE', 'H3', 11, 'Ricardo', 'Cruz', 'Daniel', 'Martínez', '3125353091', 'ricardo.cruz95@gmail.com', 'Calle 73 #14-60', 'M', '1981-02-03', '2021-04-13', '06:15:00', '15:15:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('87669750', 'CC', 'GE', 'H3', 5, 'Paola', 'Álvarez', 'Claudia', 'Pérez', '3194187049', 'paola.alvarez98@gmail.com', 'Calle 32 #7-90', 'F', '1971-02-25', '2021-06-09', '09:45:00', '15:00:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('19255216', 'CC', 'AD', 'H2', 7, 'Roberto', 'Morales', 'Andrés', 'Herrera', '3158612055', 'roberto.morales65@gmail.com', 'Calle 82 #30-91', 'M', '1992-09-11', '2021-11-28', '08:00:00', '17:45:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('72394301', 'CC', 'AS', 'H5', 10, 'Paola', 'Cruz', 'Fernanda', 'Torres', '3142730796', 'paola.cruz67@gmail.com', 'Calle 97 #30-73', 'F', '1989-07-16', '2021-10-31', '08:30:00', '15:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('38470244', 'CC', 'AS', 'H4', 3, 'Isabella', 'Ramos', 'María', 'Rivera', '3179340535', 'isabella.ramos11@gmail.com', 'Calle 25 #6-31', 'F', '1985-12-01', '2021-05-13', '08:30:00', '18:30:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('49761527', 'CC', 'CO', 'H2', 2, 'Marcela', 'Suárez', 'Fernanda', 'Flores', '3117318358', 'marcela.suarez15@gmail.com', 'Calle 71 #19-90', 'F', '1980-03-16', '2021-07-04', '07:30:00', '14:15:00', 1800000.00, 'I', '2024-02-17');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('69118721', 'CC', 'AS', 'H1', 8, 'Claudia', 'Medina', 'María', 'Flores', '3163782042', 'claudia.medina18@gmail.com', 'Calle 63 #5-74', 'F', '1985-04-14', '2021-04-05', '06:30:00', '17:00:00', 5000000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('84903294', 'CC', 'GE', 'H1', 4, 'Luis', 'Flores', 'Roberto', 'Martínez', '3167556566', 'luis.flores85@gmail.com', 'Calle 40 #37-80', 'M', '1988-09-01', '2021-11-07', '07:45:00', '17:45:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('93893865', 'CC', 'SE', 'H2', 4, 'Sofía', 'Martínez', 'Daniela', 'Reyes', '3145652586', 'sofia.martinez29@gmail.com', 'Calle 19 #5-8', 'F', '1996-06-16', '2021-12-05', '07:45:00', '14:15:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('98930456', 'CC', 'SE', 'H1', 8, 'Claudia', 'Rivera', 'Paola', 'Ortiz', '3125558733', 'claudia.rivera51@gmail.com', 'Calle 99 #26-66', 'F', '1987-12-19', '2021-10-09', '06:45:00', '14:30:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('22510327', 'CC', 'MA', 'H4', 9, 'Jorge', 'Herrera', 'Alejandro', 'García', '3178299645', 'jorge.herrera47@gmail.com', 'Calle 91 #18-54', 'M', '1980-01-30', '2021-02-28', '09:00:00', '15:45:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('46468984', 'CC', 'CO', 'H4', 5, 'Valentina', 'Vargas', 'Carolina', NULL, '3130509175', 'valentina.vargas98@gmail.com', 'Calle 91 #14-9', 'F', '1985-01-24', '2021-06-13', '06:15:00', '15:15:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('60882459', 'CC', 'SE', 'H5', 1, 'Santiago', 'Vargas', 'Luis', NULL, '3143859311', 'santiago.vargas63@gmail.com', 'Calle 11 #31-3', 'M', '1984-09-07', '2021-04-19', '09:30:00', '16:45:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('93940940', 'CC', 'AS', 'H5', 6, 'Juliana', 'Sánchez', 'Laura', NULL, '3175056916', 'juliana.sanchez66@gmail.com', 'Calle 16 #2-81', 'F', '1989-10-30', '2021-01-27', '07:30:00', '18:15:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('84077101', 'CC', 'AD', 'H3', 6, 'Sandra', 'Herrera', 'Daniela', NULL, '3141348220', 'sandra.herrera59@gmail.com', 'Calle 100 #27-6', 'F', '1994-05-18', '2021-07-13', '09:30:00', '15:15:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('14968688', 'CC', 'AS', 'H2', 3, 'Gabriela', 'Reyes', 'Yolanda', 'Cruz', '3112059919', 'gabriela.reyes68@gmail.com', 'Calle 93 #10-53', 'F', '1975-08-31', '2021-09-15', '08:00:00', '17:00:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('54099326', 'CC', 'GE', 'H2', 7, 'Hernando', 'Rivera', 'Sebastián', 'Suárez', '3141510328', 'hernando.rivera18@gmail.com', 'Calle 81 #44-37', 'M', '2000-04-01', '2021-10-01', '09:30:00', '17:00:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('32329103', 'CC', 'AS', 'H4', 2, 'Santiago', 'Álvarez', 'Miguel', 'Cruz', '3167805802', 'santiago.alvarez57@gmail.com', 'Calle 19 #16-68', 'M', '1983-06-08', '2021-01-15', '06:30:00', '14:30:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('43567615', 'CC', 'MA', 'H3', 5, 'Juan', 'Morales', 'Nicolás', 'Medina', '3186762164', 'juan.morales58@gmail.com', 'Calle 46 #37-38', 'M', '1990-06-29', '2021-06-04', '07:45:00', '17:00:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('20106509', 'CC', 'AS', 'H3', 2, 'Catalina', 'Mendoza', 'Sofía', 'Rivera', '3182017516', 'catalina.mendoza43@gmail.com', 'Calle 16 #30-48', 'F', '1976-04-25', '2021-04-26', '09:30:00', '14:45:00', 1300000.00, 'I', '2024-09-01');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('70887034', 'CC', 'MA', 'H3', 3, 'Claudia', 'Ramírez', 'Yolanda', 'Herrera', '3192631441', 'claudia.ramirez72@gmail.com', 'Calle 53 #18-5', 'F', '1986-08-23', '2021-12-10', '09:15:00', '17:00:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('77624084', 'CC', 'AS', 'H4', 2, 'Daniela', 'Jiménez', 'Natalia', 'Medina', '3163904155', 'daniela.jimenez71@gmail.com', 'Calle 55 #44-14', 'F', '1979-12-09', '2021-11-11', '06:30:00', '17:00:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('26937148', 'CC', 'GE', 'H1', 3, 'Ana', 'Rivera', 'Yolanda', 'Suárez', '3191259008', 'ana.rivera74@gmail.com', 'Calle 56 #7-90', 'F', '1982-05-03', '2021-11-16', '08:45:00', '18:30:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('63516659', 'CC', 'AS', 'H1', 6, 'Santiago', 'Ramírez', 'Nicolás', 'Ortiz', '3173655158', 'santiago.ramirez29@gmail.com', 'Calle 9 #6-11', 'M', '1988-08-29', '2021-02-18', '08:45:00', '16:30:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('99927658', 'CC', 'AD', 'H2', 1, 'Claudia', 'González', 'Natalia', 'Herrera', '3157197152', 'claudia.gonzalez49@gmail.com', 'Calle 14 #37-65', 'F', '1975-06-26', '2021-07-30', '08:45:00', '14:30:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('25419645', 'CC', 'AD', 'H3', 9, 'Hernando', 'López', 'Daniel', 'Morales', '3145896226', 'hernando.lopez94@gmail.com', 'Calle 4 #12-35', 'M', '1982-07-01', '2021-10-21', '07:45:00', '18:00:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('19339597', 'CC', 'MA', 'H3', 10, 'Natalia', 'Pérez', 'María', 'González', '3170887307', 'natalia.perez63@gmail.com', 'Calle 44 #11-48', 'F', '1976-05-13', '2021-11-21', '06:00:00', '18:15:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('77144075', 'CC', 'CO', 'H4', 9, 'Juliana', 'González', 'Paola', 'Castro', '3171707170', 'juliana.gonzalez12@gmail.com', 'Calle 10 #21-74', 'F', '1995-01-24', '2021-12-09', '08:00:00', '17:00:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('33068427', 'CC', 'AD', 'H4', 1, 'Juliana', 'López', 'Sofía', 'Castro', '3189036966', 'juliana.lopez65@gmail.com', 'Calle 52 #34-11', 'F', '1997-09-23', '2021-08-24', '08:00:00', '17:00:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('78515906', 'CC', 'GE', 'H5', 3, 'Isabella', 'Rivera', 'Valentina', 'Álvarez', '3129655410', 'isabella.rivera23@gmail.com', 'Calle 33 #13-23', 'F', '1998-05-28', '2021-02-28', '07:30:00', '16:15:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('23891786', 'CC', 'AS', 'H3', 1, 'Felipe', 'Jiménez', 'Hernando', 'González', '3180162053', 'felipe.jimenez77@gmail.com', 'Calle 79 #11-47', 'M', '1985-05-28', '2021-02-13', '07:00:00', '15:45:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('27307598', 'CC', 'MA', 'H5', 11, 'Ricardo', 'Cruz', 'Alejandro', 'Molina', '3127152188', 'ricardo.cruz52@gmail.com', 'Calle 86 #45-95', 'M', '1996-09-10', '2021-12-29', '06:30:00', '18:45:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('34194479', 'CC', 'SE', 'H5', 6, 'Santiago', 'Morales', 'Fernando', 'García', '3149700543', 'santiago.morales19@gmail.com', 'Calle 13 #33-99', 'M', '1979-08-11', '2021-06-24', '09:15:00', '15:15:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('34272734', 'CC', 'CA', 'H4', 3, 'Felipe', 'Suárez', 'Luis', 'Castro', '3169619341', 'felipe.suarez40@gmail.com', 'Calle 79 #19-97', 'M', '1998-01-09', '2021-03-26', '09:00:00', '17:30:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('86560394', 'CC', 'AD', 'H4', 4, 'Alberto', 'Flores', 'Daniel', 'Ramos', '3191156554', 'alberto.flores35@gmail.com', 'Calle 18 #17-7', 'M', '1989-10-06', '2021-08-25', '08:45:00', '18:45:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('21257528', 'CC', 'SE', 'H4', 2, 'Alejandra', 'Molina', 'Claudia', 'Jiménez', '3156920514', 'alejandra.molina67@gmail.com', 'Calle 4 #27-7', 'F', '1977-03-11', '2021-05-20', '09:15:00', '17:00:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('24923247', 'CC', 'MA', 'H4', 3, 'Juan', 'Torres', 'Carlos', 'Sánchez', '3193592219', 'juan.torres91@gmail.com', 'Calle 59 #5-15', 'M', '1982-12-04', '2021-05-02', '08:00:00', '14:15:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('67611469', 'CC', 'SE', 'H1', 3, 'Fernando', 'Ramírez', 'Roberto', 'Molina', '3199686286', 'fernando.ramirez95@gmail.com', 'Calle 11 #34-47', 'M', '1970-01-26', '2021-11-11', '08:15:00', '18:45:00', 1500000.00, 'I', '2023-02-14');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('28099607', 'CC', 'CA', 'H4', 11, 'Paola', 'Molina', 'Daniela', 'Ramos', '3115624520', 'paola.molina35@gmail.com', 'Calle 41 #20-66', 'F', '1972-10-30', '2021-08-23', '06:30:00', '15:00:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('57912262', 'CC', 'SE', 'H4', 4, 'Carolina', 'Álvarez', 'Laura', 'Cruz', '3169020451', 'carolina.alvarez61@gmail.com', 'Calle 50 #22-24', 'F', '1972-02-23', '2021-12-02', '08:30:00', '14:30:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('67795113', 'CC', 'GE', 'H4', 7, 'Natalia', 'Torres', 'Fernanda', 'Martínez', '3149680122', 'natalia.torres94@gmail.com', 'Calle 40 #29-78', 'F', '1997-01-09', '2021-04-03', '08:30:00', '14:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('46850196', 'CC', 'MA', 'H2', 6, 'Nicolás', 'Vargas', 'Ricardo', 'Rodríguez', '3191547054', 'nicolas.vargas28@gmail.com', 'Calle 87 #29-5', 'M', '1998-09-08', '2021-01-30', '06:45:00', '16:15:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('91214453', 'CC', 'RE', 'H4', 10, 'Daniel', 'Morales', 'Ricardo', 'Castro', '3187030477', 'daniel.morales19@gmail.com', 'Calle 18 #34-47', 'M', '1976-11-18', '2021-12-14', '09:30:00', '16:45:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('79490594', 'CC', 'AS', 'H1', 3, 'Carolina', 'López', 'Valentina', 'García', '3148329479', 'carolina.lopez88@gmail.com', 'Calle 89 #32-26', 'F', '1987-05-12', '2021-10-15', '06:30:00', '16:45:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('52894344', 'CC', 'GE', 'H2', 8, 'Juan', 'Pérez', 'Nicolás', 'Molina', '3195590648', 'juan.perez99@gmail.com', 'Calle 23 #24-66', 'M', '1999-12-16', '2021-06-27', '06:30:00', '16:15:00', 4000000.00, 'I', '2023-06-28');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('91390501', 'CC', 'RE', 'H1', 11, 'Camilo', 'García', 'Sebastián', NULL, '3198473848', 'camilo.garcia42@gmail.com', 'Calle 88 #9-81', 'M', '1992-04-13', '2021-05-27', '07:30:00', '15:15:00', 3000000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('15047559', 'CC', 'AS', 'H5', 8, 'Ricardo', 'Martínez', 'Fernando', NULL, '3184399083', 'ricardo.martinez84@gmail.com', 'Calle 95 #3-58', 'M', '1972-07-21', '2021-07-08', '08:00:00', '14:45:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('52773159', 'CC', 'RE', 'H4', 4, 'Valentina', 'Martínez', 'Gabriela', NULL, '3128628439', 'valentina.martinez70@gmail.com', 'Calle 98 #46-61', 'F', '1974-06-12', '2021-11-29', '08:15:00', '15:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('70394554', 'CC', 'GE', 'H5', 6, 'Juliana', 'Martínez', 'Marcela', 'González', '3168065043', 'juliana.martinez26@gmail.com', 'Calle 65 #4-16', 'F', '1990-11-24', '2021-12-15', '08:15:00', '18:15:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('85647532', 'CC', 'AD', 'H1', 11, 'Roberto', 'González', 'Pedro', 'Pérez', '3186790955', 'roberto.gonzalez36@gmail.com', 'Calle 54 #40-82', 'M', '1971-11-06', '2021-01-15', '06:00:00', '18:30:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('64504816', 'CC', 'CO', 'H2', 8, 'Alejandra', 'Cruz', 'Sofía', 'Flores', '3172336371', 'alejandra.cruz71@gmail.com', 'Calle 27 #22-78', 'F', '1983-05-06', '2021-08-21', '06:00:00', '15:45:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('52831009', 'CC', 'GE', 'H4', 6, 'Isabella', 'Castro', 'Natalia', 'González', '3116792127', 'isabella.castro22@gmail.com', 'Calle 38 #25-79', 'F', '1980-11-04', '2021-08-27', '06:30:00', '17:15:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('48352498', 'CC', 'AS', 'H1', 10, 'Laura', 'Flores', 'Yolanda', 'Ramos', '3164123845', 'laura.flores56@gmail.com', 'Calle 47 #3-52', 'F', '1994-01-28', '2021-01-05', '06:45:00', '15:30:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('83800569', 'CC', 'AS', 'H2', 7, 'Ricardo', 'Flores', 'Alberto', 'Martínez', '3184870921', 'ricardo.flores53@gmail.com', 'Calle 47 #49-19', 'M', '1982-07-19', '2021-11-16', '06:15:00', '14:45:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('24710878', 'CC', 'AD', 'H1', 6, 'Marcela', 'Ramos', 'Sofía', 'García', '3187641510', 'marcela.ramos93@gmail.com', 'Calle 74 #15-93', 'F', '1988-09-07', '2021-10-26', '08:00:00', '18:45:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('85280948', 'CC', 'CO', 'H3', 3, 'Fernanda', 'Mendoza', 'Catalina', 'Rodríguez', '3155946354', 'fernanda.mendoza78@gmail.com', 'Calle 70 #23-87', 'F', '1984-07-31', '2022-12-06', '09:45:00', '16:15:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('49945150', 'CC', 'CO', 'H5', 5, 'Diana', 'Torres', 'Valentina', 'Herrera', '3146702849', 'diana.torres81@gmail.com', 'Calle 37 #8-74', 'F', '1982-12-19', '2022-12-27', '07:45:00', '16:45:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('48605090', 'CC', 'RE', 'H2', 5, 'Gabriela', 'Álvarez', 'Natalia', 'González', '3146390817', 'gabriela.alvarez78@gmail.com', 'Calle 72 #45-35', 'F', '1973-07-18', '2022-06-27', '09:30:00', '17:15:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('96690951', 'CC', 'SE', 'H3', 6, 'Catalina', 'Álvarez', 'Diana', 'Flores', '3114877451', 'catalina.alvarez32@gmail.com', 'Calle 51 #32-24', 'F', '1972-08-27', '2022-02-15', '07:00:00', '15:45:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('33554528', 'CC', 'CO', 'H4', 5, 'Paola', 'Mendoza', 'María', 'Rivera', '3199826000', 'paola.mendoza61@gmail.com', 'Calle 13 #12-18', 'F', '1997-05-28', '2022-11-24', '09:45:00', '18:30:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('27927298', 'CC', 'CO', 'H5', 4, 'Claudia', 'Morales', 'Sofía', 'Suárez', '3199133246', 'claudia.morales78@gmail.com', 'Calle 28 #49-32', 'F', '1991-06-14', '2022-03-20', '09:30:00', '17:45:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('85721444', 'CC', 'GE', 'H5', 6, 'Fernando', 'Jiménez', 'Nicolás', 'Molina', '3169302835', 'fernando.jimenez76@gmail.com', 'Calle 15 #44-27', 'M', '1975-01-13', '2022-02-01', '07:15:00', '15:30:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('78886959', 'CC', 'CA', 'H1', 8, 'Ana', 'Vargas', 'Fernanda', 'Rodríguez', '3110404729', 'ana.vargas42@gmail.com', 'Calle 96 #14-75', 'F', '1988-08-20', '2022-08-22', '06:45:00', '16:00:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('19263592', 'CC', 'RE', 'H4', 9, 'Santiago', 'Molina', 'Ricardo', 'Martínez', '3196688655', 'santiago.molina92@gmail.com', 'Calle 54 #24-49', 'M', '1991-03-06', '2022-01-17', '08:45:00', '15:15:00', 5000000.00, 'I', '2024-07-29');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('25922674', 'CC', 'AD', 'H5', 3, 'Gabriela', 'Reyes', 'Ana', 'Herrera', '3150045602', 'gabriela.reyes12@gmail.com', 'Calle 60 #44-93', 'F', '1978-01-03', '2022-10-03', '09:15:00', '15:00:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('17575790', 'CC', 'CO', 'H5', 4, 'Daniel', 'Castro', 'Andrés', 'Vargas', '3153038943', 'daniel.castro86@gmail.com', 'Calle 31 #20-19', 'M', '1976-04-14', '2022-09-15', '08:15:00', '18:30:00', 3000000.00, 'I', '2025-03-11');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('94019376', 'CC', 'CA', 'H2', 9, 'Santiago', 'Torres', 'Alejandro', 'Rodríguez', '3152779814', 'santiago.torres77@gmail.com', 'Calle 90 #27-53', 'M', '2000-06-12', '2022-08-07', '09:00:00', '16:45:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('42122457', 'CC', 'MA', 'H1', 4, 'Hernando', 'Molina', 'Daniel', 'Suárez', '3158270683', 'hernando.molina43@gmail.com', 'Calle 66 #32-60', 'M', '1994-10-07', '2022-06-14', '08:45:00', '17:30:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('75581613', 'CC', 'SE', 'H1', 6, 'Hernando', 'Cruz', 'Alberto', 'Reyes', '3175540707', 'hernando.cruz79@gmail.com', 'Calle 24 #35-83', 'M', '1998-10-14', '2022-09-09', '09:15:00', '16:15:00', 1500000.00, 'I', '2023-10-03');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('81057233', 'CC', 'RE', 'H2', 1, 'María', 'Herrera', 'Yolanda', 'Ortiz', '3124363501', 'maria.herrera32@gmail.com', 'Calle 13 #34-20', 'F', '1982-04-29', '2022-10-02', '08:00:00', '18:45:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('20605783', 'CC', 'MA', 'H1', 5, 'Pedro', 'Torres', 'Fernando', 'Morales', '3197742922', 'pedro.torres20@gmail.com', 'Calle 84 #49-5', 'M', '1986-09-26', '2022-07-27', '09:15:00', '15:30:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('33002714', 'CC', 'RE', 'H4', 1, 'Gabriela', 'Herrera', 'Yolanda', 'Ramos', '3140838737', 'gabriela.herrera15@gmail.com', 'Calle 28 #45-73', 'F', '1973-09-16', '2022-09-13', '09:30:00', '18:00:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('34072553', 'CC', 'RE', 'H5', 9, 'Laura', 'Reyes', 'Ana', 'Torres', '3185693188', 'laura.reyes30@gmail.com', 'Calle 31 #37-50', 'F', '1984-02-09', '2022-01-09', '07:15:00', '17:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('17207013', 'CC', 'AD', 'H4', 2, 'Gabriela', 'Molina', 'Sandra', 'Mendoza', '3113976288', 'gabriela.molina51@gmail.com', 'Calle 82 #18-58', 'F', '1974-05-20', '2022-08-12', '07:00:00', '16:45:00', 5000000.00, 'I', '2025-01-10');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('46207439', 'CC', 'AD', 'H1', 8, 'Claudia', 'García', 'Ana', 'Flores', '3178778646', 'claudia.garcia81@gmail.com', 'Calle 53 #7-4', 'F', '1974-08-02', '2022-03-09', '06:15:00', '17:45:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('50232066', 'CC', 'MA', 'H3', 5, 'Sandra', 'Pérez', 'Ana', 'Ortiz', '3136246038', 'sandra.perez88@gmail.com', 'Calle 59 #7-18', 'F', '1991-09-21', '2022-02-09', '08:30:00', '15:45:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('54927535', 'CC', 'AS', 'H4', 6, 'Camilo', 'Suárez', 'Felipe', 'Castro', '3133842070', 'camilo.suarez50@gmail.com', 'Calle 51 #21-38', 'M', '1989-04-26', '2022-11-30', '07:30:00', '16:15:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('45835371', 'CC', 'AS', 'H4', 4, 'Valentina', 'Torres', 'María', NULL, '3125867870', 'valentina.torres95@gmail.com', 'Calle 60 #20-21', 'F', '1984-10-14', '2022-06-04', '06:30:00', '16:15:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('85500790', 'CC', 'RE', 'H5', 7, 'Isabella', 'Morales', 'Diana', NULL, '3136332415', 'isabella.morales29@gmail.com', 'Calle 43 #15-49', 'F', '1979-12-05', '2022-03-16', '06:30:00', '18:45:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('94651342', 'CC', 'CA', 'H4', 7, 'Juan', 'Álvarez', 'Andrés', NULL, '3192924441', 'juan.alvarez17@gmail.com', 'Calle 82 #43-79', 'M', '1980-05-19', '2022-02-04', '07:00:00', '15:45:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('19927432', 'CC', 'MA', 'H1', 7, 'Valentina', 'Reyes', 'Carolina', 'González', '3158255231', 'valentina.reyes14@gmail.com', 'Calle 90 #35-77', 'F', '1990-02-22', '2022-11-03', '09:45:00', '18:45:00', 3000000.00, 'I', '2023-07-16');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('85594147', 'CC', 'RE', 'H5', 10, 'Daniel', 'Pérez', 'Ricardo', 'Cruz', '3144727276', 'daniel.perez22@gmail.com', 'Calle 29 #33-96', 'M', '1998-12-08', '2022-12-13', '09:30:00', '17:00:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('56300738', 'CC', 'CA', 'H2', 11, 'Nicolás', 'Castro', 'Ricardo', 'Vargas', '3156751880', 'nicolas.castro28@gmail.com', 'Calle 40 #22-59', 'M', '1971-02-07', '2022-09-05', '06:30:00', '17:00:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('19015987', 'CC', 'AD', 'H2', 8, 'Natalia', 'López', 'Catalina', 'Vargas', '3142737441', 'natalia.lopez31@gmail.com', 'Calle 67 #12-71', 'F', '1983-06-21', '2022-01-23', '06:00:00', '16:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('92474715', 'CC', 'SE', 'H5', 3, 'Ricardo', 'Vargas', 'Pedro', 'Suárez', '3134567819', 'ricardo.vargas24@gmail.com', 'Calle 48 #45-19', 'M', '1996-06-22', '2022-02-13', '07:30:00', '14:15:00', 1800000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('64913082', 'CC', 'AS', 'H1', 9, 'Hernando', 'Sánchez', 'Luis', 'Castro', '3114142053', 'hernando.sanchez82@gmail.com', 'Calle 98 #15-38', 'M', '2000-09-18', '2022-09-09', '09:45:00', '17:15:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('68930964', 'CC', 'GE', 'H5', 6, 'Alejandro', 'Vargas', 'Andrés', 'Torres', '3128687800', 'alejandro.vargas88@gmail.com', 'Calle 27 #14-8', 'M', '1975-04-08', '2022-05-02', '07:30:00', '18:45:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('29081953', 'CC', 'AS', 'H3', 7, 'Felipe', 'Álvarez', 'Daniel', 'Reyes', '3122494970', 'felipe.alvarez91@gmail.com', 'Calle 52 #33-96', 'M', '1995-11-26', '2022-11-20', '08:45:00', '17:45:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('16497381', 'CC', 'AD', 'H2', 8, 'Alejandra', 'González', 'Marcela', 'Medina', '3110090721', 'alejandra.gonzalez68@gmail.com', 'Calle 55 #13-89', 'F', '1972-01-23', '2022-02-20', '09:00:00', '14:15:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('79718627', 'CC', 'CO', 'H4', 10, 'David', 'Martínez', 'Hernando', 'González', '3127740248', 'david.martinez64@gmail.com', 'Calle 62 #5-30', 'M', '2000-07-02', '2022-08-16', '06:00:00', '16:00:00', 5000000.00, 'I', '2024-07-24');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('61367949', 'CC', 'CA', 'H2', 5, 'Miguel', 'Rivera', 'Pedro', 'Morales', '3132027350', 'miguel.rivera93@gmail.com', 'Calle 57 #23-93', 'M', '1975-12-22', '2022-11-25', '07:00:00', '18:00:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('26529882', 'CC', 'CA', 'H5', 2, 'Santiago', 'Sánchez', 'Nicolás', 'Martínez', '3196519508', 'santiago.sanchez45@gmail.com', 'Calle 11 #16-71', 'M', '1996-06-12', '2022-07-16', '08:45:00', '16:15:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('59350218', 'CC', 'CA', 'H4', 8, 'Daniela', 'Morales', 'Fernanda', 'Rodríguez', '3142823140', 'daniela.morales11@gmail.com', 'Calle 6 #31-47', 'F', '1977-01-21', '2022-05-11', '06:00:00', '15:00:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('40133935', 'CC', 'MA', 'H2', 11, 'Jorge', 'Herrera', 'Andrés', 'Molina', '3126025721', 'jorge.herrera57@gmail.com', 'Calle 65 #44-7', 'M', '1984-06-08', '2022-05-08', '09:30:00', '16:00:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('51701149', 'CC', 'SE', 'H4', 8, 'Fernando', 'Castro', 'Andrés', 'Martínez', '3150790016', 'fernando.castro82@gmail.com', 'Calle 95 #40-32', 'M', '1984-09-06', '2022-02-14', '09:00:00', '16:15:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('18038980', 'CC', 'AS', 'H1', 7, 'Claudia', 'Jiménez', 'Diana', 'Ramírez', '3165439545', 'claudia.jimenez76@gmail.com', 'Calle 90 #24-59', 'F', '1976-05-21', '2022-12-31', '08:00:00', '14:15:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('68382413', 'CC', 'RE', 'H2', 2, 'Fernando', 'Cruz', 'Luis', 'Castro', '3153788744', 'fernando.cruz60@gmail.com', 'Calle 41 #29-35', 'M', '1999-09-19', '2022-03-08', '07:30:00', '16:30:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('24181143', 'CC', 'CA', 'H3', 2, 'David', 'Álvarez', 'Luis', 'Medina', '3137868462', 'david.alvarez55@gmail.com', 'Calle 58 #20-60', 'M', '1977-05-17', '2022-08-19', '09:30:00', '17:00:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('27286109', 'CC', 'AS', 'H1', 11, 'Ana', 'Martínez', 'María', 'Sánchez', '3168137264', 'ana.martinez83@gmail.com', 'Calle 93 #26-64', 'F', '1974-02-15', '2022-06-19', '06:00:00', '17:00:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('61338023', 'CC', 'RE', 'H2', 4, 'Santiago', 'Cruz', 'David', 'Jiménez', '3134134478', 'santiago.cruz44@gmail.com', 'Calle 4 #21-77', 'M', '1986-02-09', '2022-09-03', '09:30:00', '18:30:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('57201978', 'CC', 'RE', 'H5', 6, 'Roberto', 'Mendoza', 'Felipe', 'Molina', '3115095407', 'roberto.mendoza72@gmail.com', 'Calle 12 #4-30', 'M', '1995-06-19', '2022-10-16', '07:15:00', '17:30:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('27514010', 'CC', 'CO', 'H3', 6, 'Carlos', 'Ramos', 'Fernando', 'García', '3124887509', 'carlos.ramos28@gmail.com', 'Calle 68 #24-10', 'M', '1985-04-14', '2022-04-01', '08:00:00', '14:15:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('31139813', 'CC', 'CA', 'H3', 6, 'Marcela', 'Rivera', 'Claudia', 'Flores', '3189047551', 'marcela.rivera95@gmail.com', 'Calle 23 #25-40', 'F', '1989-08-06', '2022-11-24', '09:30:00', '15:30:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('34438599', 'CC', 'RE', 'H1', 7, 'Jorge', 'Molina', 'Carlos', 'Medina', '3141943272', 'jorge.molina19@gmail.com', 'Calle 45 #21-22', 'M', '1997-01-08', '2022-06-12', '07:00:00', '17:15:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('31831387', 'CC', 'CO', 'H2', 11, 'Claudia', 'Medina', 'Catalina', 'Cruz', '3119959009', 'claudia.medina23@gmail.com', 'Calle 44 #11-49', 'F', '1990-03-30', '2022-02-07', '06:30:00', '14:30:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('49276764', 'CC', 'AD', 'H2', 3, 'Alejandra', 'Suárez', 'Carolina', NULL, '3198032908', 'alejandra.suarez45@gmail.com', 'Calle 17 #45-17', 'F', '1982-12-24', '2022-10-21', '08:00:00', '15:45:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('21062296', 'CC', 'SE', 'H1', 6, 'Paola', 'Martínez', 'Carolina', NULL, '3141426254', 'paola.martinez99@gmail.com', 'Calle 55 #42-12', 'F', '1986-09-06', '2022-12-07', '07:00:00', '17:30:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('62579931', 'CC', 'CO', 'H5', 10, 'María', 'Sánchez', 'Sofía', NULL, '3177052833', 'maria.sanchez40@gmail.com', 'Calle 82 #39-10', 'F', '1983-04-05', '2022-11-27', '06:15:00', '17:45:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('28762704', 'CC', 'GE', 'H1', 8, 'Alejandra', 'Ramírez', 'Yolanda', NULL, '3159961172', 'alejandra.ramirez61@gmail.com', 'Calle 88 #41-83', 'F', '1975-06-13', '2022-01-07', '06:15:00', '15:15:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('14159837', 'CC', 'AS', 'H5', 10, 'Alberto', 'Rivera', 'Juan', 'Suárez', '3137588517', 'alberto.rivera52@gmail.com', 'Calle 25 #27-90', 'M', '1989-05-07', '2022-12-01', '07:45:00', '15:00:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('69020960', 'CC', 'SE', 'H3', 1, 'Gabriela', 'Pérez', 'Natalia', 'Vargas', '3199586100', 'gabriela.perez99@gmail.com', 'Calle 13 #6-86', 'F', '1990-11-11', '2022-05-15', '07:30:00', '18:00:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('81875527', 'CC', 'MA', 'H5', 7, 'Marcela', 'Herrera', 'Valentina', 'Rodríguez', '3177390918', 'marcela.herrera14@gmail.com', 'Calle 74 #34-74', 'F', '2000-10-26', '2022-09-01', '07:45:00', '16:00:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('15727862', 'CC', 'CA', 'H5', 4, 'Miguel', 'Pérez', 'Nicolás', 'Sánchez', '3121680625', 'miguel.perez18@gmail.com', 'Calle 50 #36-51', 'M', '1988-12-28', '2022-02-10', '09:15:00', '15:30:00', 1800000.00, 'I', '2022-02-19');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('25102023', 'CC', 'MA', 'H4', 10, 'Carolina', 'Vargas', 'Fernanda', 'García', '3181891508', 'carolina.vargas46@gmail.com', 'Calle 45 #27-34', 'F', '1988-08-04', '2022-03-18', '07:00:00', '14:00:00', 5000000.00, 'I', '2024-06-18');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('29307578', 'CC', 'MA', 'H3', 5, 'Marcela', 'Rodríguez', 'Catalina', 'Pérez', '3116615722', 'marcela.rodriguez40@gmail.com', 'Calle 96 #31-35', 'F', '1997-09-25', '2022-11-08', '09:00:00', '17:30:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('40595926', 'CC', 'GE', 'H4', 8, 'Felipe', 'Flores', 'Alejandro', 'Torres', '3121983878', 'felipe.flores92@gmail.com', 'Calle 25 #29-28', 'M', '1976-01-11', '2022-06-03', '09:30:00', '16:45:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('13684342', 'CC', 'SE', 'H1', 2, 'Paola', 'Mendoza', 'Carolina', 'Molina', '3146115786', 'paola.mendoza36@gmail.com', 'Calle 84 #27-66', 'F', '1987-05-05', '2022-01-26', '07:15:00', '15:15:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('85357498', 'CC', 'AD', 'H3', 11, 'Marcela', 'García', 'Claudia', 'Jiménez', '3147108953', 'marcela.garcia53@gmail.com', 'Calle 82 #21-36', 'F', '1999-01-15', '2022-11-01', '08:30:00', '14:45:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('90535106', 'CC', 'RE', 'H1', 4, 'Diana', 'Jiménez', 'Sandra', 'Álvarez', '3166178935', 'diana.jimenez43@gmail.com', 'Calle 52 #25-95', 'F', '1988-02-16', '2022-12-05', '08:15:00', '14:45:00', 1800000.00, 'I', '2025-02-09');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('54468633', 'CC', 'MA', 'H4', 5, 'Ana', 'Morales', 'Valentina', 'Ramírez', '3188326059', 'ana.morales91@gmail.com', 'Calle 75 #40-10', 'F', '1986-09-03', '2022-05-14', '08:45:00', '14:45:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('70673557', 'CC', 'RE', 'H4', 1, 'Isabella', 'Rivera', 'Paola', 'Cruz', '3168211760', 'isabella.rivera88@gmail.com', 'Calle 82 #28-52', 'F', '1982-04-09', '2022-04-18', '07:15:00', '17:00:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('11889398', 'CC', 'AD', 'H4', 4, 'Gabriela', 'Rodríguez', 'María', 'Herrera', '3156217844', 'gabriela.rodriguez98@gmail.com', 'Calle 40 #9-14', 'F', '1984-06-15', '2022-09-29', '07:00:00', '14:15:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('79831928', 'CC', 'AS', 'H2', 5, 'Paola', 'Rodríguez', 'Ana', 'Flores', '3135290114', 'paola.rodriguez55@gmail.com', 'Calle 22 #26-3', 'F', '1996-10-01', '2022-09-26', '08:45:00', '15:30:00', 2200000.00, 'I', '2026-03-23');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('73672398', 'CC', 'SE', 'H2', 9, 'Santiago', 'Castro', 'Nicolás', 'López', '3146235719', 'santiago.castro76@gmail.com', 'Calle 80 #39-90', 'M', '1976-11-13', '2022-04-16', '06:30:00', '17:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('34544318', 'CC', 'AD', 'H2', 6, 'Yolanda', 'Mendoza', 'Carolina', 'Martínez', '3166604960', 'yolanda.mendoza71@gmail.com', 'Calle 84 #11-15', 'F', '1975-02-09', '2023-07-25', '09:45:00', '16:45:00', 4000000.00, 'I', '2026-05-05');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('20048242', 'CC', 'CA', 'H2', 8, 'Carlos', 'Jiménez', 'Jorge', 'Ramos', '3183886264', 'carlos.jimenez38@gmail.com', 'Calle 83 #25-52', 'M', '1992-01-21', '2023-06-14', '07:30:00', '16:00:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('70004467', 'CC', 'AS', 'H5', 2, 'Nicolás', 'Medina', 'Pedro', 'Vargas', '3184776858', 'nicolas.medina14@gmail.com', 'Calle 71 #1-12', 'M', '1984-03-06', '2023-03-02', '09:00:00', '14:45:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('55748676', 'CC', 'AS', 'H1', 11, 'Fernanda', 'Sánchez', 'Alejandra', 'Cruz', '3158760568', 'fernanda.sanchez94@gmail.com', 'Calle 92 #29-15', 'F', '1986-04-20', '2023-01-28', '07:45:00', '16:45:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('24270328', 'CC', 'AD', 'H2', 5, 'Carlos', 'Morales', 'Felipe', 'Cruz', '3136296134', 'carlos.morales88@gmail.com', 'Calle 25 #8-51', 'M', '1972-01-21', '2023-03-26', '09:15:00', '17:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('94992096', 'CC', 'RE', 'H4', 7, 'Diana', 'López', 'Isabella', 'Álvarez', '3181184297', 'diana.lopez10@gmail.com', 'Calle 95 #4-71', 'F', '2000-02-25', '2023-10-29', '06:45:00', '17:15:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('81659221', 'CC', 'MA', 'H2', 10, 'Claudia', 'Herrera', 'Natalia', 'Ramos', '3199959993', 'claudia.herrera16@gmail.com', 'Calle 8 #13-35', 'F', '1982-10-29', '2023-08-05', '06:00:00', '14:45:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('82634888', 'CC', 'CO', 'H3', 5, 'Carolina', 'Rodríguez', 'Sandra', 'Molina', '3185332458', 'carolina.rodriguez92@gmail.com', 'Calle 50 #16-66', 'F', '1971-06-14', '2023-07-03', '09:00:00', '18:15:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('75840632', 'CC', 'SE', 'H5', 10, 'Yolanda', 'Álvarez', 'Laura', 'Cruz', '3119150490', 'yolanda.alvarez76@gmail.com', 'Calle 65 #11-54', 'F', '1995-09-09', '2023-10-09', '08:00:00', '16:15:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('54434998', 'CC', 'AD', 'H5', 11, 'Ana', 'Ramírez', 'Natalia', 'Sánchez', '3156440312', 'ana.ramirez95@gmail.com', 'Calle 58 #16-83', 'F', '1986-03-09', '2023-05-31', '07:45:00', '18:00:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('99970857', 'CC', 'CO', 'H3', 2, 'Alberto', 'García', 'Pedro', 'Cruz', '3130636590', 'alberto.garcia19@gmail.com', 'Calle 4 #30-92', 'M', '1998-03-28', '2023-04-20', '09:00:00', '15:45:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('58116670', 'CC', 'AS', 'H2', 11, 'Felipe', 'Reyes', 'Daniel', NULL, '3144715663', 'felipe.reyes26@gmail.com', 'Calle 93 #36-98', 'M', '1992-10-03', '2022-06-03', '07:15:00', '16:00:00', 2200000.00, 'I', '2025-11-19');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('58347193', 'CC', 'SE', 'H3', 1, 'Daniela', 'López', 'Laura', NULL, '3199034004', 'daniela.lopez27@gmail.com', 'Calle 83 #11-43', 'F', '2000-05-11', '2023-06-10', '09:00:00', '14:00:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('82509424', 'CC', 'SE', 'H1', 7, 'Andrés', 'Castro', 'Felipe', NULL, '3135838575', 'andres.castro93@gmail.com', 'Calle 42 #33-11', 'M', '1982-09-08', '2023-01-13', '08:45:00', '17:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('20997276', 'CC', 'SE', 'H2', 11, 'Miguel', 'Sánchez', NULL, NULL, '3122232184', 'miguel.sanchez43@gmail.com', 'Calle 83 #35-50', 'M', '1991-03-30', '2022-03-01', '08:45:00', '17:45:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('95100169', 'CC', 'SE', 'H5', 7, 'Alberto', 'González', 'Daniel', 'Mendoza', '3110675093', 'alberto.gonzalez15@gmail.com', 'Calle 74 #39-51', 'M', '1976-06-18', '2023-06-02', '08:00:00', '18:15:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('88405961', 'CC', 'SE', 'H4', 10, 'Felipe', 'Vargas', 'Hernando', 'Rivera', '3143041067', 'felipe.vargas50@gmail.com', 'Calle 29 #46-95', 'M', '1976-11-01', '2023-10-17', '08:30:00', '17:15:00', 1300000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('77259613', 'CC', 'AS', 'H5', 3, 'Valentina', 'Mendoza', 'Marcela', 'Flores', '3192414513', 'valentina.mendoza40@gmail.com', 'Calle 88 #11-97', 'F', '1992-11-23', '2023-02-16', '09:30:00', '18:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('23854626', 'CC', 'AD', 'H1', 1, 'Gabriela', 'Vargas', 'Catalina', 'Rodríguez', '3160803895', 'gabriela.vargas93@gmail.com', 'Calle 47 #38-84', 'F', '1993-05-22', '2023-11-21', '08:30:00', '18:15:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('75345452', 'CC', 'AD', 'H2', 6, 'Gabriela', 'Jiménez', 'Valentina', 'Castro', '3179060560', 'gabriela.jimenez19@gmail.com', 'Calle 83 #18-28', 'F', '1991-08-17', '2023-11-06', '06:15:00', '17:15:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('39442512', 'CC', 'CA', 'H1', 8, 'David', 'Suárez', 'Nicolás', 'Ramos', '3155992559', 'david.suarez97@gmail.com', 'Calle 59 #39-76', 'M', '1988-06-05', '2023-11-04', '07:15:00', '18:30:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('48019408', 'CC', 'GE', 'H1', 4, 'Santiago', 'Torres', 'Luis', 'Ramos', '3187576121', 'santiago.torres10@gmail.com', 'Calle 67 #8-67', 'M', '1996-11-02', '2023-10-06', '09:30:00', '15:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('67186360', 'CC', 'CA', 'H2', 2, 'Diana', 'Ortiz', 'Isabella', 'Morales', '3192125234', 'diana.ortiz56@gmail.com', 'Calle 36 #44-51', 'F', '1999-03-25', '2023-10-27', '08:30:00', '18:45:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('44061458', 'CC', 'AS', 'H2', 6, 'Alejandra', 'Ramos', 'Yolanda', 'Pérez', '3169940949', 'alejandra.ramos39@gmail.com', 'Calle 90 #11-13', 'F', '1983-10-04', '2023-10-23', '08:45:00', '15:00:00', 4000000.00, 'I', '2024-10-30');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('90191410', 'CC', 'SE', 'H5', 7, 'Pedro', 'Mendoza', 'Andrés', 'Castro', '3179545356', 'pedro.mendoza94@gmail.com', 'Calle 37 #13-5', 'M', '1972-07-30', '2023-03-31', '09:45:00', '14:15:00', 5000000.00, 'I', '2026-03-23');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('56637316', 'CC', 'AD', 'H1', 9, 'Juan', 'Flores', 'Alberto', 'Mendoza', '3164644684', 'juan.flores32@gmail.com', 'Calle 65 #7-72', 'M', '1982-05-28', '2023-04-26', '07:45:00', '17:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('76974557', 'CC', 'CO', 'H1', 3, 'Natalia', 'Medina', 'Diana', 'Torres', '3193026670', 'natalia.medina41@gmail.com', 'Calle 46 #10-14', 'F', '1978-12-16', '2023-05-01', '07:30:00', '15:15:00', 1500000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('59821155', 'CC', 'AS', 'H5', 1, 'Hernando', 'Álvarez', 'Carlos', 'Herrera', '3147616749', 'hernando.alvarez75@gmail.com', 'Calle 51 #15-97', 'M', '1997-11-04', '2023-06-11', '09:30:00', '17:15:00', 5000000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('41828278', 'CC', 'SE', 'H3', 3, 'Felipe', 'Suárez', 'Ricardo', 'Torres', '3166249702', 'felipe.suarez36@gmail.com', 'Calle 90 #49-48', 'M', '1982-01-31', '2023-08-30', '08:30:00', '15:45:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('56189726', 'CC', 'SE', 'H3', 9, 'Carolina', 'Morales', 'Natalia', 'Herrera', '3197223468', 'carolina.morales83@gmail.com', 'Calle 84 #35-23', 'F', '1970-11-21', '2023-07-30', '06:30:00', '18:15:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('61146483', 'CC', 'GE', 'H1', 8, 'Isabella', 'Ramos', 'Fernanda', 'Álvarez', '3192182875', 'isabella.ramos90@gmail.com', 'Calle 74 #26-10', 'F', '1997-07-12', '2023-05-27', '09:15:00', '15:30:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('18562070', 'CC', 'GE', 'H4', 2, 'Ana', 'Pérez', 'Diana', 'Castro', '3192960269', 'ana.perez43@gmail.com', 'Calle 20 #6-84', 'F', '1991-03-24', '2023-10-08', '06:00:00', '17:00:00', 1300000.00, 'I', '2024-04-01');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('27619715', 'CC', 'CA', 'H4', 8, 'Valentina', 'Mendoza', 'Yolanda', 'Flores', '3172705646', 'valentina.mendoza70@gmail.com', 'Calle 70 #18-71', 'F', '1993-08-18', '2023-03-29', '06:00:00', '16:30:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('41247296', 'CC', 'RE', 'H1', 8, 'Miguel', 'Torres', 'Alejandro', 'González', '3176893545', 'miguel.torres49@gmail.com', 'Calle 48 #30-90', 'M', '1974-01-17', '2023-03-19', '06:45:00', '15:30:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('87170132', 'CC', 'GE', 'H5', 5, 'Juan', 'Rodríguez', 'Pedro', NULL, '3112267067', 'juan.rodriguez50@gmail.com', 'Calle 50 #44-16', 'M', '1980-03-18', '2023-05-13', '09:45:00', '17:45:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('69427400', 'CC', 'SE', 'H3', 9, 'Isabella', 'Jiménez', 'Claudia', NULL, '3188762521', 'isabella.jimenez68@gmail.com', 'Calle 4 #31-15', 'F', '1986-12-01', '2023-10-16', '09:15:00', '16:45:00', 4000000.00, 'I', '2024-03-09');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('77441081', 'CC', 'RE', 'H4', 9, 'Andrés', 'Ortiz', 'Fernando', NULL, '3111129926', 'andres.ortiz98@gmail.com', 'Calle 2 #44-27', 'M', '1985-07-30', '2023-07-21', '07:45:00', '14:45:00', 1800000.00, 'I', '2024-02-29');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('80257585', 'CC', 'MA', 'H3', 8, 'Alberto', 'Medina', 'Jorge', NULL, '3169305486', 'alberto.medina21@gmail.com', 'Calle 40 #24-53', 'M', '1998-09-13', '2023-11-24', '08:30:00', '17:15:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('62227199', 'CC', 'AS', 'H1', 4, 'Nicolás', 'Jiménez', 'Miguel', NULL, '3195700705', 'nicolas.jimenez71@gmail.com', 'Calle 39 #13-47', 'M', '2000-07-26', '2023-06-09', '08:15:00', '14:00:00', 1800000.00, 'I', '2025-10-08');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('32462726', 'CC', 'RE', 'H3', 6, 'Miguel', 'Cruz', 'Daniel', 'Ortiz', '3173789750', 'miguel.cruz84@gmail.com', 'Calle 89 #39-20', 'M', '1982-05-21', '2023-10-27', '06:45:00', '15:00:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('70315326', 'CC', 'CA', 'H2', 9, 'Yolanda', 'Pérez', 'Alejandra', 'Martínez', '3112512536', 'yolanda.perez33@gmail.com', 'Calle 80 #24-80', 'F', '1983-04-07', '2023-05-15', '08:45:00', '14:45:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('84016756', 'CC', 'AS', 'H2', 9, 'Ana', 'Castro', 'Alejandra', 'Sánchez', '3180222787', 'ana.castro22@gmail.com', 'Calle 85 #5-6', 'F', '1976-11-30', '2023-11-10', '08:30:00', '17:30:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('14270425', 'CC', 'GE', 'H1', 4, 'Andrés', 'López', 'David', 'Ramos', '3139624910', 'andres.lopez56@gmail.com', 'Calle 78 #46-10', 'M', '1995-08-13', '2023-11-25', '09:45:00', '18:30:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('57288136', 'CC', 'AS', 'H2', 9, 'Fernanda', 'Reyes', 'Isabella', 'Pérez', '3191659860', 'fernanda.reyes51@gmail.com', 'Calle 31 #37-70', 'F', '1984-02-20', '2023-10-09', '08:30:00', '17:45:00', 5000000.00, 'I', '2024-05-12');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('10026256', 'CC', 'MA', 'H3', 8, 'Alejandra', 'Morales', 'Carolina', 'Vargas', '3138833029', 'alejandra.morales38@gmail.com', 'Calle 41 #2-99', 'F', '1971-07-22', '2023-05-26', '06:15:00', '16:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('45566111', 'CC', 'CA', 'H1', 3, 'Miguel', 'Vargas', 'Andrés', 'Morales', '3163660012', 'miguel.vargas83@gmail.com', 'Calle 73 #14-94', 'M', '1986-06-20', '2023-10-26', '07:15:00', '16:30:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('89890579', 'CC', 'GE', 'H2', 10, 'Catalina', 'Ramos', 'Paola', 'Molina', '3156698401', 'catalina.ramos52@gmail.com', 'Calle 56 #27-16', 'F', '1998-10-23', '2023-06-03', '06:45:00', '14:00:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('85318641', 'CC', 'CO', 'H1', 11, 'Alejandra', 'Ramos', 'Diana', 'Castro', '3153407575', 'alejandra.ramos65@gmail.com', 'Calle 88 #37-12', 'F', '1997-08-19', '2023-09-26', '07:15:00', '14:30:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('89708841', 'CC', 'AD', 'H3', 6, 'Juliana', 'Morales', 'Natalia', 'Sánchez', '3169118000', 'juliana.morales28@gmail.com', 'Calle 6 #15-26', 'F', '1999-05-27', '2023-01-13', '08:15:00', '16:45:00', 3000000.00, 'I', '2025-04-18');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('60547291', 'CC', 'RE', 'H1', 3, 'Alejandra', 'Suárez', 'Catalina', 'Mendoza', '3192941828', 'alejandra.suarez35@gmail.com', 'Calle 35 #4-60', 'F', '1996-02-25', '2023-12-06', '06:30:00', '15:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('54770958', 'CC', 'SE', 'H1', 9, 'Alejandra', 'Rodríguez', 'María', 'Ramírez', '3150577537', 'alejandra.rodriguez90@gmail.com', 'Calle 31 #33-36', 'F', '1991-12-24', '2023-07-21', '07:00:00', '16:30:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('55873760', 'CC', 'CA', 'H5', 4, 'Gabriela', 'Herrera', 'María', 'Torres', '3186893142', 'gabriela.herrera40@gmail.com', 'Calle 20 #28-40', 'F', '1987-08-16', '2023-12-03', '07:00:00', '17:15:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('87984620', 'CC', 'CA', 'H1', 11, 'Daniela', 'González', 'Alejandra', 'Sánchez', '3198077934', 'daniela.gonzalez28@gmail.com', 'Calle 73 #11-41', 'F', '1994-04-14', '2023-12-17', '07:15:00', '16:15:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('65571528', 'CC', 'AD', 'H5', 1, 'Jorge', 'González', 'Felipe', 'Mendoza', '3134796255', 'jorge.gonzalez26@gmail.com', 'Calle 4 #49-79', 'M', '1988-06-12', '2023-06-05', '09:30:00', '15:15:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('50876565', 'CC', 'MA', 'H1', 8, 'Fernanda', 'Sánchez', 'Laura', 'Flores', '3129091078', 'fernanda.sanchez76@gmail.com', 'Calle 60 #42-58', 'F', '1982-10-29', '2023-08-25', '07:45:00', '16:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('65506990', 'CC', 'MA', 'H2', 3, 'Jorge', 'Molina', 'Roberto', 'Herrera', '3143565477', 'jorge.molina21@gmail.com', 'Calle 42 #45-84', 'M', '1984-07-05', '2023-08-19', '06:15:00', '17:15:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('48759467', 'CC', 'AS', 'H5', 5, 'Jorge', 'Ortiz', 'Andrés', 'Flores', '3111638498', 'jorge.ortiz42@gmail.com', 'Calle 59 #32-64', 'M', '1998-02-06', '2023-04-03', '06:15:00', '15:00:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('70899748', 'CC', 'AS', 'H2', 10, 'Pedro', 'Ramírez', 'Hernando', 'Sánchez', '3184832912', 'pedro.ramirez90@gmail.com', 'Calle 27 #4-24', 'M', '1988-05-25', '2023-08-15', '06:00:00', '15:30:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('54440977', 'CC', 'SE', 'H5', 11, 'Ricardo', 'González', 'Andrés', 'Rodríguez', '3192019078', 'ricardo.gonzalez46@gmail.com', 'Calle 85 #45-90', 'M', '1973-12-07', '2023-01-26', '06:45:00', '15:15:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('11516293', 'CC', 'CO', 'H1', 9, 'Juliana', 'Rivera', 'Laura', 'Morales', '3183818891', 'juliana.rivera74@gmail.com', 'Calle 42 #50-1', 'F', '1998-09-26', '2024-04-13', '08:30:00', '14:30:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('33572537', 'CC', 'RE', 'H5', 10, 'Isabella', 'Mendoza', 'Gabriela', 'Medina', '3174625235', 'isabella.mendoza27@gmail.com', 'Calle 20 #41-59', 'F', '1978-09-14', '2024-06-18', '08:45:00', '17:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('89885300', 'CC', 'CA', 'H2', 7, 'Alejandra', 'Medina', 'Paola', 'Suárez', '3141895802', 'alejandra.medina73@gmail.com', 'Calle 48 #29-39', 'F', '1975-03-30', '2024-06-06', '08:00:00', '16:45:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('69562350', 'CC', 'GE', 'H1', 4, 'Paola', 'Morales', 'Claudia', 'Rodríguez', '3151655640', 'paola.morales77@gmail.com', 'Calle 100 #21-19', 'F', '1992-09-12', '2024-01-13', '09:15:00', '15:30:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('10551617', 'CC', 'GE', 'H5', 9, 'David', 'Vargas', 'Andrés', 'Castro', '3198447373', 'david.vargas76@gmail.com', 'Calle 96 #20-3', 'M', '1983-12-14', '2024-01-23', '06:30:00', '17:00:00', 1300000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('69205536', 'CC', 'AD', 'H2', 5, 'Diana', 'Sánchez', 'Isabella', 'Flores', '3193610257', 'diana.sanchez11@gmail.com', 'Calle 72 #33-14', 'F', '2000-02-08', '2024-03-01', '08:15:00', '15:30:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('32988138', 'CC', 'CO', 'H1', 5, 'Alejandra', 'Torres', 'Isabella', 'González', '3116772091', 'alejandra.torres70@gmail.com', 'Calle 14 #25-7', 'F', '1973-03-13', '2024-06-08', '08:45:00', '14:15:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('92720444', 'CC', 'AS', 'H4', 10, 'Gabriela', 'Molina', 'Paola', 'Suárez', '3186207390', 'gabriela.molina69@gmail.com', 'Calle 17 #6-90', 'F', '1985-12-14', '2024-06-08', '08:15:00', '18:00:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('55119729', 'CC', 'CA', 'H2', 3, 'Daniel', 'Flores', 'Santiago', NULL, '3168316409', 'daniel.flores74@gmail.com', 'Calle 100 #45-17', 'M', '1973-09-14', '2023-09-01', '06:45:00', '16:00:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('51996390', 'CC', 'MA', 'H1', 1, 'Daniela', 'Ortiz', 'Valentina', NULL, '3142980201', 'daniela.ortiz15@gmail.com', 'Calle 67 #35-51', 'F', '1987-09-06', '2023-11-10', '06:00:00', '17:45:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('76102828', 'CC', 'AS', 'H2', 11, 'Sandra', 'Ramos', 'Marcela', NULL, '3172395893', 'sandra.ramos13@gmail.com', 'Calle 81 #8-95', 'F', '1978-01-26', '2023-11-09', '07:30:00', '15:00:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('41097470', 'CC', 'AS', 'H1', 8, 'Nicolás', 'Reyes', 'Alejandro', 'Cruz', '3154335867', 'nicolas.reyes95@gmail.com', 'Calle 42 #30-63', 'M', '1980-01-15', '2024-03-14', '08:30:00', '17:15:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('47883942', 'CC', 'CA', 'H4', 8, 'Hernando', 'Morales', 'Miguel', 'Ramos', '3197167893', 'hernando.morales81@gmail.com', 'Calle 10 #20-69', 'M', '1985-08-21', '2024-11-05', '07:00:00', '17:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('29693143', 'CC', 'RE', 'H3', 3, 'Catalina', 'Martínez', 'Laura', 'Sánchez', '3152493026', 'catalina.martinez36@gmail.com', 'Calle 39 #37-87', 'F', '1999-08-24', '2024-03-17', '09:30:00', '17:45:00', 1500000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('98917575', 'CC', 'CO', 'H2', 9, 'Isabella', 'Castro', 'Gabriela', 'Ortiz', '3166000400', 'isabella.castro56@gmail.com', 'Calle 20 #19-86', 'F', '1977-10-12', '2024-08-31', '07:15:00', '18:45:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('98305426', 'CC', 'AS', 'H4', 3, 'Carlos', 'Cruz', 'Juan', 'García', '3191125155', 'carlos.cruz99@gmail.com', 'Calle 55 #40-24', 'M', '1989-08-04', '2024-03-10', '06:15:00', '17:45:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('61427803', 'CC', 'MA', 'H2', 8, 'Ana', 'Suárez', 'Sandra', 'González', '3145486562', 'ana.suarez92@gmail.com', 'Calle 97 #8-7', 'F', '1980-09-03', '2024-12-04', '09:15:00', '15:30:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('60975999', 'CC', 'CO', 'H3', 9, 'Gabriela', 'Flores', 'Catalina', 'Ramos', '3111592230', 'gabriela.flores65@gmail.com', 'Calle 37 #29-49', 'F', '2000-08-29', '2024-12-27', '09:45:00', '16:15:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('19120357', 'CC', 'RE', 'H5', 11, 'Paola', 'Herrera', 'Isabella', 'García', '3143808923', 'paola.herrera46@gmail.com', 'Calle 25 #3-4', 'F', '1970-07-15', '2024-07-29', '06:00:00', '17:30:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('21594582', 'CC', 'GE', 'H4', 2, 'Andrés', 'Suárez', 'David', 'Cruz', '3172673716', 'andres.suarez47@gmail.com', 'Calle 85 #5-82', 'M', '1997-02-15', '2024-03-07', '09:15:00', '14:15:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('92405160', 'CC', 'CO', 'H1', 7, 'Hernando', 'González', 'Miguel', 'Herrera', '3186684568', 'hernando.gonzalez19@gmail.com', 'Calle 94 #17-58', 'M', '1998-11-10', '2024-02-24', '09:30:00', '14:00:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('30348410', 'CC', 'SE', 'H4', 7, 'Sandra', 'Rodríguez', 'María', 'Reyes', '3182494849', 'sandra.rodriguez18@gmail.com', 'Calle 29 #1-50', 'F', '1984-10-17', '2024-07-19', '06:45:00', '17:45:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('63769608', 'CC', 'SE', 'H5', 11, 'Roberto', 'Morales', 'Alberto', 'Rivera', '3148917593', 'roberto.morales68@gmail.com', 'Calle 83 #13-23', 'M', '1972-06-23', '2024-11-19', '06:30:00', '18:30:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('14949636', 'CC', 'GE', 'H1', 4, 'Alejandra', 'Mendoza', 'Sandra', 'Medina', '3197078639', 'alejandra.mendoza99@gmail.com', 'Calle 17 #1-23', 'F', '1976-05-08', '2024-09-07', '06:45:00', '18:00:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('24271532', 'CC', 'GE', 'H5', 10, 'Claudia', 'Suárez', 'Daniela', 'Pérez', '3163956682', 'claudia.suarez96@gmail.com', 'Calle 42 #8-88', 'F', '1975-02-14', '2024-09-11', '07:00:00', '15:45:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('12097866', 'CC', 'CA', 'H4', 7, 'Luis', 'Cruz', 'Miguel', 'Suárez', '3189689161', 'luis.cruz93@gmail.com', 'Calle 37 #27-89', 'M', '1991-11-05', '2024-02-11', '06:00:00', '15:00:00', 4000000.00, 'I', '2026-04-15');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('65301908', 'CC', 'AS', 'H2', 9, 'David', 'Cruz', 'Luis', 'Torres', '3156688115', 'david.cruz48@gmail.com', 'Calle 54 #1-72', 'M', '1980-09-24', '2024-03-30', '06:15:00', '17:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('72306017', 'CC', 'CO', 'H1', 6, 'Miguel', 'López', 'Fernando', 'Suárez', '3173674613', 'miguel.lopez29@gmail.com', 'Calle 64 #12-21', 'M', '1998-02-06', '2024-12-03', '07:30:00', '14:15:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('40878564', 'CC', 'AD', 'H5', 4, 'Marcela', 'Rivera', 'Yolanda', 'Ortiz', '3160403103', 'marcela.rivera35@gmail.com', 'Calle 29 #5-61', 'F', '1974-12-10', '2024-06-15', '07:00:00', '15:45:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('33898911', 'CC', 'AS', 'H5', 10, 'Laura', 'González', 'Juliana', 'Sánchez', '3155082572', 'laura.gonzalez35@gmail.com', 'Calle 17 #3-89', 'F', '1987-05-18', '2024-07-10', '07:45:00', '15:30:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('32978251', 'CC', 'MA', 'H4', 8, 'Sebastián', 'López', 'Luis', 'Vargas', '3140830120', 'sebastian.lopez80@gmail.com', 'Calle 12 #27-67', 'M', '1985-05-31', '2024-04-22', '08:15:00', '18:15:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('43105363', 'CC', 'MA', 'H5', 1, 'Roberto', 'Vargas', 'Hernando', 'Torres', '3166072388', 'roberto.vargas10@gmail.com', 'Calle 6 #3-61', 'M', '1981-02-12', '2024-06-16', '09:15:00', '18:15:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('76476033', 'CC', 'AS', 'H4', 2, 'Santiago', 'Castro', 'Fernando', 'Ramos', '3142086411', 'santiago.castro47@gmail.com', 'Calle 83 #6-3', 'M', '1980-10-15', '2024-02-12', '06:45:00', '15:15:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('54953500', 'CC', 'CA', 'H4', 4, 'Alberto', 'Herrera', 'Juan', 'Molina', '3153011925', 'alberto.herrera38@gmail.com', 'Calle 46 #18-65', 'M', '1980-09-14', '2024-10-03', '06:45:00', '18:15:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('73104323', 'CC', 'GE', 'H1', 8, 'Laura', 'Morales', 'Ana', 'Vargas', '3118808386', 'laura.morales96@gmail.com', 'Calle 25 #30-12', 'F', '1993-11-10', '2024-12-13', '08:45:00', '18:30:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('48674340', 'CC', 'AD', 'H2', 8, 'Alejandro', 'Torres', 'Jorge', 'Ramírez', '3181848989', 'alejandro.torres30@gmail.com', 'Calle 37 #12-23', 'M', '1972-02-15', '2024-03-16', '08:30:00', '17:15:00', 3000000.00, 'I', '2026-02-02');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('29513094', 'CC', 'AS', 'H2', 7, 'Alberto', 'López', 'Alejandro', 'García', '3173607213', 'alberto.lopez47@gmail.com', 'Calle 38 #49-74', 'M', '1990-07-19', '2024-06-12', '07:00:00', '18:30:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('27120235', 'CC', 'MA', 'H5', 10, 'Natalia', 'Medina', 'Ana', NULL, '3114185545', 'natalia.medina46@gmail.com', 'Calle 31 #28-90', 'F', '1983-03-13', '2024-02-01', '08:00:00', '14:30:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('70939515', 'CC', 'AS', 'H3', 1, 'Yolanda', 'Rivera', 'Laura', NULL, '3114741407', 'yolanda.rivera31@gmail.com', 'Calle 89 #39-96', 'F', '1992-12-30', '2024-08-28', '08:45:00', '16:30:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('89426041', 'CC', 'CA', 'H1', 2, 'Carolina', 'García', 'Yolanda', NULL, '3141701674', 'carolina.garcia99@gmail.com', 'Calle 63 #12-68', 'F', '1976-10-12', '2024-12-03', '09:30:00', '15:30:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('18373492', 'CC', 'SE', 'H4', 2, 'Juliana', 'Torres', 'Isabella', NULL, '3119314506', 'juliana.torres66@gmail.com', 'Calle 63 #13-79', 'F', '1987-03-04', '2024-07-17', '08:00:00', '16:30:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('81664219', 'CC', 'AS', 'H5', 5, 'Gabriela', 'Herrera', 'Ana', NULL, '3164426343', 'gabriela.herrera15@gmail.com', 'Calle 16 #14-84', 'F', '1990-02-26', '2024-01-09', '06:30:00', '14:30:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('92788091', 'CC', 'AD', 'H2', 5, 'Ricardo', 'Sánchez', 'Alejandro', NULL, '3175103838', 'ricardo.sanchez13@gmail.com', 'Calle 66 #8-10', 'M', '1990-04-30', '2024-01-23', '06:00:00', '18:15:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('83948598', 'CC', 'CA', 'H2', 1, 'Isabella', 'Mendoza', 'Claudia', 'Ramos', '3122412607', 'isabella.mendoza55@gmail.com', 'Calle 42 #4-78', 'F', '1975-03-30', '2024-06-06', '06:45:00', '18:15:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('69804203', 'CC', 'SE', 'H5', 6, 'Natalia', 'Flores', 'María', 'Morales', '3166885794', 'natalia.flores30@gmail.com', 'Calle 94 #27-18', 'F', '1995-03-02', '2024-02-14', '07:45:00', '17:45:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('18873909', 'CC', 'AD', 'H2', 9, 'Luis', 'Flores', 'David', 'Ramos', '3184600071', 'luis.flores32@gmail.com', 'Calle 60 #46-73', 'M', '1996-06-30', '2024-07-11', '06:00:00', '17:30:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('50532800', 'CC', 'RE', 'H4', 8, 'Jorge', 'Flores', 'Camilo', 'Herrera', '3130672747', 'jorge.flores10@gmail.com', 'Calle 34 #20-82', 'M', '1996-04-02', '2024-06-04', '09:45:00', '15:00:00', 5000000.00, 'I', '2025-09-07');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('65296966', 'CC', 'AS', 'H5', 6, 'Carlos', 'Jiménez', 'Luis', 'Flores', '3184981433', 'carlos.jimenez34@gmail.com', 'Calle 79 #45-68', 'M', '1985-04-07', '2024-03-24', '06:15:00', '15:15:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('74359847', 'CC', 'RE', 'H2', 3, 'Santiago', 'Martínez', 'Nicolás', 'López', '3113860039', 'santiago.martinez48@gmail.com', 'Calle 96 #8-29', 'M', '1985-08-15', '2024-06-08', '08:15:00', '17:30:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('67016371', 'CC', 'GE', 'H5', 3, 'Daniel', 'González', 'Alejandro', 'Sánchez', '3124471004', 'daniel.gonzalez35@gmail.com', 'Calle 5 #43-66', 'M', '2000-12-27', '2024-02-27', '06:00:00', '17:45:00', 1300000.00, 'I', '2025-10-28');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('99601933', 'CC', 'SE', 'H3', 2, 'Hernando', 'Torres', 'Miguel', 'Rodríguez', '3157182050', 'hernando.torres95@gmail.com', 'Calle 4 #6-19', 'M', '1970-06-18', '2024-02-19', '06:15:00', '18:15:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('77767769', 'CC', 'CO', 'H1', 10, 'Natalia', 'Jiménez', 'Paola', 'Álvarez', '3147830178', 'natalia.jimenez34@gmail.com', 'Calle 22 #49-69', 'F', '1995-07-31', '2024-02-04', '06:00:00', '18:15:00', 4000000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('69010948', 'CC', 'CA', 'H3', 6, 'David', 'Molina', 'Fernando', 'Ramos', '3140541809', 'david.molina75@gmail.com', 'Calle 53 #8-98', 'M', '2000-03-19', '2024-02-24', '07:30:00', '17:45:00', 1500000.00, 'I', '2024-06-07');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('73844258', 'CC', 'GE', 'H1', 4, 'Alberto', 'Flores', 'Santiago', 'Ortiz', '3180150556', 'alberto.flores66@gmail.com', 'Calle 85 #44-11', 'M', '2000-06-18', '2024-07-07', '07:00:00', '17:00:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('75965276', 'CC', 'CA', 'H5', 5, 'Jorge', 'Reyes', 'Alberto', 'Álvarez', '3175841004', 'jorge.reyes96@gmail.com', 'Calle 85 #36-88', 'M', '1989-04-27', '2024-03-09', '08:45:00', '17:00:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('45351739', 'CC', 'MA', 'H3', 1, 'Catalina', 'Pérez', 'Alejandra', 'Jiménez', '3189250658', 'catalina.perez13@gmail.com', 'Calle 6 #9-47', 'F', '1992-03-11', '2024-10-29', '09:30:00', '16:30:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('32364326', 'CC', 'AD', 'H1', 9, 'Claudia', 'Rivera', 'Diana', 'Ramos', '3181918425', 'claudia.rivera19@gmail.com', 'Calle 28 #19-34', 'F', '1997-07-31', '2024-06-02', '08:45:00', '15:45:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('89438729', 'CC', 'GE', 'H4', 2, 'Marcela', 'Ramírez', 'Gabriela', 'Suárez', '3197447790', 'marcela.ramirez19@gmail.com', 'Calle 39 #33-39', 'F', '1985-02-09', '2024-05-19', '06:45:00', '17:15:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('83492593', 'CC', 'AS', 'H5', 10, 'Diana', 'Castro', 'Juliana', 'Torres', '3181500378', 'diana.castro91@gmail.com', 'Calle 79 #50-56', 'F', '1978-02-06', '2024-01-10', '07:45:00', '15:45:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('30196097', 'CC', 'CO', 'H2', 3, 'Fernando', 'Morales', 'David', 'Vargas', '3165356542', 'fernando.morales36@gmail.com', 'Calle 35 #19-83', 'M', '2000-09-28', '2024-06-02', '09:45:00', '16:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('75208604', 'CC', 'RE', 'H1', 3, 'Sebastián', 'Reyes', 'Pedro', 'Herrera', '3164627534', 'sebastian.reyes18@gmail.com', 'Calle 47 #43-85', 'M', '1970-11-23', '2024-01-29', '06:30:00', '18:30:00', 5000000.00, 'I', '2024-05-06');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('80055957', 'CC', 'GE', 'H4', 9, 'Sandra', 'López', 'Valentina', 'Medina', '3152065222', 'sandra.lopez25@gmail.com', 'Calle 43 #38-95', 'F', '1999-10-18', '2024-10-24', '08:45:00', '14:15:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('12828532', 'CC', 'SE', 'H1', 6, 'Sandra', 'Ramos', 'Natalia', 'Molina', '3151509315', 'sandra.ramos59@gmail.com', 'Calle 82 #45-47', 'F', '1998-12-14', '2024-11-06', '06:00:00', '15:30:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('22113193', 'CC', 'SE', 'H4', 5, 'Nicolás', 'García', 'Camilo', 'Castro', '3164531161', 'nicolas.garcia92@gmail.com', 'Calle 5 #18-11', 'M', '1980-07-24', '2024-06-01', '07:15:00', '17:30:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('45026810', 'CC', 'CA', 'H2', 2, 'Juliana', 'Molina', 'Isabella', 'Ortiz', '3113670974', 'juliana.molina98@gmail.com', 'Calle 98 #4-83', 'F', '1992-09-17', '2024-02-03', '08:45:00', '18:30:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('65632768', 'CC', 'GE', 'H2', 4, 'Paola', 'Rivera', 'Marcela', 'Flores', '3184964625', 'paola.rivera12@gmail.com', 'Calle 83 #40-81', 'F', '1986-06-28', '2024-04-03', '09:45:00', '18:15:00', 1300000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('92903638', 'CC', 'CO', 'H2', 5, 'Santiago', 'García', 'Luis', 'Flores', '3153385340', 'santiago.garcia27@gmail.com', 'Calle 89 #26-88', 'M', '1990-03-25', '2024-05-07', '08:45:00', '14:00:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('16994436', 'CC', 'RE', 'H4', 9, 'Juliana', 'Martínez', 'Carolina', 'López', '3177718480', 'juliana.martinez42@gmail.com', 'Calle 80 #25-39', 'F', '1984-12-06', '2024-04-30', '09:30:00', '18:00:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('32799095', 'CC', 'SE', 'H3', 3, 'Sandra', 'Rodríguez', 'Alejandra', 'Medina', '3168106835', 'sandra.rodriguez77@gmail.com', 'Calle 19 #17-15', 'F', '1992-08-06', '2024-09-09', '08:45:00', '15:00:00', 1800000.00, 'I', '2026-02-01');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('47973618', 'CC', 'MA', 'H4', 6, 'Luis', 'Torres', 'Hernando', 'Mendoza', '3130302410', 'luis.torres72@gmail.com', 'Calle 72 #43-82', 'M', '1981-10-22', '2024-11-09', '08:30:00', '17:15:00', 1800000.00, 'I', '2025-11-28');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('75032899', 'CC', 'MA', 'H1', 10, 'Gabriela', 'Ramos', 'Natalia', NULL, '3176742957', 'gabriela.ramos72@gmail.com', 'Calle 30 #41-18', 'F', '1992-12-10', '2024-05-22', '07:45:00', '14:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('61356129', 'CC', 'CA', 'H4', 1, 'Andrés', 'Ramos', 'Juan', NULL, '3198728736', 'andres.ramos19@gmail.com', 'Calle 97 #34-99', 'M', '1997-02-13', '2024-12-13', '08:15:00', '16:00:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('82804811', 'CC', 'SE', 'H1', 8, 'Diana', 'Reyes', 'Sofía', NULL, '3152219420', 'diana.reyes67@gmail.com', 'Calle 49 #29-59', 'F', '1985-05-31', '2024-10-03', '06:00:00', '17:00:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('65288255', 'CC', 'AD', 'H2', 6, 'Felipe', 'López', 'Camilo', NULL, '3118791292', 'felipe.lopez20@gmail.com', 'Calle 40 #8-44', 'M', '1985-10-04', '2024-01-29', '07:15:00', '15:30:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('86242300', 'CC', 'MA', 'H1', 11, 'Alberto', 'Rodríguez', 'Felipe', NULL, '3186551556', 'alberto.rodriguez58@gmail.com', 'Calle 50 #21-74', 'M', '1993-02-02', '2024-08-03', '08:00:00', '17:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('52107027', 'CC', 'SE', 'H2', 11, 'Sandra', 'Castro', 'María', NULL, '3165071708', 'sandra.castro86@gmail.com', 'Calle 41 #29-62', 'F', '1995-10-31', '2024-02-12', '06:15:00', '15:15:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('45729141', 'CC', 'CO', 'H4', 4, 'Catalina', 'Ramírez', 'Claudia', NULL, '3147979220', 'catalina.ramirez37@gmail.com', 'Calle 94 #44-25', 'F', '1982-12-01', '2024-09-10', '09:15:00', '17:15:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('48133464', 'CC', 'CO', 'H4', 2, 'Claudia', 'López', 'Sandra', 'Morales', '3134235540', 'claudia.lopez83@gmail.com', 'Calle 54 #5-32', 'F', '1978-02-07', '2024-03-27', '08:15:00', '18:00:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('62904575', 'CC', 'GE', 'H3', 11, 'Felipe', 'Flores', 'Carlos', 'Reyes', '3198521869', 'felipe.flores68@gmail.com', 'Calle 62 #30-81', 'M', '1986-10-04', '2024-10-29', '06:30:00', '15:00:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('86391152', 'CC', 'AD', 'H4', 8, 'Felipe', 'Cruz', 'Andrés', 'Suárez', '3183438064', 'felipe.cruz19@gmail.com', 'Calle 78 #25-12', 'M', '1975-10-20', '2025-04-19', '06:30:00', '16:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('69786268', 'CC', 'AS', 'H4', 4, 'Ricardo', 'Morales', 'Miguel', 'Jiménez', '3192391939', 'ricardo.morales57@gmail.com', 'Calle 24 #28-81', 'M', '1987-05-30', '2025-09-01', '08:45:00', '14:45:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('16052535', 'CC', 'GE', 'H1', 1, 'Fernando', 'Flores', 'Santiago', 'Medina', '3144008132', 'fernando.flores82@gmail.com', 'Calle 46 #17-75', 'M', '1993-01-11', '2025-02-25', '09:45:00', '14:45:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('65868338', 'CC', 'GE', 'H5', 1, 'Miguel', 'Pérez', 'Nicolás', 'Castro', '3138329117', 'miguel.perez33@gmail.com', 'Calle 24 #6-96', 'M', '1983-05-09', '2025-06-10', '09:45:00', '18:30:00', 1800000.00, 'I', '2025-12-23');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('12132081', 'CC', 'GE', 'H4', 4, 'Ana', 'González', 'Sandra', 'García', '3182287324', 'ana.gonzalez90@gmail.com', 'Calle 25 #6-39', 'F', '1978-06-11', '2025-01-14', '07:45:00', '15:15:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('14968366', 'CC', 'SE', 'H1', 10, 'Santiago', 'Ramos', 'Pedro', 'Mendoza', '3166640491', 'santiago.ramos12@gmail.com', 'Calle 74 #21-71', 'M', '1991-11-14', '2025-07-24', '09:45:00', '15:00:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('97577092', 'CC', 'MA', 'H5', 7, 'Sandra', 'Mendoza', 'Sofía', 'Molina', '3127327046', 'sandra.mendoza71@gmail.com', 'Calle 23 #13-21', 'F', '1986-02-28', '2025-08-30', '07:15:00', '16:00:00', 4000000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('84736526', 'CC', 'CO', 'H1', 4, 'Claudia', 'Ramos', 'Juliana', 'Flores', '3114290941', 'claudia.ramos74@gmail.com', 'Calle 9 #22-56', 'F', '1972-02-10', '2025-01-10', '08:30:00', '16:15:00', 1500000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('57679636', 'CC', 'AD', 'H1', 5, 'Miguel', 'Ramírez', 'Alberto', 'Ramos', '3168764105', 'miguel.ramirez16@gmail.com', 'Calle 59 #49-15', 'M', '1972-02-04', '2025-10-13', '08:15:00', '18:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('66278204', 'CC', 'SE', 'H4', 11, 'Roberto', 'Cruz', 'Andrés', 'Molina', '3180839007', 'roberto.cruz45@gmail.com', 'Calle 79 #10-90', 'M', '1988-01-13', '2025-12-15', '08:30:00', '16:00:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('13743496', 'CC', 'RE', 'H5', 3, 'Fernanda', 'Álvarez', 'Isabella', 'Cruz', '3118045780', 'fernanda.alvarez24@gmail.com', 'Calle 48 #17-81', 'F', '1994-03-22', '2025-10-31', '08:15:00', '16:45:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('49991663', 'CC', 'AS', 'H2', 2, 'Claudia', 'Álvarez', 'Laura', 'Cruz', '3148189707', 'claudia.alvarez48@gmail.com', 'Calle 86 #46-74', 'F', '1995-09-05', '2025-01-03', '09:30:00', '15:15:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('45392370', 'CC', 'MA', 'H4', 9, 'Ricardo', 'Castro', 'Fernando', 'Medina', '3129373816', 'ricardo.castro30@gmail.com', 'Calle 65 #9-63', 'M', '1996-03-18', '2025-09-13', '09:45:00', '17:45:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('75219822', 'CC', 'SE', 'H1', 5, 'Miguel', 'Flores', 'Ricardo', 'Morales', '3134572196', 'miguel.flores37@gmail.com', 'Calle 95 #32-1', 'M', '1971-04-04', '2025-03-15', '07:45:00', '14:30:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('85935555', 'CC', 'SE', 'H4', 10, 'Ana', 'Ortiz', 'Laura', 'Ramos', '3177748258', 'ana.ortiz27@gmail.com', 'Calle 82 #30-98', 'F', '1990-04-17', '2025-06-22', '09:45:00', '18:15:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('61973818', 'CC', 'MA', 'H3', 11, 'Sandra', 'Martínez', 'Isabella', 'Suárez', '3132228439', 'sandra.martinez21@gmail.com', 'Calle 91 #2-74', 'F', '1980-06-11', '2025-07-22', '08:00:00', '17:30:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('86536905', 'CC', 'RE', 'H4', 9, 'Alberto', 'Sánchez', 'Juan', 'Suárez', '3137622679', 'alberto.sanchez45@gmail.com', 'Calle 32 #46-75', 'M', '1993-05-28', '2025-04-07', '09:00:00', '14:15:00', 1300000.00, 'I', '2026-03-30');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('13122340', 'CC', 'AS', 'H2', 1, 'Alberto', 'Castro', 'Felipe', 'Medina', '3122217180', 'alberto.castro42@gmail.com', 'Calle 15 #7-70', 'M', '1985-04-01', '2025-08-12', '07:45:00', '14:30:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('46126008', 'CC', 'RE', 'H5', 4, 'Hernando', 'Ortiz', 'Carlos', 'Cruz', '3164592513', 'hernando.ortiz82@gmail.com', 'Calle 58 #6-82', 'M', '1994-11-08', '2025-10-28', '06:15:00', '18:15:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('84511273', 'CC', 'MA', 'H5', 4, 'Luis', 'Herrera', 'Ricardo', 'Pérez', '3110072871', 'luis.herrera31@gmail.com', 'Calle 8 #31-35', 'M', '1990-04-07', '2025-01-22', '06:45:00', '18:30:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('12655050', 'CC', 'CO', 'H3', 1, 'Nicolás', 'Sánchez', 'Ricardo', 'Vargas', '3141441568', 'nicolas.sanchez38@gmail.com', 'Calle 64 #24-5', 'M', '1982-08-12', '2025-12-15', '08:15:00', '14:30:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('35749878', 'CC', 'SE', 'H4', 4, 'Juan', 'Torres', 'Luis', 'Medina', '3197245556', 'juan.torres96@gmail.com', 'Calle 7 #21-56', 'M', '2000-05-31', '2025-01-12', '08:45:00', '14:45:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('18434795', 'CC', 'SE', 'H2', 6, 'Ana', 'Sánchez', 'Valentina', 'Pérez', '3189528133', 'ana.sanchez13@gmail.com', 'Calle 81 #22-33', 'F', '1998-01-30', '2025-11-17', '06:00:00', '17:45:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('19785926', 'CC', 'CO', 'H1', 6, 'Hernando', 'Rivera', 'Daniel', 'Rodríguez', '3114475312', 'hernando.rivera17@gmail.com', 'Calle 49 #21-89', 'M', '1996-11-29', '2025-11-14', '09:00:00', '17:00:00', 1300000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('37947183', 'CC', 'RE', 'H5', 2, 'Paola', 'Álvarez', NULL, 'Castro', '3168030164', 'paola.alvarez72@gmail.com', 'Calle 95 #20-88', 'F', '1977-04-23', '2025-07-18', '09:30:00', '15:00:00', 1800000.00, 'I', '2025-07-23');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('70173215', 'CC', 'AD', 'H3', 10, 'Juliana', 'López', 'Catalina', NULL, '3141152352', 'juliana.lopez66@gmail.com', 'Calle 65 #15-76', 'F', '1989-07-27', '2025-01-11', '07:30:00', '15:45:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('73574016', 'CC', 'CO', 'H2', 1, 'David', 'Ortiz', 'Nicolás', NULL, '3158404738', 'david.ortiz63@gmail.com', 'Calle 81 #43-32', 'M', '1985-04-24', '2025-05-27', '07:00:00', '16:30:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('13994712', 'CC', 'AD', 'H1', 9, 'Valentina', 'Ortiz', 'Sandra', NULL, '3132055285', 'valentina.ortiz61@gmail.com', 'Calle 56 #4-51', 'F', '1989-11-08', '2025-03-16', '06:00:00', '14:30:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('97074691', 'CC', 'AD', 'H1', 8, 'Diana', 'Suárez', 'Alejandra', NULL, '3179856260', 'diana.suarez26@gmail.com', 'Calle 70 #19-28', 'F', '1988-02-23', '2025-04-12', '08:00:00', '14:30:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('18830219', 'CC', 'MA', 'H5', 10, 'Andrés', 'Rodríguez', 'Nicolás', 'Flores', '3192852868', 'andres.rodriguez22@gmail.com', 'Calle 97 #27-30', 'M', '1974-07-27', '2025-12-13', '06:00:00', '16:45:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('55582551', 'CC', 'GE', 'H1', 10, 'Nicolás', 'Vargas', 'Camilo', 'Ortiz', '3124496399', 'nicolas.vargas34@gmail.com', 'Calle 14 #1-77', 'M', '1999-03-14', '2025-12-12', '06:45:00', '18:30:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('66506603', 'CC', 'AD', 'H4', 5, 'Roberto', 'Cruz', 'Luis', 'Jiménez', '3118118989', 'roberto.cruz15@gmail.com', 'Calle 17 #20-75', 'M', '1991-08-06', '2025-11-14', '09:15:00', '15:15:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('73018412', 'CC', 'CA', 'H2', 3, 'Sofía', 'Herrera', 'Marcela', 'Álvarez', '3198271886', 'sofia.herrera85@gmail.com', 'Calle 87 #10-8', 'F', '1983-11-06', '2025-11-05', '08:30:00', '16:00:00', 3000000.00, 'I', '2025-11-07');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('55842323', 'CC', 'GE', 'H4', 4, 'Santiago', 'Sánchez', 'Ricardo', 'Cruz', '3185980240', 'santiago.sanchez84@gmail.com', 'Calle 43 #40-39', 'M', '1978-06-30', '2025-12-08', '09:45:00', '18:30:00', 5000000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('84449447', 'CC', 'RE', 'H2', 6, 'Carlos', 'García', 'Ricardo', 'Martínez', '3136725819', 'carlos.garcia13@gmail.com', 'Calle 26 #19-23', 'M', '1975-03-03', '2025-03-14', '08:45:00', '15:30:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('12884611', 'CC', 'CO', 'H2', 3, 'Paola', 'Herrera', 'Isabella', 'Ramírez', '3155417034', 'paola.herrera24@gmail.com', 'Calle 27 #20-59', 'F', '1977-11-24', '2025-05-15', '06:00:00', '15:45:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('53980546', 'CC', 'CA', 'H2', 5, 'Pedro', 'Sánchez', 'Roberto', 'Herrera', '3173171894', 'pedro.sanchez20@gmail.com', 'Calle 85 #40-9', 'M', '1981-02-01', '2025-01-28', '08:15:00', '18:45:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('53194369', 'CC', 'CA', 'H2', 8, 'Fernanda', 'Ramos', 'Natalia', 'Jiménez', '3195645083', 'fernanda.ramos61@gmail.com', 'Calle 75 #42-5', 'F', '1986-10-09', '2025-09-27', '09:45:00', '17:30:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('67045601', 'CC', 'SE', 'H2', 4, 'David', 'Ramírez', 'Nicolás', 'Castro', '3149600674', 'david.ramirez20@gmail.com', 'Calle 57 #34-46', 'M', '1986-12-01', '2025-10-20', '07:30:00', '16:00:00', 1500000.00, 'I', '2026-04-18');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('47101128', 'CC', 'GE', 'H3', 11, 'Ana', 'Jiménez', 'Sofía', 'Herrera', '3154796219', 'ana.jimenez35@gmail.com', 'Calle 26 #44-43', 'F', '1980-03-20', '2025-02-20', '06:00:00', '16:00:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('11145397', 'CC', 'SE', 'H2', 3, 'Carolina', 'Molina', 'Diana', 'Suárez', '3178806311', 'carolina.molina93@gmail.com', 'Calle 98 #10-51', 'F', '1983-06-08', '2025-05-25', '08:45:00', '17:00:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('35278389', 'CC', 'MA', 'H5', 9, 'Gabriela', 'Castro', 'Diana', 'Martínez', '3184209891', 'gabriela.castro23@gmail.com', 'Calle 23 #3-89', 'F', '1991-04-19', '2025-02-25', '08:45:00', '16:00:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('91181404', 'CC', 'MA', 'H3', 2, 'Diana', 'González', 'María', 'Vargas', '3122227594', 'diana.gonzalez15@gmail.com', 'Calle 37 #42-59', 'F', '1981-01-27', '2025-09-27', '08:45:00', '17:45:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('71448654', 'CC', 'MA', 'H1', 3, 'Gabriela', 'Ortiz', 'Paola', 'Ramírez', '3146745629', 'gabriela.ortiz30@gmail.com', 'Calle 81 #35-38', 'F', '1987-04-04', '2025-12-04', '07:00:00', '17:00:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('20272170', 'CC', 'AD', 'H1', 2, 'Hernando', 'Álvarez', 'Santiago', 'Herrera', '3177922837', 'hernando.alvarez36@gmail.com', 'Calle 6 #30-4', 'M', '1974-09-20', '2025-09-16', '08:45:00', '17:15:00', 1800000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('15070029', 'CC', 'MA', 'H2', 4, 'Gabriela', 'Mendoza', 'Isabella', 'Castro', '3119158638', 'gabriela.mendoza69@gmail.com', 'Calle 11 #36-85', 'F', '1970-06-25', '2025-05-09', '06:15:00', '16:45:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('27841755', 'CC', 'MA', 'H2', 11, 'Sebastián', 'Suárez', 'Miguel', 'Rivera', '3188522325', 'sebastian.suarez87@gmail.com', 'Calle 58 #25-66', 'M', '1984-11-23', '2025-03-31', '08:45:00', '14:30:00', 1300000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('41728577', 'CC', 'SE', 'H1', 2, 'Daniel', 'Suárez', 'Carlos', 'Álvarez', '3137113563', 'daniel.suarez47@gmail.com', 'Calle 20 #25-27', 'M', '1989-03-22', '2025-05-05', '06:00:00', '15:30:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('52619317', 'CC', 'SE', 'H1', 3, 'Pedro', 'Mendoza', 'Nicolás', 'Rivera', '3156000229', 'pedro.mendoza52@gmail.com', 'Calle 32 #14-70', 'M', '1998-11-14', '2025-01-21', '09:30:00', '14:15:00', 5000000.00, 'I', '2025-03-14');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('66733465', 'CC', 'AS', 'H5', 8, 'Ana', 'Castro', 'Natalia', 'Pérez', '3167364292', 'ana.castro58@gmail.com', 'Calle 11 #49-39', 'F', '1992-08-31', '2025-11-09', '09:15:00', '17:00:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('70881578', 'CC', 'SE', 'H1', 8, 'Alberto', 'Torres', 'Jorge', 'Castro', '3136268523', 'alberto.torres70@gmail.com', 'Calle 20 #13-1', 'M', '1982-09-15', '2025-07-12', '09:00:00', '16:15:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('75706438', 'CC', 'MA', 'H3', 6, 'Catalina', 'Ortiz', 'Gabriela', 'Castro', '3131791910', 'catalina.ortiz82@gmail.com', 'Calle 25 #49-56', 'F', '1983-10-23', '2025-11-25', '06:45:00', '14:00:00', 2200000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('97363169', 'CC', 'RE', 'H2', 6, 'Fernanda', 'Cruz', 'Catalina', 'Molina', '3194685039', 'fernanda.cruz56@gmail.com', 'Calle 91 #44-4', 'F', '1987-04-15', '2025-08-06', '07:15:00', '17:00:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('90819114', 'CC', 'CO', 'H5', 5, 'Yolanda', 'Reyes', 'Daniela', 'González', '3163373950', 'yolanda.reyes59@gmail.com', 'Calle 91 #38-11', 'F', '1995-12-11', '2025-12-06', '07:00:00', '14:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('88662295', 'CC', 'MA', 'H4', 5, 'Santiago', 'Ortiz', 'Jorge', 'Torres', '3146107432', 'santiago.ortiz28@gmail.com', 'Calle 96 #14-96', 'M', '1983-10-25', '2025-07-30', '06:00:00', '18:30:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('66081482', 'CC', 'GE', 'H5', 2, 'María', 'Ramos', 'Paola', 'García', '3128029744', 'maria.ramos33@gmail.com', 'Calle 26 #32-24', 'F', '1993-07-19', '2025-08-02', '08:45:00', '15:15:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('34525524', 'CC', 'RE', 'H4', 4, 'Nicolás', 'Sánchez', 'Roberto', 'Pérez', '3132297072', 'nicolas.sanchez91@gmail.com', 'Calle 11 #19-11', 'M', '1978-08-10', '2025-05-13', '09:45:00', '18:00:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('74142265', 'CC', 'CO', 'H2', 10, 'Sebastián', 'Rivera', 'Juan', 'García', '3199298044', 'sebastian.rivera10@gmail.com', 'Calle 75 #3-13', 'M', '1991-10-07', '2025-12-11', '06:00:00', '14:30:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('55235396', 'CC', 'AS', 'H5', 8, 'Camilo', 'Álvarez', 'Fernando', 'Torres', '3158480869', 'camilo.alvarez40@gmail.com', 'Calle 86 #26-49', 'M', '1997-02-10', '2025-08-08', '08:30:00', '16:30:00', 5000000.00, 'I', '2026-01-19');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('28637880', 'CC', 'MA', 'H2', 8, 'Ricardo', 'López', 'Felipe', 'García', '3198432853', 'ricardo.lopez89@gmail.com', 'Calle 61 #33-53', 'M', '1971-02-25', '2025-11-05', '06:30:00', '15:30:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('10496212', 'CC', 'CO', 'H4', 8, 'Paola', 'Vargas', 'Claudia', NULL, '3154495204', 'paola.vargas71@gmail.com', 'Calle 95 #25-27', 'F', '1998-08-27', '2025-04-25', '07:45:00', '18:15:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('40264841', 'CC', 'AD', 'H5', 6, 'Alejandro', 'Ramos', 'Carlos', NULL, '3128674348', 'alejandro.ramos14@gmail.com', 'Calle 20 #22-73', 'M', '1988-10-20', '2025-08-06', '09:30:00', '16:00:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('37713235', 'CC', 'MA', 'H4', 2, 'Luis', 'Ortiz', 'Alberto', NULL, '3151649604', 'luis.ortiz83@gmail.com', 'Calle 76 #13-65', 'M', '1975-10-30', '2025-04-16', '08:45:00', '17:15:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('82706099', 'CC', 'CO', 'H3', 4, 'Felipe', 'Herrera', 'Pedro', NULL, '3133303091', 'felipe.herrera51@gmail.com', 'Calle 2 #26-84', 'M', '1987-09-21', '2025-08-08', '06:15:00', '15:00:00', 1800000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('97234140', 'CC', 'SE', 'H5', 2, 'Camilo', 'Vargas', 'David', NULL, '3177051958', 'camilo.vargas86@gmail.com', 'Calle 14 #46-69', 'M', '1997-12-27', '2025-07-08', '06:00:00', '15:45:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('69633763', 'CC', 'AD', 'H4', 1, 'Felipe', 'Cruz', 'Carlos', 'Morales', '3173904001', 'felipe.cruz64@gmail.com', 'Calle 85 #45-13', 'M', '1980-06-23', '2025-11-07', '09:45:00', '18:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('27161260', 'CC', 'RE', 'H2', 9, 'Yolanda', 'Molina', 'Diana', 'González', '3198938318', 'yolanda.molina71@gmail.com', 'Calle 70 #16-32', 'F', '1992-05-03', '2025-02-14', '08:45:00', '15:45:00', 1300000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('60601468', 'CC', 'AD', 'H5', 2, 'Valentina', 'Álvarez', 'Marcela', 'Suárez', '3121768256', 'valentina.alvarez47@gmail.com', 'Calle 15 #6-44', 'F', '1987-02-13', '2025-12-01', '09:15:00', '15:30:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('87432467', 'CC', 'MA', 'H5', 6, 'Miguel', 'Morales', 'Roberto', 'González', '3126952687', 'miguel.morales56@gmail.com', 'Calle 67 #43-78', 'M', '1970-01-28', '2025-06-09', '06:15:00', '17:45:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('29421410', 'CC', 'AD', 'H5', 8, 'Miguel', 'García', 'Camilo', 'Herrera', '3114609555', 'miguel.garcia95@gmail.com', 'Calle 77 #21-40', 'M', '1983-04-26', '2025-04-23', '09:45:00', '15:30:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('49123810', 'CC', 'AS', 'H3', 4, 'Sebastián', 'Ramos', 'Roberto', 'Cruz', '3134027688', 'sebastian.ramos16@gmail.com', 'Calle 63 #47-51', 'M', '1986-11-24', '2025-01-31', '08:15:00', '15:15:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('56748995', 'CC', 'AS', 'H5', 7, 'Carlos', 'Castro', 'Alberto', 'Rivera', '3162851244', 'carlos.castro80@gmail.com', 'Calle 13 #9-42', 'M', '1987-07-23', '2025-07-20', '06:30:00', '16:15:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('69308631', 'CC', 'CA', 'H1', 10, 'Alejandro', 'Cruz', 'Nicolás', 'Pérez', '3111225745', 'alejandro.cruz93@gmail.com', 'Calle 47 #47-74', 'M', '1991-08-23', '2025-05-30', '07:15:00', '15:15:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('57725656', 'CC', 'GE', 'H2', 1, 'Camilo', 'Reyes', 'Santiago', 'Pérez', '3129940502', 'camilo.reyes65@gmail.com', 'Calle 81 #47-52', 'M', '1991-04-04', '2025-04-02', '06:00:00', '18:30:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('13090599', 'CC', 'CO', 'H5', 9, 'Miguel', 'Cruz', 'Hernando', 'Reyes', '3196516297', 'miguel.cruz71@gmail.com', 'Calle 90 #28-39', 'M', '1996-04-28', '2025-10-21', '09:30:00', '14:15:00', 2200000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('64402540', 'CC', 'CA', 'H2', 9, 'Miguel', 'Martínez', 'Felipe', 'Molina', '3198393430', 'miguel.martinez36@gmail.com', 'Calle 16 #12-77', 'M', '1970-11-20', '2025-07-21', '09:00:00', '18:00:00', 5000000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('53822194', 'CC', 'CA', 'H1', 1, 'Juan', 'Ortiz', NULL, 'Molina', '3181745187', 'juan.ortiz27@gmail.com', 'Calle 82 #47-63', 'M', '1987-03-16', '2025-05-24', '07:30:00', '17:00:00', 4000000.00, 'I', '2025-12-11');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('97616925', 'CC', 'CA', 'H1', 5, 'Miguel', 'Castro', NULL, 'Ramos', '3169742764', 'miguel.castro93@gmail.com', 'Calle 48 #1-16', 'M', '1986-11-03', '2025-12-21', '06:45:00', '17:30:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('30513739', 'CC', 'CO', 'H5', 11, 'Fernando', 'Cruz', NULL, 'Flores', '3151273847', 'fernando.cruz56@gmail.com', 'Calle 31 #4-31', 'M', '1986-10-10', '2021-03-24', '06:30:00', '17:00:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('55377076', 'CC', 'GE', 'H3', 4, 'Fernanda', 'López', NULL, 'Ramírez', '3117901903', 'fernanda.lopez90@gmail.com', 'Calle 30 #5-5', 'F', '1970-12-11', '2021-10-29', '07:15:00', '14:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('30776478', 'CC', 'AS', 'H5', 9, 'Daniela', 'Ortiz', NULL, 'Molina', '3117672593', 'daniela.ortiz50@gmail.com', 'Calle 7 #38-62', 'F', '1978-07-09', '2021-06-01', '07:00:00', '18:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('77834855', 'CC', 'SE', 'H3', 4, 'Yolanda', 'Molina', NULL, 'Rivera', '3154769200', 'yolanda.molina10@gmail.com', 'Calle 99 #9-82', 'F', '1991-12-01', '2021-05-09', '06:00:00', '17:30:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('25015458', 'CC', 'RE', 'H3', 9, 'Nicolás', 'Molina', NULL, 'Ortiz', '3115614174', 'nicolas.molina26@gmail.com', 'Calle 40 #24-6', 'M', '1973-05-17', '2021-12-20', '07:00:00', '16:15:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('71780854', 'CC', 'CO', 'H3', 4, 'Miguel', 'Rodríguez', NULL, 'Ramos', '3147393469', 'miguel.rodriguez52@gmail.com', 'Calle 9 #50-36', 'M', '1985-09-07', '2021-06-06', '07:15:00', '14:15:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('58884978', 'CC', 'CO', 'H3', 9, 'Laura', 'García', NULL, 'Jiménez', '3199508850', 'laura.garcia49@gmail.com', 'Calle 53 #21-52', 'F', '1989-05-07', '2021-02-05', '08:30:00', '14:30:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('48089166', 'CC', 'GE', 'H4', 3, 'Daniela', 'Jiménez', NULL, 'Ramos', '3129777514', 'daniela.jimenez35@gmail.com', 'Calle 4 #3-32', 'F', '1993-02-14', '2021-12-06', '08:00:00', '15:30:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('62191530', 'CC', 'RE', 'H1', 8, 'Hernando', 'Torres', NULL, 'Ortiz', '3113619375', 'hernando.torres78@gmail.com', 'Calle 51 #38-73', 'M', '1985-01-29', '2021-12-09', '09:15:00', '17:15:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('42194159', 'CC', 'CA', 'H2', 2, 'David', 'Torres', NULL, 'Reyes', '3189699989', 'david.torres98@gmail.com', 'Calle 61 #19-5', 'M', '1977-10-18', '2021-10-10', '06:15:00', '14:45:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('50814428', 'CC', 'AS', 'H2', 2, 'Yolanda', 'Flores', NULL, 'Vargas', '3191029073', 'yolanda.flores51@gmail.com', 'Calle 33 #2-12', 'F', '1988-01-21', '2021-05-20', '09:45:00', '14:00:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('79654147', 'CC', 'AS', 'H3', 3, 'Sebastián', 'Rodríguez', NULL, 'Álvarez', '3122246348', 'sebastian.rodriguez72@gmail.com', 'Calle 61 #23-53', 'M', '1999-03-24', '2021-08-15', '08:15:00', '18:45:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('90447099', 'CC', 'CO', 'H3', 7, 'Valentina', 'Herrera', NULL, 'González', '3145859307', 'valentina.herrera74@gmail.com', 'Calle 1 #19-93', 'F', '1992-10-19', '2021-03-11', '06:30:00', '17:30:00', 5000000.00, 'I', '2024-05-22');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('76795767', 'CC', 'CO', 'H5', 7, 'Jorge', 'Martínez', NULL, 'Suárez', '3111261301', 'jorge.martinez95@gmail.com', 'Calle 60 #19-87', 'M', '1996-02-28', '2021-03-15', '07:45:00', '16:45:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('22097496', 'CC', 'CA', 'H2', 6, 'Alejandro', 'Rodríguez', NULL, 'Medina', '3159104566', 'alejandro.rodriguez79@gmail.com', 'Calle 68 #33-35', 'M', '1983-03-29', '2021-06-17', '09:15:00', '15:15:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('93154172', 'CC', 'RE', 'H3', 8, 'Natalia', 'Reyes', NULL, 'Ramírez', '3125659979', 'natalia.reyes62@gmail.com', 'Calle 18 #3-5', 'F', '1995-03-09', '2021-06-17', '07:00:00', '17:30:00', 4000000.00, 'I', '2024-01-01');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('83076970', 'CC', 'AD', 'H5', 2, 'Nicolás', 'Ramírez', NULL, 'Morales', '3122304198', 'nicolas.ramirez68@gmail.com', 'Calle 85 #14-83', 'M', '1998-12-04', '2021-07-03', '06:45:00', '16:15:00', 1300000.00, 'I', '2026-04-15');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('19208698', 'CC', 'CO', 'H5', 10, 'Andrés', 'Ramírez', NULL, 'González', '3110380581', 'andres.ramirez86@gmail.com', 'Calle 36 #10-17', 'M', '1994-11-11', '2021-04-17', '07:15:00', '16:15:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('58082464', 'CC', 'RE', 'H1', 3, 'Paola', 'Reyes', NULL, 'García', '3166500369', 'paola.reyes26@gmail.com', 'Calle 68 #8-96', 'F', '1980-09-03', '2021-10-29', '08:00:00', '15:30:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('20949687', 'CC', 'RE', 'H3', 3, 'Marcela', 'Rodríguez', NULL, 'González', '3138933176', 'marcela.rodriguez44@gmail.com', 'Calle 97 #33-15', 'F', '1982-03-17', '2021-08-15', '09:45:00', '18:45:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('85663295', 'CC', 'AS', 'H5', 8, 'Juan', 'Álvarez', NULL, 'Cruz', '3169352161', 'juan.alvarez70@gmail.com', 'Calle 81 #20-36', 'M', '1995-12-30', '2021-08-18', '08:30:00', '15:45:00', 1300000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('44044361', 'CC', 'AD', 'H5', 7, 'Camilo', 'Rodríguez', NULL, 'Cruz', '3154629892', 'camilo.rodriguez84@gmail.com', 'Calle 18 #3-46', 'M', '1970-09-24', '2021-07-02', '06:30:00', '15:00:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('84359498', 'CC', 'AD', 'H5', 1, 'David', 'Ramírez', NULL, 'Ramos', '3163440127', 'david.ramirez49@gmail.com', 'Calle 92 #47-62', 'M', '1995-09-03', '2021-07-08', '09:15:00', '18:00:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('79645282', 'CC', 'AD', 'H5', 4, 'Alejandro', 'Pérez', NULL, 'Rivera', '3150644430', 'alejandro.perez90@gmail.com', 'Calle 79 #35-12', 'M', '1982-09-28', '2021-02-10', '08:15:00', '18:30:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('31386576', 'CC', 'CO', 'H2', 6, 'Jorge', 'Medina', NULL, 'Mendoza', '3162780072', 'jorge.medina21@gmail.com', 'Calle 65 #30-31', 'M', '1992-05-08', '2021-09-21', '09:45:00', '16:45:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('79703656', 'CC', 'AS', 'H3', 6, 'Fernanda', 'Rodríguez', NULL, 'González', '3192745294', 'fernanda.rodriguez60@gmail.com', 'Calle 95 #20-76', 'F', '1990-07-02', '2021-03-18', '07:30:00', '18:30:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('95623471', 'CC', 'CO', 'H4', 11, 'Pedro', 'Ramírez', NULL, 'Rodríguez', '3128450513', 'pedro.ramirez97@gmail.com', 'Calle 1 #36-21', 'M', '1980-06-11', '2022-01-27', '06:45:00', '16:45:00', 1300000.00, 'I', '2024-02-17');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('48193218', 'CC', 'AD', 'H4', 2, 'Carlos', 'Medina', NULL, 'Suárez', '3125119192', 'carlos.medina34@gmail.com', 'Calle 43 #11-94', 'M', '1990-05-20', '2022-11-25', '09:15:00', '18:45:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('46997080', 'CC', 'CA', 'H4', 6, 'Alejandra', 'Ramírez', NULL, 'Vargas', '3119031632', 'alejandra.ramirez36@gmail.com', 'Calle 13 #39-5', 'F', '1978-06-16', '2022-02-27', '06:45:00', '18:00:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('40245233', 'CC', 'CO', 'H3', 8, 'Gabriela', 'Álvarez', NULL, 'Herrera', '3181134297', 'gabriela.alvarez81@gmail.com', 'Calle 18 #25-32', 'F', '1983-06-29', '2022-12-29', '07:45:00', '14:45:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('16917129', 'CC', 'CO', 'H2', 2, 'Felipe', 'Vargas', NULL, 'Morales', '3154689713', 'felipe.vargas36@gmail.com', 'Calle 39 #1-28', 'M', '1982-01-16', '2022-07-13', '06:00:00', '15:15:00', 2200000.00, 'I', '2026-01-09');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('21501669', 'CC', 'MA', 'H3', 3, 'Ricardo', 'Castro', NULL, 'Ortiz', '3195080736', 'ricardo.castro58@gmail.com', 'Calle 20 #48-50', 'M', '1997-10-01', '2022-06-01', '07:00:00', '14:30:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('49171088', 'CC', 'RE', 'H3', 7, 'Alejandra', 'Suárez', NULL, 'Rivera', '3132750139', 'alejandra.suarez58@gmail.com', 'Calle 18 #18-39', 'F', '1988-07-24', '2022-07-18', '06:15:00', '18:15:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('85678734', 'CC', 'GE', 'H2', 6, 'Felipe', 'Torres', NULL, 'Castro', '3119282319', 'felipe.torres47@gmail.com', 'Calle 53 #44-64', 'M', '1978-12-18', '2022-10-31', '07:00:00', '17:15:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('59095909', 'CC', 'CA', 'H4', 9, 'Sebastián', 'Medina', NULL, 'López', '3152064387', 'sebastian.medina91@gmail.com', 'Calle 77 #25-79', 'M', '1984-08-15', '2022-04-11', '09:00:00', '16:45:00', 3000000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('75319770', 'CC', 'CA', 'H3', 7, 'Juliana', 'Medina', NULL, 'Castro', '3152222214', 'juliana.medina33@gmail.com', 'Calle 58 #40-7', 'F', '1998-07-05', '2022-10-03', '07:15:00', '17:30:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('83782999', 'CC', 'AS', 'H1', 8, 'Valentina', 'Flores', NULL, 'Pérez', '3169239219', 'valentina.flores15@gmail.com', 'Calle 70 #14-55', 'F', '1992-11-30', '2022-02-27', '06:30:00', '18:30:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('71532017', 'CC', 'GE', 'H3', 1, 'Daniela', 'Rivera', NULL, 'Medina', '3138434222', 'daniela.rivera64@gmail.com', 'Calle 64 #18-42', 'F', '1998-06-24', '2022-12-07', '08:00:00', '18:45:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('59044830', 'CC', 'MA', 'H1', 10, 'Ricardo', 'González', NULL, 'Castro', '3111851322', 'ricardo.gonzalez18@gmail.com', 'Calle 34 #14-6', 'M', '1994-07-05', '2022-12-16', '07:45:00', '14:00:00', 3000000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('66851305', 'CC', 'MA', 'H4', 9, 'Fernanda', 'Cruz', NULL, 'Molina', '3137272705', 'fernanda.cruz75@gmail.com', 'Calle 20 #35-42', 'F', '1988-01-17', '2022-02-12', '07:30:00', '14:30:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('21571285', 'CC', 'CO', 'H4', 1, 'Alejandro', 'Mendoza', NULL, 'Ramírez', '3128416255', 'alejandro.mendoza11@gmail.com', 'Calle 90 #1-21', 'M', '1989-06-28', '2022-03-01', '09:00:00', '16:15:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('30208677', 'CC', 'CO', 'H4', 9, 'Marcela', 'Álvarez', NULL, 'Sánchez', '3111287794', 'marcela.alvarez98@gmail.com', 'Calle 43 #1-98', 'F', '1970-04-15', '2022-07-29', '06:15:00', '18:30:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('47561442', 'CC', 'SE', 'H4', 3, 'Juliana', 'Morales', NULL, 'Sánchez', '3174294443', 'juliana.morales80@gmail.com', 'Calle 8 #6-36', 'F', '1990-01-03', '2022-03-18', '06:15:00', '16:45:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('31424479', 'CC', 'CO', 'H2', 6, 'Sebastián', 'Ramos', NULL, 'Jiménez', '3187268086', 'sebastian.ramos38@gmail.com', 'Calle 50 #23-23', 'M', '1974-06-29', '2022-05-07', '07:30:00', '18:00:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('57040785', 'CC', 'GE', 'H3', 4, 'Daniela', 'Torres', NULL, 'Sánchez', '3132325567', 'daniela.torres63@gmail.com', 'Calle 53 #32-49', 'F', '1981-07-07', '2022-02-25', '06:00:00', '17:45:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('86741644', 'CC', 'MA', 'H4', 1, 'Sofía', 'Ramírez', NULL, 'López', '3149533757', 'sofia.ramirez21@gmail.com', 'Calle 85 #41-77', 'F', '1994-08-28', '2022-09-09', '07:00:00', '16:00:00', 2200000.00, 'I', '2023-12-02');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('51758234', 'CC', 'GE', 'H1', 3, 'Fernanda', 'Rodríguez', NULL, 'Jiménez', '3117734634', 'fernanda.rodriguez35@gmail.com', 'Calle 32 #3-59', 'F', '1992-09-25', '2022-07-26', '07:00:00', '15:15:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('40033905', 'CC', 'RE', 'H3', 10, 'Hernando', 'Cruz', NULL, 'Pérez', '3171605671', 'hernando.cruz54@gmail.com', 'Calle 33 #14-60', 'M', '1981-04-28', '2022-11-08', '08:30:00', '17:45:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('65446317', 'CC', 'SE', 'H1', 9, 'Fernando', 'Reyes', NULL, 'Castro', '3129223220', 'fernando.reyes68@gmail.com', 'Calle 41 #46-24', 'M', '1972-06-04', '2022-03-19', '07:15:00', '16:45:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('26530521', 'CC', 'CA', 'H1', 10, 'Luis', 'Mendoza', NULL, 'García', '3198848098', 'luis.mendoza16@gmail.com', 'Calle 14 #42-3', 'M', '1986-06-12', '2022-12-31', '06:45:00', '16:00:00', 3000000.00, 'I', '2025-05-25');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('25302505', 'CC', 'SE', 'H4', 2, 'Claudia', 'Mendoza', NULL, 'Suárez', '3149641367', 'claudia.mendoza62@gmail.com', 'Calle 21 #3-71', 'F', '1974-10-08', '2023-09-12', '07:15:00', '16:15:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('99904987', 'CC', 'CO', 'H5', 10, 'María', 'Álvarez', NULL, 'Mendoza', '3196087848', 'maria.alvarez94@gmail.com', 'Calle 50 #10-72', 'F', '1985-03-05', '2023-09-23', '06:45:00', '15:45:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('23898777', 'CC', 'CA', 'H2', 3, 'Fernanda', 'Molina', NULL, 'Medina', '3156017729', 'fernanda.molina60@gmail.com', 'Calle 38 #29-18', 'F', '1987-05-19', '2023-12-03', '08:45:00', '17:15:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('84300459', 'CC', 'AD', 'H5', 9, 'Yolanda', 'Flores', NULL, 'Molina', '3127806897', 'yolanda.flores54@gmail.com', 'Calle 91 #42-23', 'F', '1998-05-18', '2023-04-22', '07:15:00', '18:30:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('11740164', 'CC', 'RE', 'H1', 6, 'Camilo', 'Ortiz', NULL, 'Reyes', '3149483865', 'camilo.ortiz34@gmail.com', 'Calle 58 #12-88', 'M', '1981-04-10', '2023-04-14', '09:15:00', '16:15:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('47461811', 'CC', 'MA', 'H2', 1, 'Jorge', 'López', NULL, 'Castro', '3172589932', 'jorge.lopez52@gmail.com', 'Calle 91 #10-6', 'M', '1994-12-20', '2023-05-16', '07:15:00', '18:30:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('96695458', 'CC', 'MA', 'H5', 4, 'Alejandro', 'Mendoza', NULL, 'Morales', '3134341456', 'alejandro.mendoza24@gmail.com', 'Calle 86 #37-7', 'M', '1992-12-28', '2023-03-14', '07:15:00', '15:30:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('23180503', 'CC', 'SE', 'H1', 2, 'Alejandra', 'Flores', NULL, 'Reyes', '3141478466', 'alejandra.flores93@gmail.com', 'Calle 13 #19-80', 'F', '1978-11-09', '2023-10-25', '09:30:00', '16:15:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('72122457', 'CC', 'AS', 'H5', 6, 'Natalia', 'Reyes', NULL, 'Mendoza', '3191420187', 'natalia.reyes92@gmail.com', 'Calle 11 #18-18', 'F', '1989-12-23', '2023-07-03', '08:45:00', '18:00:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('88100019', 'CC', 'RE', 'H3', 1, 'Sebastián', 'Mendoza', NULL, 'Martínez', '3173364719', 'sebastian.mendoza79@gmail.com', 'Calle 84 #50-20', 'M', '1995-12-20', '2023-07-27', '07:00:00', '18:30:00', 3000000.00, 'I', '2025-10-04');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('74894729', 'CC', 'CA', 'H5', 10, 'Nicolás', 'Pérez', NULL, 'Medina', '3141409454', 'nicolas.perez57@gmail.com', 'Calle 6 #43-27', 'M', '1986-02-04', '2023-01-21', '07:45:00', '15:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('65648506', 'CC', 'CO', 'H1', 2, 'Jorge', 'Suárez', NULL, 'Molina', '3196873663', 'jorge.suarez30@gmail.com', 'Calle 53 #2-32', 'M', '1984-10-24', '2023-02-28', '09:45:00', '17:15:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('86808685', 'CC', 'RE', 'H3', 11, 'Roberto', 'Pérez', NULL, 'González', '3195580271', 'roberto.perez82@gmail.com', 'Calle 3 #47-94', 'M', '1976-08-03', '2023-01-29', '07:30:00', '15:45:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('80157128', 'CC', 'CO', 'H5', 1, 'Camilo', 'González', NULL, 'López', '3192510102', 'camilo.gonzalez70@gmail.com', 'Calle 77 #3-69', 'M', '1992-08-16', '2023-12-17', '09:15:00', '18:00:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('97138408', 'CC', 'RE', 'H5', 10, 'Juan', 'Reyes', NULL, 'González', '3161168696', 'juan.reyes71@gmail.com', 'Calle 45 #38-95', 'M', '1989-05-10', '2023-09-25', '09:30:00', '14:45:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('31573890', 'CC', 'RE', 'H3', 11, 'Isabella', 'Suárez', NULL, 'Molina', '3121830043', 'isabella.suarez65@gmail.com', 'Calle 9 #17-29', 'F', '1987-06-16', '2023-11-22', '06:00:00', '15:45:00', 3000000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('97915178', 'CC', 'CO', 'H1', 6, 'Pedro', 'Reyes', NULL, 'Rodríguez', '3164418707', 'pedro.reyes60@gmail.com', 'Calle 76 #13-67', 'M', '1970-01-05', '2023-03-22', '06:30:00', '17:30:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('23404289', 'CC', 'CO', 'H4', 3, 'Carolina', 'Pérez', NULL, 'Medina', '3173483243', 'carolina.perez29@gmail.com', 'Calle 2 #12-54', 'F', '1982-02-09', '2023-05-01', '09:45:00', '15:15:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('48488577', 'CC', 'AD', 'H5', 3, 'Alejandro', 'García', NULL, 'Jiménez', '3149315407', 'alejandro.garcia65@gmail.com', 'Calle 77 #15-1', 'M', '1991-01-18', '2023-10-01', '06:45:00', '17:30:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('31913660', 'CC', 'CO', 'H3', 7, 'Diana', 'Herrera', NULL, 'Ortiz', '3142153442', 'diana.herrera90@gmail.com', 'Calle 67 #49-79', 'F', '1998-12-23', '2023-07-19', '09:15:00', '16:00:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('28337367', 'CC', 'CA', 'H1', 2, 'Alejandra', 'Ortiz', NULL, 'Sánchez', '3112603206', 'alejandra.ortiz51@gmail.com', 'Calle 20 #4-69', 'F', '1982-12-28', '2023-02-26', '09:45:00', '16:45:00', 1500000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('82905989', 'CC', 'GE', 'H1', 7, 'Ana', 'Rodríguez', NULL, 'Torres', '3161646699', 'ana.rodriguez41@gmail.com', 'Calle 99 #29-32', 'F', '1991-02-02', '2023-04-03', '07:30:00', '17:00:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('93903841', 'CC', 'AD', 'H3', 11, 'Daniel', 'Ramos', NULL, 'Martínez', '3141229060', 'daniel.ramos72@gmail.com', 'Calle 41 #36-83', 'M', '1972-09-10', '2023-01-31', '08:15:00', '18:00:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('43647879', 'CC', 'CA', 'H4', 6, 'Diana', 'Molina', NULL, 'Castro', '3135048615', 'diana.molina82@gmail.com', 'Calle 70 #23-42', 'F', '1971-10-09', '2023-09-06', '09:30:00', '18:45:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('84896161', 'CC', 'AD', 'H1', 1, 'Hernando', 'Vargas', NULL, 'Cruz', '3150789378', 'hernando.vargas19@gmail.com', 'Calle 10 #14-67', 'M', '1988-08-28', '2023-07-08', '06:30:00', '18:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('86507818', 'CC', 'CO', 'H2', 4, 'Daniel', 'Castro', NULL, 'Sánchez', '3199287317', 'daniel.castro68@gmail.com', 'Calle 55 #7-22', 'M', '1998-01-19', '2023-04-02', '09:00:00', '18:30:00', 4000000.00, 'I', '2023-06-03');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('82468141', 'CC', 'AD', 'H5', 1, 'Camilo', 'Flores', NULL, 'Jiménez', '3169809598', 'camilo.flores60@gmail.com', 'Calle 97 #39-74', 'M', '1995-05-05', '2023-03-18', '08:15:00', '15:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('48612439', 'CC', 'CA', 'H2', 4, 'Juan', 'Mendoza', NULL, 'Rodríguez', '3138052785', 'juan.mendoza52@gmail.com', 'Calle 95 #35-28', 'M', '1970-08-14', '2023-06-25', '06:30:00', '17:45:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('49258091', 'CC', 'RE', 'H2', 2, 'Camilo', 'Reyes', NULL, 'Morales', '3190142265', 'camilo.reyes72@gmail.com', 'Calle 69 #6-24', 'M', '1999-02-17', '2023-07-17', '07:45:00', '18:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('40992534', 'CC', 'CO', 'H2', 10, 'Yolanda', 'Suárez', NULL, 'Ramírez', '3172916371', 'yolanda.suarez87@gmail.com', 'Calle 92 #42-48', 'F', '2000-10-31', '2023-01-14', '08:00:00', '17:15:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('14325777', 'CC', 'CO', 'H4', 4, 'Catalina', 'González', NULL, 'Pérez', '3118876667', 'catalina.gonzalez36@gmail.com', 'Calle 23 #29-79', 'F', '1988-04-30', '2023-01-08', '08:45:00', '15:15:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('21449650', 'CC', 'AD', 'H2', 11, 'Juan', 'Molina', NULL, 'Vargas', '3154988861', 'juan.molina31@gmail.com', 'Calle 73 #43-20', 'M', '1993-07-01', '2023-12-29', '09:15:00', '17:45:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('53328415', 'CC', 'SE', 'H3', 2, 'Nicolás', 'Morales', NULL, 'Rodríguez', '3128058430', 'nicolas.morales70@gmail.com', 'Calle 16 #45-36', 'M', '1986-07-14', '2023-07-14', '06:45:00', '18:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('85825317', 'CC', 'SE', 'H3', 9, 'Daniela', 'Mendoza', NULL, 'Rodríguez', '3118886963', 'daniela.mendoza55@gmail.com', 'Calle 20 #18-4', 'F', '2000-06-03', '2024-06-10', '06:15:00', '18:30:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('74743230', 'CC', 'CA', 'H2', 4, 'Marcela', 'Ramírez', NULL, 'Suárez', '3186129797', 'marcela.ramirez65@gmail.com', 'Calle 44 #35-89', 'F', '1987-03-21', '2024-02-03', '08:15:00', '18:45:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('53671508', 'CC', 'AS', 'H4', 10, 'Juan', 'Ramos', NULL, 'López', '3124595457', 'juan.ramos86@gmail.com', 'Calle 88 #39-99', 'M', '1994-11-25', '2024-02-19', '09:15:00', '16:45:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('67011913', 'CC', 'CA', 'H5', 4, 'Alejandra', 'Castro', NULL, 'Morales', '3187356703', 'alejandra.castro79@gmail.com', 'Calle 47 #3-5', 'F', '1997-02-13', '2024-01-04', '09:15:00', '18:30:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('98089763', 'CC', 'RE', 'H5', 10, 'Laura', 'Medina', NULL, 'Pérez', '3120316277', 'laura.medina74@gmail.com', 'Calle 36 #17-17', 'F', '1983-02-02', '2024-11-15', '06:30:00', '17:00:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('54958564', 'CC', 'SE', 'H2', 7, 'Miguel', 'Cruz', NULL, 'Morales', '3142453439', 'miguel.cruz96@gmail.com', 'Calle 94 #44-76', 'M', '1982-02-16', '2024-05-16', '06:30:00', '18:45:00', 2200000.00, 'L', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('94639988', 'CC', 'GE', 'H2', 7, 'Camilo', 'Flores', NULL, 'Molina', '3135916466', 'camilo.flores14@gmail.com', 'Calle 4 #47-76', 'M', '2000-11-24', '2024-07-02', '09:00:00', '17:15:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('55030548', 'CC', 'CA', 'H5', 10, 'Felipe', 'Álvarez', NULL, 'Rodríguez', '3184277128', 'felipe.alvarez57@gmail.com', 'Calle 22 #29-32', 'M', '1972-11-01', '2024-03-02', '08:15:00', '17:15:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('20866138', 'CC', 'CO', 'H3', 10, 'Alejandro', 'Álvarez', NULL, 'Torres', '3172458605', 'alejandro.alvarez56@gmail.com', 'Calle 80 #3-47', 'M', '1997-10-31', '2024-06-20', '06:30:00', '14:00:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('25035684', 'CC', 'SE', 'H4', 3, 'Paola', 'Martínez', NULL, 'López', '3182670169', 'paola.martinez63@gmail.com', 'Calle 17 #31-45', 'F', '1976-08-21', '2024-09-11', '07:15:00', '18:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('79742280', 'CC', 'CO', 'H3', 1, 'María', 'Sánchez', NULL, 'Martínez', '3181157706', 'maria.sanchez95@gmail.com', 'Calle 71 #29-59', 'F', '1998-12-02', '2024-06-20', '09:30:00', '16:45:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('69175071', 'CC', 'CA', 'H5', 10, 'Daniel', 'Rodríguez', NULL, 'Rivera', '3156150365', 'daniel.rodriguez50@gmail.com', 'Calle 19 #24-58', 'M', '1981-09-06', '2024-07-08', '07:15:00', '18:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('21727533', 'CC', 'AS', 'H3', 9, 'Sebastián', 'García', NULL, 'Martínez', '3163359331', 'sebastian.garcia56@gmail.com', 'Calle 19 #46-55', 'M', '1992-12-16', '2024-07-20', '07:45:00', '16:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('13817499', 'CC', 'CO', 'H4', 11, 'Alejandro', 'Pérez', NULL, 'Ramos', '3185910136', 'alejandro.perez71@gmail.com', 'Calle 56 #17-81', 'M', '1975-05-10', '2024-05-21', '09:00:00', '18:30:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('31856985', 'CC', 'SE', 'H3', 1, 'Ricardo', 'Mendoza', NULL, 'Medina', '3117098551', 'ricardo.mendoza30@gmail.com', 'Calle 35 #24-54', 'M', '1996-02-03', '2024-01-30', '07:30:00', '17:15:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('48691113', 'CC', 'AD', 'H4', 8, 'Nicolás', 'Jiménez', NULL, 'González', '3171330222', 'nicolas.jimenez46@gmail.com', 'Calle 77 #48-40', 'M', '1994-12-29', '2024-01-21', '06:30:00', '17:00:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('18685284', 'CC', 'CA', 'H5', 2, 'Camilo', 'Molina', NULL, 'Medina', '3167002833', 'camilo.molina39@gmail.com', 'Calle 93 #32-36', 'M', '1986-04-26', '2024-04-11', '08:15:00', '18:45:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('35758531', 'CC', 'CA', 'H2', 2, 'Yolanda', 'Castro', NULL, 'Ramírez', '3114966557', 'yolanda.castro92@gmail.com', 'Calle 26 #11-35', 'F', '1971-03-30', '2024-05-05', '08:45:00', '17:45:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('46849119', 'CC', 'CO', 'H2', 3, 'Santiago', 'González', NULL, 'López', '3152478561', 'santiago.gonzalez24@gmail.com', 'Calle 70 #28-61', 'M', '1989-09-18', '2024-07-28', '08:00:00', '17:30:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('63825994', 'CC', 'RE', 'H4', 3, 'Nicolás', 'Torres', NULL, 'Molina', '3125750520', 'nicolas.torres82@gmail.com', 'Calle 2 #46-68', 'M', '1997-09-21', '2024-08-07', '08:15:00', '14:30:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('73115555', 'CC', 'RE', 'H4', 3, 'David', 'Rodríguez', NULL, 'Ramírez', '3157851319', 'david.rodriguez66@gmail.com', 'Calle 91 #36-63', 'M', '1981-09-03', '2024-03-24', '09:45:00', '14:45:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('96920825', 'CC', 'CO', 'H3', 11, 'Andrés', 'Rivera', NULL, 'Vargas', '3174103912', 'andres.rivera20@gmail.com', 'Calle 39 #10-17', 'M', '2000-10-13', '2025-03-21', '09:00:00', '16:45:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('25660291', 'CC', 'MA', 'H4', 1, 'Claudia', 'Herrera', NULL, 'García', '3192778089', 'claudia.herrera89@gmail.com', 'Calle 47 #45-87', 'F', '1970-08-06', '2025-03-29', '09:45:00', '17:45:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('73532708', 'CC', 'AS', 'H5', 4, 'Fernando', 'López', NULL, 'Molina', '3159604988', 'fernando.lopez25@gmail.com', 'Calle 74 #19-6', 'M', '1971-06-19', '2025-03-22', '08:00:00', '18:45:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('51177222', 'CC', 'CA', 'H3', 2, 'Sandra', 'Torres', NULL, 'Álvarez', '3117851976', 'sandra.torres13@gmail.com', 'Calle 39 #25-13', 'F', '1988-04-08', '2025-12-14', '07:00:00', '18:30:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('37187070', 'CC', 'RE', 'H4', 2, 'Santiago', 'Torres', NULL, 'Castro', '3118137886', 'santiago.torres44@gmail.com', 'Calle 41 #30-71', 'M', '1980-09-30', '2025-11-02', '07:45:00', '18:45:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('16104857', 'CC', 'SE', 'H4', 10, 'Gabriela', 'Cruz', NULL, 'Sánchez', '3128743541', 'gabriela.cruz25@gmail.com', 'Calle 93 #36-36', 'F', '1977-03-29', '2025-10-01', '06:30:00', '14:45:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('70762792', 'CC', 'SE', 'H1', 6, 'Pedro', 'Rivera', NULL, 'Reyes', '3112130654', 'pedro.rivera52@gmail.com', 'Calle 89 #9-83', 'M', '1982-04-01', '2025-05-06', '08:30:00', '15:45:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('62719526', 'CC', 'AS', 'H1', 7, 'María', 'Reyes', NULL, 'Pérez', '3190706579', 'maria.reyes58@gmail.com', 'Calle 46 #25-23', 'F', '1994-02-20', '2025-02-11', '06:00:00', '17:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('24890990', 'CC', 'MA', 'H5', 11, 'Yolanda', 'García', NULL, 'Sánchez', '3190929605', 'yolanda.garcia82@gmail.com', 'Calle 73 #12-9', 'F', '1982-06-11', '2025-10-19', '09:15:00', '18:15:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('40138350', 'CC', 'RE', 'H2', 6, 'Claudia', 'Vargas', NULL, 'Ramos', '3154923454', 'claudia.vargas34@gmail.com', 'Calle 11 #37-4', 'F', '1972-02-09', '2025-05-23', '09:45:00', '16:00:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('25903904', 'CC', 'GE', 'H2', 7, 'Natalia', 'Jiménez', NULL, 'Suárez', '3152674742', 'natalia.jimenez57@gmail.com', 'Calle 77 #28-82', 'F', '1976-06-24', '2025-03-08', '07:15:00', '18:45:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('72753631', 'CC', 'AS', 'H1', 7, 'Nicolás', 'Suárez', NULL, 'Rivera', '3134100904', 'nicolas.suarez13@gmail.com', 'Calle 57 #15-34', 'M', '1989-05-27', '2025-07-29', '08:45:00', '16:30:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('71928212', 'CC', 'AS', 'H2', 10, 'David', 'Ramírez', NULL, 'Jiménez', '3170394210', 'david.ramirez66@gmail.com', 'Calle 72 #2-48', 'M', '1985-04-13', '2025-02-13', '08:15:00', '17:45:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('37634396', 'CC', 'SE', 'H2', 7, 'María', 'Sánchez', NULL, 'Martínez', '3133062057', 'maria.sanchez11@gmail.com', 'Calle 42 #27-51', 'F', '1980-06-15', '2025-05-30', '06:45:00', '14:30:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('94527978', 'CC', 'AS', 'H5', 3, 'Daniel', 'Jiménez', NULL, 'Rivera', '3137409946', 'daniel.jimenez28@gmail.com', 'Calle 17 #6-23', 'M', '1970-04-10', '2025-02-03', '09:00:00', '15:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('92613013', 'CC', 'CA', 'H4', 11, 'David', 'Reyes', NULL, NULL, '3187844239', 'david.reyes65@gmail.com', 'Calle 78 #42-42', 'M', '1995-07-13', '2021-06-04', '09:00:00', '16:30:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('70152969', 'CC', 'AS', 'H5', 11, 'Alejandra', 'Molina', NULL, NULL, '3188055069', 'alejandra.molina94@gmail.com', 'Calle 48 #31-71', 'F', '1970-10-10', '2021-02-17', '08:15:00', '17:15:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('51154241', 'CC', 'SE', 'H4', 8, 'Juliana', 'Rivera', NULL, NULL, '3134850391', 'juliana.rivera78@gmail.com', 'Calle 25 #14-95', 'F', '1981-04-11', '2021-04-29', '06:15:00', '16:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('16095815', 'CC', 'SE', 'H1', 8, 'Claudia', 'Reyes', NULL, NULL, '3144295247', 'claudia.reyes27@gmail.com', 'Calle 38 #21-16', 'F', '1979-11-22', '2021-07-22', '06:00:00', '15:30:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('94676162', 'CC', 'RE', 'H1', 11, 'Gabriela', 'Álvarez', NULL, NULL, '3198122539', 'gabriela.alvarez42@gmail.com', 'Calle 78 #10-43', 'F', '1999-01-14', '2021-06-21', '06:30:00', '14:45:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('29834119', 'CC', 'MA', 'H2', 10, 'Paola', 'Cruz', NULL, NULL, '3166207740', 'paola.cruz50@gmail.com', 'Calle 20 #27-89', 'F', '2000-07-15', '2022-05-05', '06:00:00', '15:00:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('35016429', 'CC', 'CA', 'H2', 7, 'Alejandra', 'Vargas', NULL, NULL, '3167653606', 'alejandra.vargas85@gmail.com', 'Calle 50 #1-91', 'F', '1998-09-24', '2022-12-03', '09:45:00', '14:15:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('27036337', 'CC', 'AD', 'H1', 3, 'Fernanda', 'Mendoza', NULL, NULL, '3145292504', 'fernanda.mendoza18@gmail.com', 'Calle 92 #37-81', 'F', '1982-01-21', '2022-03-02', '06:30:00', '17:30:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('38859601', 'CC', 'RE', 'H4', 10, 'Juan', 'Reyes', NULL, NULL, '3150109721', 'juan.reyes16@gmail.com', 'Calle 34 #12-4', 'M', '1984-09-14', '2022-03-17', '06:15:00', '16:45:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('95283260', 'CC', 'MA', 'H3', 9, 'Diana', 'Morales', NULL, NULL, '3133834879', 'diana.morales67@gmail.com', 'Calle 61 #38-71', 'F', '1975-07-23', '2022-12-15', '06:15:00', '16:45:00', 3000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('24821786', 'CC', 'GE', 'H3', 1, 'Hernando', 'Ramírez', NULL, NULL, '3144345256', 'hernando.ramirez22@gmail.com', 'Calle 83 #15-59', 'M', '1995-10-03', '2023-12-09', '09:15:00', '14:00:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('34328380', 'CC', 'AS', 'H3', 8, 'Jorge', 'Ortiz', NULL, NULL, '3165201639', 'jorge.ortiz24@gmail.com', 'Calle 57 #3-9', 'M', '1997-06-03', '2023-07-14', '08:00:00', '15:45:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('19742790', 'CC', 'RE', 'H4', 10, 'Pedro', 'Álvarez', NULL, NULL, '3161192463', 'pedro.alvarez66@gmail.com', 'Calle 51 #43-4', 'M', '1986-01-17', '2023-09-15', '06:30:00', '16:00:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('65354876', 'CC', 'AD', 'H4', 4, 'Camilo', 'Reyes', NULL, NULL, '3155901507', 'camilo.reyes61@gmail.com', 'Calle 10 #36-23', 'M', '1985-11-03', '2023-09-22', '06:30:00', '15:30:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('43685164', 'CC', 'SE', 'H4', 8, 'Fernando', 'Mendoza', NULL, NULL, '3144130183', 'fernando.mendoza37@gmail.com', 'Calle 61 #41-13', 'M', '1995-03-21', '2023-10-18', '06:45:00', '14:15:00', 1300000.00, 'I', '2024-06-12');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('91253395', 'CC', 'SE', 'H2', 5, 'Felipe', 'Rivera', NULL, NULL, '3134680787', 'felipe.rivera31@gmail.com', 'Calle 3 #9-94', 'M', '1998-12-01', '2023-07-22', '08:45:00', '16:45:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('24670297', 'CC', 'RE', 'H5', 10, 'Fernanda', 'Molina', NULL, NULL, '3152478375', 'fernanda.molina87@gmail.com', 'Calle 34 #34-74', 'F', '1995-08-19', '2023-11-19', '06:45:00', '18:30:00', 2200000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('80653292', 'CC', 'CA', 'H5', 2, 'Natalia', 'Medina', NULL, NULL, '3199753695', 'natalia.medina94@gmail.com', 'Calle 10 #44-82', 'F', '1982-07-15', '2024-08-26', '06:00:00', '15:45:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('71047698', 'CC', 'RE', 'H3', 10, 'Paola', 'Medina', NULL, NULL, '3110183025', 'paola.medina91@gmail.com', 'Calle 81 #5-50', 'F', '1990-10-21', '2024-03-11', '09:15:00', '16:45:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('94292753', 'CC', 'CO', 'H3', 2, 'Alejandro', 'Jiménez', NULL, NULL, '3158656970', 'alejandro.jimenez97@gmail.com', 'Calle 13 #35-75', 'M', '1978-03-22', '2024-02-18', '07:30:00', '16:30:00', 1800000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('69762583', 'CC', 'CA', 'H1', 3, 'Hernando', 'García', NULL, NULL, '3186427662', 'hernando.garcia47@gmail.com', 'Calle 51 #4-43', 'M', '1991-10-05', '2025-08-30', '06:45:00', '18:15:00', 1500000.00, 'I', '2026-01-09');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('37566472', 'CC', 'GE', 'H2', 3, 'Alberto', 'Jiménez', NULL, NULL, '3130709222', 'alberto.jimenez22@gmail.com', 'Calle 83 #24-43', 'M', '1986-03-23', '2025-03-22', '08:45:00', '18:45:00', 4000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('58488507', 'CC', 'CO', 'H4', 9, 'Fernanda', 'López', NULL, NULL, '3167027331', 'fernanda.lopez17@gmail.com', 'Calle 17 #31-28', 'F', '1990-05-19', '2025-02-20', '07:45:00', '17:00:00', 1300000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('91468625', 'CC', 'RE', 'H4', 3, 'Sandra', 'Torres', NULL, NULL, '3111504663', 'sandra.torres19@gmail.com', 'Calle 87 #18-20', 'F', '1974-07-05', '2025-04-01', '08:00:00', '18:45:00', 1500000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('69332039', 'CC', 'CO', 'H2', 11, 'Paola', 'Molina', NULL, NULL, '3110626224', 'paola.molina86@gmail.com', 'Calle 7 #50-49', 'F', '1972-02-22', '2025-11-22', '06:45:00', '16:45:00', 1300000.00, 'I', '2025-12-14');
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('13750602', 'CC', 'MA', 'H4', 1, 'Ricardo', 'Sánchez', NULL, NULL, '3132532859', 'ricardo.sanchez95@gmail.com', 'Calle 93 #11-6', 'M', '1970-08-27', '2025-06-22', '07:00:00', '15:00:00', 5000000.00, 'A', NULL);
INSERT INTO public.employees (employee_doc, doc_type_id, position_id, hotel_id, city_id, fname, fsurname, mname, ssurname, phone_number, email, address, sex, date_birth, hire_date, check_in, check_out, salary, status, termination_date) VALUES ('32033022', 'CC', 'SE', 'H3', 8, 'Daniel', 'Martínez', NULL, NULL, '3187366028', 'daniel.martinez46@gmail.com', 'Calle 58 #41-26', 'M', '1978-11-11', '2025-05-06', '09:15:00', '18:15:00', 1800000.00, 'L', NULL);


--
-- TOC entry 4240 (class 0 OID 18457)
-- Dependencies: 227
-- Data for Name: equipments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (2, '101', 'H1', 1, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (3, '101', 'H1', 2, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (6, '102', 'H1', 3, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (7, '102', 'H1', 2, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (9, '102', 'H1', 3, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (11, '103', 'H1', 1, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (12, '103', 'H1', 1, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (13, '103', 'H1', 1, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (16, '104', 'H1', 2, 'Sofá Cama', 'O', 'Sofá cama para uso adicional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (17, '104', 'H1', 1, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (18, '104', 'H1', 2, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (19, '104', 'H1', 1, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (20, '201', 'H1', 2, 'Router WiFi', 'D', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (24, '202', 'H1', 1, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (30, '203', 'H1', 2, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (34, '204', 'H1', 3, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (35, '204', 'H1', 3, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (36, '204', 'H1', 3, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (38, '401', 'H1', 3, 'Caja Fuerte', 'O', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (41, '402', 'H1', 1, 'Sofá Cama', 'O', 'Sofá cama para uso adicional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (42, '402', 'H1', 1, 'Caja Fuerte', 'D', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (46, '403', 'H1', 3, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (47, '403', 'H1', 2, 'Sofá Cama', 'D', 'Sofá cama para uso adicional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (49, '404', 'H1', 1, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (50, '404', 'H1', 2, 'Refrigerador', 'D', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (51, '404', 'H1', 2, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (52, '404', 'H1', 3, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (53, '301', 'H1', 3, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (54, '301', 'H1', 3, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (55, '301', 'H1', 2, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (56, '301', 'H1', 3, 'Teléfono', 'O', 'Teléfono de habitación con línea directa');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (57, '301', 'H1', 1, 'Sofá Cama', 'O', 'Sofá cama para uso adicional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (59, '302', 'H1', 3, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (61, '302', 'H1', 2, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (62, '302', 'H1', 1, 'Teléfono', 'O', 'Teléfono de habitación con línea directa');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (63, '303', 'H1', 2, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (64, '303', 'H1', 2, 'Secador', 'R', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (70, '304', 'H1', 2, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (71, '501', 'H1', 1, 'Teléfono', 'O', 'Teléfono de habitación con línea directa');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (72, '501', 'H1', 3, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (74, '501', 'H1', 1, 'Sofá Cama', 'O', 'Sofá cama para uso adicional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (76, '502', 'H1', 1, 'Caja Fuerte', 'O', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (77, '502', 'H1', 2, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (78, '502', 'H1', 3, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (80, '503', 'H1', 2, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (82, '503', 'H1', 1, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (83, '503', 'H1', 2, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (31, '203', 'H1', 1, 'Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (86, '504', 'H1', 2, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (90, '101', 'H2', 3, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (97, '102', 'H2', 1, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (98, '103', 'H2', 1, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (99, '103', 'H2', 1, 'Teléfono', 'O', 'Teléfono de habitación con línea directa');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (100, '103', 'H2', 2, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (103, '104', 'H2', 1, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (104, '104', 'H2', 3, 'Sofá Cama', 'O', 'Sofá cama para uso adicional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (105, '104', 'H2', 3, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (106, '104', 'H2', 1, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (107, '201', 'H2', 2, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (108, '201', 'H2', 1, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (109, '201', 'H2', 1, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (111, '202', 'H2', 2, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (113, '202', 'H2', 1, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (114, '202', 'H2', 2, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (115, '203', 'H2', 2, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (116, '203', 'H2', 2, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (117, '203', 'H2', 2, 'Teléfono', 'O', 'Teléfono de habitación con línea directa');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (125, '401', 'H2', 3, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (127, '401', 'H2', 1, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (131, '402', 'H2', 2, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (132, '403', 'H2', 3, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (134, '403', 'H2', 2, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (137, '404', 'H2', 3, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (138, '404', 'H2', 1, 'Caja Fuerte', 'O', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (139, '404', 'H2', 3, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (140, '301', 'H2', 3, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (141, '301', 'H2', 1, 'Caja Fuerte', 'O', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (142, '301', 'H2', 3, 'Teléfono', 'O', 'Teléfono de habitación con línea directa');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (144, '301', 'H2', 3, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (145, '302', 'H2', 3, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (147, '302', 'H2', 3, 'Teléfono', 'O', 'Teléfono de habitación con línea directa');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (150, '303', 'H2', 2, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (151, '303', 'H2', 3, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (152, '303', 'H2', 3, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (153, '303', 'H2', 3, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (154, '304', 'H2', 2, 'Televisor', 'R', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (156, '304', 'H2', 2, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (158, '304', 'H2', 2, 'Caja Fuerte', 'R', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (159, '501', 'H2', 1, 'Sofá Cama', 'R', 'Sofá cama para uso adicional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (160, '501', 'H2', 3, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (161, '501', 'H2', 1, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (162, '501', 'H2', 2, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (163, '502', 'H2', 2, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (164, '502', 'H2', 1, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (1, '101', 'H1', 1, 'Router WiFi', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (166, '503', 'H2', 3, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (169, '503', 'H2', 2, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (174, '101', 'H3', 3, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (177, '101', 'H3', 2, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (178, '101', 'H3', 1, 'Secador', 'R', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (179, '102', 'H3', 2, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (181, '102', 'H3', 2, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (183, '103', 'H3', 2, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (186, '103', 'H3', 1, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (187, '103', 'H3', 1, 'Sofá Cama', 'O', 'Sofá cama para uso adicional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (190, '104', 'H3', 1, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (192, '201', 'H3', 2, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (194, '201', 'H3', 3, 'Caja Fuerte', 'O', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (195, '202', 'H3', 1, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (197, '202', 'H3', 1, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (198, '202', 'H3', 3, 'Teléfono', 'O', 'Teléfono de habitación con línea directa');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (199, '202', 'H3', 2, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (200, '203', 'H3', 3, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (201, '203', 'H3', 2, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (202, '203', 'H3', 3, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (203, '203', 'H3', 2, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (204, '203', 'H3', 3, 'Teléfono', 'O', 'Teléfono de habitación con línea directa');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (205, '204', 'H3', 1, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (206, '204', 'H3', 3, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (207, '204', 'H3', 1, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (208, '401', 'H3', 1, 'Caja Fuerte', 'O', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (209, '401', 'H3', 1, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (212, '401', 'H3', 2, 'Aire Acondicionado', 'R', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (213, '402', 'H3', 1, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (215, '402', 'H3', 2, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (216, '402', 'H3', 1, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (217, '403', 'H3', 1, 'Cama', 'R', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (218, '403', 'H3', 3, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (219, '403', 'H3', 3, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (220, '404', 'H3', 2, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (223, '301', 'H3', 2, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (224, '301', 'H3', 1, 'Aire Acondicionado', 'R', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (227, '301', 'H3', 2, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (231, '302', 'H3', 1, 'Caja Fuerte', 'O', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (232, '303', 'H3', 2, 'Teléfono', 'O', 'Teléfono de habitación con línea directa');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (236, '303', 'H3', 1, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (242, '501', 'H3', 2, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (243, '501', 'H3', 3, 'Sofá Cama', 'O', 'Sofá cama para uso adicional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (244, '501', 'H3', 1, 'Caja Fuerte', 'O', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (245, '501', 'H3', 3, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (247, '502', 'H3', 1, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (4, '101', 'H1', 1, 'Sofá Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (249, '502', 'H3', 3, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (250, '502', 'H3', 1, 'Sofá Cama', 'O', 'Sofá cama para uso adicional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (253, '503', 'H3', 3, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (255, '504', 'H3', 1, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (256, '504', 'H3', 1, 'Sofá Cama', 'O', 'Sofá cama para uso adicional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (257, '504', 'H3', 2, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (258, '504', 'H3', 2, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (259, '504', 'H3', 1, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (260, '101', 'H4', 2, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (261, '101', 'H4', 2, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (262, '101', 'H4', 3, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (263, '102', 'H4', 1, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (264, '102', 'H4', 2, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (266, '102', 'H4', 1, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (267, '103', 'H4', 3, 'Caja Fuerte', 'O', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (268, '103', 'H4', 2, 'Caja Fuerte', 'O', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (271, '104', 'H4', 2, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (272, '104', 'H4', 2, 'Teléfono', 'O', 'Teléfono de habitación con línea directa');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (274, '201', 'H4', 2, 'Teléfono', 'O', 'Teléfono de habitación con línea directa');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (276, '201', 'H4', 2, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (279, '202', 'H4', 2, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (280, '203', 'H4', 1, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (281, '203', 'H4', 2, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (282, '203', 'H4', 1, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (284, '204', 'H4', 3, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (286, '204', 'H4', 1, 'Sofá Cama', 'O', 'Sofá cama para uso adicional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (288, '401', 'H4', 2, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (289, '401', 'H4', 1, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (291, '402', 'H4', 3, 'Refrigerador', 'D', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (292, '402', 'H4', 2, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (293, '403', 'H4', 1, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (297, '404', 'H4', 1, 'Teléfono', 'D', 'Teléfono de habitación con línea directa');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (298, '404', 'H4', 2, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (299, '404', 'H4', 2, 'Teléfono', 'O', 'Teléfono de habitación con línea directa');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (300, '404', 'H4', 2, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (303, '301', 'H4', 3, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (304, '302', 'H4', 1, 'Sofá Cama', 'O', 'Sofá cama para uso adicional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (305, '302', 'H4', 2, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (306, '302', 'H4', 3, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (307, '302', 'H4', 1, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (313, '304', 'H4', 2, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (314, '304', 'H4', 1, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (315, '304', 'H4', 3, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (316, '304', 'H4', 2, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (317, '304', 'H4', 1, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (318, '501', 'H4', 2, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (319, '501', 'H4', 2, 'Refrigerador', 'D', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (320, '501', 'H4', 1, 'Secador', 'R', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (321, '501', 'H4', 1, 'Sofá Cama', 'D', 'Sofá cama para uso adicional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (322, '501', 'H4', 3, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (323, '502', 'H4', 1, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (324, '502', 'H4', 3, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (325, '502', 'H4', 3, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (326, '502', 'H4', 1, 'Cama', 'D', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (331, '504', 'H4', 1, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (332, '504', 'H4', 2, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (333, '504', 'H4', 1, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (337, '101', 'H5', 1, 'Caja Fuerte', 'O', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (338, '101', 'H5', 2, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (339, '101', 'H5', 1, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (340, '102', 'H5', 3, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (341, '102', 'H5', 1, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (342, '102', 'H5', 2, 'Teléfono', 'O', 'Teléfono de habitación con línea directa');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (343, '102', 'H5', 1, 'Caja Fuerte', 'O', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (344, '102', 'H5', 1, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (345, '103', 'H5', 1, 'Aire Acondicionado', 'R', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (346, '103', 'H5', 3, 'Caja Fuerte', 'O', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (349, '103', 'H5', 1, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (350, '104', 'H5', 1, 'Sofá Cama', 'O', 'Sofá cama para uso adicional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (356, '201', 'H5', 3, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (357, '202', 'H5', 3, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (360, '202', 'H5', 3, 'Sofá Cama', 'O', 'Sofá cama para uso adicional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (361, '203', 'H5', 2, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (362, '203', 'H5', 2, 'Televisor', 'R', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (363, '203', 'H5', 1, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (364, '203', 'H5', 3, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (366, '204', 'H5', 1, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (367, '204', 'H5', 1, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (368, '204', 'H5', 1, 'Televisor', 'D', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (371, '401', 'H5', 2, 'Teléfono', 'O', 'Teléfono de habitación con línea directa');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (372, '401', 'H5', 2, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (373, '402', 'H5', 3, 'Router WiFi', 'D', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (374, '402', 'H5', 2, 'Sofá Cama', 'O', 'Sofá cama para uso adicional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (376, '402', 'H5', 1, 'Caja Fuerte', 'D', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (377, '403', 'H5', 2, 'Router WiFi', 'D', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (380, '403', 'H5', 1, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (381, '403', 'H5', 3, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (383, '404', 'H5', 1, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (384, '404', 'H5', 2, 'Caja Fuerte', 'O', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (385, '404', 'H5', 2, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (387, '301', 'H5', 2, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (388, '301', 'H5', 2, 'Caja Fuerte', 'O', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (389, '301', 'H5', 2, 'Televisor', 'O', 'Smart TV 55 pulgadas con control remoto');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (390, '302', 'H5', 3, 'Caja Fuerte', 'O', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (393, '302', 'H5', 1, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (395, '303', 'H5', 3, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (396, '303', 'H5', 3, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (397, '304', 'H5', 2, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (398, '304', 'H5', 3, 'Refrigerador', 'O', 'Mini refrigerador 60 litros');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (399, '304', 'H5', 3, 'Teléfono', 'O', 'Teléfono de habitación con línea directa');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (400, '501', 'H5', 2, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (401, '501', 'H5', 1, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (402, '501', 'H5', 1, 'Sofá Cama', 'O', 'Sofá cama para uso adicional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (403, '501', 'H5', 1, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (406, '502', 'H5', 2, 'Aire Acondicionado', 'O', 'Unidad de A/C inverter 12000 BTU');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (407, '502', 'H5', 3, 'Router WiFi', 'O', 'Router WiFi de alta velocidad');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (412, '503', 'H5', 1, 'Cama', 'O', 'Cama tipo queen size con colchón ortopédico');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (413, '504', 'H5', 2, 'Escritorio', 'O', 'Escritorio de trabajo con silla ergonómica');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (414, '504', 'H5', 1, 'Caja Fuerte', 'O', 'Caja fuerte digital con combinación');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (415, '504', 'H5', 2, 'Secador', 'O', 'Secador de cabello profesional');
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (334, '504', 'H4', 1, 'Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (5, '101', 'H1', 3, 'Escritorio', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (8, '102', 'H1', 1, 'Televisor', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (10, '102', 'H1', 3, 'Sofá Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (14, '103', 'H1', 1, 'Escritorio', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (15, '104', 'H1', 1, 'Escritorio', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (21, '201', 'H1', 2, 'Televisor', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (22, '201', 'H1', 3, 'Teléfono', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (23, '201', 'H1', 2, 'Escritorio', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (25, '202', 'H1', 2, 'Televisor', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (26, '202', 'H1', 2, 'Caja Fuerte', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (27, '202', 'H1', 3, 'Secador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (28, '202', 'H1', 1, 'Sofá Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (29, '203', 'H1', 1, 'Escritorio', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (32, '203', 'H1', 1, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (33, '203', 'H1', 1, 'Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (37, '401', 'H1', 2, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (39, '401', 'H1', 1, 'Router WiFi', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (40, '401', 'H1', 1, 'Caja Fuerte', 'D', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (43, '402', 'H1', 1, 'Router WiFi', 'D', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (44, '403', 'H1', 1, 'Cama', 'R', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (45, '403', 'H1', 1, 'Teléfono', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (48, '404', 'H1', 2, 'Refrigerador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (58, '302', 'H1', 2, 'Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (60, '302', 'H1', 2, 'Router WiFi', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (65, '303', 'H1', 1, 'Secador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (66, '303', 'H1', 3, 'Secador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (67, '304', 'H1', 3, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (68, '304', 'H1', 1, 'Refrigerador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (69, '304', 'H1', 3, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (73, '501', 'H1', 1, 'Secador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (75, '502', 'H1', 2, 'Televisor', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (79, '502', 'H1', 2, 'Aire Acondicionado', 'D', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (81, '503', 'H1', 1, 'Televisor', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (84, '503', 'H1', 3, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (85, '504', 'H1', 2, 'Secador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (87, '504', 'H1', 2, 'Secador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (88, '504', 'H1', 2, 'Escritorio', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (89, '101', 'H2', 1, 'Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (91, '101', 'H2', 1, 'Cama', 'D', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (92, '101', 'H2', 1, 'Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (93, '101', 'H2', 3, 'Refrigerador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (94, '102', 'H2', 2, 'Escritorio', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (95, '102', 'H2', 2, 'Secador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (96, '102', 'H2', 1, 'Router WiFi', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (101, '103', 'H2', 1, 'Escritorio', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (102, '104', 'H2', 1, 'Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (110, '202', 'H2', 1, 'Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (112, '202', 'H2', 3, 'Televisor', 'R', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (118, '203', 'H2', 2, 'Router WiFi', 'D', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (119, '203', 'H2', 3, 'Caja Fuerte', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (120, '204', 'H2', 1, 'Cama', 'D', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (121, '204', 'H2', 2, 'Refrigerador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (122, '204', 'H2', 1, 'Caja Fuerte', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (123, '204', 'H2', 2, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (124, '401', 'H2', 3, 'Caja Fuerte', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (126, '401', 'H2', 2, 'Teléfono', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (128, '401', 'H2', 3, 'Teléfono', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (129, '402', 'H2', 3, 'Sofá Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (130, '402', 'H2', 3, 'Secador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (133, '403', 'H2', 3, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (135, '403', 'H2', 1, 'Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (136, '404', 'H2', 3, 'Refrigerador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (143, '301', 'H2', 2, 'Cama', 'R', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (146, '302', 'H2', 1, 'Escritorio', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (148, '302', 'H2', 1, 'Escritorio', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (149, '302', 'H2', 2, 'Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (155, '304', 'H2', 3, 'Televisor', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (157, '304', 'H2', 1, 'Secador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (165, '502', 'H2', 3, 'Televisor', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (167, '503', 'H2', 3, 'Refrigerador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (168, '503', 'H2', 1, 'Teléfono', 'D', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (170, '503', 'H2', 2, 'Router WiFi', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (171, '504', 'H2', 1, 'Escritorio', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (172, '504', 'H2', 1, 'Escritorio', 'D', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (173, '504', 'H2', 1, 'Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (175, '101', 'H3', 1, 'Televisor', 'D', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (176, '101', 'H3', 2, 'Router WiFi', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (180, '102', 'H3', 1, 'Teléfono', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (182, '102', 'H3', 2, 'Aire Acondicionado', 'D', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (184, '103', 'H3', 2, 'Televisor', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (185, '103', 'H3', 3, 'Router WiFi', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (188, '104', 'H3', 3, 'Sofá Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (189, '104', 'H3', 3, 'Router WiFi', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (191, '104', 'H3', 3, 'Router WiFi', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (193, '201', 'H3', 1, 'Caja Fuerte', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (196, '202', 'H3', 3, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (210, '401', 'H3', 2, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (211, '401', 'H3', 3, 'Televisor', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (214, '402', 'H3', 3, 'Secador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (221, '404', 'H3', 3, 'Secador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (222, '404', 'H3', 1, 'Caja Fuerte', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (225, '301', 'H3', 3, 'Refrigerador', 'R', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (226, '301', 'H3', 1, 'Router WiFi', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (228, '302', 'H3', 1, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (229, '302', 'H3', 1, 'Teléfono', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (230, '302', 'H3', 2, 'Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (233, '303', 'H3', 3, 'Televisor', 'R', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (234, '303', 'H3', 2, 'Teléfono', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (235, '303', 'H3', 2, 'Caja Fuerte', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (237, '304', 'H3', 2, 'Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (238, '304', 'H3', 1, 'Caja Fuerte', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (239, '304', 'H3', 1, 'Sofá Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (240, '304', 'H3', 3, 'Televisor', 'R', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (241, '304', 'H3', 2, 'Sofá Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (246, '501', 'H3', 1, 'Sofá Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (248, '502', 'H3', 3, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (251, '502', 'H3', 1, 'Caja Fuerte', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (252, '503', 'H3', 3, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (254, '503', 'H3', 3, 'Refrigerador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (265, '102', 'H4', 1, 'Cama', 'D', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (269, '103', 'H4', 1, 'Sofá Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (270, '103', 'H4', 2, 'Televisor', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (273, '104', 'H4', 2, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (275, '201', 'H4', 2, 'Router WiFi', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (277, '202', 'H4', 1, 'Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (278, '202', 'H4', 1, 'Router WiFi', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (283, '203', 'H4', 2, 'Escritorio', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (285, '204', 'H4', 3, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (287, '401', 'H4', 1, 'Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (290, '402', 'H4', 2, 'Escritorio', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (294, '403', 'H4', 3, 'Secador', 'D', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (295, '403', 'H4', 1, 'Caja Fuerte', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (296, '403', 'H4', 1, 'Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (301, '301', 'H4', 1, 'Caja Fuerte', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (302, '301', 'H4', 2, 'Secador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (308, '303', 'H4', 2, 'Televisor', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (309, '303', 'H4', 3, 'Teléfono', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (310, '303', 'H4', 1, 'Refrigerador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (311, '303', 'H4', 3, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (312, '303', 'H4', 2, 'Secador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (327, '503', 'H4', 2, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (328, '503', 'H4', 1, 'Secador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (329, '503', 'H4', 1, 'Sofá Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (330, '503', 'H4', 3, 'Refrigerador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (335, '101', 'H5', 1, 'Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (336, '101', 'H5', 1, 'Caja Fuerte', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (347, '103', 'H5', 2, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (348, '103', 'H5', 3, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (351, '104', 'H5', 3, 'Aire Acondicionado', 'D', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (352, '104', 'H5', 1, 'Sofá Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (353, '201', 'H5', 1, 'Cama', 'D', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (354, '201', 'H5', 2, 'Secador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (355, '201', 'H5', 2, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (358, '202', 'H5', 1, 'Sofá Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (359, '202', 'H5', 2, 'Sofá Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (365, '204', 'H5', 2, 'Refrigerador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (369, '401', 'H5', 3, 'Caja Fuerte', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (370, '401', 'H5', 2, 'Router WiFi', 'R', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (375, '402', 'H5', 2, 'Refrigerador', 'R', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (378, '403', 'H5', 2, 'Teléfono', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (379, '403', 'H5', 1, 'Escritorio', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (382, '404', 'H5', 1, 'Sofá Cama', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (386, '301', 'H5', 3, 'Televisor', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (391, '302', 'H5', 1, 'Caja Fuerte', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (392, '302', 'H5', 1, 'Caja Fuerte', 'R', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (394, '303', 'H5', 3, 'Caja Fuerte', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (404, '502', 'H5', 2, 'Aire Acondicionado', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (405, '502', 'H5', 1, 'Sofá Cama', 'D', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (408, '503', 'H5', 2, 'Secador', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (409, '503', 'H5', 2, 'Teléfono', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (410, '503', 'H5', 1, 'Teléfono', 'O', NULL);
INSERT INTO public.equipments (equipment_id, room_number, hotel_id, quantity, name, status, description) VALUES (411, '503', 'H5', 1, 'Secador', 'O', NULL);


--
-- TOC entry 4246 (class 0 OID 18550)
-- Dependencies: 233
-- Data for Name: guests; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('21906479', 'VE', 'Hernando', 'Ortiz', 'David', 'Rivera', '1995-03-11');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('57902263', 'AR', 'Roberto', 'García', 'Sebastián', 'Ortiz', '1990-08-01');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('59209911', 'US', 'Pedro', 'Rodríguez', 'Luis', 'López', '2006-04-06');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('73582971', 'EC', 'Juliana', 'Molina', 'Sandra', 'Martínez', '1983-12-03');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('81251601', 'CL', 'Jorge', 'Molina', 'Sebastián', 'Jiménez', '2003-01-31');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('25188734', 'CL', 'Luis', 'Ramírez', 'Andrés', 'Mendoza', '2000-03-31');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('17090950', 'EC', 'Gabriela', 'Molina', 'Marcela', 'Mendoza', '1996-06-20');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('78238437', 'CO', 'Alberto', 'González', 'Daniel', 'Ramírez', '2004-06-12');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('80474490', 'AR', 'Daniel', 'Herrera', 'Alberto', 'Martínez', '1998-03-24');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('33932371', 'EC', 'Sebastián', 'Rivera', 'Pedro', 'Herrera', '1953-12-13');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('20758474', 'CL', 'Ana', 'Mendoza', 'Juliana', 'Cruz', '1978-11-16');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('20880118', 'ES', 'Carlos', 'Rivera', 'Juan', 'Pérez', '1957-05-31');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('17683639', 'AR', 'Hernando', 'Vargas', 'Miguel', 'Herrera', '2006-08-06');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('30210136', 'VE', 'Sofía', 'Jiménez', 'Catalina', 'Álvarez', '1965-10-07');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('84161109', 'CO', 'Sofía', 'Medina', 'Paola', 'Castro', '1953-07-14');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('90812831', 'BR', 'Laura', 'Sánchez', 'Juliana', 'Ramírez', '2005-02-07');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('95395354', 'ES', 'Yolanda', 'García', 'Natalia', 'Álvarez', '1997-03-05');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('66344563', 'US', 'Juliana', 'Pérez', 'Sofía', 'García', '1961-09-16');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('43802725', 'MX', 'Fernanda', 'Sánchez', 'Juliana', 'López', '1957-05-16');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('73059790', 'VE', 'Alejandro', 'Mendoza', 'David', 'García', '1983-11-06');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('81183035', 'ES', 'Juliana', 'Flores', 'Carolina', 'Jiménez', '1995-04-29');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('91885596', 'PE', 'Sebastián', 'Mendoza', 'Felipe', 'González', '1955-07-10');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('49107858', 'CO', 'Laura', 'Reyes', 'Sofía', 'Cruz', '1971-06-05');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('80627050', 'US', 'David', 'Álvarez', 'Pedro', 'Morales', '1973-02-13');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('23713785', 'EC', 'Claudia', 'Mendoza', 'Gabriela', 'Ramírez', '1958-01-30');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('83065167', 'VE', 'Pedro', 'Jiménez', 'Nicolás', 'Vargas', '1954-05-03');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('76113110', 'US', 'Daniel', 'Martínez', 'Roberto', 'Cruz', '1969-06-13');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('14665068', 'BR', 'Camilo', 'Ramírez', 'Felipe', 'Rodríguez', '1956-11-22');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('62256420', 'AR', 'Pedro', 'Ramos', 'Fernando', 'Álvarez', '1958-07-21');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('11125006', 'CL', 'Fernanda', 'Álvarez', 'Juliana', 'Herrera', '1950-12-16');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('54907705', 'VE', 'David', 'García', 'Carlos', 'Medina', '1987-03-27');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('56411493', 'ES', 'María', 'Castro', 'Diana', 'Morales', '1962-01-06');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('63284724', 'US', 'Claudia', 'Flores', 'Alejandra', 'Ramírez', '1997-07-16');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('36132987', 'BR', 'Isabella', 'Medina', 'María', 'González', '1965-04-22');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('22882933', 'CL', 'Juliana', 'Mendoza', 'Yolanda', 'Rodríguez', '1960-06-14');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('79827653', 'CO', 'Santiago', 'Rodríguez', 'Carlos', 'Sánchez', '1968-03-24');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('61846177', 'CO', 'Gabriela', 'Suárez', 'Yolanda', 'Martínez', '1963-10-26');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('33556305', 'VE', 'Ana', 'Mendoza', 'Isabella', 'Sánchez', '1969-08-12');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('83858860', 'CL', 'Isabella', 'Rodríguez', 'Natalia', 'Ortiz', '1966-06-15');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('66971876', 'PE', 'Marcela', 'Ramos', 'Claudia', 'Cruz', '2000-05-13');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('15414590', 'MX', 'Pedro', 'Jiménez', 'David', 'Torres', '1960-05-23');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('36047525', 'PE', 'Alejandro', 'García', 'Alberto', 'Jiménez', '1980-09-26');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('28320085', 'CL', 'Valentina', 'Reyes', 'Catalina', 'Herrera', '1986-07-22');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('26661403', 'ES', 'David', 'Cruz', 'Daniel', 'Morales', '1954-10-16');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('48354650', 'MX', 'Marcela', 'Molina', 'Yolanda', 'Martínez', '2001-07-03');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('64070291', 'EC', 'Carlos', 'Torres', 'Nicolás', 'Medina', '2003-08-21');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('59147913', 'CL', 'Ana', 'Flores', 'Fernanda', 'González', '2001-12-20');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('33504699', 'US', 'Fernando', 'Medina', 'Alejandro', 'Suárez', '1967-01-30');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('86003182', 'EC', 'Ricardo', 'Reyes', 'Santiago', 'López', '2004-09-22');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('55211575', 'ES', 'Luis', 'Jiménez', 'David', 'Rivera', '1960-10-13');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('90583309', 'BR', 'Carlos', 'Reyes', 'Pedro', 'Jiménez', '1985-01-18');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('77632223', 'BR', 'Ana', 'López', 'Laura', 'Álvarez', '1968-02-17');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('16431196', 'CO', 'Juan', 'Suárez', 'David', 'Rivera', '1955-12-10');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('20751435', 'MX', 'Fernanda', 'Suárez', 'Laura', 'Cruz', '1976-04-16');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('94495057', 'EC', 'Felipe', 'Vargas', 'Andrés', 'Ortiz', '1996-10-24');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('69417509', 'PE', 'Sebastián', 'García', 'Pedro', 'Ramos', '2003-09-22');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('28754310', 'PE', 'Gabriela', 'Rodríguez', 'Paola', 'Molina', '1986-03-05');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('22357361', 'CL', 'Sandra', 'Morales', 'Yolanda', 'García', '1994-02-23');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('19013806', 'MX', 'Camilo', 'Reyes', 'Fernando', 'Herrera', '1967-07-09');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('52171230', 'EC', 'David', 'Ramírez', 'Nicolás', 'Martínez', '1982-02-08');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('83106438', 'PE', 'David', 'Castro', 'Ricardo', 'López', '1957-02-06');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('49826179', 'CL', 'David', 'Vargas', 'Pedro', 'Martínez', '1977-07-20');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('53355368', 'ES', 'Marcela', 'Mendoza', 'Laura', 'Pérez', '1954-04-15');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('67869281', 'VE', 'Camilo', 'Jiménez', 'Alejandro', 'Rodríguez', '1974-09-16');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('23638593', 'MX', 'Laura', 'Vargas', 'Valentina', 'Sánchez', '1985-09-27');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('64817898', 'AR', 'Miguel', 'Pérez', 'Fernando', 'Herrera', '1952-08-13');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('59001054', 'CO', 'Camilo', 'Álvarez', 'Fernando', 'González', '1950-03-15');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('34219451', 'EC', 'Alejandra', 'Martínez', 'Sandra', 'Reyes', '1970-02-02');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('19779395', 'EC', 'Claudia', 'Castro', 'Carolina', 'Medina', '1996-11-27');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('63409319', 'ES', 'Juan', 'González', 'Roberto', 'Rivera', '1990-12-22');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('41570584', 'MX', 'Alberto', 'Herrera', 'Roberto', 'Álvarez', '1988-07-28');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('54410181', 'CO', 'Alejandra', 'Pérez', 'María', 'González', '1953-01-16');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('78096871', 'MX', 'Alberto', 'Mendoza', 'Santiago', 'Suárez', '1976-03-08');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('84294997', 'CL', 'Alejandro', 'Mendoza', 'Felipe', 'Suárez', '2006-06-23');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('78120181', 'CL', 'Juan', 'Morales', 'Alejandro', 'Vargas', '1991-01-29');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('83010270', 'US', 'Nicolás', 'Morales', 'Juan', 'Pérez', '1986-01-13');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('18520287', 'ES', 'Carolina', 'Álvarez', 'Gabriela', 'Martínez', '2006-04-29');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('30121529', 'CL', 'Catalina', 'Ramos', 'Alejandra', 'Castro', '2005-12-13');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('52965279', 'EC', 'Fernanda', 'Molina', 'Catalina', 'González', '1996-04-21');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('80382000', 'AR', 'Hernando', 'Cruz', 'Andrés', 'Herrera', '1950-01-22');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('14012808', 'MX', 'Paola', 'Morales', 'Valentina', 'Rodríguez', '2009-07-13');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('71288572', 'AR', 'Gabriela', 'Mendoza', 'Yolanda', 'Suárez', '2001-01-24');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('33609865', 'CL', 'Carlos', 'Pérez', 'Miguel', 'Torres', '1980-09-27');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('34922740', 'MX', 'Diana', 'Morales', 'Sandra', 'Suárez', '2007-04-07');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('62530853', 'MX', 'Luis', 'Mendoza', 'Alberto', 'Medina', '1969-12-07');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('74867809', 'AR', 'Felipe', 'Herrera', 'Jorge', 'Álvarez', '1965-12-17');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('89070916', 'BR', 'Gabriela', 'Medina', 'Paola', 'Pérez', '1969-11-20');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('23719833', 'AR', 'Felipe', 'Suárez', 'Fernando', 'Reyes', '1970-01-21');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('75467163', 'AR', 'Alejandra', 'García', 'Isabella', 'Suárez', '1975-10-11');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('26103144', 'ES', 'Valentina', 'Sánchez', 'María', 'Flores', '2010-08-06');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('16293447', 'EC', 'Miguel', 'Suárez', 'Hernando', 'Ramos', '1967-11-13');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('24431443', 'PE', 'Sofía', 'Rivera', 'Ana', 'Flores', '1979-04-26');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('33800125', 'AR', 'Alejandro', 'Rodríguez', 'Juan', 'Álvarez', '1990-12-19');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('80292642', 'ES', 'Yolanda', 'López', 'Fernanda', 'Molina', '1992-06-04');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('46464544', 'CO', 'Pedro', 'Álvarez', 'Luis', 'Ramos', '1982-05-21');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('63981512', 'AR', 'Daniel', 'Jiménez', 'Fernando', 'Herrera', '1964-08-09');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('17834175', 'BR', 'Felipe', 'Álvarez', 'Alberto', 'Ortiz', '1979-02-09');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('48659084', 'ES', 'Marcela', 'Morales', 'Juliana', 'Rivera', '1965-12-13');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('54599850', 'BR', 'Alejandro', 'Martínez', 'Miguel', 'Molina', '1952-04-12');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('59996586', 'MX', 'Carlos', 'Rodríguez', 'Andrés', 'González', '2007-05-06');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('96255089', 'EC', 'Roberto', 'Martínez', 'Daniel', 'Ramírez', '1960-05-20');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('55624601', 'AR', 'Isabella', 'Sánchez', 'Ana', 'García', '1993-02-09');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('22059594', 'CO', 'Alejandro', 'Rodríguez', 'Juan', 'Castro', '1996-08-12');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('28208868', 'PE', 'Natalia', 'Cruz', 'Alejandra', 'Torres', '1983-12-30');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('62679863', 'VE', 'Gabriela', 'Ramírez', 'Alejandra', 'Mendoza', '1954-10-06');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('85763872', 'US', 'David', 'Molina', 'Nicolás', 'Mendoza', '2008-10-19');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('86084622', 'ES', 'Carlos', 'Pérez', 'Felipe', 'González', '2005-02-27');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('53883117', 'BR', 'Santiago', 'López', 'Jorge', 'Mendoza', '2008-12-18');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('32355818', 'US', 'Alejandro', 'Herrera', 'Daniel', 'González', '1979-03-02');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('76183001', 'PE', 'Juliana', 'Ramos', 'Claudia', 'Mendoza', '1969-08-20');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('54644060', 'ES', 'Camilo', 'Ramírez', 'Alejandro', 'García', '1973-06-02');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('34220993', 'VE', 'Marcela', 'Suárez', 'Catalina', 'Molina', '1990-02-01');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('87789716', 'EC', 'David', 'Molina', 'Hernando', 'Rivera', '2000-02-02');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('28081314', 'VE', 'Luis', 'García', 'Pedro', 'Reyes', '1982-09-07');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('56883986', 'PE', 'Yolanda', 'Jiménez', 'Daniela', 'Medina', '1968-11-22');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('96290143', 'EC', 'David', 'Martínez', 'Roberto', 'García', '2001-10-13');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('36351317', 'ES', 'Carolina', 'Sánchez', 'Fernanda', 'Rodríguez', '1950-06-10');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('30372558', 'EC', 'Luis', 'Rodríguez', 'Camilo', 'Cruz', '1960-05-14');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('26234545', 'CO', 'Gabriela', 'González', 'Claudia', 'Pérez', '2005-05-26');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('68738639', 'CL', 'Nicolás', 'Mendoza', 'Luis', 'Rivera', '1972-04-23');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('71115136', 'EC', 'Isabella', 'Herrera', 'Diana', 'García', '2008-05-15');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('33640730', 'MX', 'Fernanda', 'González', 'Claudia', 'Álvarez', '1959-01-05');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('93932840', 'BR', 'Alejandro', 'Herrera', 'Carlos', 'Reyes', '1997-01-31');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('59221290', 'US', 'Gabriela', 'García', 'Sandra', 'Medina', '1981-05-25');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('90020978', 'ES', 'Ana', 'Sánchez', 'María', 'Molina', '1980-12-21');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('40717503', 'VE', 'Roberto', 'García', 'Hernando', 'Álvarez', '1990-09-15');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('83778810', 'AR', 'Luis', 'Sánchez', 'Sebastián', 'Ortiz', '1979-04-22');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('13629536', 'US', 'Gabriela', 'Álvarez', 'Sofía', 'González', '1973-04-08');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('66701593', 'CO', 'Luis', 'González', 'Carlos', 'Ramos', '1961-01-17');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('76418594', 'CL', 'Yolanda', 'Ramos', 'Paola', 'Ramírez', '1974-12-08');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('67877622', 'VE', 'Jorge', 'Vargas', 'Andrés', 'Mendoza', '1988-03-27');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('93605083', 'MX', 'Marcela', 'Morales', 'Daniela', 'Ortiz', '1955-10-28');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('28368925', 'VE', 'Paola', 'Torres', 'Valentina', 'Ramos', '1972-07-12');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('17972328', 'CL', 'Juliana', 'López', 'María', 'Rodríguez', '1960-08-19');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('84335596', 'BR', 'Andrés', 'García', 'David', 'Mendoza', '1970-08-15');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('24519890', 'CO', 'Daniela', 'González', 'Claudia', 'Medina', '1980-09-30');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('54578981', 'US', 'Daniel', 'Vargas', 'Andrés', 'Molina', '1957-02-24');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('12339362', 'CO', 'Paola', 'Molina', 'Claudia', 'Sánchez', '2000-09-13');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('69971142', 'AR', 'Paola', 'Herrera', 'Natalia', 'Jiménez', '1988-03-18');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('73753876', 'EC', 'Marcela', 'Jiménez', 'Ana', 'Ramírez', '1951-09-14');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('16788404', 'VE', 'Marcela', 'Álvarez', 'María', 'Martínez', '1990-02-05');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('97926462', 'CO', 'Daniela', 'Torres', 'Claudia', 'Rodríguez', '1973-07-26');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('94701395', 'ES', 'Alberto', 'Martínez', 'Pedro', 'Molina', '1974-03-08');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('96783043', 'MX', 'Sebastián', 'Rodríguez', 'Fernando', 'Medina', '2003-08-24');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('11967696', 'PE', 'Marcela', 'López', 'Yolanda', 'Suárez', '1956-01-05');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('38768529', 'CO', 'Paola', 'Reyes', 'Juliana', 'González', '1991-12-03');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('22761159', 'MX', 'Jorge', 'Cruz', 'Carlos', 'Reyes', '1998-12-18');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('86713815', 'ES', 'Daniel', 'Reyes', 'Ricardo', 'Molina', '1996-01-08');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('78873201', 'CL', 'Jorge', 'Vargas', 'Miguel', 'Morales', '1970-12-01');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('33162629', 'CL', 'Fernanda', 'Vargas', 'Natalia', 'García', '1955-07-16');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('52976267', 'PE', 'Sebastián', 'Rodríguez', 'Alberto', 'Ortiz', '1992-06-17');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('50205681', 'VE', 'Jorge', 'Castro', 'David', 'Medina', '2003-06-11');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('89246165', 'PE', 'Ana', 'Pérez', 'Yolanda', 'Jiménez', '1974-04-05');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('72191000', 'EC', 'Pedro', 'Herrera', 'Santiago', 'Jiménez', '1985-03-06');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('40781126', 'AR', 'Laura', 'Rodríguez', 'Carolina', 'Medina', '1960-07-30');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('84250773', 'MX', 'Alejandra', 'Pérez', 'Valentina', 'Ramos', '2000-01-29');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('87985029', 'PE', 'Felipe', 'Morales', 'Camilo', 'López', '2009-02-02');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('66590557', 'ES', 'Paola', 'Cruz', 'Sofía', 'Rodríguez', '2007-05-22');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('61799347', 'VE', 'María', 'Herrera', 'Sandra', 'Rivera', '1962-10-09');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('46939031', 'BR', 'Ricardo', 'Álvarez', 'Roberto', 'Ramírez', '1998-09-06');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('45690939', 'US', 'Carlos', 'Medina', 'Fernando', 'Álvarez', '1997-12-18');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('68506613', 'CO', 'Alejandra', 'Ramírez', 'Fernanda', 'Suárez', '1962-05-02');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('69750285', 'CL', 'Gabriela', 'González', 'Catalina', 'Álvarez', '2004-01-02');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('50251854', 'VE', 'Santiago', 'Suárez', 'Carlos', 'Martínez', '1956-08-17');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('58016004', 'US', 'Miguel', 'Álvarez', 'Roberto', 'Mendoza', '2009-04-26');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('73768236', 'US', 'David', 'López', 'Santiago', 'Ramírez', '1986-07-28');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('53113090', 'MX', 'Felipe', 'Ramírez', 'Jorge', 'Rodríguez', '1999-11-28');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('32222880', 'CO', 'Camilo', 'Álvarez', 'Felipe', 'Molina', '1982-04-29');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('92715650', 'VE', 'Sofía', 'González', 'Catalina', 'Torres', '1958-09-26');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('18768924', 'PE', 'Gabriela', 'Ramos', 'Ana', 'Álvarez', '1996-04-10');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('94622522', 'CL', 'Sebastián', 'Medina', 'Alberto', 'Álvarez', '1953-10-02');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('46439924', 'VE', 'Camilo', 'Herrera', 'Nicolás', 'González', '1957-02-21');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('69102324', 'CL', 'Roberto', 'Molina', 'Camilo', 'Suárez', '1977-12-16');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('90410932', 'EC', 'Isabella', 'López', 'Laura', 'Suárez', '2010-12-18');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('96921883', 'BR', 'Diana', 'Rivera', 'Juliana', 'Ramírez', '1961-04-14');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('90462702', 'AR', 'Fernando', 'Torres', 'Roberto', 'Rivera', '1955-01-03');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('98055418', 'ES', 'Catalina', 'Rodríguez', 'María', 'García', '2008-06-07');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('43596935', 'VE', 'Felipe', 'Suárez', NULL, 'López', '2003-09-05');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('32419424', 'CL', 'Andrés', 'Molina', NULL, 'Torres', '2008-12-20');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('99563301', 'CO', 'Carlos', 'Cruz', NULL, 'Medina', '1974-09-11');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('66419315', 'EC', 'Jorge', 'Rodríguez', NULL, 'Herrera', '1959-09-27');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('79518752', 'VE', 'Catalina', 'González', NULL, 'Ramírez', '1963-04-06');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('29856655', 'CL', 'Sofía', 'Pérez', NULL, 'Martínez', '2003-11-11');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('15420136', 'PE', 'Fernanda', 'Rivera', NULL, 'Castro', '1995-07-02');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('21903576', 'AR', 'Valentina', 'Morales', NULL, 'Cruz', '1982-06-06');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('98761392', 'AR', 'Sebastián', 'Ramírez', NULL, 'Rivera', '1954-05-25');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('26429653', 'CO', 'Luis', 'Rodríguez', NULL, 'Torres', '1985-02-20');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('36018939', 'CL', 'Paola', 'Ramos', NULL, 'Ramírez', '1983-12-03');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('31028161', 'BR', 'Laura', 'Flores', NULL, 'Cruz', '1981-10-27');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('59532732', 'US', 'Sofía', 'Pérez', NULL, 'Castro', '1980-06-30');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('90003444', 'MX', 'Catalina', 'Torres', NULL, 'Mendoza', '1960-09-27');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('70571378', 'US', 'David', 'González', NULL, 'Martínez', '1974-09-03');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('49453084', 'CO', 'Isabella', 'Martínez', NULL, 'Torres', '1961-09-01');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('41896662', 'AR', 'Laura', 'Cruz', NULL, 'García', '1994-03-05');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('67696791', 'EC', 'Jorge', 'Flores', NULL, 'Álvarez', '1986-04-07');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('33342425', 'PE', 'Nicolás', 'García', NULL, 'Cruz', '1969-05-15');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('53725194', 'US', 'Alejandra', 'Jiménez', NULL, 'Suárez', '2010-02-14');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('12348712', 'CL', 'Valentina', 'González', NULL, 'Reyes', '1975-07-18');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('89257196', 'BR', 'Isabella', 'Herrera', NULL, 'González', '1982-03-08');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('74683425', 'CL', 'Juliana', 'Sánchez', NULL, 'García', '1988-03-19');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('32044652', 'CO', 'Fernanda', 'Cruz', NULL, 'Rodríguez', '1992-12-02');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('16751040', 'EC', 'Roberto', 'Cruz', NULL, 'Ortiz', '1983-01-18');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('20548786', 'VE', 'María', 'Pérez', NULL, 'Reyes', '2004-02-03');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('41940192', 'BR', 'Carlos', 'López', NULL, 'Ramírez', '1996-01-19');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('56300448', 'ES', 'Sandra', 'Ramos', NULL, 'Herrera', '1983-09-25');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('99560316', 'PE', 'Alejandra', 'González', NULL, 'Vargas', '1996-01-22');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('75978123', 'VE', 'Jorge', 'García', NULL, 'Pérez', '2002-11-04');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('33034395', 'BR', 'Miguel', 'Torres', NULL, 'Jiménez', '2001-05-13');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('76145997', 'CO', 'Valentina', 'Álvarez', NULL, 'Vargas', '2002-10-22');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('64044021', 'CO', 'Gabriela', 'Vargas', NULL, 'Ramos', '1994-07-17');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('11990737', 'AR', 'Isabella', 'Martínez', NULL, 'Castro', '1980-01-22');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('13518905', 'EC', 'Gabriela', 'Sánchez', NULL, 'Herrera', '2005-03-24');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('71832203', 'BR', 'Carolina', 'Pérez', NULL, 'Jiménez', '2003-04-03');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('32068284', 'BR', 'Alberto', 'López', NULL, 'Rivera', '1973-05-23');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('79650275', 'PE', 'Alberto', 'Morales', NULL, 'García', '1973-08-01');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('41963795', 'VE', 'Santiago', 'Mendoza', NULL, 'Jiménez', '1988-03-29');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('32493530', 'MX', 'Daniela', 'Vargas', NULL, 'Torres', '1962-05-27');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('82658694', 'MX', 'Isabella', 'Rivera', NULL, 'Mendoza', '2006-09-19');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('34447629', 'CL', 'Fernando', 'Cruz', NULL, 'Ortiz', '1959-01-02');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('61784641', 'BR', 'Sofía', 'Jiménez', NULL, 'Suárez', '2002-08-12');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('70264344', 'BR', 'Sandra', 'Molina', NULL, 'Ramírez', '2007-03-06');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('27412946', 'CO', 'Sofía', 'González', NULL, 'Mendoza', '1982-11-11');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('39318337', 'CL', 'Ricardo', 'Sánchez', NULL, 'Martínez', '1965-07-05');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('84188311', 'US', 'Santiago', 'Ramos', NULL, 'Pérez', '1991-07-22');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('18498926', 'EC', 'Nicolás', 'Cruz', NULL, 'Ramos', '1991-01-06');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('80732751', 'PE', 'Felipe', 'Reyes', NULL, 'Suárez', '1994-08-26');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('15968073', 'CO', 'Laura', 'Sánchez', NULL, 'Pérez', '1973-10-20');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('62928192', 'CL', 'Fernanda', 'Pérez', NULL, 'Ramírez', '1955-06-18');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('77090777', 'ES', 'Catalina', 'Sánchez', NULL, 'Reyes', '1958-05-04');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('65044235', 'PE', 'Jorge', 'Reyes', NULL, 'Molina', '1991-11-10');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('25560384', 'VE', 'Andrés', 'Suárez', NULL, 'Álvarez', '1960-02-11');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('35829473', 'ES', 'Pedro', 'Rodríguez', NULL, 'Flores', '1988-09-15');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('28070303', 'AR', 'Felipe', 'Medina', NULL, 'Reyes', '1963-06-21');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('97254175', 'CL', 'Santiago', 'González', NULL, 'Flores', '1959-08-09');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('59924941', 'AR', 'Daniela', 'Reyes', NULL, 'Álvarez', '1975-07-29');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('23076608', 'CL', 'Fernanda', 'Herrera', NULL, 'García', '2010-02-15');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('64839596', 'CO', 'Nicolás', 'Sánchez', NULL, 'Jiménez', '1990-08-21');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('26172749', 'US', 'Yolanda', 'Ramos', NULL, 'García', '2000-05-09');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('91465153', 'US', 'Felipe', 'Reyes', NULL, 'Álvarez', '1986-02-12');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('29986839', 'BR', 'Nicolás', 'Ortiz', NULL, 'Castro', '1957-01-30');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('52502178', 'VE', 'Felipe', 'Reyes', NULL, 'Molina', '1965-06-11');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('96976700', 'US', 'Gabriela', 'Ramos', NULL, 'Cruz', '1955-11-04');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('65643484', 'VE', 'Nicolás', 'Vargas', NULL, 'Reyes', '1984-04-16');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('39029091', 'EC', 'Claudia', 'Castro', NULL, 'López', '1993-07-05');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('99889840', 'CL', 'Felipe', 'Pérez', NULL, 'Sánchez', '2003-01-08');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('21948440', 'VE', 'Fernando', 'Herrera', NULL, 'Pérez', '1986-11-07');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('82142272', 'CO', 'Sandra', 'Martínez', NULL, 'Vargas', '1995-03-09');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('44901404', 'BR', 'Fernanda', 'Martínez', NULL, 'Herrera', '1977-04-14');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('67331056', 'AR', 'Ana', 'Ortiz', NULL, 'López', '1953-12-13');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('30359406', 'MX', 'María', 'Vargas', NULL, 'Jiménez', '1955-10-24');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('46721983', 'MX', 'Isabella', 'Sánchez', NULL, 'Molina', '1952-07-14');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('53815113', 'US', 'Carolina', 'Jiménez', NULL, 'López', '2005-11-07');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('55672278', 'AR', 'Marcela', 'Molina', NULL, 'Martínez', '2002-10-14');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('15971136', 'BR', 'Andrés', 'Morales', NULL, 'Ramírez', '1981-07-07');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('34015248', 'MX', 'Sandra', 'Jiménez', NULL, 'Medina', '1954-03-19');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('34077528', 'CO', 'Jorge', 'Ramírez', 'Pedro', NULL, '1967-07-28');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('98806672', 'CO', 'David', 'Flores', 'Luis', NULL, '1990-04-29');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('24554533', 'BR', 'Jorge', 'Martínez', 'David', NULL, '1988-12-28');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('38935675', 'ES', 'Daniela', 'Suárez', 'Paola', NULL, '1990-04-15');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('72393578', 'CL', 'David', 'Flores', 'Camilo', NULL, '1958-03-02');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('11547478', 'CO', 'Paola', 'Rivera', 'Carolina', NULL, '1952-06-14');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('10375217', 'CO', 'Daniela', 'Rodríguez', 'María', NULL, '2009-05-24');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('41648778', 'VE', 'Fernanda', 'Castro', 'Sandra', NULL, '1987-01-19');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('45112407', 'CO', 'Fernanda', 'Herrera', 'Claudia', NULL, '2006-02-14');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('32933935', 'MX', 'Luis', 'Suárez', 'Camilo', NULL, '1996-10-21');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('42800911', 'CO', 'Alberto', 'Suárez', 'Luis', NULL, '1983-11-07');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('80593346', 'VE', 'Juan', 'Suárez', 'Alejandro', NULL, '2007-05-10');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('23816907', 'ES', 'Marcela', 'González', 'Valentina', NULL, '1976-05-31');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('63417821', 'EC', 'Santiago', 'Herrera', 'Carlos', NULL, '2007-06-10');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('42292892', 'EC', 'Diana', 'Castro', 'Carolina', NULL, '2002-09-19');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('18964953', 'ES', 'Gabriela', 'Pérez', 'Laura', NULL, '1973-08-23');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('41088690', 'BR', 'Catalina', 'Ramírez', 'Daniela', NULL, '1998-05-22');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('30090581', 'MX', 'Isabella', 'García', 'Laura', NULL, '2007-09-19');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('91413687', 'US', 'Luis', 'Martínez', 'David', NULL, '1962-11-06');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('64227365', 'PE', 'María', 'Pérez', 'Alejandra', NULL, '1996-07-14');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('22111010', 'ES', 'Roberto', 'Rivera', 'Andrés', NULL, '1995-11-03');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('84617558', 'AR', 'Valentina', 'Herrera', 'Marcela', NULL, '1977-08-21');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('19379467', 'PE', 'María', 'Medina', 'Paola', NULL, '1964-07-17');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('62056495', 'US', 'David', 'Torres', 'Carlos', NULL, '2007-11-26');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('18913189', 'PE', 'Roberto', 'Rivera', 'Pedro', NULL, '1981-02-13');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('50639874', 'VE', 'Roberto', 'Reyes', 'Ricardo', NULL, '1967-11-03');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('39774445', 'CO', 'Isabella', 'Pérez', 'Carolina', NULL, '1975-08-11');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('75630349', 'VE', 'Nicolás', 'Torres', 'Camilo', NULL, '1964-07-10');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('50297070', 'PE', 'Alejandro', 'Jiménez', 'Ricardo', NULL, '1967-11-25');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('23444210', 'BR', 'Andrés', 'Castro', 'Sebastián', NULL, '1977-11-12');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('43318451', 'MX', 'Laura', 'Ramos', 'Catalina', NULL, '1970-12-06');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('45545064', 'US', 'Yolanda', 'Castro', 'Gabriela', NULL, '2004-11-20');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('92740956', 'BR', 'Camilo', 'Torres', 'Pedro', NULL, '2009-06-30');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('91373700', 'MX', 'Paola', 'Torres', NULL, NULL, '1969-03-19');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('77648431', 'VE', 'Luis', 'Rivera', NULL, NULL, '2007-12-03');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('30785082', 'US', 'Fernando', 'Castro', NULL, NULL, '2010-05-18');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('77239032', 'CL', 'Daniel', 'Morales', NULL, NULL, '1996-07-16');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('16374169', 'ES', 'Ricardo', 'Molina', NULL, NULL, '1995-07-10');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('84181946', 'MX', 'Yolanda', 'Castro', NULL, NULL, '2007-07-29');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('86895118', 'BR', 'Santiago', 'Martínez', NULL, NULL, '1983-12-10');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('58885275', 'VE', 'Marcela', 'Torres', NULL, NULL, '1968-11-09');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('59138468', 'EC', 'Diana', 'Sánchez', NULL, NULL, '2005-07-26');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('72312114', 'PE', 'Nicolás', 'Pérez', NULL, NULL, '1978-10-14');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('58746103', 'ES', 'Daniel', 'López', NULL, NULL, '1986-05-20');
INSERT INTO public.guests (guest_doc, country_id, fname, fsurname, mname, ssurname, date_birth) VALUES ('40476715', 'CO', 'Juan', 'Martínez', NULL, NULL, '2003-06-21');


--
-- TOC entry 4230 (class 0 OID 17784)
-- Dependencies: 217
-- Data for Name: hotels; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.hotels (hotel_id, location, name, phone_number, email) VALUES ('H1', 'Ocaña, Norte de Santander, Colombia', 'Hotel Alemana', '3175551001', 'alemana@hotel.com');
INSERT INTO public.hotels (hotel_id, location, name, phone_number, email) VALUES ('H2', 'Bogotá, Cundinamarca, Colombia', 'Hotel Capital Grande', '3175551002', 'capitalgr@hotel.com');
INSERT INTO public.hotels (hotel_id, location, name, phone_number, email) VALUES ('H3', 'Medellín, Antioquia, Colombia', 'Hotel Montaña Verde', '3175551003', 'montanaverde@hotel.com');
INSERT INTO public.hotels (hotel_id, location, name, phone_number, email) VALUES ('H4', 'Cali, Valle del Cauca, Colombia', 'Hotel Valle del Sol', '3175551004', 'valledelsol@hotel.com');
INSERT INTO public.hotels (hotel_id, location, name, phone_number, email) VALUES ('H5', 'Cartagena, Bolívar, Colombia', 'Hotel Mar Caribe', '3175551005', 'marcaribe@hotel.com');


--
-- TOC entry 4251 (class 0 OID 18604)
-- Dependencies: 238
-- Data for Name: invoice_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (1, 1, 84149.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (2, 1, 120050.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (3, 1, 54357.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (4, 1, 127607.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (5, 2, 314276.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (6, 2, 48137.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (7, 2, 148054.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (8, 3, 117961.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (9, 3, 217443.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (10, 4, 148616.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (11, 4, 178729.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (12, 4, 388062.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (13, 4, 148508.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (14, 5, 158766.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (15, 5, 115040.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (16, 6, 311754.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (17, 6, 211833.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (18, 7, 114773.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (19, 7, 60163.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (20, 8, 100200.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (21, 8, 91815.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (22, 8, 157258.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (23, 8, 240495.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (24, 9, 64375.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (25, 9, 231290.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (26, 10, 337210.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (27, 10, 124797.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (28, 11, 240125.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (29, 11, 252063.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (30, 11, 278225.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (31, 11, 109243.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (32, 12, 355483.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (33, 12, 93158.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (34, 13, 309469.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (35, 13, 195363.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (36, 13, 171810.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (37, 13, 130166.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (38, 14, 35207.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (39, 14, 79328.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (40, 14, 140039.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (41, 15, 261534.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (42, 15, 340000.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (43, 15, 364344.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (44, 15, 166801.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (45, 16, 315871.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (46, 16, 163364.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (47, 16, 397217.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (48, 16, 87389.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (49, 17, 362423.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (50, 17, 331245.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (51, 17, 139560.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (52, 18, 59968.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (53, 18, 208411.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (54, 18, 314636.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (55, 18, 257169.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (56, 19, 313894.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (57, 19, 198107.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (58, 20, 238613.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (59, 20, 95708.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (60, 20, 118228.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (61, 21, 321215.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (62, 21, 120499.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (63, 22, 377963.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (64, 22, 118081.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (65, 22, 264473.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (66, 22, 319653.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (67, 23, 173406.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (68, 23, 180718.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (69, 24, 248893.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (70, 24, 119255.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (71, 24, 50844.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (72, 24, 244910.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (73, 25, 127051.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (74, 25, 280197.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (75, 26, 74251.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (76, 26, 145136.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (77, 26, 224372.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (78, 26, 312456.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (79, 27, 146493.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (80, 27, 33035.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (81, 27, 250133.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (82, 27, 307283.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (83, 28, 389183.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (84, 28, 58779.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (85, 29, 215591.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (86, 29, 37720.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (87, 29, 200689.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (88, 29, 272760.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (89, 30, 146880.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (90, 30, 137786.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (91, 31, 78839.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (92, 31, 187113.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (93, 31, 134883.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (94, 32, 123678.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (95, 32, 276346.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (96, 32, 304390.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (97, 33, 183258.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (98, 33, 356985.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (99, 33, 175460.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (100, 33, 66417.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (101, 34, 352697.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (102, 34, 128978.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (103, 34, 187170.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (104, 34, 51588.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (105, 35, 290157.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (106, 35, 144831.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (107, 36, 265214.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (108, 36, 35651.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (109, 36, 218185.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (110, 37, 327701.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (111, 37, 177258.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (112, 37, 120679.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (113, 37, 300384.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (114, 38, 292594.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (115, 38, 358110.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (116, 39, 198446.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (117, 39, 346358.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (118, 40, 382301.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (119, 40, 56167.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (120, 40, 286234.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (121, 41, 174602.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (122, 41, 269618.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (123, 41, 237712.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (124, 42, 98877.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (125, 42, 152599.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (126, 42, 320168.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (127, 43, 47594.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (128, 43, 108198.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (129, 43, 279234.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (130, 43, 332443.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (131, 44, 324701.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (132, 44, 40713.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (133, 44, 153830.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (134, 44, 245952.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (135, 45, 252720.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (136, 45, 296965.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (137, 45, 140768.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (138, 46, 93041.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (139, 46, 101114.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (140, 46, 126159.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (141, 46, 245121.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (142, 47, 296382.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (143, 47, 255919.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (144, 47, 144310.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (145, 48, 247427.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (146, 48, 189740.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (147, 48, 395101.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (148, 48, 393645.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (149, 49, 199163.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (150, 49, 381663.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (151, 49, 329369.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (152, 49, 102875.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (153, 50, 70763.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (154, 50, 240487.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (155, 50, 45592.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (156, 50, 234867.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (157, 51, 278809.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (158, 51, 334200.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (159, 52, 287183.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (160, 52, 324572.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (161, 53, 33185.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (162, 53, 251715.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (163, 53, 350206.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (164, 53, 119976.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (165, 54, 310788.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (166, 54, 75664.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (167, 54, 201355.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (168, 54, 390231.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (169, 55, 265741.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (170, 55, 229429.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (171, 55, 124179.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (172, 56, 348378.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (173, 56, 115147.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (174, 56, 151634.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (175, 57, 385621.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (176, 57, 274270.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (177, 57, 88534.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (178, 57, 277189.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (179, 58, 385362.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (180, 58, 210218.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (181, 59, 375070.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (182, 59, 372910.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (183, 59, 78839.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (184, 59, 30772.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (185, 60, 246146.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (186, 60, 52298.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (187, 61, 301361.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (188, 61, 268163.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (189, 62, 371459.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (190, 62, 186839.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (191, 63, 333800.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (192, 63, 326194.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (193, 63, 366375.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (194, 63, 361007.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (195, 64, 344489.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (196, 64, 87765.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (197, 65, 308073.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (198, 65, 38778.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (199, 66, 382593.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (200, 66, 177120.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (201, 67, 162687.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (202, 67, 303636.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (203, 67, 33077.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (204, 67, 123660.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (205, 68, 243816.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (206, 68, 39734.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (207, 69, 319050.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (208, 69, 328779.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (209, 70, 183954.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (210, 70, 226834.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (211, 71, 164134.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (212, 71, 71502.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (213, 71, 260485.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (214, 72, 316672.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (215, 72, 92315.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (216, 72, 328820.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (217, 72, 291311.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (218, 73, 151016.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (219, 73, 50153.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (220, 74, 225471.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (221, 74, 192745.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (222, 75, 347106.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (223, 75, 232874.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (224, 76, 68100.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (225, 76, 328422.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (226, 76, 244004.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (227, 77, 317394.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (228, 77, 142898.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (229, 77, 319850.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (230, 77, 239619.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (231, 78, 36478.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (232, 78, 93658.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (233, 78, 163592.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (234, 79, 134932.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (235, 79, 306761.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (236, 79, 344305.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (237, 80, 185970.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (238, 80, 372030.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (239, 80, 239136.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (240, 81, 144151.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (241, 81, 91975.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (242, 82, 276455.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (243, 82, 47391.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (244, 82, 351334.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (245, 82, 257949.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (246, 83, 185635.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (247, 83, 202756.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (248, 84, 328963.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (249, 84, 253674.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (250, 85, 327997.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (251, 85, 47802.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (252, 86, 158977.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (253, 86, 265179.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (254, 86, 244167.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (255, 87, 366569.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (256, 87, 33527.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (257, 87, 159975.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (258, 87, 287295.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (259, 88, 376279.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (260, 88, 195543.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (261, 88, 80820.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (262, 89, 290219.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (263, 89, 62563.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (264, 90, 356114.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (265, 90, 343325.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (266, 90, 339742.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (267, 91, 126389.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (268, 91, 192796.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (269, 91, 265171.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (270, 92, 310255.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (271, 92, 97460.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (272, 92, 195262.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (273, 92, 32693.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (274, 93, 322218.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (275, 93, 77095.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (276, 93, 394420.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (277, 93, 374672.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (278, 94, 130970.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (279, 94, 49419.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (280, 94, 68469.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (281, 95, 71446.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (282, 95, 198275.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (283, 95, 166614.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (284, 95, 354615.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (285, 96, 277880.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (286, 96, 56517.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (287, 96, 35928.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (288, 97, 39633.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (289, 97, 346778.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (290, 97, 108439.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (291, 98, 50922.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (292, 98, 299348.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (293, 99, 41031.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (294, 99, 310063.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (295, 99, 36526.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (296, 99, 235385.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (297, 100, 344736.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (298, 100, 136809.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (299, 100, 209592.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (300, 100, 99285.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (301, 101, 295933.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (302, 101, 256493.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (303, 101, 52319.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (304, 101, 347256.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (305, 102, 396630.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (306, 102, 78578.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (307, 102, 393203.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (308, 102, 146579.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (309, 103, 311602.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (310, 103, 320216.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (311, 103, 324061.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (312, 104, 341426.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (313, 104, 46959.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (314, 105, 385530.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (315, 105, 279586.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (316, 105, 172940.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (317, 106, 385937.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (318, 106, 365844.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (319, 106, 71905.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (320, 106, 63304.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (321, 107, 250842.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (322, 107, 233154.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (323, 107, 99347.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (324, 108, 102282.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (325, 108, 68625.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (326, 109, 143289.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (327, 109, 301023.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (328, 110, 155150.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (329, 110, 34384.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (330, 110, 53077.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (331, 111, 338159.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (332, 111, 35740.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (333, 111, 337569.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (334, 111, 340569.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (335, 112, 348929.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (336, 112, 207716.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (337, 113, 222239.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (338, 113, 88779.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (339, 113, 370403.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (340, 113, 235742.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (341, 114, 184809.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (342, 114, 165155.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (343, 114, 360387.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (344, 115, 177595.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (345, 115, 202688.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (346, 115, 299376.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (347, 115, 95198.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (348, 116, 140814.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (349, 116, 178368.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (350, 116, 238738.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (351, 116, 112260.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (352, 117, 195096.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (353, 117, 229169.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (354, 118, 45982.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (355, 118, 35497.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (356, 118, 265357.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (357, 119, 221874.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (358, 119, 221452.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (359, 120, 362822.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (360, 120, 251857.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (361, 120, 79225.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (362, 120, 251903.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (363, 121, 188451.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (364, 121, 139675.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (365, 121, 339712.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (366, 122, 221557.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (367, 122, 80894.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (368, 122, 394063.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (369, 123, 305100.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (370, 123, 308668.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (371, 123, 257922.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (372, 123, 242135.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (373, 124, 198961.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (374, 124, 289468.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (375, 125, 275737.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (376, 125, 127378.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (377, 125, 393889.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (378, 125, 278537.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (379, 126, 115953.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (380, 126, 346392.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (381, 127, 346514.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (382, 127, 141516.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (383, 127, 140275.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (384, 127, 242269.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (385, 128, 271271.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (386, 128, 353649.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (387, 128, 372224.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (388, 129, 147353.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (389, 129, 207286.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (390, 130, 391098.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (391, 130, 64214.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (392, 130, 353405.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (393, 131, 289335.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (394, 131, 347010.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (395, 131, 305393.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (396, 132, 391781.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (397, 132, 96499.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (398, 132, 60187.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (399, 133, 45442.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (400, 133, 236227.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (401, 134, 288349.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (402, 134, 275072.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (403, 135, 238889.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (404, 135, 186624.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (405, 136, 228417.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (406, 136, 205666.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (407, 137, 49709.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (408, 137, 185981.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (409, 138, 222321.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (410, 138, 117558.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (411, 138, 267734.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (412, 139, 158508.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (413, 139, 130091.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (414, 140, 330771.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (415, 140, 170124.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (416, 140, 341957.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (417, 141, 283967.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (418, 141, 313998.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (419, 141, 343606.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (420, 141, 165102.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (421, 142, 194407.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (422, 142, 177899.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (423, 142, 398155.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (424, 143, 146618.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (425, 143, 164878.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (426, 143, 83178.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (427, 143, 82871.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (428, 144, 181160.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (429, 144, 207961.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (430, 144, 161846.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (431, 144, 32141.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (432, 145, 398678.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (433, 145, 290942.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (434, 145, 120505.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (435, 145, 208786.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (436, 146, 104104.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (437, 146, 137494.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (438, 146, 305701.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (439, 146, 370227.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (440, 147, 231546.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (441, 147, 134820.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (442, 148, 311270.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (443, 148, 235214.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (444, 148, 386226.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (445, 148, 300172.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (446, 149, 313942.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (447, 149, 31943.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (448, 149, 263189.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (449, 149, 135555.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (450, 150, 231426.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (451, 150, 99420.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (452, 151, 295587.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (453, 151, 175638.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (454, 151, 291757.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (455, 151, 238979.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (456, 152, 255943.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (457, 152, 32999.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (458, 152, 57421.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (459, 153, 60141.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (460, 153, 67377.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (461, 153, 230600.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (462, 153, 163879.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (463, 154, 338663.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (464, 154, 277626.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (465, 154, 32589.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (466, 154, 135757.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (467, 155, 276390.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (468, 155, 63304.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (469, 155, 40422.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (470, 156, 367110.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (471, 156, 61857.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (472, 156, 53709.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (473, 156, 55433.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (474, 157, 171093.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (475, 157, 36352.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (476, 158, 100741.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (477, 158, 206493.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (478, 158, 321104.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (479, 159, 186669.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (480, 159, 52144.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (481, 160, 198751.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (482, 160, 365659.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (483, 160, 330436.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (484, 160, 384854.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (485, 161, 118387.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (486, 161, 161583.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (487, 162, 204128.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (488, 162, 176992.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (489, 163, 80525.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (490, 163, 260696.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (491, 164, 89600.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (492, 164, 64966.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (493, 164, 253011.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (494, 165, 97704.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (495, 165, 197772.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (496, 165, 237844.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (497, 165, 174941.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (498, 166, 46320.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (499, 166, 317643.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (500, 166, 356479.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (501, 167, 262496.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (502, 167, 396893.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (503, 168, 224788.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (504, 168, 307679.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (505, 169, 208198.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (506, 169, 193792.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (507, 169, 356556.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (508, 170, 105713.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (509, 170, 372760.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (510, 170, 92414.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (511, 170, 357508.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (512, 171, 330526.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (513, 171, 48828.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (514, 171, 195862.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (515, 171, 314244.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (516, 172, 166047.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (517, 172, 358791.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (518, 172, 250578.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (519, 172, 194605.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (520, 173, 299582.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (521, 173, 214938.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (522, 173, 63974.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (523, 174, 358826.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (524, 174, 117895.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (525, 174, 318320.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (526, 174, 295042.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (527, 175, 38857.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (528, 175, 238977.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (529, 176, 361138.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (530, 176, 44605.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (531, 177, 304199.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (532, 177, 373756.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (533, 177, 297776.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (534, 177, 43921.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (535, 178, 99182.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (536, 178, 282207.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (537, 178, 339057.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (538, 178, 105486.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (539, 179, 376739.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (540, 179, 348490.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (541, 179, 54232.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (542, 180, 352009.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (543, 180, 301877.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (544, 180, 130143.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (545, 180, 215762.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (546, 181, 144305.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (547, 181, 199295.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (548, 181, 208396.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (549, 181, 387221.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (550, 182, 353940.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (551, 182, 384157.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (552, 182, 300835.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (553, 183, 139700.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (554, 183, 70029.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (555, 183, 63497.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (556, 183, 283439.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (557, 184, 240027.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (558, 184, 262767.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (559, 185, 259591.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (560, 185, 353962.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (561, 185, 311923.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (562, 185, 104513.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (563, 186, 246013.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (564, 186, 331206.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (565, 186, 42970.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (566, 187, 100628.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (567, 187, 197404.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (568, 188, 221916.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (569, 188, 113973.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (570, 188, 398732.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (571, 189, 139249.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (572, 189, 101672.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (573, 189, 76519.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (574, 189, 323187.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (575, 190, 227087.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (576, 190, 66161.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (577, 191, 274613.00, 'Servicio de restaurante');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (578, 191, 187229.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (579, 192, 361449.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (580, 192, 217032.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (581, 192, 178601.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (582, 193, 206512.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (583, 193, 114704.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (584, 194, 180302.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (585, 194, 149499.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (586, 194, 173370.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (587, 194, 232691.00, 'Habitación sencilla');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (588, 195, 43542.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (589, 195, 340111.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (590, 195, 311025.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (591, 196, 45503.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (592, 196, 368590.00, 'Room service');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (593, 196, 231573.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (594, 197, 344459.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (595, 197, 247835.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (596, 198, 175691.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (597, 198, 46814.00, 'Suite');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (598, 199, 50771.00, 'Habitación doble');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (599, 199, 139448.00, 'Spa');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (600, 199, 251971.00, 'Desayuno incluido');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (601, 199, 145714.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (602, 200, 67836.00, 'Minibar');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (603, 200, 108496.00, 'Lavandería');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (604, 200, 174744.00, 'Estacionamiento');
INSERT INTO public.invoice_details (line_number, invoice_id, amount, description) VALUES (605, 200, 93070.00, 'Lavandería');


--
-- TOC entry 4249 (class 0 OID 18576)
-- Dependencies: 236
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (1, 256, '16104857', '35443261', 'TC', '2021-12-07 10:14:42', 143522.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (2, 174, '91181404', '81104791', 'TD', '2021-05-24 18:38:57', 549534.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (3, 177, '37634396', '40265633', 'TD', '2022-03-30 08:10:23', 553551.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (4, 131, '76354180', '22957438', 'TD', '2021-02-28 08:21:52', 844964.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (5, 82, '53328415', '90658619', 'PP', '2022-11-16 17:29:37', 547346.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (6, 224, '62719526', '51672868', 'TR', '2024-03-08 09:20:32', 392279.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (7, 40, '35758531', '49413474', 'TC', '2023-05-19 11:43:24', 406793.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (8, 15, '62904575', '22364660', 'PP', '2025-11-04 08:41:27', 973807.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (9, 124, '50814428', '35070625', 'TR', '2023-05-23 20:46:50', 697999.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (10, 270, '69562350', '12351359', 'EF', '2023-11-15 09:56:02', 526035.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (11, 133, '88100019', '24645711', 'TC', '2023-04-29 20:20:08', 309452.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (12, 76, '61427803', '86704340', 'TD', '2022-12-26 09:24:59', 953408.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (13, 93, '37566472', '65875235', 'EF', '2025-03-23 07:08:25', 59457.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (14, 245, '94292753', '38692049', 'EF', '2022-06-19 09:27:46', 692041.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (15, 108, '22097496', '46499378', 'EF', '2026-01-26 09:07:46', 778123.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (16, 207, '41097470', '99393218', 'TD', '2022-02-17 06:35:49', 677065.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (17, 67, '85647532', '46675397', 'TD', '2021-08-09 07:05:53', 1113139.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (18, 234, '22113193', '57910133', 'PP', '2021-07-03 11:28:17', 1051771.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (19, 106, '72394301', '17129557', 'TD', '2025-09-29 15:09:35', 703459.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (20, 288, '74359847', '25581274', 'TC', '2021-09-18 11:22:59', 998362.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (21, 31, '21571285', '14533608', 'TD', '2025-07-20 10:15:44', 932724.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (22, 91, '73018412', '30626125', 'EF', '2022-06-30 10:23:25', 272905.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (23, 90, '48352498', '14543241', 'TC', '2022-03-25 17:59:44', 176659.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (24, 289, '21449650', '17014171', 'PP', '2025-12-26 10:00:24', 174001.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (25, 247, '28566572', '61917499', 'TD', '2023-08-09 14:43:07', 160342.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (26, 53, '94639988', '96223229', 'EF', '2021-01-26 08:50:16', 535698.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (27, 55, '70394554', '50754622', 'TC', '2021-02-14 16:32:58', 724696.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (28, 39, '80157128', '15759135', 'EF', '2023-07-24 07:40:27', 771866.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (29, 238, '64402540', '12603460', 'TC', '2022-12-29 17:33:32', 969823.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (30, 190, '49945150', '66711004', 'TR', '2024-12-03 11:23:36', 289019.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (31, 251, '69786268', '73459898', 'EF', '2025-05-13 19:26:34', -23931.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (32, 219, '73672398', '51763267', 'TD', '2026-04-11 10:46:13', 753362.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (33, 62, '56637316', '22292455', 'EF', '2022-05-09 18:25:54', 834976.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (34, 252, '27286109', '55265544', 'EF', '2021-09-11 20:26:08', 1075641.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (35, 274, '29081953', '28222781', 'TC', '2023-05-17 15:41:59', 1083854.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (36, 217, '31831387', '72226540', 'TD', '2024-10-20 06:51:31', 461819.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (37, 85, '32799095', '54310874', 'TD', '2022-08-03 10:22:38', 572686.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (38, 30, '45351739', '44606236', 'EF', '2025-06-23 08:28:35', 175350.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (39, 151, '65354876', '12351359', 'TC', '2026-05-23 20:58:50', 291617.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (40, 81, '86536905', '24276138', 'PP', '2025-02-09 07:41:44', 562158.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (41, 191, '86242300', '70895423', 'TD', '2025-09-25 10:05:27', 565838.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (42, 59, '22510327', '70345934', 'TR', '2023-08-01 17:19:29', 836944.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (43, 148, '13684342', '71649116', 'EF', '2026-11-08 15:54:27', 831749.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (44, 138, '82374753', '61347982', 'TD', '2026-08-21 11:32:00', 851542.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (45, 285, '58884978', '27677427', 'EF', '2022-08-16 11:56:51', 427927.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (46, 258, '58347193', '25133395', 'TR', '2024-08-29 08:38:05', 592478.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (47, 142, '91468625', '43837801', 'TD', '2021-09-20 06:36:32', 220461.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (48, 60, '52107027', '27172930', 'PP', '2024-04-15 09:23:14', 197917.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (49, 9, '66506603', '68606209', 'TR', '2026-06-11 06:51:48', 988451.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (50, 96, '21727533', '14187584', 'EF', '2025-08-05 07:51:11', 500212.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (51, 45, '31386576', '91090807', 'EF', '2025-12-13 07:02:48', 993514.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (52, 241, '70394554', '68504671', 'PP', '2025-10-02 06:58:48', 117965.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (53, 27, '82634888', '51403708', 'TC', '2021-08-23 17:53:22', 589434.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (54, 214, '11516293', '55961908', 'TC', '2026-12-23 06:00:18', 213348.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (55, 109, '83948598', '63964665', 'EF', '2025-11-09 10:43:25', 741977.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (56, 287, '98917575', '55265544', 'PP', '2021-07-08 20:03:54', 1071046.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (57, 149, '69332039', '53684898', 'TD', '2026-03-17 16:16:37', 664552.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (58, 3, '18434795', '19470140', 'TR', '2023-12-06 09:33:05', 740427.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (59, 54, '54440977', '98816127', 'EF', '2023-10-25 06:08:59', 746107.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (60, 150, '88662295', '13155879', 'EF', '2021-11-03 10:02:19', 339993.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (61, 220, '25903904', '15976158', 'TC', '2026-10-04 09:18:25', 115195.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (62, 300, '99904987', '14574615', 'PP', '2024-10-08 08:19:31', 397297.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (63, 46, '27286109', '66112969', 'EF', '2025-09-17 06:32:39', 1109747.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (64, 48, '14968688', '24645711', 'TR', '2025-12-17 07:39:00', 104576.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (65, 8, '14968366', '15190410', 'TR', '2021-10-13 06:24:49', 971901.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (66, 231, '70939515', '24790683', 'TR', '2022-08-04 19:41:34', 69157.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (67, 47, '78886959', '26730148', 'PP', '2026-04-05 07:47:56', 750032.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (68, 192, '65288255', '77255871', 'TC', '2026-07-11 06:01:00', 775489.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (69, 282, '54099326', '33362909', 'TC', '2022-01-05 09:04:36', 1111605.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (70, 146, '70004467', '14051460', 'TC', '2024-01-01 20:08:40', 740044.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (71, 204, '78515906', '79318932', 'EF', '2022-12-24 08:19:23', 888051.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (72, 141, '48133464', '67919082', 'EF', '2026-05-20 06:23:51', 609758.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (73, 4, '32462726', '63183240', 'TD', '2022-04-12 09:37:39', 938998.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (74, 25, '20048242', '76372099', 'PP', '2025-02-07 08:47:24', 1005119.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (75, 69, '97074691', '74114251', 'TC', '2021-05-12 10:17:45', 232881.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (76, 237, '67795113', '73459898', 'PP', '2024-08-01 11:34:15', 420135.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (77, 299, '48352498', '47369085', 'TR', '2026-11-05 17:32:03', 373632.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (78, 102, '82905989', '32048771', 'TR', '2022-07-10 10:47:19', 995689.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (79, 226, '52894344', '29780540', 'PP', '2022-02-18 08:16:32', 577368.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (80, 127, '24923247', '99393218', 'TR', '2021-02-04 08:50:21', 170643.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (81, 213, '37187070', '62430988', 'TD', '2023-10-16 11:29:37', 625694.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (82, 20, '95623471', '80259009', 'PP', '2022-11-22 16:53:07', 1189571.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (83, 16, '61973818', '85330101', 'TD', '2026-12-24 07:20:29', 285059.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (84, 246, '57725656', '38290431', 'EF', '2023-04-29 06:04:59', 533047.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (85, 140, '74743230', '51820248', 'PP', '2025-07-25 16:03:34', 597396.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (86, 7, '99904987', '21123747', 'TC', '2024-12-03 14:43:27', 159046.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (87, 19, '22097496', '66047853', 'TR', '2022-11-30 11:52:05', 798782.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (88, 116, '99927658', '41624005', 'TD', '2026-04-10 06:36:23', 622988.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (89, 119, '14164775', '61926784', 'TR', '2026-03-28 11:52:30', 1189910.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (90, 195, '82634888', '95108432', 'PP', '2022-12-22 14:51:20', 526100.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (91, 5, '62227199', '74254637', 'TC', '2021-04-08 06:02:17', 540333.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (92, 56, '48612439', '87186069', 'TD', '2021-08-16 11:57:02', 1134697.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (93, 239, '23898777', '39915787', 'EF', '2026-01-18 07:31:46', 249511.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (94, 21, '18830219', '49413474', 'PP', '2023-06-30 15:26:41', 877949.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (95, 103, '25660291', '60442020', 'PP', '2023-10-06 14:39:32', 153052.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (96, 50, '32978251', '41501680', 'TC', '2021-11-28 11:47:38', 345310.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (97, 115, '33002714', '51025192', 'TD', '2021-10-04 07:34:49', 818851.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (98, 200, '93940940', '20664018', 'EF', '2024-07-20 18:59:57', 488317.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (99, 11, '13750602', '11238177', 'PP', '2023-11-18 09:44:19', 787477.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (100, 88, '67611469', '95178684', 'EF', '2026-08-12 11:15:13', 951398.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (101, 176, '19255216', '97688458', 'PP', '2023-01-11 20:14:27', 1132353.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (102, 243, '76974557', '94530413', 'PP', '2026-03-02 11:50:24', 502714.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (103, 267, '32329103', '91358784', 'TC', '2021-02-19 11:21:57', 917464.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (104, 75, '57040785', '55371664', 'TR', '2026-03-03 14:51:41', 655348.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (105, 249, '75345452', '76595544', 'TC', '2022-11-04 19:42:59', 187936.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (106, 51, '67016371', '67919082', 'TD', '2026-01-30 10:59:43', 957152.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (107, 242, '73672398', '45276100', 'PP', '2022-10-23 20:03:05', 660847.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (108, 225, '85647532', '70354107', 'TD', '2023-04-29 09:29:46', 938375.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (109, 232, '59044830', '16832563', 'TC', '2025-08-18 09:15:12', 884272.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (110, 118, '62191530', '66269326', 'EF', '2021-07-22 15:29:18', 974958.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (111, 283, '75965276', '66276356', 'EF', '2021-11-16 20:18:27', 1049541.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (112, 65, '67795113', '14051460', 'TC', '2023-03-11 15:36:25', 210424.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (113, 72, '69175071', '91358784', 'TR', '2024-12-22 20:08:11', 828100.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (114, 97, '60882459', '21123747', 'TR', '2024-06-27 07:57:00', 240173.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (115, 255, '69633763', '57597933', 'EF', '2026-10-13 11:53:47', 819039.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (116, 58, '30776478', '82085863', 'EF', '2026-06-29 10:52:00', 966399.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (117, 29, '10551617', '82425578', 'TC', '2025-09-11 20:04:21', 358679.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (118, 113, '85500790', '48888385', 'EF', '2023-10-05 16:11:25', 1030801.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (119, 41, '22113193', '36481124', 'TR', '2022-06-30 10:21:56', 183628.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (120, 145, '42194159', '40419133', 'TC', '2024-04-27 09:04:46', 159160.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (121, 188, '14159837', '18870325', 'TR', '2022-04-02 11:51:04', 279684.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (122, 114, '27036337', '70845390', 'PP', '2026-07-12 07:25:47', 706475.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (123, 111, '24670297', '76331270', 'TD', '2025-02-10 17:32:29', 1115182.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (124, 268, '27927298', '63609010', 'TD', '2025-05-01 07:09:53', 964414.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (125, 143, '89426041', '97069298', 'TR', '2021-07-11 07:51:30', 880447.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (126, 2, '82468141', '54971462', 'TC', '2021-10-16 08:57:31', -37461.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (127, 139, '87170132', '91241436', 'TC', '2022-12-20 18:44:03', 605111.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (128, 57, '54927535', '96223229', 'TC', '2022-03-25 07:48:27', 429700.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (129, 181, '54927535', '67917038', 'TR', '2025-12-30 08:19:23', 1142787.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (130, 198, '66390708', '30808715', 'TC', '2025-02-18 08:59:32', 532438.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (131, 223, '94019376', '17014171', 'PP', '2022-04-19 08:42:36', 734896.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (132, 84, '47101128', '32917330', 'TR', '2021-06-18 06:32:39', 844994.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (133, 284, '38859601', '12603460', 'PP', '2025-04-24 17:28:12', 295626.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (134, 218, '33002714', '84208202', 'TC', '2026-03-19 11:01:50', 486515.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (135, 182, '78886959', '52253072', 'EF', '2025-12-25 06:25:07', 818572.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (136, 278, '93303777', '52314652', 'EF', '2023-01-27 07:25:33', 484813.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (137, 158, '51701149', '56931572', 'PP', '2026-05-28 09:57:52', 788028.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (138, 157, '33068427', '88327265', 'TD', '2026-08-11 08:28:55', -11198.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (139, 229, '15047559', '81104791', 'PP', '2022-01-08 18:56:35', 105075.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (140, 169, '92788091', '44026103', 'TR', '2026-02-06 06:23:34', 650234.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (141, 28, '63769608', '53674052', 'EF', '2026-10-20 17:17:48', 506317.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (142, 155, '69332039', '61133053', 'TR', '2026-11-14 20:31:36', 122103.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (143, 173, '27307598', '78797888', 'TR', '2022-03-09 10:22:24', 772012.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (144, 159, '69010948', '44110350', 'PP', '2021-06-18 11:16:48', 106510.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (145, 185, '64504816', '62132821', 'TR', '2022-10-30 06:21:12', 492567.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (146, 33, '77767769', '41074206', 'PP', '2025-09-14 14:35:11', 1181159.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (147, 212, '72394301', '27172930', 'PP', '2024-09-24 16:11:08', 758432.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (148, 166, '48759467', '63183240', 'TR', '2026-10-22 11:30:51', 741618.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (149, 221, '48674340', '53488444', 'PP', '2024-04-08 10:04:34', 614845.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (150, 271, '97577092', '24790683', 'EF', '2022-08-02 09:58:20', 174474.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (151, 295, '91390501', '18718672', 'TD', '2026-08-19 20:15:56', 897275.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (152, 23, '27286109', '82240647', 'TR', '2022-05-11 10:41:57', 888333.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (153, 153, '70315326', '25468478', 'TD', '2022-05-30 07:04:34', 920160.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (154, 147, '70887034', '22957438', 'TC', '2023-02-05 16:10:17', 688313.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (155, 280, '14270425', '52441605', 'PP', '2025-04-30 14:09:57', 1042968.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (156, 100, '24270328', '57562437', 'EF', '2022-04-19 10:37:06', 775578.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (157, 164, '29693143', '10280147', 'TC', '2023-02-05 07:08:49', 113746.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (158, 165, '16994436', '93011005', 'EF', '2024-10-21 15:04:28', 1047469.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (159, 13, '19208698', '74926313', 'TD', '2023-09-27 08:07:47', 866296.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (160, 77, '95623471', '60442020', 'TR', '2025-01-08 19:51:16', 1182098.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (161, 110, '72753631', '43644452', 'PP', '2026-08-10 14:44:03', 244701.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (162, 167, '34272734', '62908270', 'TC', '2025-11-04 09:30:18', 338792.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (163, 163, '37187070', '74843897', 'TR', '2022-01-21 19:38:26', 550996.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (164, 178, '31573890', '42120359', 'PP', '2023-11-09 08:38:02', 1016007.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (165, 286, '15070029', '53828083', 'TC', '2025-09-25 07:27:57', 572506.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (166, 240, '65506990', '22292455', 'TC', '2022-03-28 18:40:38', 463157.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (167, 170, '67795113', '14987687', 'TR', '2025-04-18 18:27:56', 1157819.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (168, 264, '11889398', '37637454', 'TC', '2026-12-15 06:24:55', 398028.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (169, 44, '67186360', '87748344', 'PP', '2022-07-15 10:05:57', 463694.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (170, 117, '89885300', '25944033', 'TR', '2022-08-24 10:46:20', 470366.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (171, 43, '74142265', '43836123', 'EF', '2022-08-30 10:10:59', 467727.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (172, 78, '19255216', '65777619', 'TD', '2025-06-15 08:18:19', 1077305.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (173, 92, '48605090', '22507696', 'EF', '2026-04-18 06:48:13', 183448.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (174, 126, '43685164', '60661928', 'PP', '2025-11-08 06:52:53', 784388.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (175, 248, '48612439', '53684898', 'TR', '2025-01-12 06:10:11', 1011981.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (176, 277, '21257528', '11432428', 'PP', '2021-04-03 19:11:23', 787074.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (177, 63, '86242300', '61147669', 'PP', '2025-11-28 07:27:35', 359229.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (178, 34, '27232410', '66524541', 'TR', '2021-08-21 07:59:49', 226856.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (179, 80, '49258091', '88446018', 'TC', '2025-12-06 10:40:35', 526509.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (180, 291, '99601933', '34714856', 'EF', '2023-08-24 19:16:08', 982320.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (181, 261, '18135295', '74339388', 'TR', '2021-03-29 09:12:27', 445191.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (182, 125, '23180503', '24276138', 'TD', '2021-09-26 10:45:34', 216292.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (183, 193, '74359847', '26575085', 'TD', '2023-09-18 15:50:04', 243768.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (184, 199, '14949636', '51820248', 'TC', '2023-01-26 07:09:55', 425679.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (185, 156, '28762704', '42447383', 'PP', '2021-10-26 16:44:04', 106547.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (186, 281, '18373492', '86414081', 'TD', '2025-05-30 06:53:00', 849019.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (187, 1, '13743496', '31800123', 'TR', '2021-08-10 06:10:20', 775293.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (188, 189, '78886959', '48143081', 'PP', '2023-10-26 14:21:58', 586863.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (189, 216, '92788091', '91212652', 'TC', '2024-10-13 18:32:33', 269069.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (190, 70, '27841755', '43423167', 'TC', '2022-06-03 06:20:47', 625568.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (191, 209, '14159837', '24476095', 'PP', '2024-07-18 09:16:04', 568917.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (192, 273, '25660291', '88848869', 'TR', '2022-03-04 19:02:52', 633951.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (193, 105, '27841755', '74339388', 'TD', '2021-08-15 10:36:09', 340972.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (194, 179, '79654147', '27755795', 'EF', '2025-02-06 14:20:13', 898275.00, 100000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (195, 194, '94292753', '80341559', 'PP', '2024-08-18 06:50:44', 376551.00, 200000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (196, 121, '71532017', '47242488', 'TC', '2024-11-20 11:00:48', 210129.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (197, 64, '26937148', '53246831', 'TC', '2024-08-23 15:27:30', 971610.00, 50000.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (198, 262, '19742790', '52974720', 'EF', '2026-07-21 07:57:33', 442657.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (199, 187, '25660291', '29674031', 'TC', '2025-10-29 08:58:49', 611751.00, 0.00);
INSERT INTO public.invoices (invoice_id, reserve_id, employee_doc, customer_doc, payment_method_id, creation_date, total, discount) VALUES (200, 275, '77441081', '31554308', 'PP', '2024-08-19 19:43:04', 183859.00, 0.00);


--
-- TOC entry 4231 (class 0 OID 17789)
-- Dependencies: 218
-- Data for Name: payment_methods; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.payment_methods (payment_method_id, name, status, description) VALUES ('EF', 'Efectivo', 'A', NULL);
INSERT INTO public.payment_methods (payment_method_id, name, status, description) VALUES ('TC', 'Tarjeta de Crédito', 'A', 'Visa, Mastercard, Amex');
INSERT INTO public.payment_methods (payment_method_id, name, status, description) VALUES ('TD', 'Tarjeta de Débito', 'A', 'Débito bancario directo');
INSERT INTO public.payment_methods (payment_method_id, name, status, description) VALUES ('TR', 'Transferencia Bancaria', 'A', 'Transferencia electrónica');
INSERT INTO public.payment_methods (payment_method_id, name, status, description) VALUES ('PP', 'PayPal', 'A', NULL);
INSERT INTO public.payment_methods (payment_method_id, name, status, description) VALUES ('CK', 'Cheque', 'I', 'Pago con cheque bancario');
INSERT INTO public.payment_methods (payment_method_id, name, status, description) VALUES ('CR', 'Criptomoneda', 'E', 'Bitcoin y otras criptomonedas');


--
-- TOC entry 4233 (class 0 OID 17800)
-- Dependencies: 220
-- Data for Name: positions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.positions (position_id, name, description) VALUES ('RE', 'Recepcionista', 'Atención al cliente y check-in/check-out');
INSERT INTO public.positions (position_id, name, description) VALUES ('GE', 'Gerente de Hotel', 'Dirección y administración general del hotel');
INSERT INTO public.positions (position_id, name, description) VALUES ('CA', 'Camarero/a', 'Limpieza y mantenimiento de habitaciones');
INSERT INTO public.positions (position_id, name, description) VALUES ('CO', 'Cocinero/a', 'Preparación de alimentos en restaurante');
INSERT INTO public.positions (position_id, name, description) VALUES ('SE', 'Seguridad', 'Vigilancia y control de acceso');
INSERT INTO public.positions (position_id, name, description) VALUES ('AD', 'Administrador', 'Gestión contable y administrativa');
INSERT INTO public.positions (position_id, name, description) VALUES ('MA', 'Mantenimiento', 'Reparación y mantenimiento de instalaciones');
INSERT INTO public.positions (position_id, name, description) VALUES ('AS', 'Asistente de Reservas', 'Gestión de reservas online y telefónicas');


--
-- TOC entry 4245 (class 0 OID 18534)
-- Dependencies: 232
-- Data for Name: reservation_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (1, 1, '404', 'H2', '2021-05-25', '2021-05-29', 966004.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (2, 1, '404', 'H2', '2021-05-24', '2021-05-26', 483002.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (3, 2, '402', 'H3', '2021-08-19', '2021-08-26', 1802514.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (4, 3, '304', 'H4', '2021-01-18', '2021-01-21', 1137315.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (5, 4, '303', 'H5', '2021-06-01', '2021-06-06', 1898030.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (6, 5, '103', 'H1', '2021-03-26', '2021-03-29', 371238.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (7, 6, '502', 'H2', '2021-09-03', '2021-09-08', 3048630.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (8, 6, '104', 'H2', '2021-09-01', '2021-09-02', 118024.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (9, 7, '204', 'H3', '2021-05-10', '2021-05-17', 1315090.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (10, 7, '404', 'H3', '2021-05-14', '2021-05-18', 981416.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (11, 8, '102', 'H4', '2021-10-26', '2021-10-30', 443276.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (12, 8, '402', 'H4', '2021-10-25', '2021-10-31', 1482330.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (13, 9, '403', 'H5', '2021-10-02', '2021-10-05', 758892.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (14, 10, '303', 'H1', '2021-10-03', '2021-10-10', 2606373.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (15, 10, '202', 'H1', '2021-10-02', '2021-10-05', 525987.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (16, 11, '501', 'H2', '2021-06-19', '2021-06-20', 594681.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (17, 11, '401', 'H2', '2021-06-19', '2021-06-25', 1470564.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (18, 12, '201', 'H3', '2021-02-11', '2021-02-17', 1108314.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (19, 13, '504', 'H4', '2021-02-17', '2021-02-24', 4186567.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (20, 13, '202', 'H4', '2021-02-16', '2021-02-22', 1082016.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (21, 14, '302', 'H5', '2021-10-07', '2021-10-10', 1168047.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (22, 15, '304', 'H1', '2021-01-24', '2021-01-25', 380311.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (23, 15, '401', 'H1', '2021-01-27', '2021-02-01', 1234835.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (24, 16, '202', 'H2', '2021-01-08', '2021-01-14', 1051974.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (25, 17, '404', 'H3', '2021-08-09', '2021-08-12', 730047.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (26, 18, '101', 'H4', '2021-10-06', '2021-10-11', 566545.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (27, 19, '103', 'H5', '2021-12-05', '2021-12-06', 111832.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (28, 20, '504', 'H1', '2021-05-16', '2021-05-21', 3041250.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (29, 20, '504', 'H1', '2021-05-13', '2021-05-20', 4186567.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (30, 21, '204', 'H2', '2021-02-25', '2021-02-28', 536319.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (31, 21, '304', 'H2', '2021-02-28', '2021-03-05', 1855205.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (32, 22, '101', 'H3', '2021-12-04', '2021-12-06', 233030.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (33, 22, '402', 'H3', '2021-12-01', '2021-12-02', 243070.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (34, 23, '304', 'H4', '2021-04-23', '2021-04-28', 1901555.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (35, 24, '103', 'H5', '2021-01-09', '2021-01-10', 123746.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (36, 25, '304', 'H1', '2021-01-28', '2021-01-29', 380311.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (37, 25, '303', 'H1', '2021-01-27', '2021-01-29', 767650.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (38, 26, '104', 'H2', '2021-10-13', '2021-10-19', 705030.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (39, 26, '501', 'H2', '2021-10-12', '2021-10-19', 4162767.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (40, 27, '203', 'H3', '2021-06-09', '2021-06-10', 183145.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (41, 27, '402', 'H3', '2021-06-09', '2021-06-13', 1025432.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (42, 28, '302', 'H4', '2021-11-01', '2021-11-02', 389349.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (43, 28, '202', 'H4', '2021-11-02', '2021-11-06', 721344.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (44, 29, '303', 'H5', '2021-06-05', '2021-06-08', 1165755.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (45, 30, '202', 'H1', '2021-11-04', '2021-11-09', 872860.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (46, 30, '503', 'H1', '2021-11-04', '2021-11-11', 4162025.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (47, 31, '101', 'H2', '2021-03-18', '2021-03-23', 582575.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (48, 31, '302', 'H2', '2021-03-19', '2021-03-23', 1535392.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (49, 32, '203', 'H3', '2021-11-26', '2021-11-29', 522270.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (50, 33, '501', 'H4', '2021-07-14', '2021-07-15', 606559.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (51, 34, '301', 'H5', '2021-09-26', '2021-09-29', 1117746.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (52, 35, '504', 'H1', '2021-07-11', '2021-07-14', 1792884.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (53, 36, '302', 'H2', '2021-03-17', '2021-03-19', 776178.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (54, 36, '302', 'H2', '2021-03-17', '2021-03-19', 757496.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (55, 37, '202', 'H3', '2021-03-19', '2021-03-20', 175329.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (56, 37, '401', 'H3', '2021-03-17', '2021-03-20', 740901.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (57, 38, '404', 'H4', '2021-09-11', '2021-09-13', 483002.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (58, 38, '503', 'H4', '2021-09-08', '2021-09-15', 4136083.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (59, 39, '303', 'H5', '2021-02-05', '2021-02-09', 1554340.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (60, 40, '304', 'H1', '2021-09-03', '2021-09-06', 1169880.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (61, 41, '304', 'H2', '2021-04-08', '2021-04-10', 760622.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (62, 41, '402', 'H2', '2021-04-05', '2021-04-09', 985200.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (63, 42, '403', 'H3', '2021-11-30', '2021-12-03', 741492.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (64, 43, '403', 'H4', '2021-02-15', '2021-02-21', 1453674.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (65, 44, '202', 'H5', '2021-01-29', '2021-02-02', 698288.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (66, 45, '304', 'H1', '2021-05-15', '2021-05-21', 2339760.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (67, 45, '401', 'H1', '2021-05-17', '2021-05-21', 982428.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (68, 46, '101', 'H2', '2021-03-10', '2021-03-14', 453236.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (69, 46, '101', 'H2', '2021-03-11', '2021-03-18', 793163.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (70, 47, '202', 'H3', '2021-01-21', '2021-01-24', 523716.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (71, 47, '301', 'H3', '2021-01-23', '2021-01-26', 1118544.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (72, 48, '204', 'H4', '2021-06-23', '2021-06-27', 726564.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (73, 48, '201', 'H4', '2021-06-26', '2021-06-30', 709256.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (74, 49, '303', 'H5', '2021-10-08', '2021-10-10', 744678.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (75, 50, '203', 'H1', '2021-01-29', '2021-02-05', 1213506.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (76, 50, '303', 'H1', '2021-01-28', '2021-02-01', 1518424.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (77, 51, '501', 'H2', '2022-10-18', '2022-10-23', 3025735.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (78, 52, '401', 'H3', '2022-01-16', '2022-01-17', 240976.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (79, 53, '303', 'H4', '2022-03-18', '2022-03-24', 2331510.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (80, 53, '102', 'H4', '2022-03-15', '2022-03-19', 511424.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (81, 54, '202', 'H5', '2022-04-03', '2022-04-05', 360672.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (82, 55, '303', 'H1', '2022-03-25', '2022-03-26', 383825.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (83, 56, '102', 'H2', '2022-11-03', '2022-11-06', 361878.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (84, 56, '501', 'H2', '2022-10-30', '2022-11-06', 4151273.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (85, 57, '303', 'H3', '2022-10-14', '2022-10-20', 2331510.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (86, 57, '202', 'H3', '2022-10-10', '2022-10-11', 180336.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (87, 58, '301', 'H4', '2022-06-10', '2022-06-11', 372168.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (88, 59, '301', 'H5', '2022-08-09', '2022-08-14', 1864240.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (89, 59, '104', 'H5', '2022-08-11', '2022-08-16', 587525.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (90, 60, '202', 'H1', '2022-10-21', '2022-10-25', 698288.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (91, 61, '303', 'H2', '2022-10-28', '2022-11-01', 1518424.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (92, 62, '201', 'H3', '2022-01-26', '2022-02-01', 1091724.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (93, 62, '401', 'H3', '2022-01-26', '2022-01-29', 736821.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (94, 63, '102', 'H4', '2022-03-24', '2022-03-26', 221638.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (95, 63, '104', 'H4', '2022-03-24', '2022-03-28', 499428.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (96, 64, '403', 'H5', '2022-10-04', '2022-10-10', 1488126.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (97, 65, '102', 'H1', '2022-06-20', '2022-06-25', 554095.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (98, 66, '202', 'H2', '2022-10-07', '2022-10-09', 350658.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (99, 66, '403', 'H2', '2022-10-05', '2022-10-09', 988656.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (100, 67, '501', 'H3', '2022-06-26', '2022-07-01', 2973405.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (101, 67, '104', 'H3', '2022-06-22', '2022-06-24', 234446.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (102, 68, '301', 'H4', '2022-08-05', '2022-08-09', 1488672.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (103, 69, '501', 'H5', '2022-01-14', '2022-01-15', 597467.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (104, 70, '301', 'H1', '2022-03-31', '2022-04-05', 1864240.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (105, 71, '402', 'H2', '2022-07-08', '2022-07-13', 1215350.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (106, 71, '204', 'H2', '2022-07-10', '2022-07-15', 912015.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (107, 72, '303', 'H3', '2022-02-19', '2022-02-26', 2720095.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (108, 73, '502', 'H4', '2022-04-23', '2022-04-28', 3012165.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (109, 73, '404', 'H4', '2022-04-24', '2022-04-27', 730047.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (110, 74, '103', 'H5', '2022-03-30', '2022-04-01', 247492.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (111, 75, '404', 'H1', '2022-02-03', '2022-02-07', 973396.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (112, 76, '203', 'H2', '2022-07-06', '2022-07-12', 1098870.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (113, 77, '501', 'H3', '2022-03-22', '2022-03-26', 2426236.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (114, 78, '402', 'H4', '2022-03-11', '2022-03-12', 246300.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (115, 79, '503', 'H5', '2022-06-30', '2022-07-03', 1777842.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (116, 79, '503', 'H5', '2022-07-01', '2022-07-03', 1197690.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (117, 80, '101', 'H1', '2022-02-18', '2022-02-22', 453236.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (118, 81, '301', 'H2', '2022-05-20', '2022-05-24', 1491392.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (119, 81, '401', 'H2', '2022-05-16', '2022-05-23', 1719249.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (120, 82, '402', 'H3', '2022-07-11', '2022-07-15', 985200.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (121, 82, '302', 'H3', '2022-07-11', '2022-07-13', 767696.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (122, 83, '504', 'H4', '2022-02-03', '2022-02-06', 1794243.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (123, 83, '303', 'H4', '2022-02-02', '2022-02-08', 2277636.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (124, 84, '503', 'H5', '2022-11-30', '2022-12-02', 1185228.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (125, 85, '401', 'H1', '2022-02-17', '2022-02-24', 1715658.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (126, 86, '301', 'H2', '2022-03-23', '2022-03-28', 1884325.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (127, 87, '301', 'H3', '2022-02-15', '2022-02-20', 1876155.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (128, 87, '401', 'H3', '2022-02-16', '2022-02-20', 987868.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (129, 88, '201', 'H4', '2022-05-08', '2022-05-09', 177314.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (130, 89, '504', 'H5', '2022-05-21', '2022-05-27', 3588486.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (131, 89, '503', 'H5', '2022-05-21', '2022-05-26', 2963070.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (132, 90, '303', 'H1', '2022-10-20', '2022-10-26', 2277636.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (133, 90, '404', 'H1', '2022-10-18', '2022-10-21', 724503.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (134, 91, '504', 'H2', '2022-10-05', '2022-10-10', 3041250.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (135, 91, '104', 'H2', '2022-10-06', '2022-10-11', 586115.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (136, 92, '303', 'H3', '2022-08-18', '2022-08-22', 1524596.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (137, 93, '404', 'H4', '2022-05-20', '2022-05-21', 247623.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (138, 93, '202', 'H4', '2022-05-19', '2022-05-26', 1325163.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (139, 94, '401', 'H5', '2022-04-24', '2022-04-26', 491214.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (140, 94, '204', 'H5', '2022-04-21', '2022-04-22', 178773.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (141, 95, '304', 'H1', '2022-02-15', '2022-02-18', 1113123.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (142, 95, '203', 'H1', '2022-02-13', '2022-02-19', 1044540.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (143, 96, '403', 'H2', '2022-12-04', '2022-12-06', 494328.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (144, 97, '504', 'H3', '2022-03-21', '2022-03-23', 1195256.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (145, 97, '401', 'H3', '2022-03-19', '2022-03-21', 517836.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (146, 98, '501', 'H4', '2022-11-24', '2022-11-25', 597467.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (147, 99, '102', 'H5', '2022-01-21', '2022-01-27', 734730.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (148, 100, '104', 'H1', '2022-04-15', '2022-04-18', 354072.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (149, 100, '301', 'H1', '2022-04-11', '2022-04-18', 2605176.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (150, 101, '202', 'H2', '2023-09-12', '2023-09-14', 378618.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (151, 102, '304', 'H3', '2023-01-17', '2023-01-19', 758210.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (152, 102, '303', 'H3', '2023-01-16', '2023-01-18', 762298.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (153, 103, '501', 'H4', '2023-11-08', '2023-11-15', 4151273.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (154, 104, '201', 'H5', '2023-02-18', '2023-02-22', 709256.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (155, 104, '303', 'H5', '2023-02-18', '2023-02-19', 372339.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (156, 105, '401', 'H1', '2023-04-14', '2023-04-18', 963904.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (157, 106, '303', 'H2', '2023-04-25', '2023-05-02', 2720095.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (158, 107, '501', 'H3', '2023-09-05', '2023-09-07', 1194934.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (159, 107, '204', 'H3', '2023-09-04', '2023-09-06', 340424.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (160, 108, '201', 'H4', '2023-06-04', '2023-06-10', 1110324.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (161, 109, '504', 'H5', '2023-02-02', '2023-02-04', 1216500.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (162, 110, '103', 'H1', '2023-09-04', '2023-09-09', 559160.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (163, 111, '103', 'H2', '2023-02-26', '2023-02-28', 238216.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (164, 112, '103', 'H3', '2023-02-10', '2023-02-16', 742476.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (165, 112, '501', 'H3', '2023-02-10', '2023-02-12', 1186078.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (166, 113, '401', 'H4', '2023-01-29', '2023-01-30', 245094.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (167, 113, '204', 'H4', '2023-01-25', '2023-01-29', 729612.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (168, 114, '103', 'H5', '2023-06-23', '2023-06-29', 714072.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (169, 114, '401', 'H5', '2023-06-22', '2023-06-27', 1234835.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (170, 115, '502', 'H1', '2023-02-01', '2023-02-04', 1829178.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (171, 116, '502', 'H2', '2023-12-01', '2023-12-03', 1219452.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (172, 117, '301', 'H3', '2023-11-19', '2023-11-25', 2261190.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (173, 117, '401', 'H3', '2023-11-19', '2023-11-23', 982428.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (174, 118, '501', 'H4', '2023-05-03', '2023-05-09', 3639354.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (175, 119, '202', 'H5', '2023-10-03', '2023-10-10', 1312997.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (176, 119, '202', 'H5', '2023-10-02', '2023-10-07', 946545.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (177, 120, '302', 'H1', '2023-10-25', '2023-10-27', 767696.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (178, 121, '403', 'H2', '2023-07-01', '2023-07-06', 1255145.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (179, 121, '101', 'H2', '2023-06-29', '2023-06-30', 113648.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (180, 122, '304', 'H3', '2023-10-09', '2023-10-14', 1909250.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (181, 122, '304', 'H3', '2023-10-10', '2023-10-17', 2597287.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (182, 123, '103', 'H4', '2023-05-16', '2023-05-18', 238024.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (183, 124, '503', 'H5', '2023-07-19', '2023-07-23', 2395380.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (184, 124, '102', 'H5', '2023-07-22', '2023-07-28', 723756.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (185, 125, '103', 'H1', '2023-07-12', '2023-07-15', 371238.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (186, 126, '303', 'H2', '2023-04-17', '2023-04-24', 2668043.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (187, 126, '504', 'H2', '2023-04-21', '2023-04-28', 4257750.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (188, 127, '502', 'H3', '2023-06-04', '2023-06-07', 1807347.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (189, 127, '503', 'H3', '2023-06-03', '2023-06-07', 2395380.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (190, 128, '402', 'H4', '2023-10-23', '2023-10-28', 1235275.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (191, 128, '301', 'H4', '2023-10-23', '2023-10-28', 1876155.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (192, 129, '401', 'H5', '2023-04-24', '2023-04-26', 481952.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (193, 129, '502', 'H5', '2023-04-27', '2023-05-01', 2394716.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (194, 130, '203', 'H1', '2023-09-06', '2023-09-08', 364260.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (195, 130, '104', 'H1', '2023-09-07', '2023-09-14', 779961.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (196, 131, '301', 'H2', '2023-10-19', '2023-10-21', 745164.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (197, 131, '104', 'H2', '2023-10-20', '2023-10-26', 708144.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (198, 132, '204', 'H3', '2023-06-25', '2023-06-29', 726564.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (199, 132, '403', 'H3', '2023-06-23', '2023-06-29', 1488126.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (200, 133, '402', 'H4', '2023-11-12', '2023-11-17', 1235275.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (201, 134, '203', 'H5', '2023-02-09', '2023-02-12', 520074.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (202, 134, '401', 'H5', '2023-02-09', '2023-02-15', 1553508.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (203, 135, '104', 'H1', '2023-05-17', '2023-05-18', 117505.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (204, 136, '201', 'H2', '2023-07-27', '2023-08-03', 1241198.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (205, 137, '501', 'H3', '2023-03-23', '2023-03-24', 597467.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (206, 137, '201', 'H3', '2023-03-23', '2023-03-25', 354628.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (207, 138, '304', 'H4', '2023-01-30', '2023-02-02', 1169880.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (208, 139, '502', 'H5', '2023-03-28', '2023-03-30', 1219452.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (209, 140, '102', 'H1', '2023-02-27', '2023-02-28', 110819.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (210, 141, '203', 'H2', '2023-03-05', '2023-03-09', 696360.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (211, 141, '503', 'H2', '2023-03-09', '2023-03-12', 1796535.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (212, 142, '302', 'H3', '2023-02-03', '2023-02-08', 1919240.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (213, 143, '302', 'H4', '2023-03-12', '2023-03-16', 1514992.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (214, 144, '203', 'H5', '2023-03-28', '2023-03-29', 173358.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (215, 144, '201', 'H5', '2023-03-30', '2023-04-03', 684204.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (216, 145, '203', 'H1', '2023-11-19', '2023-11-22', 520074.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (217, 145, '501', 'H1', '2023-11-17', '2023-11-24', 4182269.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (218, 146, '403', 'H2', '2023-03-24', '2023-03-28', 992084.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (219, 147, '304', 'H3', '2023-03-19', '2023-03-23', 1516420.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (220, 147, '501', 'H3', '2023-03-18', '2023-03-19', 606559.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (221, 148, '404', 'H4', '2023-05-06', '2023-05-07', 255035.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (222, 148, '103', 'H4', '2023-05-04', '2023-05-10', 714648.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (223, 149, '103', 'H5', '2023-11-18', '2023-11-21', 371238.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (224, 149, '103', 'H5', '2023-11-15', '2023-11-17', 247492.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (225, 150, '502', 'H1', '2023-03-27', '2023-03-29', 1204898.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (226, 150, '103', 'H1', '2023-03-29', '2023-04-04', 742476.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (227, 151, '202', 'H2', '2024-01-04', '2024-01-07', 567927.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (228, 152, '403', 'H3', '2024-09-21', '2024-09-22', 251029.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (229, 153, '201', 'H4', '2024-07-01', '2024-07-05', 738876.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (230, 153, '403', 'H4', '2024-06-29', '2024-07-01', 484558.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (231, 154, '101', 'H5', '2024-09-02', '2024-09-07', 582575.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (232, 155, '502', 'H1', '2024-10-06', '2024-10-07', 602433.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (233, 156, '202', 'H2', '2024-06-16', '2024-06-21', 872860.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (234, 157, '504', 'H3', '2024-03-22', '2024-03-28', 3649500.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (235, 158, '103', 'H4', '2024-05-17', '2024-05-20', 335496.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (236, 159, '403', 'H5', '2024-10-07', '2024-10-12', 1255145.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (237, 160, '302', 'H1', '2024-03-21', '2024-03-27', 2336094.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (238, 161, '304', 'H2', '2024-10-08', '2024-10-09', 381850.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (239, 161, '403', 'H2', '2024-10-10', '2024-10-13', 741492.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (240, 162, '302', 'H3', '2024-03-11', '2024-03-16', 1940445.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (241, 163, '501', 'H4', '2024-06-20', '2024-06-26', 3558234.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (242, 163, '401', 'H4', '2024-06-18', '2024-06-20', 493934.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (243, 164, '104', 'H5', '2024-04-02', '2024-04-05', 351669.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (244, 165, '202', 'H1', '2024-03-03', '2024-03-10', 1227303.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (245, 165, '503', 'H1', '2024-03-02', '2024-03-04', 1197690.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (246, 166, '204', 'H2', '2024-04-13', '2024-04-17', 751480.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (247, 167, '302', 'H3', '2024-06-30', '2024-07-02', 757496.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (248, 168, '204', 'H4', '2024-04-03', '2024-04-08', 908205.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (249, 169, '502', 'H5', '2024-04-01', '2024-04-06', 2997410.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (250, 170, '201', 'H1', '2024-04-05', '2024-04-09', 727816.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (251, 171, '103', 'H2', '2024-06-25', '2024-06-29', 494984.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (252, 171, '404', 'H2', '2024-06-26', '2024-06-29', 724503.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (253, 172, '304', 'H3', '2024-03-26', '2024-03-28', 760622.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (254, 173, '204', 'H4', '2024-04-09', '2024-04-12', 544923.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (255, 174, '101', 'H5', '2024-08-09', '2024-08-14', 568240.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (256, 175, '403', 'H1', '2024-08-31', '2024-09-05', 1235820.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (257, 175, '403', 'H1', '2024-09-01', '2024-09-07', 1488126.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (258, 176, '301', 'H2', '2024-01-12', '2024-01-18', 2235492.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (259, 176, '502', 'H2', '2024-01-11', '2024-01-16', 2993395.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (260, 177, '104', 'H3', '2024-11-14', '2024-11-16', 222846.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (261, 178, '403', 'H4', '2024-10-27', '2024-10-29', 502058.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (262, 178, '301', 'H4', '2024-10-27', '2024-11-01', 1864240.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (263, 179, '401', 'H5', '2024-08-27', '2024-08-30', 735282.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (264, 179, '404', 'H5', '2024-08-23', '2024-08-28', 1216745.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (265, 180, '203', 'H1', '2024-05-31', '2024-06-06', 1074690.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (266, 180, '301', 'H1', '2024-05-30', '2024-06-06', 2608074.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (267, 181, '102', 'H2', '2024-03-29', '2024-03-31', 221638.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (268, 181, '101', 'H2', '2024-03-30', '2024-04-01', 233030.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (269, 182, '403', 'H3', '2024-01-15', '2024-01-22', 1757203.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (270, 183, '202', 'H4', '2024-10-04', '2024-10-07', 541008.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (271, 184, '303', 'H5', '2024-09-02', '2024-09-06', 1489356.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (272, 185, '204', 'H1', '2024-01-08', '2024-01-14', 1021272.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (273, 186, '202', 'H2', '2024-07-05', '2024-07-08', 562713.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (274, 187, '502', 'H3', '2024-10-09', '2024-10-10', 599482.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (275, 187, '204', 'H3', '2024-10-08', '2024-10-10', 363282.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (276, 188, '302', 'H4', '2024-07-12', '2024-07-15', 1151544.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (277, 189, '204', 'H5', '2024-06-26', '2024-06-29', 547209.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (278, 189, '503', 'H5', '2024-06-26', '2024-06-27', 590869.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (279, 190, '404', 'H1', '2024-04-06', '2024-04-07', 247623.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (280, 191, '302', 'H2', '2024-09-15', '2024-09-20', 1940445.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (281, 191, '501', 'H2', '2024-09-14', '2024-09-19', 3025735.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (282, 192, '101', 'H3', '2024-10-04', '2024-10-11', 795536.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (283, 192, '501', 'H3', '2024-10-03', '2024-10-09', 3558234.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (284, 193, '303', 'H4', '2024-01-31', '2024-02-06', 2277636.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (285, 194, '104', 'H5', '2024-05-03', '2024-05-07', 499428.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (286, 194, '402', 'H5', '2024-05-03', '2024-05-08', 1281790.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (287, 195, '204', 'H1', '2024-10-29', '2024-10-31', 357546.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (288, 196, '301', 'H2', '2024-11-11', '2024-11-14', 1118544.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (289, 196, '102', 'H2', '2024-11-11', '2024-11-14', 361878.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (290, 197, '202', 'H3', '2024-04-29', '2024-05-02', 562713.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (291, 198, '302', 'H4', '2024-03-06', '2024-03-10', 1507652.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (292, 198, '502', 'H4', '2024-03-06', '2024-03-08', 1204898.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (293, 199, '204', 'H5', '2024-04-25', '2024-04-29', 726564.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (294, 200, '201', 'H1', '2024-11-08', '2024-11-12', 709256.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (295, 200, '301', 'H1', '2024-11-06', '2024-11-13', 2609936.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (296, 201, '101', 'H2', '2025-10-13', '2025-10-16', 363810.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (297, 202, '102', 'H3', '2025-04-24', '2025-04-25', 122455.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (298, 203, '404', 'H4', '2025-09-06', '2025-09-10', 973396.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (299, 203, '501', 'H4', '2025-09-06', '2025-09-08', 1194934.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (300, 204, '101', 'H5', '2025-11-01', '2025-11-04', 351588.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (301, 204, '403', 'H5', '2025-10-29', '2025-11-04', 1488126.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (302, 205, '301', 'H1', '2025-09-05', '2025-09-12', 2638055.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (303, 206, '102', 'H2', '2025-09-28', '2025-10-02', 511424.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (304, 206, '503', 'H2', '2025-09-30', '2025-10-07', 4152183.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (305, 207, '501', 'H3', '2025-09-14', '2025-09-16', 1189362.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (306, 207, '503', 'H3', '2025-09-10', '2025-09-14', 2363476.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (307, 208, '303', 'H4', '2025-10-08', '2025-10-09', 383825.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (308, 208, '503', 'H4', '2025-10-07', '2025-10-10', 1779507.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (309, 209, '303', 'H5', '2025-09-27', '2025-10-03', 2302950.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (310, 210, '402', 'H1', '2025-10-04', '2025-10-09', 1287510.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (311, 211, '402', 'H2', '2025-01-10', '2025-01-14', 972280.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (312, 212, '204', 'H3', '2025-10-28', '2025-11-03', 1094418.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (313, 213, '501', 'H4', '2025-01-11', '2025-01-12', 606559.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (314, 214, '502', 'H5', '2025-03-09', '2025-03-12', 1829178.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (315, 214, '401', 'H5', '2025-03-10', '2025-03-11', 246967.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (316, 215, '102', 'H1', '2025-03-05', '2025-03-07', 259564.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (317, 215, '203', 'H1', '2025-03-08', '2025-03-09', 179115.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (318, 216, '301', 'H2', '2025-08-17', '2025-08-22', 1860840.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (319, 217, '302', 'H3', '2025-02-03', '2025-02-10', 2651236.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (320, 217, '102', 'H3', '2025-02-03', '2025-02-07', 482504.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (321, 218, '201', 'H4', '2025-09-08', '2025-09-09', 185054.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (322, 218, '303', 'H4', '2025-09-12', '2025-09-13', 379606.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (323, 219, '503', 'H5', '2025-03-27', '2025-03-31', 2378300.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (324, 219, '304', 'H5', '2025-03-26', '2025-03-28', 758210.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (325, 220, '402', 'H1', '2025-08-05', '2025-08-11', 1458420.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (326, 221, '202', 'H2', '2025-06-06', '2025-06-07', 174572.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (327, 221, '202', 'H2', '2025-06-08', '2025-06-13', 901680.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (328, 222, '403', 'H3', '2025-09-09', '2025-09-16', 1695953.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (329, 223, '103', 'H4', '2025-05-03', '2025-05-07', 476048.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (330, 224, '103', 'H5', '2025-11-12', '2025-11-17', 618730.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (331, 225, '301', 'H1', '2025-03-03', '2025-03-05', 753730.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (332, 225, '403', 'H1', '2025-03-01', '2025-03-02', 251029.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (333, 226, '504', 'H2', '2025-05-21', '2025-05-26', 3008815.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (334, 227, '402', 'H3', '2025-12-02', '2025-12-04', 512716.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (335, 228, '504', 'H4', '2025-05-01', '2025-05-04', 1824750.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (336, 229, '201', 'H5', '2025-03-10', '2025-03-17', 1295378.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (337, 230, '401', 'H1', '2025-05-03', '2025-05-07', 987868.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (338, 231, '401', 'H2', '2025-02-03', '2025-02-05', 481952.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (339, 231, '204', 'H2', '2025-01-31', '2025-02-07', 1276821.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (340, 232, '104', 'H3', '2025-03-20', '2025-03-26', 708144.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (341, 232, '404', 'H3', '2025-03-19', '2025-03-22', 765105.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (342, 233, '502', 'H4', '2025-06-03', '2025-06-06', 1807347.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (343, 234, '504', 'H5', '2025-01-31', '2025-02-05', 3008815.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (344, 235, '301', 'H1', '2025-10-09', '2025-10-10', 372168.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (345, 235, '201', 'H1', '2025-10-12', '2025-10-15', 531942.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (346, 236, '302', 'H2', '2025-07-09', '2025-07-10', 378748.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (347, 236, '504', 'H2', '2025-07-08', '2025-07-13', 2988140.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (348, 237, '504', 'H3', '2025-10-18', '2025-10-23', 2988140.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (349, 238, '302', 'H4', '2025-02-21', '2025-02-26', 1893740.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (350, 239, '404', 'H5', '2025-09-12', '2025-09-19', 1733361.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (351, 240, '101', 'H1', '2025-02-27', '2025-03-03', 453236.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (352, 241, '501', 'H2', '2025-04-28', '2025-05-01', 1819677.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (353, 241, '103', 'H2', '2025-04-30', '2025-05-01', 111832.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (354, 242, '403', 'H3', '2025-02-15', '2025-02-18', 744063.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (355, 243, '101', 'H4', '2025-04-05', '2025-04-07', 242540.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (356, 243, '401', 'H4', '2025-04-05', '2025-04-11', 1553508.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (357, 244, '403', 'H5', '2025-05-24', '2025-05-27', 744063.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (358, 244, '201', 'H5', '2025-05-21', '2025-05-22', 177314.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (359, 245, '404', 'H1', '2025-10-30', '2025-11-03', 966004.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (360, 246, '504', 'H2', '2025-08-08', '2025-08-09', 597628.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (361, 247, '501', 'H3', '2025-01-18', '2025-01-19', 597467.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (362, 248, '503', 'H4', '2025-03-09', '2025-03-10', 593169.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (363, 248, '503', 'H4', '2025-03-10', '2025-03-14', 2378300.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (364, 249, '202', 'H5', '2025-08-17', '2025-08-19', 349144.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (365, 249, '402', 'H5', '2025-08-17', '2025-08-21', 1030008.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (366, 250, '202', 'H1', '2025-04-01', '2025-04-07', 1135854.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (367, 251, '103', 'H2', '2026-01-07', '2026-01-12', 595060.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (368, 252, '203', 'H3', '2026-11-15', '2026-11-20', 910650.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (369, 253, '401', 'H4', '2026-10-26', '2026-11-02', 1719249.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (370, 253, '204', 'H4', '2026-10-28', '2026-10-30', 357546.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (371, 254, '102', 'H5', '2026-11-18', '2026-11-25', 775733.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (372, 254, '303', 'H5', '2026-11-18', '2026-11-22', 1535300.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (373, 255, '204', 'H1', '2026-10-31', '2026-11-02', 357546.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (374, 255, '401', 'H1', '2026-10-31', '2026-11-04', 987868.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (375, 256, '301', 'H2', '2026-11-09', '2026-11-12', 1116504.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (376, 256, '504', 'H2', '2026-11-07', '2026-11-09', 1216780.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (377, 257, '104', 'H3', '2026-05-27', '2026-05-30', 354072.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (378, 257, '501', 'H3', '2026-05-28', '2026-06-03', 3558234.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (379, 258, '403', 'H4', '2026-01-31', '2026-02-07', 1757203.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (380, 259, '501', 'H5', '2026-04-27', '2026-04-28', 605147.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (381, 259, '503', 'H5', '2026-04-25', '2026-04-30', 2954345.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (382, 260, '102', 'H1', '2026-08-30', '2026-09-03', 482504.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (383, 260, '201', 'H1', '2026-09-01', '2026-09-02', 185054.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (384, 261, '402', 'H2', '2026-03-18', '2026-03-19', 243070.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (385, 261, '101', 'H2', '2026-03-16', '2026-03-19', 351588.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (386, 262, '204', 'H3', '2026-11-08', '2026-11-12', 751480.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (387, 263, '104', 'H4', '2026-03-16', '2026-03-22', 708144.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (388, 264, '304', 'H5', '2026-08-09', '2026-08-10', 371041.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (389, 264, '102', 'H5', '2026-08-11', '2026-08-17', 664914.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (390, 265, '401', 'H1', '2026-05-14', '2026-05-17', 740901.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (391, 265, '402', 'H1', '2026-05-15', '2026-05-22', 1724100.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (392, 266, '401', 'H2', '2026-01-06', '2026-01-12', 1481802.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (393, 266, '402', 'H2', '2026-01-06', '2026-01-09', 741165.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (394, 267, '202', 'H3', '2026-02-23', '2026-02-27', 721344.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (395, 267, '303', 'H3', '2026-02-25', '2026-03-03', 2277636.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (396, 268, '302', 'H4', '2026-11-19', '2026-11-24', 1893740.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (397, 268, '504', 'H4', '2026-11-16', '2026-11-22', 3585768.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (398, 269, '202', 'H5', '2026-01-22', '2026-01-27', 876645.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (399, 270, '504', 'H1', '2026-04-22', '2026-04-28', 3610578.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (400, 271, '101', 'H2', '2026-08-13', '2026-08-16', 349545.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (401, 271, '201', 'H2', '2026-08-13', '2026-08-20', 1197357.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (402, 272, '204', 'H3', '2026-04-13', '2026-04-17', 726564.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (403, 273, '401', 'H4', '2026-10-29', '2026-11-03', 1234835.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (404, 274, '202', 'H5', '2026-06-29', '2026-06-30', 174572.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (405, 275, '104', 'H1', '2026-02-13', '2026-02-19', 708144.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (406, 276, '304', 'H2', '2026-09-17', '2026-09-21', 1521244.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (407, 277, '303', 'H3', '2026-04-19', '2026-04-24', 1861695.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (408, 277, '404', 'H3', '2026-04-15', '2026-04-16', 243349.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (409, 278, '502', 'H4', '2026-09-17', '2026-09-21', 2394716.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (410, 278, '101', 'H4', '2026-09-16', '2026-09-18', 234392.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (411, 279, '203', 'H5', '2026-11-23', '2026-11-29', 1044540.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (412, 279, '203', 'H5', '2026-11-26', '2026-11-29', 537345.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (413, 280, '203', 'H1', '2026-08-31', '2026-09-04', 728520.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (414, 280, '501', 'H1', '2026-08-31', '2026-09-06', 3630882.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (415, 281, '504', 'H2', '2026-01-20', '2026-01-24', 2392324.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (416, 282, '102', 'H3', '2026-11-25', '2026-12-02', 857185.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (417, 282, '202', 'H3', '2026-11-25', '2026-11-28', 567927.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (418, 283, '303', 'H4', '2026-01-05', '2026-01-11', 2234034.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (419, 283, '504', 'H4', '2026-01-09', '2026-01-10', 597628.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (420, 284, '104', 'H5', '2026-03-13', '2026-03-20', 820561.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (421, 284, '403', 'H5', '2026-03-12', '2026-03-19', 1736147.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (422, 285, '501', 'H1', '2026-09-02', '2026-09-03', 597467.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (423, 285, '402', 'H1', '2026-09-02', '2026-09-08', 1545012.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (424, 286, '302', 'H2', '2026-06-03', '2026-06-07', 1557396.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (425, 286, '202', 'H2', '2026-06-05', '2026-06-06', 189309.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (426, 287, '402', 'H3', '2026-03-01', '2026-03-04', 772506.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (427, 288, '101', 'H4', '2026-08-08', '2026-08-09', 121270.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (428, 289, '302', 'H5', '2026-07-09', '2026-07-13', 1507652.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (429, 289, '302', 'H5', '2026-07-09', '2026-07-14', 1919240.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (430, 290, '402', 'H1', '2026-05-24', '2026-05-28', 988220.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (431, 290, '101', 'H1', '2026-05-26', '2026-05-28', 242540.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (432, 291, '502', 'H2', '2026-09-12', '2026-09-17', 3048630.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (433, 292, '502', 'H3', '2026-03-26', '2026-03-30', 2394716.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (434, 293, '403', 'H4', '2026-08-15', '2026-08-19', 969116.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (435, 293, '202', 'H4', '2026-08-12', '2026-08-16', 750284.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (436, 294, '302', 'H5', '2026-08-29', '2026-09-05', 2716623.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (437, 294, '102', 'H5', '2026-08-27', '2026-08-29', 244910.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (438, 295, '502', 'H1', '2026-01-10', '2026-01-17', 4217143.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (439, 295, '303', 'H1', '2026-01-13', '2026-01-19', 2331510.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (440, 296, '503', 'H2', '2026-05-17', '2026-05-19', 1181738.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (441, 296, '502', 'H2', '2026-05-17', '2026-05-21', 2397928.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (442, 297, '301', 'H3', '2026-04-18', '2026-04-21', 1118544.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (443, 297, '304', 'H3', '2026-04-20', '2026-04-24', 1527400.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (444, 298, '401', 'H4', '2026-09-17', '2026-09-24', 1812426.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (445, 299, '504', 'H5', '2026-02-01', '2026-02-04', 1794243.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (446, 299, '104', 'H5', '2026-02-04', '2026-02-11', 826168.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (447, 300, '401', 'H1', '2026-11-03', '2026-11-06', 735282.00);
INSERT INTO public.reservation_details (line_number, reserve_id, room_number, hotel_id, check_in, check_out, subtotal) VALUES (448, 300, '401', 'H1', '2026-11-06', '2026-11-07', 258918.00);


--
-- TOC entry 4247 (class 0 OID 18560)
-- Dependencies: 234
-- Data for Name: reservation_guests; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (1, '59996586');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (2, '80292642');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (3, '32493530');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (3, '53355368');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (4, '28081314');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (4, '41896662');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (5, '84188311');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (5, '75978123');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (5, '30210136');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (6, '75630349');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (7, '62056495');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (8, '34922740');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (9, '59209911');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (9, '62256420');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (9, '73753876');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (10, '99889840');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (10, '18768924');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (11, '68738639');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (12, '36018939');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (12, '28320085');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (13, '66701593');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (14, '33342425');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (14, '84617558');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (14, '18520287');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (15, '36132987');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (16, '13629536');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (17, '74867809');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (17, '26172749');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (18, '74867809');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (18, '46939031');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (19, '34219451');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (20, '63417821');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (20, '65643484');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (20, '33342425');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (21, '98806672');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (21, '68506613');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (21, '41648778');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (22, '75978123');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (22, '54599850');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (23, '30121529');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (24, '58746103');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (24, '73753876');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (25, '85763872');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (25, '83010270');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (25, '13518905');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (26, '84335596');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (27, '61799347');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (28, '87985029');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (28, '52976267');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (29, '41648778');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (29, '41963795');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (29, '63981512');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (30, '41088690');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (30, '80474490');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (31, '28081314');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (31, '54410181');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (31, '86003182');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (32, '92740956');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (33, '73768236');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (33, '38768529');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (33, '25188734');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (34, '63417821');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (35, '40781126');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (36, '58016004');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (37, '15968073');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (37, '77239032');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (38, '78873201');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (39, '33609865');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (39, '59221290');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (40, '16751040');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (41, '55211575');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (41, '32419424');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (42, '20880118');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (42, '97254175');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (42, '76418594');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (43, '77239032');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (43, '45112407');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (44, '28368925');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (45, '84617558');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (46, '66701593');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (47, '59209911');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (47, '87985029');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (48, '92715650');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (48, '72191000');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (48, '53815113');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (49, '13629536');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (49, '74683425');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (49, '86084622');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (50, '66701593');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (51, '32222880');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (52, '46464544');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (52, '56411493');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (52, '54578981');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (53, '49107858');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (54, '77239032');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (54, '65044235');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (55, '30210136');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (55, '18520287');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (56, '76113110');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (57, '40476715');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (58, '11967696');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (58, '43596935');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (59, '30210136');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (59, '54578981');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (60, '34922740');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (60, '21906479');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (60, '10375217');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (61, '61846177');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (62, '34220993');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (62, '57902263');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (62, '94701395');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (63, '86895118');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (64, '86084622');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (65, '66701593');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (66, '99560316');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (66, '66971876');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (67, '92715650');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (67, '90410932');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (68, '73059790');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (68, '52976267');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (68, '66971876');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (69, '46939031');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (69, '43802725');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (70, '65044235');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (70, '53355368');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (70, '55211575');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (71, '85763872');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (72, '50251854');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (72, '67877622');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (73, '58016004');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (74, '99560316');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (74, '28081314');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (75, '33609865');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (75, '77648431');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (76, '61784641');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (76, '28208868');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (76, '32933935');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (77, '54599850');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (77, '14665068');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (78, '82142272');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (78, '62928192');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (79, '30210136');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (79, '89257196');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (80, '76183001');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (80, '41088690');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (80, '63981512');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (81, '46464544');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (81, '53815113');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (82, '20548786');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (82, '55211575');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (83, '39774445');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (84, '23713785');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (84, '93605083');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (85, '72393578');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (85, '33034395');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (86, '96290143');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (87, '71832203');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (88, '91885596');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (88, '53355368');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (89, '86003182');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (89, '50251854');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (89, '18498926');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (90, '78238437');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (91, '21903576');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (91, '45112407');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (91, '50251854');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (92, '70571378');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (92, '56300448');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (92, '20751435');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (93, '34220993');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (93, '23638593');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (93, '24554533');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (94, '64227365');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (94, '34077528');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (94, '45112407');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (95, '78096871');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (95, '41896662');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (96, '90410932');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (97, '59221290');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (98, '16374169');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (99, '59924941');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (99, '49826179');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (100, '84335596');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (100, '48659084');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (100, '53815113');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (101, '90020978');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (101, '80292642');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (101, '63417821');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (102, '22111010');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (102, '72191000');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (103, '23816907');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (103, '23638593');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (104, '40781126');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (105, '83106438');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (105, '61799347');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (106, '66344563');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (106, '46464544');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (106, '69102324');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (107, '76145997');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (107, '97926462');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (108, '97926462');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (108, '12348712');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (108, '44901404');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (109, '49107858');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (110, '75467163');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (110, '61799347');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (110, '49453084');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (111, '83106438');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (111, '22882933');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (112, '98806672');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (112, '49453084');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (112, '80474490');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (113, '49453084');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (113, '83065167');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (114, '54410181');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (114, '50639874');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (115, '34015248');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (115, '49107858');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (116, '26429653');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (117, '79518752');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (117, '59147913');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (117, '98055418');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (118, '33504699');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (118, '16374169');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (119, '56411493');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (120, '15968073');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (121, '55672278');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (122, '80474490');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (122, '58746103');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (122, '66701593');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (123, '90583309');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (123, '23638593');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (124, '56883986');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (125, '33556305');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (125, '91413687');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (126, '80627050');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (126, '26234545');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (126, '28320085');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (127, '64044021');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (127, '79827653');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (128, '32355818');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (129, '32355818');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (130, '52965279');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (130, '38768529');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (130, '55624601');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (131, '52965279');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (131, '61784641');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (131, '69417509');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (132, '22761159');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (132, '28081314');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (132, '98761392');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (133, '32933935');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (134, '39318337');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (135, '48659084');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (136, '61846177');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (136, '64044021');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (137, '18520287');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (137, '69750285');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (137, '98055418');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (138, '33640730');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (139, '64839596');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (139, '23638593');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (139, '76113110');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (140, '63284724');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (140, '99889840');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (140, '66590557');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (141, '84181946');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (141, '52171230');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (142, '76418594');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (143, '33504699');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (143, '38935675');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (143, '87985029');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (144, '66701593');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (144, '77090777');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (144, '48659084');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (145, '32419424');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (145, '54907705');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (146, '84617558');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (147, '84161109');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (148, '90410932');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (149, '36351317');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (150, '84188311');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (150, '72312114');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (151, '34220993');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (151, '28208868');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (151, '20548786');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (152, '93605083');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (153, '53355368');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (153, '22111010');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (154, '77648431');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (155, '32044652');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (155, '62056495');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (155, '11967696');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (156, '64070291');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (157, '67877622');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (157, '13518905');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (158, '52171230');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (159, '44901404');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (160, '53815113');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (160, '48354650');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (160, '42292892');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (161, '77648431');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (161, '62056495');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (162, '14012808');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (163, '41963795');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (163, '63284724');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (163, '94622522');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (164, '44901404');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (165, '73753876');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (165, '32355818');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (165, '56883986');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (166, '90812831');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (167, '52965279');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (167, '26429653');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (167, '30785082');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (168, '40476715');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (169, '82658694');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (170, '67877622');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (171, '45112407');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (171, '28754310');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (172, '25560384');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (172, '80474490');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (173, '45112407');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (174, '72393578');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (174, '54578981');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (175, '19013806');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (175, '55672278');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (175, '33800125');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (176, '28081314');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (177, '59147913');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (178, '24519890');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (178, '32068284');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (178, '97926462');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (179, '59221290');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (180, '84335596');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (180, '33800125');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (181, '56883986');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (182, '63981512');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (182, '49826179');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (183, '32933935');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (183, '11125006');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (184, '33556305');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (184, '69102324');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (185, '23816907');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (186, '23719833');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (186, '67331056');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (187, '61784641');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (187, '96290143');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (187, '64227365');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (188, '84294997');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (188, '45112407');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (188, '41963795');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (189, '11990737');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (189, '34219451');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (189, '78120181');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (190, '94622522');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (190, '53725194');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (190, '36047525');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (191, '21948440');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (191, '59221290');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (192, '99563301');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (193, '41648778');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (194, '71115136');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (194, '76183001');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (195, '22882933');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (195, '70571378');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (195, '33932371');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (196, '67869281');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (196, '92740956');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (196, '30210136');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (197, '14665068');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (197, '61846177');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (198, '55624601');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (199, '29986839');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (199, '32419424');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (199, '92715650');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (200, '90583309');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (200, '78120181');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (201, '77632223');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (202, '61846177');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (202, '78238437');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (202, '63409319');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (203, '33034395');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (203, '84335596');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (204, '46464544');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (204, '66971876');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (204, '69102324');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (205, '13518905');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (205, '90583309');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (206, '10375217');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (206, '64070291');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (207, '18913189');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (207, '27412946');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (208, '41088690');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (208, '99563301');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (208, '61846177');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (209, '16751040');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (210, '66971876');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (210, '16788404');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (211, '63409319');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (211, '10375217');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (212, '96976700');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (212, '53725194');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (213, '90462702');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (214, '71115136');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (214, '78120181');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (215, '83065167');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (215, '23444210');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (215, '99889840');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (216, '68506613');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (216, '99560316');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (216, '61799347');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (217, '91465153');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (217, '28320085');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (217, '27412946');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (218, '30359406');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (218, '62530853');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (219, '30785082');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (219, '32044652');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (219, '23713785');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (220, '80593346');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (221, '45112407');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (221, '23076608');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (221, '77648431');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (222, '23638593');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (223, '11125006');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (223, '43318451');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (223, '83065167');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (224, '62928192');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (224, '78096871');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (225, '19379467');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (226, '83010270');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (226, '28081314');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (227, '93605083');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (227, '66419315');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (228, '34077528');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (229, '55211575');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (229, '36351317');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (230, '17834175');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (230, '33640730');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (230, '41088690');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (231, '73582971');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (232, '84617558');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (232, '90410932');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (232, '84181946');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (233, '63981512');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (233, '90462702');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (234, '20758474');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (235, '20751435');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (236, '84181946');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (237, '78873201');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (237, '54907705');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (238, '98055418');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (239, '92715650');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (239, '46939031');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (240, '11967696');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (240, '93605083');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (240, '67331056');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (241, '56411493');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (241, '67877622');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (242, '74683425');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (242, '54907705');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (243, '98761392');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (243, '20880118');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (243, '32068284');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (244, '54907705');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (244, '81183035');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (244, '29986839');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (245, '71832203');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (245, '15971136');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (246, '68738639');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (246, '24554533');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (247, '50639874');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (247, '90583309');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (247, '49107858');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (248, '43596935');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (248, '22111010');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (248, '32222880');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (249, '76418594');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (249, '33504699');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (249, '64839596');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (250, '22357361');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (250, '20548786');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (250, '52502178');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (251, '19779395');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (252, '43596935');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (253, '45690939');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (254, '24554533');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (254, '25560384');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (254, '94701395');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (255, '30121529');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (256, '11125006');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (256, '28208868');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (256, '28070303');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (257, '68506613');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (258, '30359406');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (258, '15968073');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (259, '15971136');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (259, '91885596');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (260, '14012808');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (260, '67877622');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (260, '99563301');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (261, '35829473');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (261, '90020978');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (261, '59138468');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (262, '50639874');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (262, '96783043');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (262, '81251601');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (263, '55672278');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (263, '32068284');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (263, '25560384');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (264, '86713815');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (265, '61799347');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (265, '30359406');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (265, '14665068');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (266, '30359406');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (266, '72393578');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (266, '18520287');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (267, '17090950');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (268, '79518752');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (268, '36351317');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (269, '18498926');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (269, '72191000');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (270, '41963795');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (270, '45690939');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (271, '59209911');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (272, '62056495');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (272, '65044235');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (273, '46721983');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (274, '97926462');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (274, '66419315');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (274, '56411493');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (275, '78238437');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (275, '25188734');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (276, '54410181');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (276, '22882933');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (277, '80732751');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (278, '22059594');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (278, '97254175');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (279, '64817898');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (279, '41940192');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (280, '54599850');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (280, '54644060');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (281, '59996586');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (281, '53725194');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (282, '33556305');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (283, '56300448');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (283, '83065167');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (284, '81183035');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (285, '61799347');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (285, '50251854');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (286, '92715650');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (286, '82658694');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (287, '46464544');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (287, '23713785');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (287, '25560384');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (288, '87985029');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (289, '77239032');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (289, '78120181');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (290, '87985029');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (290, '26103144');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (291, '83010270');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (292, '34447629');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (293, '95395354');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (294, '30359406');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (294, '86003182');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (294, '46721983');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (295, '97926462');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (296, '63284724');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (297, '33162629');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (298, '97926462');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (299, '36351317');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (299, '84161109');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (299, '33800125');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (300, '29856655');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (300, '15971136');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (301, '54907705');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (302, '39318337');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (302, '33504699');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (302, '91885596');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (303, '52976267');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (303, '50205681');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (304, '64839596');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (304, '98055418');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (304, '76183001');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (305, '11125006');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (305, '29856655');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (305, '86895118');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (306, '98055418');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (306, '50297070');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (306, '46939031');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (307, '90462702');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (307, '87985029');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (308, '30121529');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (309, '25188734');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (310, '46939031');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (310, '32933935');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (311, '17683639');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (311, '76183001');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (311, '63981512');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (312, '46464544');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (312, '86713815');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (312, '46939031');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (313, '63284724');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (313, '15971136');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (313, '59001054');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (314, '34219451');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (315, '21903576');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (315, '66590557');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (315, '59996586');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (316, '83106438');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (316, '50297070');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (317, '66590557');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (317, '11967696');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (318, '30372558');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (318, '92740956');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (318, '11990737');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (319, '81183035');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (319, '32355818');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (320, '19779395');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (320, '59532732');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (320, '61784641');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (321, '23719833');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (321, '19779395');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (322, '79827653');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (322, '44901404');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (322, '64044021');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (323, '91413687');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (324, '43802725');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (324, '80732751');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (324, '78096871');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (325, '48659084');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (325, '22357361');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (326, '90583309');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (327, '61846177');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (328, '83065167');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (328, '13518905');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (328, '78120181');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (329, '11547478');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (329, '28070303');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (329, '99889840');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (330, '44901404');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (330, '23076608');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (331, '36132987');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (331, '23076608');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (332, '40717503');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (332, '32222880');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (332, '18768924');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (333, '40781126');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (333, '84161109');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (333, '82142272');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (334, '32068284');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (334, '23444210');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (335, '33162629');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (336, '79518752');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (337, '79827653');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (337, '57902263');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (338, '80382000');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (339, '36018939');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (339, '21903576');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (339, '52502178');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (340, '46721983');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (340, '23444210');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (340, '16374169');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (341, '26234545');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (341, '22357361');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (341, '55211575');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (342, '20548786');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (342, '12348712');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (342, '28070303');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (343, '80627050');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (343, '28081314');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (344, '78238437');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (345, '18913189');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (346, '27412946');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (347, '25188734');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (347, '21903576');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (348, '73059790');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (348, '77632223');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (349, '44901404');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (350, '63981512');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (350, '34922740');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (351, '41963795');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (351, '11990737');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (352, '77239032');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (353, '91413687');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (354, '28368925');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (354, '73753876');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (354, '74683425');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (355, '91465153');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (356, '58885275');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (356, '46721983');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (357, '28081314');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (358, '15971136');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (359, '74867809');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (359, '61799347');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (359, '71115136');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (360, '21948440');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (361, '11125006');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (361, '55672278');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (361, '17090950');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (362, '55672278');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (362, '87985029');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (363, '49453084');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (363, '16751040');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (363, '54599850');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (364, '67869281');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (365, '71288572');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (365, '76418594');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (366, '28320085');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (366, '59209911');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (366, '18498926');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (367, '63409319');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (367, '79650275');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (368, '81183035');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (368, '63284724');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (368, '54410181');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (369, '83858860');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (370, '90462702');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (370, '45545064');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (371, '70264344');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (371, '58885275');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (371, '69750285');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (372, '78120181');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (372, '62928192');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (373, '56411493');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (373, '49107858');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (374, '49107858');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (375, '66971876');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (375, '90410932');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (375, '33800125');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (376, '83010270');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (376, '98806672');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (376, '95395354');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (377, '15971136');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (377, '41570584');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (378, '25560384');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (378, '76418594');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (379, '45690939');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (380, '18913189');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (381, '21948440');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (381, '95395354');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (382, '59147913');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (382, '53355368');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (383, '75467163');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (384, '28070303');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (384, '95395354');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (384, '89257196');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (385, '66419315');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (385, '74867809');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (385, '36351317');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (386, '38935675');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (386, '30210136');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (387, '86003182');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (387, '69417509');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (387, '49453084');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (388, '18520287');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (388, '45545064');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (388, '34220993');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (389, '67877622');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (389, '54599850');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (390, '89257196');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (390, '15414590');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (390, '58746103');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (391, '58885275');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (391, '15968073');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (391, '38935675');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (392, '39029091');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (392, '26661403');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (393, '59221290');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (393, '43802725');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (393, '39029091');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (394, '32419424');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (394, '44901404');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (395, '72312114');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (395, '77090777');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (396, '75467163');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (396, '73753876');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (397, '96921883');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (398, '52502178');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (398, '24431443');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (398, '36047525');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (399, '58016004');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (399, '48354650');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (400, '12348712');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (400, '73582971');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (400, '77090777');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (401, '73059790');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (401, '36132987');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (402, '32419424');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (403, '33609865');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (403, '28070303');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (403, '61799347');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (404, '76183001');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (405, '29856655');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (405, '80292642');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (406, '10375217');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (407, '77648431');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (407, '66344563');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (407, '73059790');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (408, '16293447');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (409, '76113110');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (410, '29856655');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (410, '82142272');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (411, '30785082');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (412, '70264344');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (413, '26172749');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (414, '26172749');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (415, '41896662');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (416, '61799347');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (417, '79518752');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (418, '73768236');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (418, '32355818');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (418, '28208868');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (419, '33342425');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (420, '18913189');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (421, '28081314');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (421, '53113090');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (422, '56411493');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (422, '11990737');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (423, '66971876');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (423, '73059790');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (423, '82658694');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (424, '56300448');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (425, '40781126');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (425, '78120181');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (425, '84181946');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (426, '79650275');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (426, '22761159');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (426, '84161109');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (427, '23713785');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (428, '11990737');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (428, '33034395');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (428, '96255089');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (429, '77239032');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (430, '34015248');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (430, '40717503');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (430, '63284724');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (431, '70264344');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (431, '82658694');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (431, '11125006');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (432, '46439924');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (432, '11967696');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (433, '99560316');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (434, '80474490');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (435, '91373700');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (436, '94701395');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (436, '45545064');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (436, '75978123');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (437, '96976700');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (438, '22761159');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (438, '54599850');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (439, '15968073');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (440, '50205681');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (440, '58885275');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (440, '20880118');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (441, '61846177');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (441, '34077528');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (442, '58016004');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (443, '33556305');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (443, '18498926');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (443, '70571378');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (444, '50205681');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (444, '40781126');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (445, '84188311');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (446, '36047525');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (446, '73753876');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (446, '69417509');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (447, '82658694');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (448, '73753876');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (448, '21948440');
INSERT INTO public.reservation_guests (line_number, guest_doc) VALUES (448, '12339362');


--
-- TOC entry 4243 (class 0 OID 18515)
-- Dependencies: 230
-- Data for Name: reserves; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (1, '69037325', '27841755', 'C', 'O', '2021-05-21 13:51:28', '2021-05-31 16:15:53', 1449006.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (2, '83361416', '47461811', 'O', 'O', '2021-08-15 21:42:07', '2021-08-22 16:10:59', 1802514.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (3, '76330432', '86391152', 'X', 'T', '2021-01-15 19:20:38', '2021-01-23 16:35:34', 1137315.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (4, '86553214', '16994436', 'C', 'T', '2021-05-29 16:18:22', '2021-05-31 14:19:56', 1898030.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (5, '32917330', '21727533', 'O', 'O', '2021-03-24 17:10:23', '2021-03-28 13:46:40', 371238.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (6, '72226540', '49123810', 'O', 'T', '2021-08-31 11:35:39', '2021-09-06 12:13:14', 3166654.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (7, '28597882', '32329103', 'C', 'T', '2021-05-09 14:02:21', '2021-05-19 12:52:53', 2296506.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (8, '10135086', '29834119', 'O', 'P', '2021-10-23 11:01:23', '2021-10-30 17:02:15', 1925606.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (9, '20706173', '97234140', 'C', 'P', '2021-09-28 18:29:37', '2021-10-04 18:56:10', 758892.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (10, '10047461', '69804203', 'I', 'O', '2021-09-30 08:59:20', '2021-10-02 19:37:11', 3132360.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (11, '38502474', '21727533', 'O', 'T', '2021-06-16 07:11:57', '2021-06-22 19:27:52', 2065245.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (12, '95178684', '32364326', 'C', 'P', '2021-02-09 12:43:24', '2021-02-12 19:57:27', 1108314.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (13, '47382608', '25035684', 'O', 'T', '2021-02-13 07:26:58', '2021-02-22 15:25:07', 5268583.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (14, '23524006', '79703656', 'O', 'T', '2021-10-03 21:41:27', '2021-10-11 13:27:27', 1168047.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (15, '62430988', '47883942', 'O', 'P', '2021-01-22 18:15:14', '2021-01-28 16:40:35', 1615146.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (16, '65875235', '61338023', 'O', 'O', '2021-01-07 20:46:50', '2021-01-09 17:16:08', 1051974.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (17, '60928119', '29081953', 'X', 'P', '2021-08-06 18:54:51', '2021-08-13 12:52:19', 730047.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (18, '83271725', '87669750', 'O', 'P', '2021-10-01 22:56:02', '2021-10-08 14:05:17', 566545.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (19, '65777619', '70887034', 'P', 'T', '2021-11-30 11:50:06', '2021-12-07 14:04:46', 111832.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (20, '38898236', '87432467', 'X', 'T', '2021-05-11 11:08:38', '2021-05-21 20:01:09', 7227817.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (21, '35070625', '54440977', 'I', 'O', '2021-02-23 08:03:24', '2021-03-01 19:29:49', 2391524.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (22, '12351359', '33068427', 'O', 'T', '2021-11-29 18:13:49', '2021-12-04 16:54:55', 476100.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (23, '36949332', '27841755', 'O', 'T', '2021-04-18 16:08:25', '2021-04-22 12:53:00', 1901555.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (24, '13309323', '25419645', 'P', 'P', '2021-01-08 11:01:19', '2021-01-12 13:31:46', 123746.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (25, '52991351', '80157128', 'C', 'P', '2021-01-24 18:46:59', '2021-01-26 12:10:20', 1147961.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (26, '96850860', '70152969', 'O', 'P', '2021-10-11 13:43:07', '2021-10-17 20:21:58', 4867797.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (27, '98756651', '92405160', 'C', 'O', '2021-06-08 21:34:13', '2021-06-16 12:12:32', 1208577.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (28, '63183240', '97074691', 'O', 'O', '2021-10-29 07:35:49', '2021-11-06 13:40:34', 1110693.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (29, '48366253', '71448654', 'I', 'O', '2021-06-03 14:03:01', '2021-06-06 12:20:47', 1165755.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (30, '62451520', '38859601', 'C', 'T', '2021-10-30 20:05:53', '2021-11-05 18:05:27', 5034885.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (31, '94691777', '89708841', 'C', 'T', '2021-03-14 16:03:53', '2021-03-22 12:04:30', 2117967.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (32, '63714593', '31573890', 'X', 'T', '2021-11-25 19:17:25', '2021-12-04 16:37:02', 522270.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (33, '86080861', '84511273', 'C', 'O', '2021-07-13 18:33:09', '2021-07-15 16:22:36', 606559.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (34, '82240647', '75345452', 'O', 'T', '2021-09-25 20:35:13', '2021-10-05 16:36:09', 1117746.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (35, '19470140', '52107027', 'O', 'T', '2021-07-08 21:47:14', '2021-07-12 14:16:20', 1792884.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (36, '74339388', '65648506', 'C', 'P', '2021-03-12 14:13:22', '2021-03-21 20:45:00', 1533674.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (37, '68494269', '95100169', 'C', 'P', '2021-03-14 18:56:39', '2021-03-23 14:44:12', 916230.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (38, '95768162', '14159837', 'I', 'O', '2021-09-06 11:15:44', '2021-09-08 15:00:48', 4619085.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (39, '43837801', '41568532', 'O', 'P', '2021-02-02 08:46:52', '2021-02-10 19:31:33', 1554340.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (40, '77571298', '45835371', 'O', 'O', '2021-08-29 14:25:24', '2021-09-02 19:38:25', 1169880.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (41, '45917890', '59821155', 'X', 'T', '2021-04-04 18:59:59', '2021-04-08 13:53:53', 1745822.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (42, '16022958', '38470244', 'O', 'T', '2021-11-25 19:40:28', '2021-11-27 14:58:49', 741492.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (43, '76372099', '67045601', 'O', 'T', '2021-02-14 21:44:00', '2021-02-21 12:53:43', 1453674.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (44, '80126092', '74142265', 'O', 'O', '2021-01-28 15:06:08', '2021-02-01 16:29:29', 698288.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (45, '53559761', '73104323', 'P', 'O', '2021-05-12 14:00:43', '2021-05-15 20:16:47', 3322188.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (46, '84208202', '18830219', 'O', 'O', '2021-03-09 14:23:10', '2021-03-15 18:14:36', 1246399.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (47, '84208202', '37713235', 'O', 'P', '2021-01-19 09:16:07', '2021-01-25 16:13:01', 1642260.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (48, '57804163', '50232066', 'X', 'P', '2021-06-22 09:34:32', '2021-06-26 14:38:37', 1435820.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (49, '85295643', '69010948', 'O', 'O', '2021-10-05 17:04:41', '2021-10-15 13:37:49', 744678.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (50, '19019126', '70004467', 'O', 'T', '2021-01-25 13:57:40', '2021-02-01 13:17:29', 2731930.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (51, '42930552', '87432467', 'C', 'P', '2022-10-17 18:06:08', '2022-10-21 14:33:51', 3025735.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (52, '94530413', '43685164', 'I', 'O', '2022-01-15 14:11:33', '2022-01-18 20:37:32', 240976.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (53, '29296419', '32988138', 'O', 'P', '2022-03-14 07:47:54', '2022-03-21 19:14:59', 2842934.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (54, '12351359', '18873909', 'O', 'T', '2022-04-01 13:23:36', '2022-04-03 18:41:50', 360672.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (55, '44026103', '55842323', 'O', 'P', '2022-03-22 09:43:39', '2022-03-30 12:04:28', 383825.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (56, '42542841', '56748995', 'O', 'T', '2022-10-29 12:26:34', '2022-11-04 15:09:55', 4513151.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (57, '99375941', '84511273', 'C', 'T', '2022-10-09 07:34:36', '2022-10-11 12:09:16', 2511846.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (58, '10923862', '60601468', 'I', 'P', '2022-06-05 21:13:02', '2022-06-07 15:23:04', 372168.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (59, '63880436', '20949687', 'O', 'P', '2022-08-08 07:04:25', '2022-08-10 13:05:52', 2451765.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (60, '10047461', '52107027', 'O', 'O', '2022-10-18 13:13:38', '2022-10-25 13:12:42', 698288.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (61, '14051460', '55748676', 'O', 'T', '2022-10-23 17:08:14', '2022-10-25 14:46:56', 1518424.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (62, '10636028', '69010948', 'C', 'O', '2022-01-23 21:25:41', '2022-01-28 18:54:15', 1828545.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (63, '87453221', '24821786', 'X', 'O', '2022-03-22 18:12:50', '2022-03-29 17:15:07', 721066.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (64, '63446108', '52831009', 'C', 'O', '2022-10-03 21:31:38', '2022-10-09 15:39:03', 1488126.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (65, '14574615', '19263592', 'O', 'O', '2022-06-19 07:51:31', '2022-06-22 19:24:02', 554095.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (66, '94206105', '15727862', 'C', 'T', '2022-10-04 10:29:36', '2022-10-14 14:26:28', 1339314.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (67, '30808715', '98917575', 'O', 'O', '2022-06-21 13:38:44', '2022-06-30 13:57:50', 3207851.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (68, '62520989', '66390708', 'C', 'P', '2022-08-03 21:42:28', '2022-08-07 14:20:04', 1488672.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (69, '61148988', '79654147', 'C', 'O', '2022-01-13 10:12:31', '2022-01-17 13:27:41', 597467.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (70, '98756651', '27232410', 'C', 'O', '2022-03-28 13:58:50', '2022-03-31 17:20:05', 1864240.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (71, '11846825', '15070029', 'X', 'P', '2022-07-07 12:27:01', '2022-07-10 12:04:40', 2127365.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (72, '76372099', '29513094', 'O', 'P', '2022-02-18 16:44:56', '2022-02-26 13:48:13', 2720095.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (73, '10280147', '63825994', 'O', 'T', '2022-04-21 11:05:27', '2022-04-24 20:25:56', 3742212.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (74, '31754935', '15047559', 'C', 'O', '2022-03-25 18:43:43', '2022-03-27 20:21:46', 247492.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (75, '65875235', '85663295', 'I', 'P', '2022-01-31 10:29:10', '2022-02-06 19:29:42', 973396.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (76, '22507696', '35758531', 'C', 'O', '2022-07-04 22:57:54', '2022-07-09 12:25:35', 1098870.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (77, '94560859', '60882459', 'C', 'T', '2022-03-18 18:24:38', '2022-03-23 12:07:48', 2426236.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (78, '91675383', '85357498', 'I', 'P', '2022-03-08 20:32:00', '2022-03-18 14:51:14', 246300.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (79, '88930879', '82070937', 'I', 'P', '2022-06-26 15:26:56', '2022-07-01 19:21:13', 2975532.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (80, '25944033', '14949636', 'C', 'T', '2022-02-15 10:12:40', '2022-02-23 18:13:23', 453236.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (81, '66276356', '78886959', 'C', 'P', '2022-05-15 09:38:05', '2022-05-20 13:44:25', 3210641.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (82, '94691777', '77441081', 'P', 'P', '2022-07-07 14:26:08', '2022-07-15 19:50:06', 1752896.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (83, '53684898', '97577092', 'C', 'O', '2022-01-31 20:36:32', '2022-02-06 14:46:22', 4071879.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (84, '32732400', '81659221', 'C', 'O', '2022-11-28 09:41:43', '2022-12-06 13:57:37', 1185228.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (85, '50754622', '19742790', 'O', 'P', '2022-02-15 14:14:58', '2022-02-21 14:50:14', 1715658.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (86, '57411092', '69804203', 'C', 'T', '2022-03-19 12:31:31', '2022-03-22 20:54:36', 1884325.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (87, '14083774', '18685284', 'C', 'T', '2022-02-13 14:40:51', '2022-02-21 18:56:16', 2864023.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (88, '49553600', '51758234', 'X', 'P', '2022-05-06 07:48:57', '2022-05-12 18:21:25', 177314.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (89, '46532526', '91253395', 'C', 'O', '2022-05-17 10:11:38', '2022-05-24 20:16:12', 6551556.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (90, '88094160', '69308631', 'C', 'O', '2022-10-16 08:02:48', '2022-10-25 15:24:03', 3002139.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (91, '79647305', '57040785', 'C', 'P', '2022-10-02 11:48:55', '2022-10-04 14:40:44', 3627365.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (92, '81104791', '48759467', 'C', 'O', '2022-08-17 07:58:48', '2022-08-21 13:46:35', 1524596.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (93, '68770044', '73115555', 'I', 'P', '2022-05-17 08:01:27', '2022-05-21 17:33:46', 1572786.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (94, '11762024', '59044830', 'O', 'O', '2022-04-20 12:22:36', '2022-04-22 19:39:48', 669987.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (95, '99800835', '97234140', 'C', 'P', '2022-02-10 22:32:00', '2022-02-17 14:41:40', 2157663.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (96, '60928119', '69762583', 'X', 'O', '2022-11-30 09:01:52', '2022-12-09 16:05:51', 494328.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (97, '73459898', '12132081', 'C', 'T', '2022-03-17 18:25:31', '2022-03-22 13:58:55', 1713092.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (98, '67919082', '91468625', 'C', 'P', '2022-11-19 12:31:54', '2022-11-26 17:36:56', 597467.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (99, '26730148', '81664219', 'X', 'P', '2022-01-19 10:54:10', '2022-01-21 12:52:21', 734730.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (100, '51101815', '31386576', 'C', 'T', '2022-04-10 14:58:16', '2022-04-13 16:05:05', 2959248.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (101, '46532526', '84736526', 'I', 'P', '2023-09-11 21:37:23', '2023-09-15 18:47:03', 378618.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (102, '22957438', '32462726', 'O', 'P', '2023-01-14 11:51:33', '2023-01-18 19:54:08', 1520508.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (103, '80126092', '50532800', 'I', 'T', '2023-11-05 12:21:10', '2023-11-09 18:02:50', 4151273.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (104, '11828652', '77144075', 'C', 'O', '2023-02-14 21:47:15', '2023-02-24 19:36:35', 1081595.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (105, '21283250', '63825994', 'X', 'P', '2023-04-13 07:08:59', '2023-04-21 19:30:05', 963904.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (106, '69127002', '22097496', 'C', 'T', '2023-04-24 17:05:15', '2023-05-04 13:19:27', 2720095.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (107, '21123747', '18434795', 'C', 'O', '2023-09-02 19:02:19', '2023-09-07 15:14:05', 1535358.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (108, '74843897', '54958564', 'C', 'T', '2023-05-30 18:58:35', '2023-06-05 17:48:29', 1110324.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (109, '82853994', '45351739', 'O', 'O', '2023-01-30 09:25:02', '2023-02-07 19:37:50', 1216500.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (110, '99187054', '61973818', 'O', 'T', '2023-09-03 21:18:19', '2023-09-08 20:01:14', 559160.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (111, '65019090', '79742280', 'O', 'O', '2023-02-23 22:06:51', '2023-02-28 19:25:50', 238216.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (112, '40884016', '86560394', 'P', 'T', '2023-02-06 15:32:39', '2023-02-11 16:05:25', 1928554.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (113, '91212919', '51701149', 'I', 'O', '2023-01-24 22:38:17', '2023-01-31 17:03:18', 974706.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (114, '22658740', '45729141', 'O', 'O', '2023-06-18 14:00:10', '2023-06-26 15:32:19', 1948907.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (115, '62132821', '89708841', 'X', 'P', '2023-01-31 18:56:24', '2023-02-09 12:11:46', 1829178.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (116, '76595544', '33898911', 'P', 'T', '2023-11-30 08:22:30', '2023-12-09 12:25:13', 1219452.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (117, '16249742', '20605783', 'O', 'O', '2023-11-14 20:41:34', '2023-11-22 17:36:10', 3243618.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (118, '20817074', '54434998', 'X', 'O', '2023-04-29 13:59:15', '2023-05-02 15:12:42', 3639354.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (119, '64446341', '69804203', 'I', 'T', '2023-10-01 16:47:56', '2023-10-10 14:32:05', 2259542.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (120, '21334884', '59350218', 'C', 'T', '2023-10-24 10:59:48', '2023-10-31 13:55:09', 767696.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (121, '21283250', '11516293', 'C', 'P', '2023-06-28 08:00:47', '2023-07-07 16:22:09', 1368793.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (122, '82085863', '97138408', 'C', 'O', '2023-10-06 20:11:04', '2023-10-14 13:12:39', 4506537.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (123, '42542841', '54434998', 'I', 'P', '2023-05-12 11:31:58', '2023-05-19 13:19:00', 238024.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (124, '50773548', '85280948', 'P', 'T', '2023-07-17 13:08:40', '2023-07-23 16:08:16', 3119136.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (125, '43047380', '46997080', 'C', 'P', '2023-07-09 09:18:47', '2023-07-18 20:10:14', 371238.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (126, '46532526', '28099607', 'X', 'T', '2023-04-16 22:02:19', '2023-04-24 19:37:54', 6925793.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (127, '77418191', '23898777', 'I', 'P', '2023-06-02 14:53:55', '2023-06-09 14:29:30', 4202727.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (128, '11686744', '54440977', 'X', 'P', '2023-10-22 07:23:51', '2023-10-28 12:04:59', 3111430.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (129, '29674031', '41097470', 'I', 'T', '2023-04-22 17:48:07', '2023-05-02 13:13:52', 2876668.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (130, '25332850', '77624084', 'O', 'P', '2023-09-03 10:37:39', '2023-09-10 19:10:08', 1144221.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (131, '72579321', '82374753', 'P', 'O', '2023-10-18 10:34:47', '2023-10-26 13:11:34', 1453308.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (132, '95483760', '95623471', 'I', 'O', '2023-06-20 20:24:34', '2023-06-28 14:00:39', 2214690.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (133, '46358251', '97616925', 'O', 'T', '2023-11-09 15:28:17', '2023-11-14 17:59:28', 1235275.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (134, '10973829', '34544318', 'C', 'P', '2023-02-07 22:45:17', '2023-02-12 19:10:40', 2073582.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (135, '16071701', '59350218', 'X', 'P', '2023-05-16 08:53:34', '2023-05-24 16:13:59', 117505.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (136, '43836123', '84300459', 'X', 'T', '2023-07-22 22:40:35', '2023-08-01 14:20:36', 1241198.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (137, '64830114', '70673557', 'O', 'P', '2023-03-20 07:03:32', '2023-03-23 16:18:58', 952095.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (138, '59828775', '10026256', 'O', 'O', '2023-01-25 20:20:47', '2023-01-29 15:24:44', 1169880.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (139, '44629107', '77259613', 'O', 'T', '2023-03-23 10:55:07', '2023-03-28 20:17:39', 1219452.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (140, '16832563', '78515906', 'C', 'T', '2023-02-25 13:02:16', '2023-03-02 19:38:39', 110819.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (141, '73561767', '24270328', 'X', 'P', '2023-03-04 22:32:47', '2023-03-12 14:37:32', 2492895.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (142, '25332850', '64913082', 'I', 'P', '2023-01-29 18:58:50', '2023-02-01 18:14:32', 1919240.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (143, '42315990', '93303777', 'C', 'T', '2023-03-09 12:54:21', '2023-03-11 20:16:32', 1514992.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (144, '16832563', '54099326', 'X', 'P', '2023-03-25 20:29:37', '2023-03-29 18:01:13', 857562.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (145, '12883470', '45392370', 'C', 'P', '2023-11-15 12:44:50', '2023-11-19 16:39:39', 4702343.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (146, '60928119', '55842323', 'O', 'P', '2023-03-21 12:07:26', '2023-03-28 14:38:50', 992084.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (147, '24476095', '13750602', 'X', 'T', '2023-03-17 17:33:20', '2023-03-22 17:05:02', 2122979.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (148, '66276356', '86808685', 'O', 'P', '2023-05-01 20:32:27', '2023-05-08 18:50:07', 969683.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (149, '38290431', '69020960', 'C', 'T', '2023-11-13 21:32:04', '2023-11-19 15:14:46', 618730.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (150, '37843059', '19263592', 'I', 'P', '2023-03-25 18:47:18', '2023-03-27 12:51:29', 1947374.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (151, '76330432', '15070029', 'C', 'T', '2024-01-01 10:34:48', '2024-01-11 18:26:35', 567927.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (152, '73150290', '27619715', 'O', 'O', '2024-09-17 22:16:43', '2024-09-24 17:56:32', 251029.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (153, '40419133', '27120235', 'I', 'T', '2024-06-27 18:29:28', '2024-06-30 16:26:54', 1223434.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (154, '12351359', '52831009', 'X', 'O', '2024-08-30 20:52:05', '2024-09-06 12:03:21', 582575.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (155, '18718672', '93940940', 'O', 'O', '2024-10-04 09:59:40', '2024-10-07 13:09:04', 602433.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (156, '38290431', '89885300', 'C', 'P', '2024-06-14 11:23:28', '2024-06-22 12:53:37', 872860.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (157, '66524541', '42122457', 'C', 'O', '2024-03-19 07:45:52', '2024-03-27 15:44:23', 3649500.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (158, '76993019', '54468633', 'C', 'T', '2024-05-12 21:34:59', '2024-05-22 15:55:14', 335496.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (159, '36263497', '18685284', 'C', 'T', '2024-10-02 07:51:20', '2024-10-04 19:04:28', 1255145.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (160, '36136297', '13743496', 'I', 'P', '2024-03-18 22:22:32', '2024-03-21 15:11:44', 2336094.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (161, '54532115', '45566111', 'C', 'O', '2024-10-05 22:02:17', '2024-10-13 13:26:30', 1123342.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (162, '60661928', '73672398', 'C', 'O', '2024-03-09 15:41:30', '2024-03-11 14:50:35', 1940445.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (163, '18747686', '33002714', 'O', 'T', '2024-06-16 12:57:02', '2024-06-24 15:25:42', 4052168.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (164, '21868737', '77767769', 'O', 'P', '2024-04-01 14:45:23', '2024-04-04 16:19:10', 351669.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (165, '41624005', '29693143', 'C', 'P', '2024-02-27 08:31:46', '2024-03-04 19:37:05', 2424993.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (166, '18870325', '43567615', 'I', 'T', '2024-04-11 12:22:01', '2024-04-14 19:22:46', 751480.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (167, '86242194', '94292753', 'P', 'P', '2024-06-27 21:26:41', '2024-07-02 19:17:24', 757496.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (168, '50226291', '24181143', 'I', 'O', '2024-04-01 08:25:16', '2024-04-07 12:46:39', 908205.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (169, '42399944', '52619317', 'C', 'T', '2024-03-28 14:32:08', '2024-03-30 15:47:03', 2997410.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (170, '12603460', '70881578', 'C', 'P', '2024-03-31 17:53:47', '2024-04-10 16:55:36', 727816.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (171, '37247147', '37634396', 'I', 'T', '2024-06-21 13:28:41', '2024-06-24 19:41:48', 1219487.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (172, '63590510', '83800569', 'C', 'T', '2024-03-21 13:25:34', '2024-03-26 20:53:50', 760622.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (173, '22075904', '75965276', 'O', 'O', '2024-04-05 08:24:23', '2024-04-14 19:40:21', 544923.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (174, '84209410', '79831928', 'C', 'P', '2024-08-04 19:59:57', '2024-08-11 18:00:45', 568240.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (175, '33771581', '16994436', 'C', 'P', '2024-08-27 13:56:35', '2024-09-05 16:20:25', 2723946.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (176, '97349865', '20997276', 'I', 'P', '2024-01-09 19:19:00', '2024-01-13 15:53:22', 5228887.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (177, '68494269', '38859601', 'C', 'O', '2024-11-11 14:45:15', '2024-11-21 20:00:53', 222846.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (178, '80166422', '86242300', 'C', 'P', '2024-10-23 20:11:50', '2024-10-25 18:50:39', 2366298.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (179, '19985429', '82070937', 'I', 'T', '2024-08-22 13:14:27', '2024-08-28 16:46:08', 1952027.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (180, '86414081', '58082464', 'C', 'P', '2024-05-27 08:01:31', '2024-06-05 16:08:09', 3682764.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (181, '67524179', '30208677', 'P', 'T', '2024-03-26 13:21:50', '2024-04-05 15:56:52', 454668.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (182, '30553823', '16497381', 'I', 'P', '2024-01-10 15:57:21', '2024-01-20 20:34:51', 1757203.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (183, '65003534', '16994436', 'C', 'T', '2024-10-03 16:57:21', '2024-10-13 20:25:10', 541008.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (184, '20694051', '75581613', 'I', 'T', '2024-08-30 07:51:41', '2024-09-05 17:01:06', 1489356.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (185, '72272153', '52619317', 'O', 'O', '2024-01-07 12:14:53', '2024-01-09 13:26:33', 1021272.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (186, '51820248', '89885300', 'O', 'T', '2024-07-01 17:59:36', '2024-07-06 12:42:58', 562713.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (187, '77102111', '45729141', 'I', 'O', '2024-10-04 07:07:52', '2024-10-10 14:53:23', 962764.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (188, '82149862', '60975999', 'O', 'O', '2024-07-09 18:43:43', '2024-07-12 20:06:51', 1151544.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (189, '71658297', '24821786', 'X', 'T', '2024-06-24 11:38:03', '2024-07-02 17:52:23', 1138078.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (190, '25581274', '15047559', 'C', 'O', '2024-04-01 12:44:31', '2024-04-05 12:48:28', 247623.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (191, '29912993', '23180503', 'O', 'O', '2024-09-12 10:29:46', '2024-09-18 17:25:27', 4966180.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (192, '22452337', '70762792', 'O', 'P', '2024-09-30 09:54:39', '2024-10-05 13:20:48', 4353770.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (193, '74716210', '13817499', 'O', 'T', '2024-01-29 10:15:12', '2024-01-31 18:16:19', 2277636.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (194, '74015552', '32033022', 'I', 'O', '2024-05-01 08:59:41', '2024-05-05 20:48:19', 1781218.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (195, '12883470', '49258091', 'C', 'P', '2024-10-26 20:18:16', '2024-11-01 17:21:27', 357546.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (196, '40310459', '27619715', 'C', 'O', '2024-11-10 14:18:27', '2024-11-13 19:48:06', 1480422.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (197, '41227854', '75345452', 'C', 'O', '2024-04-27 16:54:25', '2024-05-04 12:31:12', 562713.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (198, '40066698', '61973818', 'O', 'O', '2024-03-01 11:25:52', '2024-03-08 18:50:58', 2712550.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (199, '88446018', '41828278', 'X', 'P', '2024-04-23 20:22:08', '2024-04-28 19:18:31', 726564.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (200, '15334488', '94651342', 'O', 'T', '2024-11-03 18:52:00', '2024-11-07 12:44:28', 3319192.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (201, '54903382', '97915178', 'C', 'O', '2025-10-12 16:57:00', '2025-10-20 19:18:17', 363810.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (202, '80166422', '83948598', 'C', 'O', '2025-04-19 21:33:31', '2025-04-26 12:13:50', 122455.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (203, '98301804', '18830219', 'C', 'O', '2025-09-02 20:53:47', '2025-09-07 13:01:53', 2168330.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (204, '97511116', '33554528', 'O', 'P', '2025-10-28 15:39:44', '2025-11-03 12:49:29', 1839714.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (205, '15976158', '86507818', 'I', 'O', '2025-09-03 11:00:15', '2025-09-08 17:50:03', 2638055.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (206, '25217605', '89890579', 'I', 'T', '2025-09-25 19:38:04', '2025-10-01 12:07:28', 4663607.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (207, '57804163', '79490594', 'I', 'O', '2025-09-09 12:28:54', '2025-09-16 18:38:02', 3552838.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (208, '45276100', '13743496', 'C', 'T', '2025-10-04 09:11:25', '2025-10-09 14:45:33', 2163332.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (209, '61041690', '75840632', 'X', 'P', '2025-09-25 22:50:36', '2025-10-03 12:22:54', 2302950.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (210, '74926313', '14270425', 'X', 'O', '2025-10-02 12:56:28', '2025-10-05 13:06:28', 1287510.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (211, '39669864', '34525524', 'O', 'T', '2025-01-06 20:27:04', '2025-01-08 19:00:56', 972280.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (212, '73908898', '87984620', 'O', 'O', '2025-10-27 21:48:29', '2025-11-01 18:02:23', 1094418.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (213, '81998064', '12828532', 'I', 'T', '2025-01-07 20:51:04', '2025-01-14 18:58:07', 606559.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (214, '23772773', '98930456', 'P', 'T', '2025-03-06 18:15:25', '2025-03-15 17:56:46', 2076145.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (215, '10280147', '69762583', 'C', 'T', '2025-03-04 16:47:20', '2025-03-06 16:02:50', 438679.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (216, '79297448', '65446317', 'O', 'P', '2025-08-14 13:35:32', '2025-08-17 12:27:46', 1860840.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (217, '74926313', '69020960', 'C', 'T', '2025-01-31 20:29:36', '2025-02-02 19:33:34', 3133740.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (218, '52991351', '49991663', 'C', 'T', '2025-09-07 13:57:09', '2025-09-11 19:13:31', 564660.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (219, '44330502', '59821155', 'C', 'P', '2025-03-23 12:04:35', '2025-04-02 19:45:42', 3136510.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (220, '71567486', '84903294', 'O', 'T', '2025-07-31 08:51:30', '2025-08-03 15:51:36', 1458420.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (221, '27206526', '10026256', 'O', 'T', '2025-06-03 16:57:18', '2025-06-11 17:20:13', 1076252.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (222, '40580466', '27927298', 'P', 'P', '2025-09-07 16:31:00', '2025-09-15 18:47:17', 1695953.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (223, '66711004', '75345452', 'C', 'T', '2025-04-28 14:04:44', '2025-05-05 18:09:06', 476048.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (224, '66524541', '85678734', 'I', 'T', '2025-11-07 10:15:23', '2025-11-09 12:22:20', 618730.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (225, '15454740', '55842323', 'C', 'O', '2025-02-27 22:54:01', '2025-03-04 14:47:18', 1004759.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (226, '24790683', '96920825', 'C', 'O', '2025-05-19 07:27:31', '2025-05-21 15:28:59', 3008815.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (227, '34572290', '96690951', 'X', 'O', '2025-11-30 17:19:23', '2025-12-07 13:01:00', 512716.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (228, '20821631', '22517517', 'O', 'P', '2025-04-30 18:49:34', '2025-05-02 16:19:10', 1824750.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (229, '94691777', '57725656', 'P', 'T', '2025-03-07 18:32:32', '2025-03-15 13:02:22', 1295378.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (230, '61917499', '69118721', 'I', 'P', '2025-04-30 19:50:42', '2025-05-03 18:11:19', 987868.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (231, '12351359', '45026810', 'C', 'P', '2025-01-29 11:11:02', '2025-02-07 16:36:37', 1758773.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (232, '51101815', '91390501', 'O', 'P', '2025-03-15 07:32:39', '2025-03-21 20:33:52', 1473249.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (233, '79647305', '90535106', 'C', 'O', '2025-06-02 16:42:43', '2025-06-06 14:51:57', 1807347.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (234, '28597882', '83076970', 'X', 'T', '2025-01-27 19:12:11', '2025-01-29 17:43:23', 3008815.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (235, '77310099', '60882459', 'X', 'P', '2025-10-07 21:45:01', '2025-10-15 12:09:29', 904110.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (236, '51156003', '73844258', 'C', 'T', '2025-07-04 19:50:49', '2025-07-09 19:58:45', 3366888.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (237, '22452337', '56189726', 'C', 'O', '2025-10-16 09:22:16', '2025-10-18 18:31:16', 2988140.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (238, '85208373', '55030548', 'X', 'P', '2025-02-17 16:07:28', '2025-02-20 13:50:16', 1893740.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (239, '15190410', '53194369', 'C', 'O', '2025-09-11 16:09:25', '2025-09-15 20:39:01', 1733361.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (240, '37247147', '65868338', 'C', 'O', '2025-02-26 20:33:50', '2025-03-02 20:38:08', 453236.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (241, '52441605', '87669750', 'O', 'P', '2025-04-26 15:06:03', '2025-05-02 17:21:42', 1931509.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (242, '44629107', '27927298', 'O', 'O', '2025-02-12 16:52:49', '2025-02-16 15:25:57', 744063.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (243, '17938468', '98917575', 'P', 'T', '2025-04-04 19:10:28', '2025-04-12 13:22:36', 1796048.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (244, '27638581', '57725656', 'O', 'P', '2025-05-19 14:35:24', '2025-05-26 17:17:20', 921377.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (245, '20706173', '68382413', 'O', 'T', '2025-10-25 11:56:35', '2025-10-28 15:40:37', 966004.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (246, '80341559', '69427400', 'I', 'T', '2025-08-04 16:36:08', '2025-08-08 13:16:36', 597628.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (247, '66047853', '19015987', 'C', 'O', '2025-01-13 14:34:48', '2025-01-23 20:37:57', 597467.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (248, '40580466', '21062296', 'I', 'T', '2025-03-08 09:47:35', '2025-03-11 18:52:41', 2971469.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (249, '18201748', '64913082', 'X', 'T', '2025-08-12 08:48:38', '2025-08-18 17:20:26', 1379152.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (250, '61148988', '34272734', 'I', 'P', '2025-03-28 22:23:22', '2025-03-31 20:30:05', 1135854.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (251, '21334884', '28566572', 'O', 'P', '2026-01-02 20:31:36', '2026-01-04 19:33:11', 595060.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (252, '37637454', '75345452', 'C', 'P', '2026-11-10 18:48:54', '2026-11-12 20:52:06', 910650.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (253, '63714593', '70004467', 'O', 'P', '2026-10-24 19:22:24', '2026-10-27 12:25:20', 2076795.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (254, '12301266', '61356129', 'X', 'T', '2026-11-13 09:40:29', '2026-11-15 13:59:53', 2311033.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (255, '72579321', '76354180', 'C', 'T', '2026-10-29 07:48:19', '2026-11-08 12:50:52', 1345414.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (256, '53828083', '53980546', 'C', 'P', '2026-11-06 22:24:21', '2026-11-16 15:50:25', 2333284.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (257, '92331842', '95623471', 'C', 'P', '2026-05-23 19:58:18', '2026-05-31 16:10:39', 3912306.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (258, '70845390', '34272734', 'I', 'P', '2026-01-30 07:35:11', '2026-02-09 15:48:58', 1757203.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (259, '95399182', '69175071', 'X', 'P', '2026-04-24 19:40:18', '2026-05-04 18:39:34', 3559492.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (260, '61926784', '19927432', 'I', 'P', '2026-08-28 18:08:06', '2026-09-02 17:33:54', 667558.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (261, '83112925', '44044361', 'I', 'T', '2026-03-13 18:13:30', '2026-03-23 19:53:21', 594658.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (262, '95483760', '53194369', 'P', 'O', '2026-11-05 22:51:18', '2026-11-09 16:55:32', 751480.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (263, '25217605', '16095815', 'I', 'T', '2026-03-15 16:46:15', '2026-03-24 15:46:19', 708144.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (264, '32732400', '65288255', 'O', 'T', '2026-08-07 11:04:34', '2026-08-10 14:34:51', 1035955.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (265, '97511116', '53822194', 'O', 'T', '2026-05-13 18:24:51', '2026-05-19 12:58:44', 2465001.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (266, '47319033', '80653292', 'C', 'P', '2026-01-04 17:20:35', '2026-01-11 13:08:25', 2222967.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (267, '84131297', '57288136', 'C', 'O', '2026-02-21 11:22:15', '2026-02-25 13:52:08', 2998980.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (268, '78045733', '35749878', 'C', 'P', '2026-11-15 15:38:44', '2026-11-24 20:39:16', 5479508.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (269, '28805567', '18373492', 'C', 'P', '2026-01-19 11:41:57', '2026-01-27 12:24:42', 876645.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (270, '73989419', '85500790', 'C', 'O', '2026-04-18 13:13:30', '2026-04-24 19:41:24', 3610578.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (271, '20706173', '21257528', 'C', 'T', '2026-08-10 16:04:34', '2026-08-16 18:34:02', 1546902.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (272, '72685550', '43105363', 'I', 'O', '2026-04-11 13:28:42', '2026-04-21 13:36:43', 726564.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (273, '63609010', '42122457', 'C', 'O', '2026-10-28 17:17:46', '2026-11-03 14:29:37', 1234835.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (274, '25944033', '70004467', 'C', 'P', '2026-06-27 18:08:09', '2026-06-30 13:11:18', 174572.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (275, '49566968', '29834119', 'I', 'O', '2026-02-12 16:43:16', '2026-02-16 16:43:58', 708144.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (276, '83541296', '75840632', 'P', 'P', '2026-09-12 19:37:06', '2026-09-16 12:16:09', 1521244.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (277, '57475650', '57912262', 'C', 'T', '2026-04-14 20:12:39', '2026-04-17 20:54:48', 2105044.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (278, '46875132', '13994712', 'C', 'P', '2026-09-12 16:08:49', '2026-09-15 19:18:07', 2629108.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (279, '83796808', '91390501', 'I', 'O', '2026-11-22 17:57:01', '2026-12-01 16:16:22', 1581885.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (280, '84492729', '67795113', 'I', 'P', '2026-08-30 11:28:36', '2026-09-03 16:53:15', 4359402.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (281, '40066698', '74142265', 'C', 'O', '2026-01-15 12:18:07', '2026-01-25 17:07:24', 2392324.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (282, '57475650', '20866138', 'I', 'T', '2026-11-21 22:44:00', '2026-11-29 13:24:11', 1425112.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (283, '41227854', '12884611', 'C', 'P', '2026-01-04 12:51:16', '2026-01-08 20:44:25', 2831662.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (284, '37289414', '32978251', 'O', 'P', '2026-03-11 21:06:24', '2026-03-16 18:16:22', 2556708.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (285, '95638951', '16104857', 'X', 'O', '2026-08-30 19:03:35', '2026-09-01 16:21:57', 2142479.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (286, '81641483', '65288255', 'C', 'O', '2026-06-02 12:59:30', '2026-06-06 18:13:14', 1746705.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (287, '77418191', '70762792', 'C', 'T', '2026-02-27 09:43:53', '2026-03-09 16:06:08', 772506.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (288, '24536356', '77834855', 'P', 'P', '2026-08-06 13:26:09', '2026-08-09 14:47:07', 121270.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (289, '18559981', '91468625', 'C', 'O', '2026-07-06 16:18:38', '2026-07-16 13:58:22', 3426892.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (290, '50226291', '28762704', 'P', 'P', '2026-05-22 20:02:44', '2026-05-31 13:30:29', 1230760.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (291, '57597933', '85318641', 'O', 'O', '2026-09-10 19:49:27', '2026-09-17 15:38:34', 3048630.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (292, '61133053', '91390501', 'C', 'O', '2026-03-21 20:57:19', '2026-03-29 13:58:41', 2394716.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (293, '85330101', '41568532', 'C', 'O', '2026-08-11 18:07:40', '2026-08-18 18:16:13', 1719400.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (294, '37205749', '95623471', 'C', 'T', '2026-08-26 13:00:02', '2026-08-29 19:34:43', 2961533.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (295, '68680918', '27036337', 'O', 'T', '2026-01-09 19:27:56', '2026-01-13 13:02:36', 6548653.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (296, '57957055', '28099607', 'I', 'O', '2026-05-13 21:59:48', '2026-05-21 19:25:54', 3579666.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (297, '76096285', '24271532', 'O', 'T', '2026-04-16 15:55:32', '2026-04-20 18:43:38', 2645944.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (298, '50554420', '71928212', 'X', 'T', '2026-09-16 12:52:05', '2026-09-25 19:48:03', 1812426.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (299, '42447383', '85825317', 'I', 'P', '2026-01-30 16:43:44', '2026-02-06 17:24:12', 2620411.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (300, '12301266', '82634888', 'I', 'O', '2026-11-02 22:44:46', '2026-11-11 13:32:15', 994200.00);
INSERT INTO public.reserves (reserve_id, customer_doc, employee_doc, status, source, creation_date, limit_date, total) VALUES (301, '1004899453', '27841755', 'X', 'O', '2026-05-18 22:21:01.961186', '2026-05-20 00:00:00', 1000000.00);


--
-- TOC entry 4252 (class 0 OID 18615)
-- Dependencies: 239
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('101', 'H1', 'SI', 'A', 113648.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('102', 'H1', 'SI', 'D', 110819.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('103', 'H1', 'SI', 'O', 119012.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('104', 'H1', 'SI', 'O', 118024.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('201', 'H1', 'DO', 'A', 177314.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('202', 'H1', 'DO', 'A', 174572.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('203', 'H1', 'DO', 'A', 173358.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('204', 'H1', 'DO', 'R', 187870.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('401', 'H1', 'SU', 'O', 372848.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('402', 'H1', 'SU', 'O', 389349.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('403', 'H1', 'SU', 'A', 383825.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('404', 'H1', 'SU', 'D', 371041.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('301', 'H1', 'FA', 'R', 240976.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('302', 'H1', 'FA', 'A', 243070.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('303', 'H1', 'FA', 'A', 247164.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('304', 'H1', 'FA', 'A', 247623.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('501', 'H1', 'PE', 'A', 606559.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('502', 'H1', 'PE', 'O', 609726.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('503', 'H1', 'PE', 'A', 590869.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('504', 'H1', 'PE', 'A', 608390.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('101', 'H2', 'SI', 'O', 116515.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('102', 'H2', 'SI', 'A', 127856.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('103', 'H2', 'SI', 'A', 123746.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('104', 'H2', 'SI', 'A', 117223.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('201', 'H2', 'DO', 'A', 184719.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('202', 'H2', 'DO', 'O', 189309.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('203', 'H2', 'DO', 'A', 179115.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('204', 'H2', 'DO', 'O', 170212.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('401', 'H2', 'SU', 'O', 375231.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('402', 'H2', 'SU', 'A', 383848.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('403', 'H2', 'SU', 'O', 381149.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('404', 'H2', 'SU', 'A', 379105.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('301', 'H2', 'FA', 'A', 245094.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('302', 'H2', 'FA', 'M', 247055.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('303', 'H2', 'FA', 'D', 251029.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('304', 'H2', 'FA', 'R', 243349.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('501', 'H2', 'PE', 'A', 593039.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('502', 'H2', 'PE', 'A', 602449.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('503', 'H2', 'PE', 'O', 593169.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('504', 'H2', 'PE', 'A', 601763.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('101', 'H3', 'SI', 'A', 121270.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('102', 'H3', 'SI', 'A', 129782.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('103', 'H3', 'SI', 'A', 118667.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('104', 'H3', 'SI', 'R', 111423.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('201', 'H3', 'DO', 'A', 185054.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('202', 'H3', 'DO', 'O', 187571.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('203', 'H3', 'DO', 'A', 174090.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('204', 'H3', 'DO', 'O', 182403.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('401', 'H3', 'SU', 'O', 372582.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('402', 'H3', 'SU', 'A', 388089.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('403', 'H3', 'SU', 'D', 379606.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('404', 'H3', 'SU', 'O', 381850.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('301', 'H3', 'FA', 'M', 258918.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('302', 'H3', 'FA', 'R', 246300.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('303', 'H3', 'FA', 'O', 242279.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('304', 'H3', 'FA', 'M', 241501.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('501', 'H3', 'PE', 'A', 597467.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('502', 'H3', 'PE', 'A', 599482.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('503', 'H3', 'PE', 'A', 592614.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('504', 'H3', 'PE', 'A', 597628.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('101', 'H4', 'SI', 'A', 113309.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('102', 'H4', 'SI', 'A', 122455.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('103', 'H4', 'SI', 'R', 119108.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('104', 'H4', 'SI', 'A', 124857.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('201', 'H4', 'DO', 'A', 181954.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('202', 'H4', 'DO', 'O', 175329.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('203', 'H4', 'DO', 'A', 182130.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('204', 'H4', 'DO', 'R', 181641.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('401', 'H4', 'SU', 'A', 376865.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('402', 'H4', 'SU', 'D', 378748.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('403', 'H4', 'SU', 'O', 372339.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('404', 'H4', 'SU', 'A', 389960.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('301', 'H4', 'FA', 'A', 245607.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('302', 'H4', 'FA', 'R', 257502.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('303', 'H4', 'FA', 'O', 248021.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('304', 'H4', 'FA', 'O', 245354.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('501', 'H4', 'PE', 'O', 605147.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('502', 'H4', 'PE', 'A', 602433.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('503', 'H4', 'PE', 'A', 598845.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('504', 'H4', 'PE', 'A', 608250.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('101', 'H5', 'SI', 'R', 117196.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('102', 'H5', 'SI', 'O', 120626.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('103', 'H5', 'SI', 'A', 111832.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('104', 'H5', 'SI', 'A', 117505.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('201', 'H5', 'DO', 'A', 171051.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('202', 'H5', 'DO', 'A', 180336.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('203', 'H5', 'DO', 'O', 183145.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('204', 'H5', 'DO', 'O', 178773.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('401', 'H5', 'SU', 'R', 372168.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('402', 'H5', 'SU', 'A', 376913.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('403', 'H5', 'SU', 'A', 388585.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('404', 'H5', 'SU', 'O', 380311.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('301', 'H5', 'FA', 'O', 246967.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('302', 'H5', 'FA', 'O', 256358.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('303', 'H5', 'FA', 'O', 252964.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('304', 'H5', 'FA', 'A', 255035.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('501', 'H5', 'PE', 'O', 594681.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('502', 'H5', 'PE', 'A', 598679.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('503', 'H5', 'PE', 'A', 594575.00);
INSERT INTO public.rooms (room_number, hotel_id, room_type_id, status, price_per_night) VALUES ('504', 'H5', 'PE', 'A', 598081.00);


--
-- TOC entry 4234 (class 0 OID 17805)
-- Dependencies: 221
-- Data for Name: rooms_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.rooms_types (room_type_id, name, description) VALUES ('SI', 'Sencilla', 'Habitación con cama individual para 1 persona');
INSERT INTO public.rooms_types (room_type_id, name, description) VALUES ('DO', 'Doble', 'Habitación con cama doble para 2 personas');
INSERT INTO public.rooms_types (room_type_id, name, description) VALUES ('SU', 'Suite', 'Suite de lujo con sala y jacuzzi');
INSERT INTO public.rooms_types (room_type_id, name, description) VALUES ('FA', 'Familiar', 'Habitación familiar para 4 personas');
INSERT INTO public.rooms_types (room_type_id, name, description) VALUES ('PE', 'Penthouse', 'Penthouse con vista panorámica');


--
-- TOC entry 4265 (class 0 OID 0)
-- Dependencies: 224
-- Name: cities_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cities_city_id_seq', 1, false);


--
-- TOC entry 4266 (class 0 OID 0)
-- Dependencies: 226
-- Name: equipments_equipment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.equipments_equipment_id_seq', 1, false);


--
-- TOC entry 4267 (class 0 OID 0)
-- Dependencies: 237
-- Name: invoice_details_line_number_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invoice_details_line_number_seq', 1, false);


--
-- TOC entry 4268 (class 0 OID 0)
-- Dependencies: 235
-- Name: invoices_invoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invoices_invoice_id_seq', 1, false);


--
-- TOC entry 4269 (class 0 OID 0)
-- Dependencies: 231
-- Name: reservation_details_line_number_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservation_details_line_number_seq', 1, false);


--
-- TOC entry 4270 (class 0 OID 0)
-- Dependencies: 229
-- Name: reserves_reserve_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reserves_reserve_id_seq', 3, true);


--
-- TOC entry 4035 (class 2606 OID 18412)
-- Name: countries countries_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_name_key UNIQUE (name);


--
-- TOC entry 4043 (class 2606 OID 18431)
-- Name: cities pk_cities; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT pk_cities PRIMARY KEY (city_id);


--
-- TOC entry 4037 (class 2606 OID 18410)
-- Name: countries pk_countries; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT pk_countries PRIMARY KEY (country_id);


--
-- TOC entry 4049 (class 2606 OID 18503)
-- Name: customers pk_customers; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT pk_customers PRIMARY KEY (customer_doc);


--
-- TOC entry 4039 (class 2606 OID 18417)
-- Name: departments pk_departments; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT pk_departments PRIMARY KEY (department_id);


--
-- TOC entry 4029 (class 2606 OID 17799)
-- Name: documents_types pk_documents_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents_types
    ADD CONSTRAINT pk_documents_types PRIMARY KEY (doc_type_id);


--
-- TOC entry 4065 (class 2606 OID 18673)
-- Name: employees pk_employees; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT pk_employees PRIMARY KEY (employee_doc);


--
-- TOC entry 4047 (class 2606 OID 18463)
-- Name: equipments pk_equipments; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipments
    ADD CONSTRAINT pk_equipments PRIMARY KEY (equipment_id);


--
-- TOC entry 4055 (class 2606 OID 18554)
-- Name: guests pk_guests; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guests
    ADD CONSTRAINT pk_guests PRIMARY KEY (guest_doc);


--
-- TOC entry 4025 (class 2606 OID 17788)
-- Name: hotels pk_hotels; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotels
    ADD CONSTRAINT pk_hotels PRIMARY KEY (hotel_id);


--
-- TOC entry 4061 (class 2606 OID 18609)
-- Name: invoice_details pk_invoice_details; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_details
    ADD CONSTRAINT pk_invoice_details PRIMARY KEY (line_number);


--
-- TOC entry 4059 (class 2606 OID 18582)
-- Name: invoices pk_invoices; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT pk_invoices PRIMARY KEY (invoice_id);


--
-- TOC entry 4027 (class 2606 OID 17794)
-- Name: payment_methods pk_payment_methods; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT pk_payment_methods PRIMARY KEY (payment_method_id);


--
-- TOC entry 4031 (class 2606 OID 17804)
-- Name: positions pk_positions; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT pk_positions PRIMARY KEY (position_id);


--
-- TOC entry 4053 (class 2606 OID 18539)
-- Name: reservation_details pk_reservation_details; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation_details
    ADD CONSTRAINT pk_reservation_details PRIMARY KEY (line_number);


--
-- TOC entry 4057 (class 2606 OID 18564)
-- Name: reservation_guests pk_reservation_guests; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation_guests
    ADD CONSTRAINT pk_reservation_guests PRIMARY KEY (line_number, guest_doc);


--
-- TOC entry 4051 (class 2606 OID 18522)
-- Name: reserves pk_reserves; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserves
    ADD CONSTRAINT pk_reserves PRIMARY KEY (reserve_id);


--
-- TOC entry 4063 (class 2606 OID 18621)
-- Name: rooms pk_rooms; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT pk_rooms PRIMARY KEY (room_number, hotel_id);


--
-- TOC entry 4033 (class 2606 OID 17809)
-- Name: rooms_types pk_rooms_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms_types
    ADD CONSTRAINT pk_rooms_types PRIMARY KEY (room_type_id);


--
-- TOC entry 4045 (class 2606 OID 18433)
-- Name: cities uq_city_per_department; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT uq_city_per_department UNIQUE (department_id, name);


--
-- TOC entry 4041 (class 2606 OID 18419)
-- Name: departments uq_dept_per_country; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT uq_dept_per_country UNIQUE (country_id, name);


--
-- TOC entry 4068 (class 2606 OID 18509)
-- Name: customers fk_cities_customers; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT fk_cities_customers FOREIGN KEY (city_id) REFERENCES public.cities(city_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4081 (class 2606 OID 18689)
-- Name: employees fk_cities_employees; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT fk_cities_employees FOREIGN KEY (city_id) REFERENCES public.cities(city_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4066 (class 2606 OID 18420)
-- Name: departments fk_countries_departments; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT fk_countries_departments FOREIGN KEY (country_id) REFERENCES public.countries(country_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4072 (class 2606 OID 18555)
-- Name: guests fk_countries_guests; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guests
    ADD CONSTRAINT fk_countries_guests FOREIGN KEY (country_id) REFERENCES public.countries(country_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4075 (class 2606 OID 18593)
-- Name: invoices fk_customers_invoices; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT fk_customers_invoices FOREIGN KEY (customer_doc) REFERENCES public.customers(customer_doc) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4070 (class 2606 OID 18523)
-- Name: reserves fk_customers_reserves; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserves
    ADD CONSTRAINT fk_customers_reserves FOREIGN KEY (customer_doc) REFERENCES public.customers(customer_doc) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4067 (class 2606 OID 18434)
-- Name: cities fk_departments_cities; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT fk_departments_cities FOREIGN KEY (department_id) REFERENCES public.departments(department_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4069 (class 2606 OID 18504)
-- Name: customers fk_documents_types_customers; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT fk_documents_types_customers FOREIGN KEY (doc_type_id) REFERENCES public.documents_types(doc_type_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4082 (class 2606 OID 18684)
-- Name: employees fk_documents_types_employees; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT fk_documents_types_employees FOREIGN KEY (doc_type_id) REFERENCES public.documents_types(doc_type_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4073 (class 2606 OID 18570)
-- Name: reservation_guests fk_guests_reservation_guests; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation_guests
    ADD CONSTRAINT fk_guests_reservation_guests FOREIGN KEY (guest_doc) REFERENCES public.guests(guest_doc) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4083 (class 2606 OID 18674)
-- Name: employees fk_hotels_employees; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT fk_hotels_employees FOREIGN KEY (hotel_id) REFERENCES public.hotels(hotel_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4079 (class 2606 OID 18627)
-- Name: rooms fk_hotels_rooms; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT fk_hotels_rooms FOREIGN KEY (hotel_id) REFERENCES public.hotels(hotel_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4078 (class 2606 OID 18610)
-- Name: invoice_details fk_invoices_to_invoices_details; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_details
    ADD CONSTRAINT fk_invoices_to_invoices_details FOREIGN KEY (invoice_id) REFERENCES public.invoices(invoice_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4076 (class 2606 OID 18598)
-- Name: invoices fk_payment_methods_invoices; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT fk_payment_methods_invoices FOREIGN KEY (payment_method_id) REFERENCES public.payment_methods(payment_method_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4084 (class 2606 OID 18679)
-- Name: employees fk_positions_employees; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT fk_positions_employees FOREIGN KEY (position_id) REFERENCES public.positions(position_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4074 (class 2606 OID 18565)
-- Name: reservation_guests fk_reservation_details_reservation_guests; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation_guests
    ADD CONSTRAINT fk_reservation_details_reservation_guests FOREIGN KEY (line_number) REFERENCES public.reservation_details(line_number) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4077 (class 2606 OID 18583)
-- Name: invoices fk_reserves_invoices; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT fk_reserves_invoices FOREIGN KEY (reserve_id) REFERENCES public.reserves(reserve_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4071 (class 2606 OID 18540)
-- Name: reservation_details fk_reserves_reservation_details; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation_details
    ADD CONSTRAINT fk_reserves_reservation_details FOREIGN KEY (reserve_id) REFERENCES public.reserves(reserve_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4080 (class 2606 OID 18622)
-- Name: rooms fk_rooms_types_rooms; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT fk_rooms_types_rooms FOREIGN KEY (room_type_id) REFERENCES public.rooms_types(room_type_id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2026-05-22 20:33:31 -05

--
-- PostgreSQL database dump complete
--

\unrestrict T3R5bGWcv0EuPHjT8tDpIx7glQ6zRcehJUygGdazoea4qAe0PMUdV4fG8qVNoUU

