require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @user = User.create(username: 'testers',email: 'tester@test.com', password:'123123')
    @article = Article.create(title: 'test title',description: 'This is a test', user_id: @user.id)
  end
  test 'category should be valid' do
    assert @article.valid?
  end

  test 'title should be present' do
    @article.title = " "
    assert_not @article.valid?
  end

  test 'description should be present' do
    @article.description = " "
    assert_not @article.valid?
  end

  test 'title should not be too long' do
    @article.title = "a" * 55
    assert_not @article.valid?
  end

  test 'title should not be too short' do
    @article.title = "aa"
    assert_not @article.valid?
  end

  test 'description should not be too long' do
    @article.description = "a" * 310
    assert_not @article.valid?
  end

  test 'description should not be too short' do
    @article.description = "123456789"
    assert_not @article.valid?
  end

  test 'user_id should be present' do
    @article.user_id = ""
    assert_not @article.valid?
  end

end