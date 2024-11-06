require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @user_admin = User.create(username: "admin", email: "admin@example.com", password: "password", admin: true)
    sign_in_as(@user_admin)
  end

  test "get new category form and create category" do
    get "/categories/new"
    assert_response :success
    assert_difference("Category.count", 1) do
      post categories_path, params: { category: { name: "Esportes" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Esportes", response.body
  end

  test "get new category form and reject invalid category submission" do
    get "/categories/new"
    assert_response :success
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: "" } }
    end
    assert_match "erros", response.body
    assert_select "div.alert"
    assert_select "h4.alert-heading"
  end
end
