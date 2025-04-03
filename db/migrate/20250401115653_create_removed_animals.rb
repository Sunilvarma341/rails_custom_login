class CreateRemovedAnimals < ActiveRecord::Migration[7.2]
  def change
    create_table :removed_animals do |t|
      t.string :name

      t.timestamps
    end
  end
end
