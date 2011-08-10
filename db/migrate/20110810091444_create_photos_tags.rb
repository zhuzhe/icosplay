class CreatePhotosTags < ActiveRecord::Migration
  def self.up
    create_table :photos_tags, :id => false do |t|
      t.integer :photo_id, :default => 0
      t.integer :tag_id, :default => 0
    end
  end

  def self.down
    drop_table :photos_tags
  end
end
