class ReviewsController < ApplicationController
  before_filter :ensure_logged_in, :only => [:new, :edit, :create, :update, :destroy]
  before_filter :ensure_user_owns_review, :only => [:edit, :update, :destroy]

  # GET /reviews
  def index
    @reviews = Review.all
  end

  # GET /reviews/1
  def show
    @review = Review.find(params[:id])
  end

  # GET /reviews/new
  def new
    @review = Review.new
    @review.product_id = params[:product_id]
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
  end

  # POST /reviews
  def create
    unless current_user
      flash[:alert].now = "Please sign in to create a review"
      redirect_to new_session_path
    end

    @review = Review.new(params[:review])

    @review.user = current_user

    if @review.save
      redirect_to @review.product, notice: 'Review was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /reviews/1
  def update
    unless current_user
      flash[:alert].now = "Please sign in to edit a review"
      redirect_to new_session_path
    end

    @review = Review.find(params[:id])

    if @review.update_attributes(params[:review])
      redirect_to @review, notice: 'Review was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /reviews/1
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    redirect_to reviews_url
  end

  private

  def ensure_user_owns_review
    # TODO
  end
end
