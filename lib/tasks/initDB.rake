require File.expand_path('../initDB/initDB', __FILE__)

namespace :initDB do

  task :assign_avatar2user => :environment do
    InitDB.new.assign_avatar2user
  end

  task :assign_relations => :environment do
    InitDB.new.assign_relations
  end

  task :assign_avatar_url => :environment do
    InitDB.new.assign_avatar_url
  end

  task :change_default_url => :environment do
    InitDB.new.change_default_url
  end

  task :assign_photo_count => :environment do
    InitDB.new.assign_photo_count
  end

  task :assign_tag_level => :environment do
    InitDB.new.assign_tag_level
  end

  task :assign_user_birthday => :environment do
    InitDB.new.assign_user_birthday
  end
end