class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price_in_cents, :category_ids

  validates :description, :name, :presence => true
  validates :price_in_cents, :numericality => {:only_integer => true}

  has_many :reviews, :order => "created_at desc"
  has_many :reviewers, :through => :reviews, :source => :user, :uniq => true

  has_and_belongs_to_many :categories

  def formatted_price
    price_in_dollars = price_in_cents.to_f / 100
    sprintf("%.2f", price_in_dollars)
  end
end
