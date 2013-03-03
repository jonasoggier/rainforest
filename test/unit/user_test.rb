require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "can be created with a password and confirmation" do
    u = FactoryGirl.create(:user)
    assert u.valid?
  end

  test "must have a password and confirmation on create" do
    u = FactoryGirl.build(:user)
    u.password = ""
    u.password_confirmation = ""
    assert_raise(ActiveRecord::RecordInvalid) { u.save! }
  end

  test "password confirmation must match password" do
    u = FactoryGirl.build(:user)
    u.password = "abc"
    u.password_confirmation = "def"
    assert_raise(ActiveRecord::RecordInvalid) { u.save! }
  end

  test "email must be unique" do
    u1 = FactoryGirl.create(:user, :email => "name@example.com")
    u2 = FactoryGirl.build(:user, :email => "name@example.com")
    refute u2.valid?
    u2.email = "new@example.com"
    assert u2.valid?
  end

  test "can have many reviews" do
    u = FactoryGirl.create(:user)
    r1 = FactoryGirl.create(:review, :user => u)
    r2 = FactoryGirl.create(:review, :user => u)

    u.reload
    assert_equal u.reviews, [r1, r2]
  end

  test "can list products it has reviewed without duplicates" do
    u = FactoryGirl.create(:user)
    r1 = FactoryGirl.create(:review, :user => u)
    r2 = FactoryGirl.create(:review, :user => u)
    r3 = FactoryGirl.create(:review, :user => u, :product => r2.product)

    u.reload
    assert_equal u.reviewed_products, [r1.product, r2.product]
  end

  test "must have a name" do
    u = FactoryGirl.create(:user)
    assert u.valid?
    u.name = ""
    refute u.valid?
  end
end
