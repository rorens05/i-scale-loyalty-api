# frozen_string_literal: true

module Orders
  ##
  # This service calculate points for an order
  # Points are calculated as follows:
  # - Points will be calculated as multiplier * subtotal
  # - Points must be floor value, will be rounded down to nearest integer
  # Recommendation for improvement
  # - store the list of points multiplier in the database
  class PointsService < ApplicationService
    POINTS_MULTIPLIER = 2

    def initialize(order)
      @order = order
      super()
    end

    def call
      (@order.sub_total * POINTS_MULTIPLIER).floor
    end
  end
end
