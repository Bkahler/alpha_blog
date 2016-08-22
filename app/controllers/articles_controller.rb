class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, except: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 2)
  end
  
  def new
    @article = Article.new
  end  
  
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    
    if @article.save
      logger.debug "#{ "-" * 10} session: #{session.id}, class: #{self}, method: #{__method__}, message: created new article #{ "-" * 10}"
      flash[:success] = "Article was succesfully added"
      redirect_to article_path(@article)
    else
      logger.warn "#{ "-" * 10} session: #{session.id}, class: #{self}, method: #{__method__}, message: article failed to create... #{ @article.errors.full_messages } #{ "-" * 10}"
      render 'new'
    end 
  end
  
  def show
  end 
  
  def edit
  end 
  
  def update
    if @article.update(article_params)
      logger.debug "#{ "-" * 10} session: #{session.id}, class: #{self}, method: #{__method__}, message: updated article #{@article.id} #{ "-" * 10}"
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else 
      logger.warn "#{ "-" * 10} session: #{session.id}, class: #{self}, method: #{__method__}, message: failed to update article #{@article.id}...#{ @article.errors.full_messages } #{ "-" * 10}"
      render 'edit'
    end
  end 
  
  def destroy
    if @article.destroy
      logger.debug "#{ "-" * 10} session: #{session.id}, class: #{self}, method: #{__method__}, message: deleted article #{@article.id} #{ "-" * 10}"
      flash[:danger] = "Article was successfully deleted"
      redirect_to articles_path
    else
      logger.warn "#{ "-" * 10} session: #{session.id}, class: #{self}, method: #{__method__}, message: failed to delete article #{@article.id}...#{ @article.errors.full_messages } #{ "-" * 10}"
      redirect_to request.referer
    end 
  end 
  
  private
    def set_article
      @article = Article.find(params[:id])
      rescue => e
        logger.warn "#{ "-" * 10} session: #{session.id}, class: #{self}, method: #{__method__}, message: failed to find article #{params[:id]}...#{ e.message } #{ "-" * 10}"
        flash[:error] = "Failed to find article"
        redirect_to articles_path
    end 
    
    def article_params
      params.require(:article).permit(:title, :description)
    end 
    
    def require_same_user
      if current_user != @article.user
         flash[:error] = "You are unauthorized to perform that action."
          redirect_to request.referer 
      end 
    end 
end 