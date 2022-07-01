# frozen_string_literal: true

##
# This controller is used to manage PaperTrailVersion
# Specifically for restoring versions of a model
class PaperTrailVersionController < ApplicationController
  before_action :authenticate_admin_user!, only: [:reify]

  def reify
    @version.reify.save
    redirect_to request.referer
  end

  private

  def set_version
    @version = PaperTrail::Version.find(params[:id])
  end
end
