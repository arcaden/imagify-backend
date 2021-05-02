# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def respond_with(resource, _opts = {})
    render json: {
    status: {code: 200, message: 'Logged in successfully.'},
    }
  end

  def respond_to_on_destroy
    head :ok
  end
end
