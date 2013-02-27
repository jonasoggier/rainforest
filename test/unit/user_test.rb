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
    u1 = FactoryGirl.create(:user)
    u2 = FactoryGirl.build(:user) # same password
    refute u2.valid?
    u2.email = "new@example.com"
    assert u2.valid?
  end
end
