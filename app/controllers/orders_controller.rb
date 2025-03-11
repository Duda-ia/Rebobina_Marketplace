class OrdersController < ApplicationController


  def buyer_products
  end

  def new
    @product = Product.find(params[:product_id])
    @order = Order.new
  end


  def create
    @product = Product.find(params[:product_id])
    @order = Order.new
    @order.user = current_user
    @order.product = @product
    if @order.save
      flash[:notice] = "Compra realizada com sucesso!!"
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end
end
