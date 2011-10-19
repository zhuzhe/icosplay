require File.expand_path('../photo_tool.rb', __FILE__)
namespace :photo_tool   do
task :to_thumb => :environment do
  PhotoTool.new.to_thumb
end
end



