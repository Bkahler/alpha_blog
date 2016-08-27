require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: 'testers',email: 'tester@test.com', password:'123123')
  end
  test 'get new article form and create article' do
    get new_article_path
    assert_template 'articles/new'

    assert_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: {title: 'Test', description: 'This is a test description'}
    end

    assert_template 'articles/index'
    assert_match 'Test', response.body
  end

  test 'invalid article submission results in failure' do
    get new_article_path
    assert_template 'articles/new'

    assert_no_difference 'Category.count' do
      post articles_path, article: {name: ' '}
    end

    assert_template 'articles/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end


end