class Avatar < ActiveRecord::Base
  validates_presence_of :url

  belongs_to :user

  MALE = 0
  FEMALE = 1
  OTHER = 2

  ROOT_DIR = Rails.root.join('public', 'images', 'avatar')
  RELATIVE_DIR = "avatars"

  SUFFIX = ".jpg"

  DEFAULT = "default_avatar.jpg"


  def id2 root
    dir1, dir2, file = self.id.to_s.rjust(9, '0').scan(/\d{3}/)
    Dir.mkdir(root.join(dir1)) unless File.directory?(root.join(dir1))
    Dir.mkdir(root.join(dir1, dir2)) unless File.directory?(root.join(dir1, dir2))
    root.join(dir1, dir2, file).to_s
  end

  def id2relative_path
    self._relative_path(RELATIVE_DIR)
  end

  def _relative_path root
    self.id.to_s.rjust(9, '0').scan(/\d{3}/).inject(root) { |path, f| "#{path}/#{f}" } + SUFFIX
  end
end
