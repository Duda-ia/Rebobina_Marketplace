require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @product = products(:one)
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_path(@product)
    end
    assert_redirected_to products_path
    follow_redirect!
    assert_match "Produto removido com sucesso.", response.body
  end
end
