class Api::V1::RegistrationsController < Users::RegistrationsController

  respond_to :json

  # before_filter :configure_permitted_parameters
  # skip_before_filter :authenticate_user!
  # skip_before_filter :verify_authenticity_token

  # private

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) << {person_attributes: [:name]}
  # end

end
