# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'returns correct item total' do
    subject.assign_attributes(
      timestamp: Time.now,
      store_id: 1,
      guest_id: 1,
      transaction_id: '12345'
    )
    subject.order_items.build(
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
    expect(subject.item_total.to_s).to eq('46.0')
  end

  it 'validates order items should not be empty' do
    subject.assign_attributes(
      timestamp: Time.now,
      store_id: 1,
      guest_id: 1,
      transaction_id: '12345'
    )

    expect(subject.valid?).to eq(false)
    expect(subject.errors.full_messages).to include('Order items must have at least one order item')
  end
end
