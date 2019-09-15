# This class represent the cipher and decipher methods to encrypt token for
# each user who has entered in the system for a limited time.
class JsonWebToken

  # secret to encode and decode token
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  # Encryption method
  def self.encode(payload, exp = 24.hours.from_now)
    # set expiry to 24 hours from creation time
    payload[:exp] = exp.to_i
    # sign token with application secret and user HS256 encryption code
    JWT.encode(payload, HMAC_SECRET, 'HS256')
  end

  # Decryption method
  def self.decode(token)
    # get payload; first index in decoded Array
    body = JWT.decode(token, HMAC_SECRET, true, { :algorithm => 'HS256' })[0]
    HashWithIndifferentAccess.new body
    # rescue from expiry exception
  rescue JWT::ExpiredSignature, JWT::VerificationError => e
    # raise custom error to be handled by custom handler
    raise(ExceptionHandler::ExpiredSignature, Message.expired_token)
  end

end
