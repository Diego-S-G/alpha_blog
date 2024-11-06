require "test_helper"

class CreateNewArticleTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "user", email: "user@example.com", password: "password")
    sign_in_as(@user)
  end

  test "get new article form and create new article" do
      get "/articles/new"
      assert_response :success
      assert_difference("Article.count", 1) do
        post articles_path, params: { article: { title: "TítuloShow", description: "Description", user_id: 1 } }
        assert_response :redirect
      end
      follow_redirect!
      assert_response :success
      assert_match "TítuloShow", response.body
    end
end
