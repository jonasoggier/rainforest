require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  setup do
    @review = FactoryGirl.create(:review)
  end

  def log_in
    @controller.stubs(:current_user).returns(FactoryGirl.create(:user))
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reviews)
  end

  test "should get new if logged in" do
    log_in
    get :new
    assert_response :success
  end

  test "should not get new if not logged in" do
    get :new
    assert_redirected_to new_session_path
  end

  test "should create review if logged in" do
    log_in
    assert_difference('Review.count') do
      post :create, review: { comment: @review.comment, product_id: @review.product.id }
    end

    assert_redirected_to product_path(assigns(:review).product)
  end

  test "should not create review if not logged in" do
    assert_no_difference('Review.count') do
      post :create, review: { comment: @review.comment, product_id: @review.product.id }
    end

    assert_redirected_to new_session_path
  end

  test "should show review" do
    get :show, id: @review
    assert_response :success
  end

  test "should get edit if  logged in" do
    log_in
    get :edit, id: @review
    assert_response :success
  end

  test "should not get edit if not logged in" do
    get :edit, id: @review
    assert_redirected_to new_session_path
  end

  test "should update review if logged in" do
    log_in
    put :update, id: @review, review: { comment: @review.comment }
    assert_redirected_to review_path(assigns(:review))
  end

  test "should not update review if not logged in" do
    put :update, id: @review, review: { comment: @review.comment }
    assert_redirected_to new_session_path
  end

  test "should destroy review if logged in" do
    log_in
    assert_difference('Review.count', -1) do
      delete :destroy, id: @review
    end

    assert_redirected_to reviews_path
  end

  test "should not destroy review if not logged in" do
    assert_no_difference('Review.count') do
      delete :destroy, id: @review
    end

    assert_redirected_to new_session_path
  end
end
