require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  setup do
    @p = FactoryGirl.create(:product)
    assert @p.valid?
  end

  test "must have a description" do
    @p.description = ""
    refute @p.valid?
  end

  test "must have a name" do
    @p.name = ""
    refute @p.valid?
  end

  test "must have a price" do
    @p.price_in_cents = nil
    refute @p.valid?
  end

  test "price must be an integer" do
    @p.price_in_cents = 1.5
    refute @p.valid?
  end
end
