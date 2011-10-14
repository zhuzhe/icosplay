class InitDB


  def assign_avatar2user
    avatar_ids = Avatar.where("url != '/images/avatars/default.jpg'").collect { |a| a.id }
    User.find_each do |u|
      avatar = Avatar.find(avatar_ids[rand(avatar_ids.length)])
      if u.avatar
        u.avatar.url = avatar.url
        u.save
      else
        Avatar.create(:url => avatar.url, :user_id => u.id)
      end
      puts "#{u.id}:#{u.avatar(true).id}"
    end
  end


end