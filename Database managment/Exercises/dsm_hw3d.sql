CREATE FUNCTION check_specimen() 
RETURNS TRIGGER AS
'
DECLARE
    parent_gender CHAR(1);
    n INT;
BEGIN
    SELECT specimen.gender INTO parent_gender FROM ancestry,specimen WHERE specimen.EID = ancestry.parent
    AND ancestry.EID = NEW.EID;

    IF parent_gender IS NULL THEN
    RAISE EXCEPTION ''Parent gender is set to NULL.'';
    END IF;

   
    


    RETURN NEW;
END;
'
LANGUAGE plpgsql;

CREATE FUNCTION test()
RETURNS TRIGGER AS
'
DECLARE
    n INT;
BEGIN
    N := 0;

    SELECT COUNT(*) INTO N FROM Ancestry a1
        JOIN Ancestry a2 ON a1.EID = a2.EID
        JOIN Specimen s1 ON a1.Parent = s1.EID
    WHERE
        a1.Parent <> a2.Parent AND
        a2.parent = NEW.EID AND
        s1.Gender = NEW.Gender AND
        
    IF (N > 0) THEN
        RAISE EXCEPTION ''Offspring already has this gender parent, fix ancestries first.'';
    END IF;

    RETURN NEW;
END;
'
LANGUAGE plpgsql;
CREATE TRIGGER test
AFTER INSERT OR UPDATE ON Specimen
FOR EACH ROW
EXECUTE PROCEDURE test();


CREATE TRIGGER check_specimen
AFTER INSERT OR UPDATE ON Specimen
FOR EACH ROW
EXECUTE PROCEDURE check_specimen();

CREATE FUNCTION check_ancestry() 
RETURNS TRIGGER AS
'
DECLARE
    parent_gender CHAR(1);
    n INT;
BEGIN
    SELECT specimen.gender INTO parent_gender FROM specimen WHERE specimen.EID = NEW.parent;

    IF parent_gender IS NULL THEN
    RAISE EXCEPTION ''Parent gender is set to NULL.'';
    END IF;

    SELECT COUNT(*) INTO N FROM Specimen s1
    JOIN Ancestry a1 ON s1.EID = a1.EID
    WHERE s1.EID = NEW.EID;
    
   
    
    IF (n > 2) THEN
        RAISE EXCEPTION ''Offspring already has two parents.'';
    END IF;
    
 

    N := 0;

    SELECT COUNT(*) INTO N FROM Ancestry a1
        JOIN Ancestry a2 ON a1.EID = a2.EID
        JOIN Specimen s1 ON a1.Parent = s1.EID
        JOIN Specimen s2 ON a2.Parent = s2.EID
    WHERE
        a1.Parent <> a2.Parent AND
        s1.Gender = s2.Gender AND
        a1.EID = NEW.EID;
        
    IF (N > 0) THEN
        RAISE EXCEPTION ''Offspring already has this gender parent, fix ancestries first.'';
    END IF;

    RETURN NEW;
END;
'
LANGUAGE plpgsql;

CREATE TRIGGER check_ancestry
AFTER INSERT OR UPDATE ON Ancestry
FOR EACH ROW
EXECUTE PROCEDURE check_ancestry();