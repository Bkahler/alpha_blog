class CategoriesController < ApplicationController

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
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end