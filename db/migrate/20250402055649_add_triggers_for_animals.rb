class AddTriggersForAnimals < ActiveRecord::Migration[7.2]
  def up
    # execute(<<~SQL)
    #   CREATE OR REPLACE FUNCTION  insert_same_animal_data_in_removed_animals()
    #   RETURN TRIGGER AS $$
    #   BEGIN
    #     INSERT INTO removed_animals (id, name ,  updated_at ,  created_at) VALUES (NEW.id , NEW.name, NEW.updated_at , NEW.created_at)
    #     RETURN NEW;
    #   END;
    #   $$ LANGUAGE plpgsql;
    # SQL
    execute(<<~SQL)
      CREATE OR REPLACE FUNCTION log_new_animal()
      RETURNS TRIGGER AS $$
      BEGIN
        INSERT INTO removed_animals (name,created_at , updated_at)
        VALUES (NEW.name, NOW(), NOW() );
        RETURN NEW;
      END;
      $$ LANGUAGE plpgsql;
    SQL

    execute(<<~SQL)
        CREATE TRIGGER save_inserted_animal_changes
        AFTER INSERT ON animals FOR EACH ROW EXECUTE FUNCTION  log_new_animal()
    SQL
  end

  def down
    execute("DROP TRIGGER IF EXISTS save_inserted_animal_changes ON animals;")
    execute("DROP FUNCTION IF EXISTS log_new_animal();")
  end
end
