# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def new
    build_resource({})
    set_minimum_password_length
    self.resource.company = Company.new
    yield resource if block_given?
    respond_with self.resource
  end

  def sign_up_params
    user_params = [:name, :email, :password]
    params.require(resource_name).permit(user_params)
  end
end
