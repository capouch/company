--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'LATIN1';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE brianc;
ALTER ROLE brianc WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN NOREPLICATION;
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION;
CREATE ROLE root;
ALTER ROLE root WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN NOREPLICATION;






--
-- Database creation
--

CREATE DATABASE brianc WITH TEMPLATE = template0 OWNER = brianc;
CREATE DATABASE company WITH TEMPLATE = template0 OWNER = brianc;
CREATE DATABASE school WITH TEMPLATE = template0 OWNER = brianc;
REVOKE ALL ON DATABASE template1 FROM PUBLIC;
REVOKE ALL ON DATABASE template1 FROM postgres;
GRANT ALL ON DATABASE template1 TO postgres;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;
CREATE DATABASE testgis WITH TEMPLATE = template0 OWNER = brianc;
ALTER DATABASE testgis SET search_path TO "$user", public, topology;


\connect brianc

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'LATIN1';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: bar; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE bar (
    one integer,
    two character varying
);


ALTER TABLE bar OWNER TO brianc;

--
-- Name: foo; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE foo (
    one integer,
    two integer
);


ALTER TABLE foo OWNER TO brianc;

--
-- Name: phones; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE phones (
    name character varying,
    brand character varying,
    cost integer,
    year_purchased integer
);


ALTER TABLE phones OWNER TO brianc;

--
-- Name: tryjson; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE tryjson (
    first jsonb,
    second json
);


ALTER TABLE tryjson OWNER TO brianc;

--
-- Data for Name: bar; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY bar (one, two) FROM stdin;
5	My first string
10	My second string
15	My third string
\.


--
-- Data for Name: foo; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY foo (one, two) FROM stdin;
1	3
3	5
\.


--
-- Data for Name: phones; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY phones (name, brand, cost, year_purchased) FROM stdin;
Galaxy S3	Samsung	80	2013
Buddy	Samsung	95	2014
\N	Motorola	\N	\N
\.


--
-- Data for Name: tryjson; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY tryjson (first, second) FROM stdin;
{"one": 1, "two": "two", "three": true}	\N
{"nother": 15, "aString": "Hello", "numbtwo": 4.25}	{"one": 1, "two": 2}
\.


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect company

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'LATIN1';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: department; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE department (
    dname character varying(15) NOT NULL,
    dnumber integer NOT NULL,
    mgr_ssn character(9) NOT NULL,
    mgr_start_date date
);


ALTER TABLE department OWNER TO brianc;

--
-- Name: dependent; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE dependent (
    essn character(9) NOT NULL,
    dependent_name character varying(15) NOT NULL,
    sex character(1),
    bdate date,
    relationship character varying(8)
);


ALTER TABLE dependent OWNER TO brianc;

--
-- Name: dept_locations; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE dept_locations (
    dnumber integer NOT NULL,
    dlocation character varying(15) NOT NULL
);


ALTER TABLE dept_locations OWNER TO brianc;

--
-- Name: employee; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE employee (
    fname character varying(15) NOT NULL,
    minit character(1),
    lname character varying(15) NOT NULL,
    ssn character(9) NOT NULL,
    bdate date,
    address character varying(30),
    sex character(1),
    salary numeric(10,2),
    super_ssn character(9),
    dno integer NOT NULL
);


ALTER TABLE employee OWNER TO brianc;

--
-- Name: project; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE project (
    pname character varying(15) NOT NULL,
    pnumber integer NOT NULL,
    plocation character varying(15) NOT NULL,
    dnum integer NOT NULL
);


ALTER TABLE project OWNER TO brianc;

--
-- Name: works_on; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE works_on (
    essn character(9) NOT NULL,
    pno integer NOT NULL,
    hours numeric(3,1)
);


ALTER TABLE works_on OWNER TO brianc;

--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY department (dname, dnumber, mgr_ssn, mgr_start_date) FROM stdin;
Research	5	333444555	1988-05-22
Administration	4	987654321	1995-01-01
Headquarters	1	888665555	1981-06-19
\.


--
-- Data for Name: dependent; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY dependent (essn, dependent_name, sex, bdate, relationship) FROM stdin;
333445555	Alice	F	1986-04-05	Daughter
333445555	Theodore	M	1983-10-25	Son
333445555	Joy	F	1958-05-03	Spouse
987654321	Abner	M	1942-02-28	Spouse
123456789	Michael	M	1988-01-04	Son
123456789	Alice	F	1988-12-30	Daughter
123456789	Elizabeth	F	1967-05-05	Spouse
\.


--
-- Data for Name: dept_locations; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY dept_locations (dnumber, dlocation) FROM stdin;
1	Houston
4	Stafford
5	Bellaire
5	Sugarland
5	Houston    
\.


--
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY employee (fname, minit, lname, ssn, bdate, address, sex, salary, super_ssn, dno) FROM stdin;
John	B	Smith	123456789	1965-01-09	731 Fondren, Houston, TX	M	30000.00	333445555	5
Franklin	T	Wong	333445555	1955-12-08	638 Voss, Houston, TX	M	40000.00	888665555	5
Alicia	J	Zelaya	999887777	1968-01-19	3321 Castle, Spring, TX	F	25000.00	987654321	4
Jennifer	S	Wallace	987654321	1941-06-20	291 Berry, Bellaire, TX	F	43000.00	888665555	4
Ramesh	K	Narayan	666884444	1962-09-15	975 Fire Oak, Humble, TX	M	38000.00	333445555	5
Joyce	A	English	453453453	1972-07-31	5631 Rice, Houston, TX	F	25000.00	333445555	5
Ahmad	V	Jabbar	987987987	1969-03-29	980 Dallas, Houston, TX	M	25000.00	987654321	4
James	E	Borg	888665555	1937-11-10	450 Stone, Houston, TX	M	55000.00	NULL     	1
\.


