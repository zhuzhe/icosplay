require File.expand_path('../initDB/initDB', __FILE__)

namespace :initDB  do

  task :assign_avatar2user => :environment do
    InitDB.new.assign_avatar2user
  end

end
