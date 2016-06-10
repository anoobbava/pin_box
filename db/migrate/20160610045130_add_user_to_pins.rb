class AddUserToPins < ActiveRecord::Migration
  def change
    add_reference :pins, :user, index: true, foreign_key: true
  end
end
