class Photo < ActiveRecord::Base
  belongs_to :album
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :favorite_users, :class_name => "User", :join_table => 'favorite_photos'
end
