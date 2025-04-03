CREATE OR REPLACE FUNCTION  delete_same_animal_name() 
RETURNS TRIGGER AS $$ 
BEGIN
    DELETE FROM removed_animals   WHERE name = OLD.name;
    RETURN OLD; 
END; 
$$ LANGUAGE plpgsql;     

