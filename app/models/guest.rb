# frozen_string_literal: true

##
# This class represents a guest.
class Guest < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :order_items, through: :orders
  def name
    first_name.present? && last_name.present? ? "#{first_name}, #{last_name}" : first_name || last_name || 'Guest'
  end
end
