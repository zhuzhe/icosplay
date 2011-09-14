class AddCategoryToAvatars < ActiveRecord::Migration
  def self.up
    add_column :avatars, :category, :integer, :default => 0
  end

  def self.down
    remove_column :avatars, :category
  end
end
