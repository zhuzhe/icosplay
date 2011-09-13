require File.expand_path('../tool.rb', __FILE__)


class TopIt

  include Tool

  ROOT = "http://www.topit.me"
  USERS_PATH = "http://topit.me/users/more"
  NICK_NAME_FILE = Rails.root.join("lib", "nicks")
  USER_PAGES_RANGE = (1..504)

  SPACE = " "

  attr_accessor :current_doc

  def crawl_username
    File.open(NICK_NAME_FILE, 'w') do |file|
      USER_PAGES_RANGE.each do |page|
        @current_doc = open_html("#{USERS_PATH}?p=#{page}")
        next if @current_doc.nil?
        @current_doc.css("#users .user").each do |div|
          file << "#{div.css('.who').text}#{SPACE}"
          puts "#{div.css('.who').text}"
        end
      end
    end
  end

  def update_username
    File.open(NICK_NAME_FILE, 'r') do |file|
      file.read.split(SPACE).each_with_index do |nick_name, index|
        user = User.find_by_id(index + 1)
        next if user.nil?
        user.name = nick_name
        user.save
      end
    end

  end

end