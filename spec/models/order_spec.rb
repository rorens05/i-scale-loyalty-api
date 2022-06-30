# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'validations' do
    it 'validates that the order discount is equal to 20% of the sub_total if the sub total is greater than 10' do
      order = Order.new(
        timestamp: Time.now,
        store_id: 1,
        guest_id: 1,
        transaction_id: '12345'
      )
      order.order_items.build(
        [
          {
            sku: 'AAA',
            price: 8,
            quantity: 2
          },
          {
            sku: 'BBB',
            price: 10,
            quantity: 3
          }
        ]
      )
      order.save
      expect(order.discount.to_f).to eq(9.2)
    end

    it 'validates that the order discount is equal to 0 if the sub total is less than 10' do
      order = Order.new(
        timestamp: Time.now,
        store_id: 1,
        guest_id: 1,
        transaction_id: '12345'
      )
      order.order_items.build(
        [
          {
            sku: 'AAA',
            price: 1,
            quantity: 1
          },
          {
            sku: 'BBB',
            price: 2,
            quantity: 1
          }
        ]
      )
      order.save
      expect(order.discount.to_f).to eq(0)
    end
  end
end
