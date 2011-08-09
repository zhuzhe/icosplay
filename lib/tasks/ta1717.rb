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
end