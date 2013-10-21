class Api::V1::SessionsController < Devise::SessionsController

  respond_to :json

  skip_before_filter :verify_authenticity_token

end
