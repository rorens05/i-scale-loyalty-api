class PaperTrailVersionController < ApplicationController

  layout :custom_layout
  before_action :set_version, only: [:reify]
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