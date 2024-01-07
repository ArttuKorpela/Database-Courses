CREATE FUNCTION check_habitat_and_temperature() RETURNS TRIGGER AS
'
    IF AnimalSpecies.Habitat ILIKE (''%'' || NEW.Name || ''%''); THEN
        RAISE NOTICE ''Correct habitat'';
    ELSE
        RAISE EXCEPTION ''Not the correct habitat'';
    END IF;
    
    IF ABS(NEW.Temperature - OLD.temperature) > 7 THEN
        RAISE EXCEPTION ''The Temperature difference can kill animals'';
    END IF;
    
    RETURN NEW;
END;
'
LANGUAGE plpgsql;

CREATE TRIGGER check_habitat_and_temperature_animalspecies
BEFORE INSERT OR UPDATE ON habitat
FOR EACH ROW
EXECUTE PROCEDURE check_habitat_and_temperature();

CREATE TRIGGER check_habitat_and_temperature_specimen
BEFORE INSERT OR UPDATE ON Specimen
FOR EACH ROW
EXECUTE PROCEDURE check_habitat_and_temperature();