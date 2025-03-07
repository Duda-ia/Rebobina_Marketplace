class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show ]

  def show
  end

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:category, :name, :description, :price)
  end

  def set_product
    @product = Product.find(params.expect(:id))
  end

end
