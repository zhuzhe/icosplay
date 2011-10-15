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
  
  def assign_relations 
    user_ids = Boy.all.collect{ |u| u.id }
    Boy.find_each do |u|  
        master_ids = []
        0.upto(rand(10)) do |i|
           master_id = user_ids[rand(user_ids.length)]
           next if master_ids.include?(master_id)
           master_ids << master_id  
        end
        u.master_ids = master_ids
        u.save
    end
  end


end