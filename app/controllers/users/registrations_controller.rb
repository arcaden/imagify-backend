# frozen_string_literal: true

class Users::RegistrationsController < Devise::SessionsController
  respond_to :json
end

