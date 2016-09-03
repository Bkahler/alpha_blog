require 'test_helper'

class PagesControllerTest < ActionController::TestCase

  def setup
    @user = User.create(username:'John', email:'john@example.com', password:'password' , admin: true)
  end

  test 'should get pages home' do
    get :home
    assert_response :success
  end

  test 'should redirect when logged in' do
    session[:user_id] = @user.id
    get :home
    assert_redirected_to articles_path
  end

  test 'should render home when not logged in' do
    get :home
    assert_template 'pages/home'
  end

  test 'should render about' do
    get :about
    assert_template 'pages/about'
  end

end