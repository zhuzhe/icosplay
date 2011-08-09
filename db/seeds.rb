# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


admin = User.new(:name => 'admin', :pwd => 'admin', :email => 'zhuzheiswho@sina.com', :sex => 1)

admin.save if admin.nil?

1.upto(50) do
  test_hot_users = User.create(:name => '粒沙', :pwd => 'test', :email => 'example@example.com', :sex => 1, :level => 5)
end

DEFAULT_AVATAR_URL = '/images/avatars/default.jpg'

User.all.each do |u|
  if u.avatar.nil?
    u.avatar = Avatar.create(:url => DEFAULT_AVATAR_URL)
    u.save
  end
  u.save
end

