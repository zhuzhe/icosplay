class AddWebUrlToAlbums < ActiveRecord::Migration
  def self.up
    add_column :albums, :web_url, :string
  end

  def self.down
    remove_column :albums, :web_url
  end
end
