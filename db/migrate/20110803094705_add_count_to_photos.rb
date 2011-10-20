class AddCountToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :count, :integer
  end

  def self.down
    remove_column :photos, :count
  end
end
