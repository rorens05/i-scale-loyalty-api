class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_paper_trail_whodunnit

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :middle_name, :birthday, :gender, :address, :contact_number, :image, 
      :id_image,
  ])
  end

  def user_for_paper_trail
    current_admin_user.present? ? current_admin_user.id : nil
  end
end
