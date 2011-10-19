class User < ActiveRecord::Base
  validates_presence_of :name, :message => "请输入昵称"
  validates_presence_of :pwd, :message => "请输入密码"
  validates_presence_of :email, :message => "请输入邮箱"
  validates_presence_of :sex, :message => "请选择性别"
  validates_presence_of :birthday, :message => "请选择年龄"
  validates :pwd, :confirmation => {:message => "密码不相同"}
  validates :pwd_confirmation, :presence => {:message => "请输入重复密码"}
  validates_inclusion_of :sex, :in => 0..2, :message => "请选择正确的性别"
  validates :email, :uniqueness => {:message => "此邮箱已被占用"}


  has_one :member
  has_one :album
  has_one :avatar
  belongs_to :community
  belongs_to :city

  has_many :follower_rels, :class_name => 'Rel', :foreign_key => 'master_id'
  has_many :master_rels, :class_name => 'Rel', :foreign_key => 'follower_id'
  has_many :followers, :class_name => 'User', :through => :follower_rels
  has_many :masters, :class_name => 'User', :through => :master_rels
  has_many :received_messages, :foreign_key => 'to_id', :class_name => 'Message', :order => 'created_at DESC'
  has_many :delivered_messages, :foreign_key => 'from_id', :class_name => 'Message', :order => 'created_at DESC'
  has_many :photo_comments, :class_name => "Comment"
  has_and_belongs_to_many :tags, :join_table => 'users_tags'
  has_and_belongs_to_many :favorite_photos, :class_name => "Photo", :join_table => 'favorite_photos'


  FOUNDER = 1

  MALE = 0
  FEMALE = 1

  SHADOW = 0
  REAL = 1

  def age
    if self.birthday
      Time.now.year - self.birthday.year
    end
  end

  def sex_text
    case self.sex
      when MALE then
        '男'
      when FEMALE then
        '女'
    end
  end

end
