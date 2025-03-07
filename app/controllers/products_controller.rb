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
  end
end
