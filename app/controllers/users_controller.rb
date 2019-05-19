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
      @users = User.includes(:profile).where(profiles: { active: false }).where.not(email: "pirlot.clementine@gmail.com")
      @users = @users.paginate page: params[:page], per_page: 20
    end
  end

  # GET /users/active
  def active
    if current_user.admin
      @users = User.includes(:profile).where(profiles: { active: true })
      @users = @users.paginate page: params[:page], per_page: 20
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
  
    # POST /users/filter
    def filter
      if current_user.admin
        @users = User.includes(:profile).where(profiles: { active: true })
        if params[:search_term].present?
          @users = @users.joins(:profile).where("firstName LIKE ?", "%#{params[:search_term]}%").or(@users.joins(:profile).where("lastName LIKE ?", "%#{params[:search_term]}%")).or(@users.joins(:profile).where("website LIKE ?", "%#{params[:search_term]}%"))
        end
        @users = @users.joins(:profile).where(profiles: { location: params[:location] }) if params[:location].present?
        @users = @users.joins(:profile).where(profiles: { typeOfWork: params[:typeOfWork] }) if params[:typeOfWork].present?
        @users = @users.joins(:profile).where(profiles: { fatCategory: params[:fatCategory] }) if params[:fatCategory].present?
        @users = @users.joins(:profile).where(profiles: { orientation: params[:orientation] }) if params[:orientation].present?
        @users = @users.joins(:profile).where(profiles: { religion: params[:religion] }) if params[:religion].present?
        @users = @users.joins(:profile).where(profiles: { ethnicity: params[:ethnicity] }) if params[:ethnicity].present?
        @users = @users.paginate page: params[:page], per_page: 20
        @showFilter = false
        render "active"
      end
    end

end
