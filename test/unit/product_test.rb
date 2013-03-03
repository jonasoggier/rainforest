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

  test "has a formatted price" do
    assert_equal "0.01", Product.new(:price_in_cents => 1).formatted_price
    assert_equal "0.99", Product.new(:price_in_cents => 99).formatted_price
    assert_equal "1.00", Product.new(:price_in_cents => 100).formatted_price
    assert_equal "10.50", Product.new(:price_in_cents => 1050).formatted_price
  end

  test "can have many reviews" do
    p = FactoryGirl.create(:product)
    r1 = FactoryGirl.create(:review, :product => p)
    r2 = FactoryGirl.create(:review, :product => p)

    p.reload
    assert_equal p.reviews, [r2, r1]
  end

  test "can list users that have reviewed it without duplicates" do
    p = FactoryGirl.create(:product)
    r1 = FactoryGirl.create(:review, :product => p)
    r2 = FactoryGirl.create(:review, :product => p)
    r3 = FactoryGirl.create(:review, :product => p, :user => r2.user)

    p.reload
    assert_equal p.reviewers, [r1.user, r2.user]
  end
end
