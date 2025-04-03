class CreateTriggerSaveDeletedSameAnimalName < ActiveRecord::Migration[7.2]
  def change
    create_trigger :save_deleted_same_animal_name, on: :animals
  end
end
