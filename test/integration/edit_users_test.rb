require 'test_helper'

class EditUsersTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(
                        username:'Bohn',
                        email:'bohn@example.com',
                        password:'password',
                        admin: true
                )
  end

  test 'get edit user form and update attributes' do
    sign_in_as(@user,'password')
    get edit_user_path(@user)
    assert_template 'users/edit'

    put_via_redirect(
                      "/users/#{@user.id}",
                      user: {
                        username:"John",
                        email:'bohn@example.com',
                        password:'password',
                        admin: true
                      }
                    )

    assert_template 'users/edit'
    assert_match 'John', response.body
  end
end