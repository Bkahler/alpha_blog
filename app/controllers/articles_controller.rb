class ArticlesController < ApplicationController
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
    @article = Article.find(params[:id])
  end 
  
  def edit
    @article = Article.find(params[:id])
  end 
  
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      logger.debug "#{ "-" * 10} class: #{self}, method: #{__method__}, message: updated article #{@article.id} #{ "-" * 10}"
      flash[:notice] = "Article was successfully updated"
      redirect_to article_path(@article)
    else 
      logger.warn "#{ "-" * 10} class: #{self}, method: #{__method__}, message: failed to update article #{@article.id}...#{ @article.errors.full_messages } #{ "-" * 10}"
      render 'edit'
    end
  end 
  
  private
  
  def article_params
    params.require(:article).permit(:title, :description)
  end 
end 