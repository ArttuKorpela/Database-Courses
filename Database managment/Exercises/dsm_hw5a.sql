CREATE ROLE db_user;
CREATE ROLE db_owner;
CREATE ROLE db_manager;


GRANT ALL ON Orders TO db_owner;
GRANT INSERT ON Orders to db_manager;
GRANT SELECT ON Orders to db_user;