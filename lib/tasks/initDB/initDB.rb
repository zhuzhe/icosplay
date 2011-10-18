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

  def assign_avatar_url
    Avatar.find_each do |avatar|
      next if avatar.url.match(/^http/).nil?
      if File.exist?(avatar.id2(Pathname.new("/home/belen/Pictures/avatar")) + ".jpg")
        avatar.url = avatar.id2relative_path
      else
        avatar.url = Avatar::DEFAULT
      end
      avatar.save
      puts "#{avatar.id} : #{avatar.url}"
    end
  end

  def change_default_url
    Avatar.find_each do |avatar|
      if avatar.url.match("avatars/default.jpg")
        avatar.uploaded =  false
        avatar.url = Avatar::DEFAULT
      else
        avatar.uploaded= true
      end
      avatar.save
      puts "#{avatar.url}"
    end
  end

  def assign_photo_count
    Photo.find_each do |photo|
      photo.count = rand(1000)
      photo.save
      puts photo.count
    end
  end

  def assign_tag_level
    Tag.find_each do |tag|
      tag.level = rand(6)
      tag.save
      puts tag.level
    end
  end


end