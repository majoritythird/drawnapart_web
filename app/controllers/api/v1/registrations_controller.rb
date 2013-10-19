class Api::V1::RegistrationsController < Users::RegistrationsController

  respond_to :json

  skip_before_filter :verify_authenticity_token

end
