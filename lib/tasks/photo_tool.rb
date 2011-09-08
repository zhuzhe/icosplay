require 'rubygems'
require 'mini_magick'

class PhotoTool

  def avatar_to_thumb
    Avatar.all.each
  end

  def to_thumb
    Photo.limit(10).each do |photo|
      next if photo.web_url.nil?
      image = MiniMagick::Image.open(photo.web_url)
      percent = (image[:width] * 10/image[:height]).round

      if percent > 8
        shaved_off = (image[:width] - image[:height] * (1 + 0.2))/2
         image.shave("#{shaved_off}x0")
      end
      if percent < 8
        shaved_off = (image[:height] - image[:width] * (1 - 0.2))/2
         image.shave("0x#{shaved_off}")
      end

      image.resize "245x200"
      image.write "#{photo.id2thumb}.#{photo.web_url.split(".").last}"
    end
  end

end
