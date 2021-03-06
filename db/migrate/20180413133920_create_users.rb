class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :role
      t.string :email
      t.string :phone
      t.boolean :active, default: true 

      t.timestamps
    end
  end
end
