class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show ]

  def show
  end

  private
  def set_product
    @product = Product.find(params.expect(:id))
  end

  def product_params
    params.expect(product: [ :category, :name, :description, :price, :user_id ])
  end

end
