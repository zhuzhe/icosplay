class AddUserIdToAvatars < ActiveRecord::Migration
  def self.up
    add_column :avatars, :user_id, :integer
  end

  def self.down
    remove_column :avatars, :user_id
  end
end
