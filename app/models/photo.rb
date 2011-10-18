class Photo < ActiveRecord::Base
  require "mini_magick"

  belongs_to :album
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :favorite_users, :class_name => "User", :join_table => 'favorite_photos'
  has_many :comments

  ROOT_DIR = Rails.root.join('public', 'images', 'cos', 'origin')
  THUMB_DIR = Rails.root.join('public', 'images', 'cos', 'thumbs')

  ORIGIN_RELATIVE_DIR = "cos/origin"
  THUMB_RELATIVE_DIR = "cos/thumbs"

  HOT = (500..1000)
  RECOMMEND = (200..1000)


  SUFFIX = ".jpg"

  after_destroy :destroy_photo_file

  def id2path
    self.id2(ROOT_DIR) + SUFFIX
  end

  def id2relative_path
    self._relative_path(ORIGIN_RELATIVE_DIR)
  end

  def id2thumb
    self.id2(THUMB_DIR) + SUFFIX
  end

  def id2thumb_relative_path
    self._relative_path(THUMB_RELATIVE_DIR)
  end

  def id2 root
    dir1, dir2, file = self.id.to_s.rjust(9, '0').scan(/\d{3}/)
    Dir.mkdir(root.join(dir1)) unless File.directory?(root.join(dir1))
    Dir.mkdir(root.join(dir1, dir2)) unless File.directory?(root.join(dir1, dir2))
    root.join(dir1, dir2, file).to_s
  end

  def _relative_path root
    self.id.to_s.rjust(9, '0').scan(/\d{3}/).inject(root) { |path, f| "#{path}/#{f}" } + SUFFIX
  end

  def create_thumb
    image = MiniMagick::Image.open(self.id2path)
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
    image.write self.id2thumb
  end

  def destroy_photo_file
    [self.id2path, self.id2thumb].each do |path|
      if File.exists?(path)
        File.delete(path)
      end
    end
  end

  def self.get_recommends
    Photo.where("count <= #{Photo::RECOMMEND.max} AND count >= #{Photo::RECOMMEND.min}").order("count DESC")
  end

  def self.get_hots
    Photo.where("count <= #{Photo::HOT.max} AND count >= #{Photo::HOT.min}").order("count DESC")
  end
end
