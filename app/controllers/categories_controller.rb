class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :set_category, except: [:index, :new, :create]

  def index
    @categories = Category.paginate(page: params["page"], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      logger.debug "#{ "-" * 10} session: #{session.id}, class: #{self}, method: #{__method__}, message: created new category #{ "-" * 10}"
      flash[:success] = "Category was succesfully added"
      redirect_to categories_path
    else
      logger.warn "#{ "-" * 10} session: #{session.id}, class: #{self}, method: #{__method__}, message: category failed to create... #{ @category.errors.full_messages } #{ "-" * 10}"
      render 'new'
    end
  end

  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    if @category.update(category_params)
      logger.debug "#{ "-" * 10} session: #{session.id}, class: #{self}, method: #{__method__}, message: updated category #{ "-" * 10}"
      flash[:success] = "Category: #{@category.name} successfully updated"
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !logged_in? || (logged_in? && !current_user.admin?)
      flash[:danger] = "only admins can perform that action"
      redirect_to categories_path
    end
  end

  def set_category
    @category = Category.find(params[:id])
    rescue => e
      logger.warn "#{ "-" * 10} session: #{session.id}, class: #{self}, method: #{__method__}, message: failed to find category #{params[:id]}...#{ e.message } #{ "-" * 10}"
      flash[:danger] = "Failed to find category"
      request_redirect(categories_path)
  end

end