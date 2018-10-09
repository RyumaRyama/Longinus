require 'test_helper'

class UserIntroductionTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(id:1, name: "food")
    @element = Element.new(id:1, category_id:1 ,name: "curry")
    @user = User.new(id:1, name: "John Titer", email: "John@example.com",
                     password: "foobar", password_confirmation: "foobar")

    @user_introduction = UserIntroduction.new(user_id: @user.id,  category_id: @category.id, element_id: @element.id)
    # @user_introduction_relation_category = @category.user_introductions.buildi(user_id: 1, element_id: 1)
    # @user_introduction_relation_element = @element.user_introductions.build(user_id: 1, category_id: 1)
    # @user_introduction_relation_user = @user.user_introductions.build(element_id: 1, category_id: 1)
  end

  test "should be valid" do
    assert @user_introduction.valid?
  end

  test "user_id should be present" do
    @user_introduction.user_id = nil
    assert_not @user_introduction.valid?
  end

  test "category_id should be present" do
    @user_introduction.category_id = nil
    assert_not @user_introduction.valid?
  end

  test "element_id should be present" do
    @user_introduction.element_id = nil
    assert_not @user_introduction.valid?
  end
end
