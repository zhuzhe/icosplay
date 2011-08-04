class User < ActiveRecord::Base
  validates_presence_of :name, :pwd, :email, :sex
  validates_confirmation_of :pwd
  validates_inclusion_of :sex, :in => 0..2

  has_one :member
  has_one :album
  belongs_to :community


  FOUNDER = 1

end
