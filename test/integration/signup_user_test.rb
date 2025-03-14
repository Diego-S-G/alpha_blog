require "test_helper"

class SignupUserTest < ActionDispatch::IntegrationTest
  test "get new user form and create new user" do
    get "/signup"
    assert_response :success
    assert_difference("User.count", 1) do
      post users_path, params: { user: { username: "Nome_usuario", email: "nome@example.com", password: "password" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Nome_usuario", response.body
  end
end
