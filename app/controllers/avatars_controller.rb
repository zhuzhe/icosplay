class AvatarsController < ApplicationController  
    
  def update
    @user = current_user
    uploaded_io = params[:avatar]
    @avatar = @user.avatar

    File.open(@avatar.id2path, 'w') do |file|
      file.write(uploaded_io.read)
    end

    @avatar.url = @avatar.id2relative_path
    @avatar.save

    redirect_to user_path(@user)
  end  
  
end
