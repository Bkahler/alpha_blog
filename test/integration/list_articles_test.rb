require 'test_helper'

class ListArticlesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(
                        username:'Bohn',
                        email:'bohn@example.com',
                        password:'password',
                        admin: true
                )

    @article = Article.create(
                          title: 'pizza',
                          description: "Pizza is a very good alternative to soap",
                          user_id: @user.id
                      )

    @article_2 = Article.create(
                          title: 'nachos',
                          description: "Nachos are a very good alternative to acid",
                          user_id: @user.id
                      )
  end

  test 'should show article listing' do
    get articles_path
    assert_template 'articles/index'

    assert_select "a[href=?]", article_path(@article), text: @article.title
    assert_select "a[href=?]", article_path(@article_2), text: @article_2.title
  end

end