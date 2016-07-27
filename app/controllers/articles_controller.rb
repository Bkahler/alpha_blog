class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end  
  
  def create
    # render plain: params[:articles].inspect
    @article = Article.new(article_params)
    
    if @article.save
      logger.debug "#{ "-" * 10} class: #{self}, method: #{__method__}, message: created new article"
      flash[:notice] = "Article was succesfully added"
      redirect_to article_path(@article)
    else
      logger.warn "#{ "-" * 10} class: #{self}, method: #{__method__}, message: article failed to create: #{ @article.errors.full_messages }"
      render 'new'
    end 
  end
  
  def show
    @article = Article.find(params[:id])
  end 
  
  private
  
  def article_params
    params.require(:article).permit(:title, :description)
  end 
end 