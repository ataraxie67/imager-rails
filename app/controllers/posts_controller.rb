class PostsController < ApplicationController
  before_filter :require_permission, only: [:edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  helper_method :show_post2
  impressionist :action=> [:show], :unique => [:impressionable_type, :impressionable_id, :session_hash]
  # GET /posts
  # GET /posts.json
  def index
    @posts= Post.all
    if params[:tag].present?
      begin
          @filter="hello"
          @posts=@posts.tagged_with(params[:tag]).send(params[:sort_id])
      rescue
          flash[:notice] = "No posts for your search tag found."
      end
    end
    if params[:filter_id].present?
      @filter="hello"
      @posts=@posts.send(params[:filter_id])
    else
      @posts=@posts.last_month
    end
    
    if params[:sort_id].present?
       @filter="hello"
       @posts=@posts.send(params[:sort_id])
      
    else
      @posts=@posts.upvoted_posts

    end
    @posts=@posts.page(params[:page]).per(40)
    @tags= Tag.all.order_count
    
  end
 
  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(post_params)
    @post.user_name = current_user.name
    #  @post = Post.new(post_params)
   # respond_to do |format|
      if @post.save
        #format.html { redirect_to @post, notice: 'Post was successfully created.' }
        #format.json { render :show, status: :created, location: @post }
        render json: { message: "success", fileID: @post.id }, status: 200
      else
        render json: { error: @post.errors.full_messages.join(',')}, status: 400
        #format.html { render :new }
        #format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    #end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def vote
    @post = Post.find(params[:post_id])
    #if you already have before_action set up for the preceding line, you can just add :vote there
    vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
    #strong params not needed because keys are hard coded, can parse values out
      if vote.valid?
        if vote.vote?
          Post.increment_counter(:upvote_count,@post.id)
        else 
          Post.increment_counter(:downvote_count,@post.id)
        end
        flash[:notice] = "Your vote was counted."
      else
        flash[:notice] = "You can only vote once."
      end
      respond_to do |format|
      #format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      #format.json { head :no_content }
      format.js
       end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :avatar, :sort_id, :filter_id,:all_tags)
    end
    def require_permission
      if user_signed_in?
        if current_user != Post.find(params[:id]).user
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
