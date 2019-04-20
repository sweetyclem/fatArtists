class UsersController < ApplicationController

  # GET /users/activate/1
  def activate
    if current_user.admin
      @user = User.find(params[:id])
      @user.profile.active = true
      @user.save!
      flash[:success] = 'User activated'
      redirect_to inactive_users_path
    end
  end
  
    
  # GET /users/inactive
  def inactive
    if current_user.admin
      @users = User.includes(:profile).where(profiles: { active: false })
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.id = current_user.id || current_user.admin
      @user.destroy
    end

    if @user.destroy
      redirect_to root_url, notice: "User deleted."
    end
  end

end
