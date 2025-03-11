class CategoriesController < ApplicationController
  def index
    search_param = params[:category]

    # Fetch products filtered by category or all products if no category is selected
    if search_param.present?
      @products = Product.where(category: search_param)
    else
      @products = Product.all
    end

    # Fetch unique categories for the sidebar menu
    @categories = Product.distinct.pluck(:category)

    # Handle case where no categories exist (though this should not happen if categories are present)
    if @categories.empty?
      flash[:alert] = "No categories found."
    end
  end
end
