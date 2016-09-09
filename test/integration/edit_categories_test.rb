require 'test_helper'

class EditCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(
                        username:'Bohn',
                        email:'bohn@example.com',
                        password:'password',
                        admin: true
                )

    @category = Category.create(name:"sports")
  end

  test 'get edit category form and update attributes' do
    sign_in_as(@user,'password')
    get "/categories/#{@category.id}/edit" #edit_category_path(@category)
    assert_template 'categories/edit'

    put_via_redirect(
                      "/categories/#{@category.id}",
                      category: {name:"Not Sports"}
                    )

    assert_template 'categories/show'
    assert_match 'Not Sports', response.body
  end
end