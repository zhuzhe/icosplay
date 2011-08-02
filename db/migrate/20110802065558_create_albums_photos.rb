class CreateAlbumsPhotos < ActiveRecord::Migration
  def self.up
    create_table :albums_photos do |t|
      t.integer :album_id
      t.integer :photo_id

      t.timestamps
    end
  end

  def self.down
    drop_table :albums_photos
  end
end
