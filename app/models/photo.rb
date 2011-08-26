class Photo < ActiveRecord::Base
  belongs_to :album
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :favorite_users, :class_name => "User", :join_table => 'favorite_photos'
  has_many :comments

  ROOT_DIR = Rails.root.join('public', 'uploads')

  def id2path
    dir1, dir2, file = self.id.to_s.rjust(9, '0').scan(/\d{3}/)
    Dir.mkdir(ROOT_DIR.join(dir1)) unless File.directory?(ROOT_DIR.join(dir1))
    Dir.mkdir(ROOT_DIR.join(dir1, dir2)) unless File.directory?(ROOT_DIR.join(dir1, dir2))
    ROOT_DIR.join(dir1, dir2, file).to_s
  end

  def id2relative_path
    self.id.to_s.rjust(9, '0').scan(/\d{3}/).inject("/uploads") {|path, f| "#{path}/#{f}"}
  end
end
