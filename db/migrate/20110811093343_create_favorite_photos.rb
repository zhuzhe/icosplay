class CreateFavoritePhotos < ActiveRecord::Migration
  def self.up
    create_table :favorite_photos, :id => false do |t|
      t.integer :user_id
      t.integer :photo_id
    end
  end

  def self.down
    drop_table :favorite_photos
  end
end
