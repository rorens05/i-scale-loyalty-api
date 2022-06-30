# frozen_string_literal: true

module StatusTracking
  extend ActiveSupport::Concern

  included do
    enum status: %w[Active Inactive]
    scope :active, -> { where(status: 'Active') }
    scope :inactive, -> { where(status: 'Inactive') }
  end

  class_methods do
  end
end
