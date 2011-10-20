class AddLevelToTag < ActiveRecord::Migration
  def self.up
    add_column :tags, :level, :integer, :default => 0
  end

  def self.down
    remove_column :tags, :level
  end
end
