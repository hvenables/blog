require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  def login_user
    post session_url, params: { email: users(:first).email, password: "password" }
  end

  test "#destroy deletes an article" do
    login_user

    delete article_path(articles(:first))
    assert_response :redirect
  end

  test "#destroy wont delete published articles" do
    login_user

    delete article_path(articles(:published))
    assert_response :missing
  end
end
