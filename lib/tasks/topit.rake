require File.expand_path('../topit.rb', __FILE__)

namespace :topit do

  task :crawl_username => :environment do
    TopIt.new.crawl_username
  end

  task :update_username => :environment do
    TopIt.new.update_username
  end
end