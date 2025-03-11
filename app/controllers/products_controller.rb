class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  # before_action :set_product, only: [:update]

  def index
    @products = Product.all
    if params[:query].present?
    @products = @products.where("name ILIKE ?", "%#{params[:query]}%")
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to  seller_products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # raise
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      # raise
      redirect_to seller_products_path
    else
      # raise
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      flash[:notice] = "Produto removido com sucesso."
      redirect_to seller_products_path
    else
      flash[:alert] = "Erro ao remover o produto."
      redirect_back fallback_location: products_path
    end
  end

  def image_params
    params.require(:product).permit(:title, :body, :image)
  end

  def categories
    search_params = params[:category]
    if search_params.present?
      @products = Product.where(category: search_params)
    else
      @products = Product.all
    end
  def seller_products
    # @user = current_user.id
    # @seller_products = Product.all.where(params[@user])
    @my_products = Product.where(user: current_user)
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
