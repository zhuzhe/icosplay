class UserObserver < ActiveRecord::Observer
  def after_create user
     Album.create(:user_id => user.id)
  end
end
