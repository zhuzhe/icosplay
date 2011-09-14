class Avatar < ActiveRecord::Base
  validates_presence_of :url

  belongs_to :user

  MALE = 0
  FEMALE = 1
  OTHER = 2
end
