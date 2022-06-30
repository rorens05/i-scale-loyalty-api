# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  validates :transaction_id, presence: true, uniqueness: { case_sensitive: true }
  validates :store_id, presence: true
  validates :guest_id, presence: true
  validates :timestamp, presence: true
  validate :must_have_at_least_one_order_item

  before_save :calculate_discount, :calculate_sub_total, :calculate_points

  MINIMUM_AMOUNT_FOR_DISCOUNT = 10
  DISCOUNT = 0.2
  DISCOUNTED_SKU = 'CCC'
  DISCOUNTED_SKU_AMOUNT = 2
  POINTS_MULTIPLIER = 2

  private

  def must_have_at_least_one_order_item
    errors.add(:order_items, 'must have at least one order item') if order_items.empty?
  end

  def item_total
    order_items.sum { |item| item.price * item.quantity }
  end

  def item_total_discount
    item_total * DISCOUNT
  end

  def calculate_discount
    sku_discount = discounted_by_sku? ? DISCOUNTED_SKU_AMOUNT : 0
    percentage_discount = discounted_by_amount? ? item_total_discount : 0
    self.discount = sku_discount > percentage_discount ? sku_discount : percentage_discount
  end

  def discounted_by_sku?
    order_items.any? { |item| item.sku == DISCOUNTED_SKU }
  end

  def discounted_by_amount?
    item_total > MINIMUM_AMOUNT_FOR_DISCOUNT
  end

  def calculate_sub_total
    self.sub_total = item_total - discount
  end

  def calculate_points
    self.points = (sub_total * POINTS_MULTIPLIER).floor
  end
end
