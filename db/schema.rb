# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_04_24_173829) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "animals", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "removed_animals", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "request_loggers", force: :cascade do |t|
    t.string "path"
    t.string "method"
    t.text "params"
    t.string "ip"
    t.string "user_agent"
    t.string "user_id"
    t.integer "status"
    t.float "response_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedule_meetings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.string "description", default: ""
    t.boolean "is_recurring", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end
  create_function :log_new_animal_record_in_removed_animals_db, sql_definition: <<-'SQL'
      CREATE OR REPLACE FUNCTION public.log_new_animal_record_in_removed_animals_db()
       RETURNS trigger
       LANGUAGE plpgsql
      AS $function$ 
      BEGIN
       INSERT INTO removed_animals (id,name,created_at,updated_at)
       VALUES (NEW.id, NEW.name, NEW.created_at,NEW.updated_at); 
       return NEW; 
      END;
      $function$
  SQL
  create_function :log_new_animal, sql_definition: <<-'SQL'
      CREATE OR REPLACE FUNCTION public.log_new_animal()
       RETURNS trigger
       LANGUAGE plpgsql
      AS $function$
      BEGIN
        INSERT INTO removed_animals (name,created_at , updated_at)
        VALUES (NEW.name, NOW(), NOW() );
        RETURN NEW;
      END;
      $function$
  SQL
  create_function :delete_same_animal_name, sql_definition: <<-'SQL'
      CREATE OR REPLACE FUNCTION public.delete_same_animal_name()
       RETURNS trigger
       LANGUAGE plpgsql
      AS $function$ 
      BEGIN
          DELETE FROM removed_animals   WHERE name = OLD.name;
          RETURN OLD; 
      END; 
      $function$
  SQL


  create_trigger :save_deleted_same_animal_name, sql_definition: <<-SQL
      CREATE TRIGGER save_deleted_same_animal_name BEFORE DELETE ON public.animals FOR EACH ROW EXECUTE FUNCTION delete_same_animal_name()
  SQL
  create_trigger :save_inserted_animal_changes, sql_definition: <<-SQL
      CREATE TRIGGER save_inserted_animal_changes AFTER INSERT ON public.animals FOR EACH ROW EXECUTE FUNCTION log_new_animal()
  SQL
end
