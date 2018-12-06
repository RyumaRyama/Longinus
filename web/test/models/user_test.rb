require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")

    @element_one = Element.find_by(name: "BABYMETAL")
    @element_two = Element.find_by(name: "Roselia")
    @elements = [@element_one,@element_two]
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "biography should not be too long" do
    @user.biography = "a" * 151
    assert_not @user.valid?
  end

  # test "associated user_introductions should be destroyed" do
  #   @user.save
  #   @user.user_introductions.create!(category_id: 1, element_id: 1)
  #   assert_difference 'UserIntroduction.count', -1 do
  #     @user.destroy
  #   end
  # end

  # has_and_belongs_to_many test
  # https://github.com/rails/rails/issues/21041

  test "test_assign_habtm_by_objects" do
    @user.elements = Element.all
    assert_equal 2, @user.elements.size
  end

  test "test_assign_habtm_by_ids" do
    @user.element_ids = Element.ids
    assert_equal 2, @user.elements.size
  end

  test "test_assign_habtm_by_inserting" do
    Element.create!(name: "ice")
    @user.elements << Element.find_by(name: "ice")
    assert_equal 1, @user.elements.size
  end

  test "test_assign_habtm_by_attributes" do
    @user.update! element_ids: Element.ids
    assert_equal 2, @user.elements.size
  end


  test "should follow and unfollow a user" do
    chris = users(:chris)
    okabe  = users(:okabe)
    assert_not chris.following?(okabe)
    chris.follow(okabe)
    assert_not okabe.friend?(chris)
    assert_not chris.friend?(okabe)
    okabe.follow(chris)
    assert chris.following?(okabe)
    assert okabe.followed_by?(chris)
    assert okabe.friend?(chris)
    chris.unfollow(okabe)
    assert_not chris.following?(okabe)
  end
end
