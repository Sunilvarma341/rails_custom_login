class AddResetPasswordFieldsToUser < ActiveRecord::Migration[7.2]
  def change
    change_table :users do |t|
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
    end
    change_column :users, :email, :string, null: false
    add_index :users, :email,  unique: true
  end
end
