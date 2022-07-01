# frozen_string_literal: true

require 'rails_helper'

describe 'Orders' do
  let(:not_discounted) do
    [
      {
        sku: 'AAA',
        price: 2,
        quantity: 1
      },
      {
        sku: 'BBB',
        price: 2,
        quantity: 1
      }
    ]
  end

  let(:discounted) do
    [
      {
        sku: 'AAA',
        price: 5,
        quantity: 2
      },
      {
        sku: 'BBB',
        price: 5,
        quantity: 3
      }
    ]
  end

  let(:sku_discounted) do
    [
      {
        sku: 'AAA',
        price: 2,
        quantity: 1
      },
      {
        sku: 'CCC',
        price: 5,
        quantity: 1
      }
    ]
  end

  let(:discounted_and_sku_discounted) do
    [
      {
        sku: 'AAA',
        price: 5,
        quantity: 2
      },
      {
        sku: 'BBB',
        price: 5,
        quantity: 3
      },
      {
        sku: 'CCC',
        price: 5,
        quantity: 1
      }
    ]
  end

  context 'when order is not discounted' do
    before do
      @order = Order.new
      @order.order_items.build(not_discounted)
      @order = Orders::OrderCalculatorService.call(order: @order, discount_service: Orders::DiscountService,
                                                   points_service: Orders::PointsService,
                                                   sub_total_service: Orders::SubTotalService)
    end

    it 'returns 0 discount' do
      expect(@order.discount.to_s).to eq('0.0')
    end

    it 'returns correct subtotal' do
      expect(@order.sub_total.to_s).to eq('4.0')
    end

    it 'returns correct points' do
      expect(@order.points.to_s).to eq('8.0')
    end
  end

  context 'when order is discounted' do
    before do
      @order = Order.new
      @order.order_items.build(discounted)
      @order = Orders::OrderCalculatorService.call(order: @order, discount_service: Orders::DiscountService,
                                                   points_service: Orders::PointsService,
                                                   sub_total_service: Orders::SubTotalService)
    end

    it 'returns correct discount' do
      expect(@order.discount.to_s).to eq('5.0')
    end

    it 'returns correct subtotal' do
      expect(@order.sub_total.to_s).to eq('20.0')
    end

    it 'returns correct points' do
      expect(@order.points.to_s).to eq('40.0')
    end
  end

  context 'when order is sku discounted' do
    before do
      @order = Order.new
      @order.order_items.build(sku_discounted)
      @order = Orders::OrderCalculatorService.call(order: @order, discount_service: Orders::DiscountService,
                                                   points_service: Orders::PointsService,
                                                   sub_total_service: Orders::SubTotalService)
    end

    it 'returns correct discount' do
      expect(@order.discount.to_s).to eq('2.0')
    end

    it 'returns correct subtotal' do
      expect(@order.sub_total.to_s).to eq('5.0')
    end

    it 'returns correct points' do
      expect(@order.points.to_s).to eq('10.0')
    end
  end

  context 'when order is discounted and sku discounted' do
    before do
      @order = Order.new
      @order.order_items.build(discounted_and_sku_discounted)
      @order = Orders::OrderCalculatorService.call(order: @order, discount_service: Orders::DiscountService,
                                                   points_service: Orders::PointsService,
                                                   sub_total_service: Orders::SubTotalService)
    end

    it 'returns correct discount' do
      expect(@order.discount.to_s).to eq('6.0')
    end

    it 'returns correct subtotal' do
      expect(@order.sub_total.to_s).to eq('24.0')
    end

    it 'returns correct points' do
      expect(@order.points.to_s).to eq('48.0')
    end
  end
end
