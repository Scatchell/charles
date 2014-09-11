class UsersController < ApplicationController
  before_action :authenticate_user!

  def successful_registration
    @auth_code = current_user.auth_code
  end
end
