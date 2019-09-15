# This class returns custom messages for different requests to the system.
class Message

  def self.not_found(record = 'record')
    "Sorry, #{record} not found."
  end

  def self.invalid_credentials
    'Invalid credentials'
  end

  def self.invalid_token
    'Invalid token'
  end

  def self.missing_token
    'Missing token'
  end

  def self.unauthorized
    'Unauthorized request'
  end

  def self.account_created
    'Account created successfully'
  end

  def self.account_not_created
    'Account could not be created'
  end

  def self.expired_token
    'Sorry, your token has expired. Please login to continue.'
  end

  def self.signature_has_expired
    'Signature has expired'
  end

  def self.record_created(record = 'record')
    "Great, the #{record} was created successfully"
  end

  def self.record_not_created(record = 'Object requested')
    "Sorry, the #{record} could not be created"
  end

  def self.empty
    'No records found'
  end

  def self.record_updated(record = 'record')
    "The #{record} was updated successfully"
  end

  def self.successfully_assigned(record = 'record', record2 = 'record')
    "The #{record} was successfully assigned to the #{record2}"
  end

  def self.succesfull_transfer
    "Successfull transaction"
  end

  def self.error_occurs(record = 'record')
    "The #{record} could not be removed because an unexpected error occurs"
  end

  def self.not_permission(record = 'user')
    "The #{record} has not permission to create users"
  end

  def self.not_privileges(record = 'user')
    "The user: #{record}, has not privileges to make transactions, it must be holder"
  end

  def self.not_transfer
    "The transfer could not be made"
  end

  def self.no_money
    "The holder has no enough money"
  end

  def self.holder_not_found(holder = 'holder')
    "The destination clabe: #{holder}, could not be found"
  end
end
