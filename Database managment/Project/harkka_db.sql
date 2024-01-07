CREATE OR REPLACE PROCEDURE public.extend_contracts()
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	UPDATE employee SET contract_end =
        CASE
            WHEN contract_end IS NOT NULL THEN contract_end + interval '3 month'
            ELSE contract_end
        END;
END;
$BODY$;


CREATE TABLE employee_part (
    e_id integer NOT null UNIQUE,
    emp_name varchar,
    email varchar,
	contract_type varchar,
	contract_start date,
	contract_end date,
	salary integer,
	supervisor integer,
	d_id integer,
	j_id integer,
	PRIMARY KEY(e_id),
	CONSTRAINT fk_supervisor
		FOREIGN KEY(e_id)
			REFERENCES employee_part(e_id),
	CONSTRAINT fk_d_id
		FOREIGN KEY(d_id)
			REFERENCES department(d_id),
	CONSTRAINT fk_j_id
		FOREIGN KEY(j_id)
			REFERENCES job_title(j_id)

	
) PARTITION BY RANGE (e_id);


CREATE TABLE employee_one PARTITION OF employee_part FOR VALUES FROM (0) TO (1500);
CREATE TABLE employee_two PARTITION OF employee_part FOR VALUES FROM (1500) TO (3000);
CREATE TABLE employee_three PARTITION OF employee_part FOR VALUES FROM (3000) TO (4500);
CREATE TABLE employee_four PARTITION OF employee_part FOR VALUES FROM (4500) TO (6000);

CREATE TABLE customer_part (
    c_id integer UNIQUE NOT null,
    c_name varchar,
    c_type varchar,
	phone varchar,
	email varchar,
	l_id integer,
	PRIMARY KEY(c_id),
	CONSTRAINT fk_l_id
		FOREIGN KEY(l_id)
			REFERENCES geo_location(l_id)

) PARTITION BY RANGE (c_id);


CREATE TABLE customer_one PARTITION OF customer_part FOR VALUES FROM (0) TO (300);
CREATE TABLE customer_two PARTITION OF customer_part FOR VALUES FROM (300) TO (600);
CREATE TABLE customer_three PARTITION OF customer_part FOR VALUES FROM (600) TO (900);
CREATE TABLE customer_four PARTITION OF customer_part FOR VALUES FROM (900) TO (1200);

CREATE ROLE admin SUPERUSER LOGIN;
CREATE ROLE employee LOGIN;
CREATE ROLE trainee LOGIN;

GRANT ALL PRIVILEGES ON DATABASE project_database TO admin;
REVOKE ALL ON DATABASE project_database FROM employee;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO employee;
GRANT SELECT ON project, customer, geo_location, project_role TO trainee;
CREATE VIEW employee_view AS SELECT id, name, email FROM employee;
GRANT SELECT ON employee_view TO trainee;


CREATE OR REPLACE FUNCTION set_contract_dates() 
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.contract_type = 'Temporary' THEN
        NEW.contract_start = CURRENT_DATE;
        NEW.contract_end = NEW.contract_start_date + INTERVAL '2 years';
    ELSE
		NEW.contract_start = CURRENT_DATE;
        NEW.contract_end = NULL;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_contract_dates_trigger
BEFORE UPDATE OF contract_type ON employee
FOR EACH ROW
EXECUTE FUNCTION set_contract_dates();


CREATE VIEW employee_skills_view AS
SELECT e.emp_name, array_agg(s.skill) AS skills
FROM employee e
JOIN employee_skills es ON e.e_id = es.e_id
JOIN skills s ON es.s_id = s.s_id
GROUP BY e.name, e.e_id;


ALTER TABLE geo_location
ADD COLUMN zip_code int;


ALTER TABLE customer
ALTER COLUMN email SET NOT NULL;

ALTER TABLE project
ALTER COLUMN p_start_date SET NOT NULL;

ALTER TABLE employee ADD CONSTRAINT chk_employee_salary CHECK (salary > 1000);

