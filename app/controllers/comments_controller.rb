class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_post, only: [:show]
  helper_method :show_post2
  before_action :set_user, only: [:show, :destroy]
  #before_action :set_post, only: [:show, :destroy]
  before_filter :require_permission, only: [:edit, :update, :destroy]
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end
  def show_post2


      @post = Post.find(158)
    
  end
  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    user_id = current_user.id
    post=Post.find(params[:post_id])
    body=params[:body]
    @comment=post.comments.build(body: body, user_id: user_id)
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        flash[:notice]= "Comment was successfully updated."
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    
    @comment.destroy
    respond_to do |format|
      if params[:post_id]
        set_post
      format.html { redirect_to @post, notice: 'Comment was successfully destroyed.' }
      else
        format.html { redirect_to show_user_registration_path(@user), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
      
    end
    def set_user

      @user = User.find(@comment[:user_id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.permit(:user_id, :commentable_id, :commentable_type)
    end
    def require_permission
      if user_signed_in?
        if current_user != @comment.user
          if !admin_signed_in?
          redirect_to :root, notice: "Access Denied."
          end
        end
      else
        if !admin_signed_in?
          authenticate_user!
        end
      end
    end
end
