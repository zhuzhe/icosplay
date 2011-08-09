require File.expand_path('../ta1717.rb', __FILE__)
require 'rake'

task :crawl_albums => :environment do
   Ta1717.new.crawl_albums
end

task :crawl_photos => :environment do
  Ta1717.new.crawl_photos
end