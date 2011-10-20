class AddUploadedToAvatar < ActiveRecord::Migration
  def self.up
    add_column :avatars, :uploaded, :boolean, :default => false
  end

  def self.down
    remove_column :avatars, :uploaded
  end
end
