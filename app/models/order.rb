class Order < ApplicationRecord

  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  validates :transaction_id, presence: true, uniqueness: true
  validates :store_id, presence: true
  validates :guest_id, presence: true
  validates :timestamp, presence: true
  validate :must_have_at_least_one_order_item

  before_save :calculate_discount, :calculate_sub_total, :calculate_points

  MINIMUM_AMOUNT_FOR_DISCOUNT = 10
  DISCOUNT = 0.2
  DISCOUNTED_SKU = "CCC"
  DISCOUNTED_SKU_AMOUNT = 2
  POINTS_MULTIPLIER = 2

  private
  def must_have_at_least_one_order_item
    errors.add(:order_items, "must have at least one order item") if order_items.empty?
  end

  def item_total
    sum = 0 
    order_items.each do |item|
      sum += item.price * item.quantity
    end
    sum
  end

  def calculate_discount
    sku_discount = 0
    if order_items.any? { |item| item.sku == DISCOUNTED_SKU }
      sku_discount = DISCOUNTED_SKU_AMOUNT 
    end

    percentage_discount = 0
    if item_total > MINIMUM_AMOUNT_FOR_DISCOUNT
      percentage_discount = item_total * DISCOUNT
    end

    self.discount = sku_discount > percentage_discount ? sku_discount : percentage_discount
  end

  def calculate_sub_total
    self.sub_total = item_total - self.discount
  end

  def calculate_points
    self.points = (self.sub_total * POINTS_MULTIPLIER).floor
  end
end
