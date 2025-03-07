class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def destroy
    if @product.destroy
      flash[:notice] = "Produto removido com sucesso."
    redirect_to products_path
  else
    flash[:alert] = "Erro ao remover o produto."
    redirect_back fallback_location: products_path
  end
end

private

  def set_product
    @product = Product.find(params[:id])
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
end
