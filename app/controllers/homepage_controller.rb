class HomepageController < ApplicationController
  def index
    @num_products = Product.count
  end
end