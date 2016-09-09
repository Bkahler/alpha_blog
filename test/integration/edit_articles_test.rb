require 'test_helper'

class EditArticlesTest < ActionDispatch::IntegrationTest
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
  end

  test 'get edit article form and update properties' do
    sign_in_as(@user,'password')
    get edit_article_path(@article)
    assert_template 'articles/edit'

    put_via_redirect(
                      "/articles/#{@article.id}",
                      article: {
                                  title: 'Pizza_1',
                                  description: "Pizza is a very good alternative to soap",
                                  user_id: @user.id
                               },
                    )

    assert_template 'articles/show'
    assert_match 'Pizza_1', response.body
  end
end