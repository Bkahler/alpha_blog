require 'test_helper'

class CreateUsersTest < ActionDispatch::IntegrationTest

  test 'get new user form and create user' do
    get signup_path
    assert_template 'users/new'

    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {username: 'testers',email: 'tester@test.com', password:'123123'}
    end

    assert_template 'users/show'
    assert_match 'testers', response.body
  end

  test 'invalid user submission results in failure' do
    get signup_path
    assert_template 'users/new'

    assert_no_difference 'User.count' do
      post users_path, user: {username: '',email: 'tester@test.com', password:'123123'}
    end

    assert_template 'users/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end