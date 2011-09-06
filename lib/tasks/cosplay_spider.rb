require File.expand_path('../ta1717.rb', __FILE__)
require 'rake'

task :crawl_albums => :environment do
   Ta1717.new.crawl_albums
end

task :crawl_photos => :environment do
  Ta1717.new.crawl_photos
end

task :fix_album_name => :environment do
   Ta1717.new.fix_album_name
end

task :create_tag_by_album_name => :environment do
  Ta1717.new.create_tag_by_album_name
end

task :tag_photo_by_album_name => :environment do
  Ta1717.new.tag_photo_by_album_name
end

task :fix_tag => :environment do
  Ta1717.new.fix_tag
end

task :random_album => :environment do
  Ta1717.new.random_album
end

task :random_user => :environment do
  Ta1717.new.random_user
end

task :fix => :environment do
  Ta1717.new.fix
end