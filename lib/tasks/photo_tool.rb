require 'rubygems'
require 'mini_magick'

class PhotoTool

  def avatar_to_thumb
    Avatar.all.each
  end

  def to_thumb
    Photo.find_each do |photo|
      thumb_path = photo.id2(Pathname.new("/home/belen/Pictures/thumbs")) + '.jpg'
      next if File.exist?(thumb_path)
      next unless File.exist?(photo.id2path)
      image = MiniMagick::Image.open(photo.id2path)
      percent = (image[:width] * 10/image[:height]).round
      begin
        if percent > 8
          shaved_off = (image[:width] - image[:height] * (1 + 0.2))/2
          image.shave("#{shaved_off}x0")
        end
        if percent < 8
          shaved_off = (image[:height] - image[:width] * (1 - 0.2))/2
          image.shave("0x#{shaved_off}")
        end

        image.resize "245x200"
        image.write thumb_path

        puts "#{photo.id} already to thumb"
      rescue Exception => e
        puts e
        next
      end
    end
  end

end
