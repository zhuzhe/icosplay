class Tag < ActiveRecord::Base
  has_and_belongs_to_many :photos
  has_and_belongs_to_many :users , :join_table => 'users_tags'
end
