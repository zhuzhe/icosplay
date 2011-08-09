class Avatar < ActiveRecord::Base
  validates_presence_of :url

  belongs_to :user
end
