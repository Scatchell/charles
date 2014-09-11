class RegistrationsController < Devise::RegistrationsController

  protected
  
  def after_sign_up_path_for(resource)
    successful_registration_path
  end
end