class AddWebUrlToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :web_url, :string
  end

  def self.down
    remove_column :photos, :web_url
  end
end
