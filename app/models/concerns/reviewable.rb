# frozen_string_literal: true

##
# This module is used to add reviews to a model.
module Reviewable
  extend ActiveSupport::Concern

  included do
    has_one :review, as: :reviewable
    after_save :create_review

    def review_count
      self.review = Review.new if review.nil?
      review.review_count
    end

    def review_rating
      self.review = Review.new if review.nil?
      review.review_rating
    end

    def create_review
      self.review = Review.new if review.nil?
    end
  end

  class_methods do
  end
end
