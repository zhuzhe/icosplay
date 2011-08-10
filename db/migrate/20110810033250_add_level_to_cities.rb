class AddLevelToCities < ActiveRecord::Migration
  def self.up
    add_column :cities, :level, :integer
  end

  def self.down
    remove_column :cities, :level
  end
end
