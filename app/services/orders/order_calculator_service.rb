# frozen_string_literal: true

module Orders
  ##
  # This service computes the discount, points, and sub total for an order
  # This compiles all the order services together to calculate the order
  class OrderCalculatorService < ApplicationService
    attr_reader :order, :discount_service, :points_service, :sub_total_service

    def initialize(order:, discount_service:, points_service:, sub_total_service:)
      @order = order
      @discount_service = discount_service
      @points_service = points_service
      @sub_total_service = sub_total_service

      super()
    end

    def call
      order.discount = discount_service.call(order)
      order.sub_total = sub_total_service.call(order)
      order.points = points_service.call(order)
      order
    end
  end
end
