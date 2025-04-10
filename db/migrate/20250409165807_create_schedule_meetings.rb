class CreateScheduleMeetings < ActiveRecord::Migration[7.2]
  def change
    create_table :schedule_meetings, id: :uuid  do |t|
      t.string :name,  null: false
      t.datetime :start_time,  null:  false
      t.datetime :end_time,  null: false
      t.string :description, default: ""
      t.boolean :is_recurring,  default: false

      t.timestamps
    end
  end
end
