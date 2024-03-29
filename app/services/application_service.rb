# frozen_string_literal: true

##
# Base class of services
class ApplicationService
  def self.call(*args, block)
    new(*args, block).call
  end
end
