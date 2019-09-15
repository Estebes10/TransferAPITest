# This class implements the authentication method for users which are
# already registered into the system.
# @param [String] Email, string containing the email of the current user
# @param [String] Password, hidden string containing the user's password
#
# Author:: Juan Carlos Estebes <jhon10njc@gmail.com>
class AuthenticationController < ApplicationController

  # skip authorization request to user who are trying to logged in the system
  skip_before_action :authorize_request, only: :authenticate

  # return auth token once user is authenticated
  def authenticate
    auth_token =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  private

  # permit only this attributes in the login endpoint
  def auth_params
    params.permit(:email, :password)
  end

end
