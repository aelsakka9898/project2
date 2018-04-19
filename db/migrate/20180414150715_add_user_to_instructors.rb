class AddUserToInstructors < ActiveRecord::Migration[5.1]
  def change
    add_reference :instructors, :user, foreign_key: true
  end
end
