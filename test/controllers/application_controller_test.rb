require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase

  def setup
    @user = User.create(username: 'testers',email: 'tester@test.com', password:'123123')
  end

  test 'curent_user should return logged_in user' do
    session[:user_id] = @user.id
    assert_equal @user , @controller.send(:current_user)
  end

  test 'logged_in? should return true when user is logged in' do
    session[:user_id] = @user.id
    assert_equal true , @controller.send(:logged_in?)
  end

end