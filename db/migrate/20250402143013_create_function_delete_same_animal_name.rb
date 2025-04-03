class CreateFunctionDeleteSameAnimalName < ActiveRecord::Migration[7.2]
  def change
    create_function :delete_same_animal_name
  end
end
