class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  
  def index
    @articles = Article.all
  end
  def new
    @article = Article.new
  end  
  
  def create
    # render plain: params[:articles].inspect
    @article = Article.new(article_params)
    
    if @article.save
      logger.debug "#{ "-" * 10} class: #{self}, method: #{__method__}, message: created new article #{ "-" * 10}"
      flash[:notice] = "Article was succesfully added"
      redirect_to article_path(@article)
    else
      logger.warn "#{ "-" * 10} class: #{self}, method: #{__method__}, message: article failed to create... #{ @article.errors.full_messages } #{ "-" * 10}"
      render 'new'
    end 
  end
  
  def show
  end 
  
  def edit
  end 
  
  def update
    if @article.update(article_params)
      logger.debug "#{ "-" * 10} class: #{self}, method: #{__method__}, message: updated article #{@article.id} #{ "-" * 10}"
      flash[:notice] = "Article was successfully updated"
      redirect_to article_path(@article)
    else 
      logger.warn "#{ "-" * 10} class: #{self}, method: #{__method__}, message: failed to update article #{@article.id}...#{ @article.errors.full_messages } #{ "-" * 10}"
      render 'edit'
    end
  end 
  
  def destroy
    if @article.destroy
      logger.debug "#{ "-" * 10} class: #{self}, method: #{__method__}, message: deleted article #{@article.id} #{ "-" * 10}"
      flash[:notice] = "Article was successfully deleted"
      redirect_to articles_path
    else
      logger.warn "#{ "-" * 10} class: #{self}, method: #{__method__}, message: failed to delete article #{@article.id}...#{ @article.errors.full_messages } #{ "-" * 10}"
      redirect_to request.referer
    end 
  end 
  
  private
    def set_article
      @article = Article.find(params[:id])
    end 
    
    def article_params
      params.require(:article).permit(:title, :description)
    end 
end 