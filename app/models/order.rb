# frozen_string_literal: true

##
# This class is used to represent an order.
class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  validates :transaction_id, presence: true, uniqueness: { case_sensitive: true }
  validates :store_id, presence: true
  validates :guest_id, presence: true
  validates :timestamp, presence: true
  validate :must_have_at_least_one_order_item

  before_save :calculate_discount, :calculate_sub_total, :calculate_points

  def item_total
    order_items.sum { |item| item.price * item.quantity }
  end

  private

  def must_have_at_least_one_order_item
    errors.add(:order_items, 'must have at least one order item') if order_items.empty?
  end

  def calculate_discount
    self.discount = Orders::DiscountService.call(self)
  end

  def calculate_sub_total
    self.sub_total = item_total - discount
  end

  def calculate_points
    self.points = Orders::PointsService.call(self)
  end
end
