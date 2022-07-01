# frozen_string_literal: true

##
# This class is used to represent an order.
class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :guest
  accepts_nested_attributes_for :order_items

  validates :transaction_id, presence: true, uniqueness: { case_sensitive: true }
  validates :store_id, presence: true
  validates :guest_id, presence: true
  validates :timestamp, presence: true
  validate :must_have_at_least_one_order_item

  before_validation :find_or_create_guest

  def item_total
    order_items.sum { |item| item.price * item.quantity }
  end

  private

  def must_have_at_least_one_order_item
    errors.add(:order_items, 'must have at least one order item') if order_items.empty?
  end

  def find_or_create_guest
    Guest.find_or_create_by(id: guest_id) if guest_id.present?
  end
end
