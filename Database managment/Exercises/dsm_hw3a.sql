
CREATE FUNCTION check_ancestry_age() RETURNS TRIGGER AS
'
BEGIN
    IF EXISTS (
        SELECT
        	NEW.parent,
            NEW.EID,
            s1.EID,
            s2.EID
        FROM 
            specimen s1, specimen s2
        WHERE 
            s1.EID = NEW.parent
            AND s2.EID = NEW.EID
            AND s1.BirthDate > s2.BirthDate
    ) THEN
        RAISE EXCEPTION ''Has older offsprings, fix ancestries first.'';
    END IF;
    RETURN NEW;
END;
' 
LANGUAGE plpgsql;

CREATE FUNCTION check_specimen_age() RETURNS TRIGGER AS
'
BEGIN
    IF EXISTS (
        SELECT
        	NEW.EID,
            s1.EID,
            a1.parent,
            a1.EID
        FROM 
            specimen s1, ancestry a1
        WHERE 
            a1.parent = NEW.EID
            AND s1.EID = a1.EID
            AND NEW.BirthDate > s1.BirthDate

    ) THEN
        RAISE EXCEPTION ''Has older offsprings, fix ancestries first.'';
    END IF;
    RETURN NEW;
END;
' 
LANGUAGE plpgsql;

CREATE TRIGGER trigger_ancestry_age
BEFORE INSERT OR UPDATE ON Ancestry
FOR EACH ROW
EXECUTE PROCEDURE check_ancestry_age();

CREATE TRIGGER trigger_specimen_age
BEFORE INSERT OR UPDATE ON specimen
FOR EACH ROW
EXECUTE PROCEDURE check_specimen_age();

