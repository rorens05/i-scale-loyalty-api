class OrderItem < ApplicationRecord
  belongs_to :order
  validates :sku, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :quantity, numericality: { greater_than: 0 }
end
