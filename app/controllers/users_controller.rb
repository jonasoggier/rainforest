class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id # log in
      redirect_to products_url, :notice => "Signed up!"
    else
      render "new"
    end
  end
end
