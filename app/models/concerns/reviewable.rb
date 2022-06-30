module Reviewable
  extend ActiveSupport::Concern

  included do
    has_one :review, as: :reviewable
    after_save :create_review

    
    def review_count
      self.review = Review.new if self.review.nil?
      self.review.review_count
    end

    def review_rating
      self.review = Review.new if self.review.nil?
      self.review.review_rating
    end

    def create_review
      self.review = Review.new if self.review.nil?
    end
    
  end

  class_methods do

  end
end

