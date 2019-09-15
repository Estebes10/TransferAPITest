# This class will be responsible for authenticating users via email and
# password for users who are already registered in the system.
# Params:
# +email+:: string less than 64 characters
# +password+:: hidden string less than 64 characters
#
# Author:: Juan Carlos Estebes <jhon10njc@gmail.com>
class AuthenticateUser

  # class initilization
  def initialize(email, password)
    @email = email
    @password = password
  end

  # Service entry point
  # *  Encode if user exits.
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_reader :email, :password

  # verify user credentials
  # * raise Authentication error if credentials are invalid
  def user
    user = User.find_by(email: email)
    return user if user && user.authenticate(password)
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end

end
