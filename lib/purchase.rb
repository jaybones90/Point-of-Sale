class Purchase < ActiveRecord::Base
  has_many :products
  def total
    products.map(&:cost).reduce(:+)
  end
end
