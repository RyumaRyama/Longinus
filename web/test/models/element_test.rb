require 'test_helper'

class ElementTest < ActiveSupport::TestCase
  def setup
    # @category = Category.new(id:2, name: "sport")
    # @element = @category.elements.build(name: "cycling")
    @element = Element.new(name: "cycling")
  end

  test "should be valid" do
    assert @element.valid?
  end

  # test "category_id should be present" do
  #   @element.category_id = nil
  #   assert_not @element.valid?
  # end

  test "name should be present" do
    @element.name = "  "
    assert_not @element.valid?
  end

  test "name should not be too long" do
    @element.name = "a" * 31
    assert_not @element.valid?
  end

  test "name should be unique" do
    duplicate_element = @element.dup
    @element.save
    assert_not duplicate_element.valid?
  end
end
