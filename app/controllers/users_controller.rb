# This class has the method needed to create a new user and save it into the
# system.
# @param [Hash] User, all required attributes for a user object.
#
# Author:: Juan Carlos Estebes <jhon10njc@gmail.com>
class UsersController < ApplicationController

  # skip authorization request to users who are trying to create their account
  skip_before_action :authorize_request, only: :create

  # POST /signup
  # return authenticated token upon signup
  # Create the user if valid attributes are given
  def create
    @user = User.create!(user_params)
    if @user
      auth_token = AuthenticateUser.new(@user.email, @user.password).call
      response = { message: Message.account_created, auth_token: auth_token }
      json_response(response, :created)
    else
      json_response(response, :unprocessable_entity)
    end
  end

  private

  # all params that are required to crated a new user account
  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end

end
