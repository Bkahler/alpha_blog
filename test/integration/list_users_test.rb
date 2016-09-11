require 'test_helper'

class ListUsersTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(
                        username:'Bohn',
                        email:'bohn@example.com',
                        password:'password',
                        admin: true
                )

    @user_2 = User.create(
                        username:'John',
                        email:'John@example.com',
                        password:'password',
                        admin: true
                  )
  end

  test 'should show user listing' do
    get users_path
    assert_template 'users/index'

    assert_select "a[href=?]", user_path(@user), text: @user.username
    assert_select "a[href=?]", user_path(@user_2), text: @user_2.username
  end

end