class CreateRequestLoggers < ActiveRecord::Migration[7.2]
  def change
    create_table :request_loggers do |t|
      t.string :path
      t.string :method
      t.text :params
      t.string :ip
      t.string :user_agent
      t.string :user_id
      t.integer :status
      t.float :response_time

      t.timestamps
    end
  end
end
