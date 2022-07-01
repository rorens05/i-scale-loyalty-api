# frozen_string_literal: true

##
# This class is used to represent an order item
class OrderItem < ApplicationRecord
  belongs_to :order
  validates :sku, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :quantity, numericality: { greater_than: 0 }
end
