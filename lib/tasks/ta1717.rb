require File.expand_path('../tool.rb', __FILE__)

class Ta1717

  include Tool

  DOMAIN = 'http://www.1717ta.com'
  ALBUMS_URL = 'http://www.1717ta.com/show'
  RANGE = (1..1000)

  attr_accessor :current_doc

  def crawl_albums
    RANGE.each do |i|
      album_url = "#{ALBUMS_URL}/#{i}.html"
      album_name = nil

      @current_doc = open_html(album_url)
      next if @current_doc.nil?
      next if Album.find_by_web_url(album_url)

      h1 = @current_doc.css('#conleft h1').first

      album_name = h1.content if h1

      album = Album.create(
          :web_url => album_url,
          :name => album_name
      )

      puts  album.inspect

    end
  end

  def crawl_photos
    Album.find_each do |album|
      next if album.id < 1323
      next if album.web_url.blank?

      @current_doc = open_html(album.web_url)
      next if @current_doc.nil?

      pagejump = @current_doc.css('#pagejump').first
      next if pagejump.nil?

      last_option = pagejump.css('option:last').first
      next if last_option.nil?

      page_num = last_option['value'].to_i
      1.upto(page_num) do |page|
        photo_url = album.web_url.gsub(/\/(\d+)\.html/, "/#{$1}_#{page}.html")
        @current_doc = open_html(photo_url)
        next if @current_doc.nil?

        img = @current_doc.css('#bimg img').first
        next if img.nil?

        next if Photo.find_by_web_url(img['src'])
        Photo.create(
            :web_url => img['src'],
            :album_id => album.id
        )

      end

    end
  end

  def fix_album_name
    Album.find_each do |album|
      album.name = album.name.gsub(/COSPLAY|COPSLAY/, '')
      album.save
    end
  end

  def create_tag_by_album_name
    Album.find_each do |album|
#      album.name.match(/《(.*)》/)
      tag_name = $1
      next if tag_name.nil?
      tag = Tag.find_by_name(tag_name)
      if tag.nil?
        tag = Tag.create(:name => tag_name)
      end
      puts tag.name
    end
  end

  def tag_photo_by_album_name
    Photo.find_each do |photo|
#      photo.album.name.match(/《(.*)》/)
      tag_name = $1
      next if tag_name.nil?
      tag = Tag.find_by_name(tag_name)
      next if tag.nil?
      photo.tags << tag
      puts tag.name
    end
  end

  def fix_tag
    Tag.find_each do |tag|
      tag.name = tag.name.gsub(' ',  '')
      tag.save
    end
  end

  def random_album
    album_ids = Album.all.collect{|a| a.id}
    Photo.find_each do |p|
      next if p.album_id
      p.album_id =  album_ids[rand(album_ids.size)]
      p.save
    end
  end

  def random_user
    album_ids = Album.all.collect{|a| a.id}
    city_ids = City.all.collect{|c| c.id}
    sex_ids = [0, 1]
    album_ids.each_with_index do |album_id, index|
      username = "test_#{index}"
      next if User.find_by_name(username)
      user = User.create(:name => username,
                  :sex => sex_ids[rand(2)],
                  :email => "icosplay_#{index}@icosplay.com",
                  :pwd => "test",
                  :avatar_id => 2,
                  :birthday => "19#{[8, 9][rand(2)]}#{rand(10)}/#{rand(12) + 1}/#{rand(28) + 1}",
                  :city_id => city_ids[rand(city_ids.size)]
      )

      album = Album.find(album_id)
      album.user = user
      album.save
    end
  end

  def download_cosplay_images
    Photo.find_each do |p|
      next if p.web_url.nil?
      new_file_path = p.id2(Pathname.new("/home/belen/Pictures/cosplay")) + '.jpg'
      next if File.exist?(new_file_path)
      secure_open(p.web_url) do |f|
        File.open(new_file_path, 'w') do |new_file|
          new_file.write f.read
        end
        puts "#{p.id}: already download"
      end
    end
  end

  def fix
      User.find_each do |u|
        if u.album.nil?
          u.album = Album.create(:user_id => u.id)
          u.save
        end
      end
  end
end