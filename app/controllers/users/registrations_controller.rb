class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :authenticate_scope!, only: [:destroy,:show]
  before_filter :configure_permitted_parameters
  before_filter :require_permission, only: [:destroy,:index]
  before_action :set_user, only: [:show]

  # GET /posts
  # GET /posts.json
  def index
    @users = User.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  #def new
  #end

  # GET /posts/1/edit
  #def edit
  #end

  # POST /posts
  # POST /posts.json
  #def create
  #end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  #def update
  #end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @user = User.find(params[:id]) 
    @user.destroy

    if @user.destroy
        redirect_to index_user_registration_path, notice: "User deleted."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up).push(:name)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def require_permission
      if !admin_signed_in?
        redirect_to :root, notice: "Access Denied."
      end
        
      
    end

end
