class Photo < ActiveRecord::Base
  belongs_to :album
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :favorite_users, :class_name => "User", :join_table => 'favorite_photos'
  has_many :comments

  ROOT_DIR = Rails.root.join('public', 'images', 'cos', 'origin')
  THUMB_DIR = Rails.root.join('public', 'images', 'cos', 'thumbs')

  ORIGIN_RELATIVE_DIR = "cos/origin"
  THUMB_RELATIVE_DIR = "cos/thumbs"

  SUFFIX = ".jpg"

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
end
