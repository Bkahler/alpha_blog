require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase

  def setup
    @user = User.create(username: 'testers',email: 'tester@test.com', password:'123123')
    @article = Article.create(title: 'test title',description: 'This is a test', user_id: @user.id)
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should get show' do
    get(:show, {'id'=>  @article.id})
    assert_response :success
  end

end