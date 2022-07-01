# frozen_string_literal: true

require 'rails_helper'

describe 'Orders', type: :request do
  let(:valid_payload_without_discount) do
    '{
        "timestamp": "2021-09-21T08:38:12.830Z",
        "store_id": "CADE3B168C",
        "guest_id": "54D0D284B0",
        "transaction_id": "5AA3C3C7094AF3949F2",
        "items": [
          {
            "sku": "AAA",
            "price": 1.00,
            "quantity": 1
          },
          {
            "sku": "BBB",
            "price": 2.00,
            "quantity": 1
          }
        ]
    }'
  end

  let(:valid_payload_with_discount) do
    '{
        "timestamp": "2021-09-21T08:38:12.830Z",
        "store_id": "CADE3B168C",
        "guest_id": "54D0D284B0",
        "transaction_id": "5AA3C3C7094AF3949F3",
        "items": [
          {
            "sku": "AAA",
            "price": 5.00,
            "quantity": 1
          },
          {
            "sku": "BBB",
            "price": 5.00,
            "quantity": 1
          },
          {
            "sku": "JJJ",
            "price": 5.00,
            "quantity": 1
          }
        ]
    }'
  end

  let(:valid_payload_with_sku_discount) do
    '{
        "timestamp": "2021-09-21T08:38:12.830Z",
        "store_id": "CADE3B168C",
        "guest_id": "54D0D284B0",
        "transaction_id": "5AA3C3C7094AF3949F4",
        "items": [
          {
            "sku": "AAA",
            "price": 1.00,
            "quantity": 1
          },
          {
            "sku": "CCC",
            "price": 5.00,
            "quantity": 1
          }
        ]
    }'
  end

  let(:valid_payload_with_sku_discount_and_discount) do
    '{
        "timestamp": "2021-09-21T08:38:12.830Z",
        "store_id": "CADE3B168C",
        "guest_id": "54D0D284B0",
        "transaction_id": "5AA3C3C7094AF3949F5",
        "items": [
          {
            "sku": "AAA",
            "price": 1.00,
            "quantity": 1
          },
          {
            "sku": "CCC",
            "price": 5.00,
            "quantity": 1
          },
          {
            "sku": "DDD",
            "price": 5.00,
            "quantity": 1
          }
        ]
    }'
  end

  context 'when payload is valid without discount' do
    before do
      post '/api/v1/orders', params: valid_payload_without_discount,
                             headers: { 'Content-Type' => 'application/json' }
    end

    it 'creates an order' do
      expect(Guest.count).to eq(1)
      expect(Order.count).to eq(1)
      expect(Order.first.order_items.count).to eq(2)
    end

    it 'saved 0 discount' do
      expect(Order.first.discount.to_s).to eq('0.0')
    end

    it 'saved the correct subtotal' do
      expect(Order.first.sub_total.to_s).to eq('3.0')
    end

    it 'saved the correct points' do
      expect(Order.first.points.to_s).to eq('6.0')
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(201)
    end
  end

  context 'when payload is valid with discount' do
    before do
      post '/api/v1/orders', params: valid_payload_with_discount,
                             headers: { 'Content-Type' => 'application/json' }
    end

    it 'creates an order' do
      expect(Guest.count).to eq(1)
      expect(Order.count).to eq(1)
      expect(Order.first.order_items.count).to eq(3)
    end

    it 'saved the correct discount' do
      expect(Order.first.discount.to_s).to eq('3.0')
    end

    it 'saved the correct subtotal' do
      expect(Order.first.sub_total.to_s).to eq('12.0')
    end

    it 'saved the correct points' do
      expect(Order.first.points.to_s).to eq('24.0')
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(201)
    end
  end

  context 'when payload is valid with sku discount' do
    before do
      post '/api/v1/orders', params: valid_payload_with_sku_discount,
                             headers: { 'Content-Type' => 'application/json' }
    end

    it 'creates an order' do
      expect(Guest.count).to eq(1)
      expect(Order.count).to eq(1)
      expect(Order.first.order_items.count).to eq(2)
    end

    it 'saved the correct discount' do
      expect(Order.first.discount.to_s).to eq('2.0')
    end

    it 'saved the correct subtotal' do
      expect(Order.first.sub_total.to_s).to eq('4.0')
    end

    it 'saved the correct points' do
      expect(Order.first.points.to_s).to eq('8.0')
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(201)
    end
  end

  context 'when payload is valid with sku discount and discount' do
    before do
      post '/api/v1/orders', params: valid_payload_with_sku_discount_and_discount,
                             headers: { 'Content-Type' => 'application/json' }
    end

    it 'creates an order' do
      expect(Guest.count).to eq(1)
      expect(Order.count).to eq(1)
      expect(Order.first.order_items.count).to eq(3)
    end

    it 'saved the correct discount' do
      expect(Order.first.discount.to_s).to eq('2.2')
    end

    it 'saved the correct subtotal' do
      expect(Order.first.sub_total.to_s).to eq('8.8')
    end

    it 'saved the correct points ' do
      expect(Order.first.points.to_s).to eq('17.0')
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(201)
    end
  end

  context 'Multiple order, one guest' do
    it 'does not duplicate guest' do
      post '/api/v1/orders', params: valid_payload_with_discount,
                             headers: { 'Content-Type' => 'application/json' }

      expect(Guest.count).to eq(1)
      expect(Order.count).to eq(1)

      post '/api/v1/orders', params: valid_payload_without_discount,
                             headers: { 'Content-Type' => 'application/json' }
      expect(Guest.count).to eq(1)
      expect(Order.count).to eq(2)

      post '/api/v1/orders', params: valid_payload_with_sku_discount,
                             headers: { 'Content-Type' => 'application/json' }
      expect(Guest.count).to eq(1)
      expect(Order.count).to eq(3)
    end
  end

  context 'when payload is empty' do
    before do
      post '/api/v1/orders', params: '',
                             headers: { 'Content-Type' => 'application/json' }
    end

    it 'returns status code 422' do
      expect(response).to have_http_status(422)
    end
  end
end
