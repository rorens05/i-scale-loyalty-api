# frozen_string_literal: true

##
# This module is used to format status of a model
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
