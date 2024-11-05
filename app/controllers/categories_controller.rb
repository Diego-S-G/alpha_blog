class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
  end

  def index
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Categoria criada com sucesso!"
      redirect_to @category
    else
      render "new", status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
