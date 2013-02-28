class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  attr_accessible :comment, :product_id

  validates_presence_of :comment, :product, :user
end
