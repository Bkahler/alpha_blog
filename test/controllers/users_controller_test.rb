require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = User.create(username: 'testers',email: 'tester@test.com', password:'123123')
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should get edit' do
    session[:user_id] = @user.id
    get(:edit, {'id'=>  @user.id})
    assert_response :success
  end

  test 'should get show' do
    get(:show, {'id'=>  @user.id})
    assert_response :success
  end

end