--
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY project (pname, pnumber, plocation, dnum) FROM stdin;
ProductX	1	Bellaire	5
ProductY	2	Sugarland	5
ProductZ	3	Houston	5
Computerization	10	Stafford	4
Reorganization	20	Houston	1
Newbenefits	30	Stafford	4
\.


--
-- Data for Name: works_on; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY works_on (essn, pno, hours) FROM stdin;
123456789	1	32.5
123456789	2	7.5
666884444	3	40.0
453453453	1	20.0
453453453	2	20.0
333445555	2	10.0
333445555	3	10.0
333445555	10	10.0
333445555	20	10.0
999887777	30	30.0
999887777	10	10.0
987987987	10	35.0
987987987	30	5.0
987654321	30	20.0
987654321	20	15.0
888665555	20	\N
\.


--
-- Name: department_dname_key; Type: CONSTRAINT; Schema: public; Owner: brianc; Tablespace: 
--

ALTER TABLE ONLY department
    ADD CONSTRAINT department_dname_key UNIQUE (dname);


--
-- Name: department_pkey; Type: CONSTRAINT; Schema: public; Owner: brianc; Tablespace: 
--

ALTER TABLE ONLY department
    ADD CONSTRAINT department_pkey PRIMARY KEY (dnumber);


--
-- Name: dependent_pkey; Type: CONSTRAINT; Schema: public; Owner: brianc; Tablespace: 
--

ALTER TABLE ONLY dependent
    ADD CONSTRAINT dependent_pkey PRIMARY KEY (essn, dependent_name);


--
-- Name: dept_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: brianc; Tablespace: 
--

ALTER TABLE ONLY dept_locations
    ADD CONSTRAINT dept_locations_pkey PRIMARY KEY (dnumber, dlocation);


--
-- Name: employee_pkey; Type: CONSTRAINT; Schema: public; Owner: brianc; Tablespace: 
--

ALTER TABLE ONLY employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (ssn);


--
-- Name: project_pkey; Type: CONSTRAINT; Schema: public; Owner: brianc; Tablespace: 
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_pkey PRIMARY KEY (pnumber);


--
-- Name: works_on_pkey; Type: CONSTRAINT; Schema: public; Owner: brianc; Tablespace: 
--

ALTER TABLE ONLY works_on
    ADD CONSTRAINT works_on_pkey PRIMARY KEY (essn, pno);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'LATIN1';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect school

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'LATIN1';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: course; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE course (
    course_name character varying,
    course_number character varying,
    credit_hours integer,
    department character varying
);


ALTER TABLE course OWNER TO brianc;

--
-- Name: grade_report; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE grade_report (
    student_number integer,
    section_identifier integer,
    grade character varying
);


ALTER TABLE grade_report OWNER TO brianc;

--
-- Name: prerequisite; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE prerequisite (
    course_number character varying,
    prerequisite_number character varying
);


ALTER TABLE prerequisite OWNER TO brianc;

--
-- Name: section; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE section (
    section_identifier integer,
    course_number character varying,
    semester character varying,
    year integer,
    instructor character varying
);


ALTER TABLE section OWNER TO brianc;

--
-- Name: student; Type: TABLE; Schema: public; Owner: brianc; Tablespace: 
--

CREATE TABLE student (
    name character varying,
    student_number integer,
    class integer,
    major character varying
);


ALTER TABLE student OWNER TO brianc;

--
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY course (course_name, course_number, credit_hours, department) FROM stdin;
Intro to CS	CS1310	4	CS
Data Structures	CS3320	4	CS
Discrete Mathematics	MATH2410	3	MATH
Database	CS3380	3	CS
\.


--
-- Data for Name: grade_report; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY grade_report (student_number, section_identifier, grade) FROM stdin;
17	112	B
8	85	A
17	119	C
8	92	A
8	102	B
8	135	A
\.


--
-- Data for Name: prerequisite; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY prerequisite (course_number, prerequisite_number) FROM stdin;
CS3380	CS3320
CS3380	MATH2410
CS3320	CS1310
\.


--
-- Data for Name: section; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY section (section_identifier, course_number, semester, year, instructor) FROM stdin;
85	MATH2410	Fall	7	King
102	CS3320	Spring	8	Knuth
92	CS1310	Fall	7	Anderson
112	MATH2410	Fall	8	Chang
119	CS1310	Fall	8	Anderson
135	CS3380	Fall	8	Stone
\.


--
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY student (name, student_number, class, major) FROM stdin;
Smith	17	1	CS
Brown	8	2	CS
Brown	8	2	CS
\.


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'LATIN1';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect testgis

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'LATIN1';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: brianc
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO brianc;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET search_path = public, pg_catalog;

--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: brianc
--

COPY spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


SET search_path = topology, pg_catalog;

--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: brianc
--

COPY layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: brianc
--

COPY topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

