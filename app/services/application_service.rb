# frozen_string_literal: true

##
# Base class of services
class ApplicationService
  def self.call(*args)
    new(*args).call
  end
end
