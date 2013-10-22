class Api::V1::SessionsController < Devise::SessionsController

  respond_to :json

  skip_before_filter :verify_authenticity_token
  prepend_before_filter :ensure_sign_out, only: [:create]

  private

  def ensure_sign_out
    sign_out :user
  end

end
