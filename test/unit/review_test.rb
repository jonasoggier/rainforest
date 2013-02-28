require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  test "requires a user" do
    r = FactoryGirl.create(:review)
    assert r.valid?
    r.user = nil
    refute r.valid?
  end

  test "requires a comment" do
    r = FactoryGirl.create(:review)
    assert r.valid?
    r.comment = nil
    refute r.valid?
  end
end
