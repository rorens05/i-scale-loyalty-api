# frozen_string_literal: true

##
# This class is used to isolate specific api logic from base application controller
module Api
  module V1
    class ApiController < ApplicationController
      skip_before_action :verify_authenticity_token
    end
  end
end
