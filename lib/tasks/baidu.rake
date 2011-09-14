require File.expand_path("../baidu/avatar_spider.rb", __FILE__)

namespace :baidu do
  task :crawl_avatar => :environment do
     BaiDu::AvatarSpider.new.crawl_avatar
  end

  task :crawl_girl_avatar => :environment do
    BaiDu::AvatarSpider.new.crawl_girl_avatar
  end

  task :crawl_boy_avatar => :environment do
    BaiDu::AvatarSpider.new.crawl_boy_avatar
  end

  task :crawl_other_avatar => :environment do
    BaiDu::AvatarSpider.new.crawl_other_avatar
  end
end