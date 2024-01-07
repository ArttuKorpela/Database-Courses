CREATE FUNCTION check_habitat_overbooking() 
RETURNS TRIGGER AS
'
DECLARE
    animal_size FLOAT;
    total_space FLOAT;
    n INT;
BEGIN
    SELECT size INTO total_space FROM habitat WHERE HID = NEW.HID;
    SELECT spaceRequirements INTO animal_size FROM AnimalSpecies WHERE AID = NEW.AID;

    SELECT 
        COUNT(*) 
    INTO
        n
    FROM 
        specimen
    WHERE
        specimen.AID = NEW.AID AND
        specimen.HID = NEW.HID;

    IF animal_size*n > total_space THEN
        RAISE WARNING ''% Compound is overbooked by % / %'', NEW.HID,animal_size*n ,total_space;
    END IF;

    RETURN NEW;
END;
'
LANGUAGE plpgsql;

CREATE TRIGGER check_habitat_overbooking
AFTER INSERT OR UPDATE ON Specimen
FOR EACH ROW
EXECUTE PROCEDURE check_habitat_overbooking();