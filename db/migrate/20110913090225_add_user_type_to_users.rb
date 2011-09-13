class AddUserTypeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :user_type, :integer
  end

  def self.down
    remove_column :users, :user_type
  end
end
