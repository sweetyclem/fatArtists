class ProfilesController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :filter]
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end
  
  # POST /profiles/filter
  def filter
    @profiles = Profile.all
    @profiles = @profiles.where(location: params[:location]) if params[:location].present?
    @profiles = @profiles.where(typeOfWork: params[:typeOfWork]) if params[:typeOfWork].present?
    @profiles = @profiles.where(fatCategory: params[:fatCategory]) if params[:fatCategory].present?
    @profiles = @profiles.where(orientation: params[:orientation]) if params[:orientation].present?
    @profiles = @profiles.where(religion: params[:religion]) if params[:religion].present?
    @profiles = @profiles.where(ethnicity: params[:ethnicity]) if params[:ethnicity].present?
    render "index"
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id

    respond_to do |format|
      if @profile.save!
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:active, :firstName, :lastName, :website, :location, :typeOfWork, :fatCategory, :orientation, :religion, :ethnicity, :picture)
    end
    
    def correct_user
      @profile = Profile.find_by(user_id: params[:user_id])
      redirect_to(root_path) unless current_user?(@profile)
    end
end
