CREATE TRIGGER save_deleted_same_animal_name 
BEFORE DELETE ON animals 
FOR EACH ROW 
EXECUTE FUNCTION delete_same_animal_name();