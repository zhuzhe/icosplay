class Tag < ActiveRecord::Base
  has_and_belongs_to_many :photos
  has_and_belongs_to_many :users, :join_table => 'users_tags'

  SEPARATOR = ' '

  def self.create_from_text text
    text.split(SEPARATOR).inject([]) do |tag_ids, tag_name|
      tag = Tag.find_by_name(tag_name)
      if tag.nil?
        tag = Tag.create(:name => tag_name)
      end
      tag_ids << tag.id
    end
  end
end
