require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create(username: 'testers',email: 'tester@test.com', password:'123123')
  end

  test 'username should be present' do
    @user.username = " "
    assert_not @user.valid?
  end

  test 'username should not be too long' do
    @user.username = 'b' * 26
    assert_not @user.valid?
  end

  test 'username should not be too short' do
    @user.username = 'b'
    assert_not @user.valid?
  end

  test 'username should be unique' do
    @user.save
    user2 = User.create(username: 'testers',email: 'tester@test.com', password:'123123')
    assert_not user2.valid?
  end

  test 'email should be present' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = '1111009090909090909090909090909090909090909090909090909090909090909009999999999999999999999999999bbbbbbbbbbbbbbbbbb@bbbbbbbbbbbbbbbbbbbbbbbbbbbbb.com'
    assert_not @user.valid?
  end

  test 'email should be in the correct format' do
    @user.email = "bryan.kahler.com"
    assert_not @user.valid?
  end

  test 'email should be unique' do
    @user.save
    user2 = User.create(username: 'User2',email: 'tester@test.com', password:'123123')
    assert_not user2.valid?
  end
end