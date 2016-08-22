class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end 
  
  def index
    @users = User.paginate(page: params[:page], per_page: 2)
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      logger.debug "#{ "-" * 10} session: #{session.id}, class: #{self}, method: #{__method__}, message: created new user #{ "-" * 10}"
      flash[:success] = "Welcome to Alpha Blog #{@user.username}"
      redirect_to user_path(@user)
    else
      logger.warn "#{ "-" * 10} session: #{session.id}, class: #{self}, method: #{__method__}, message: User failed to create... #{ @user.errors.full_messages } #{ "-" * 10}"
      render 'new'
    end 
  end
  
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 2)
  end 
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      logger.debug "#{ "-" * 10} session: #{session.id}, class: #{self}, method: #{__method__}, message: updated user #{ "-" * 10}"
      flash[:success] = "User: #{@user.username} successfully updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end 
  
  private
  
  def set_user
    @user = User.find(params[:id])
    rescue => e
      logger.warn "#{ "-" * 10} session: #{session.id}, class: #{self}, method: #{__method__}, message: failed to find user #{params[:id]}...#{ e.message } #{ "-" * 10}"
      flash[:danger] = "Failed to find user"
      redirect_to articles_path
  end 
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
  
  def require_same_user
    if current_user != @user
      flash[:danger] = "You are unauthorized to perform that action."
      redirect_to request.referer 
    end 
  end 
  

end