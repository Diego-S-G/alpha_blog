require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "Esportes")
    @category2 = Category.create(name: "Viagem")
  end

  test "should show categories listing" do
    get "/categories"
    assert_select "a[href=?]", category_path(@category), name: @category.name
    assert_select "a[href=?]", category_path(@category2), name: @category2.name
  end
end
