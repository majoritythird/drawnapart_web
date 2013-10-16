class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters

  # Copied from Devise::RegistrationsController
  # GET /resource/sign_up
  def new
    build_resource({})
    self.resource.person = Person.new
    respond_with self.resource
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << {person_attributes: [:name]}
  end

end
