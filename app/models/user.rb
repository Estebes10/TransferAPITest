# This class represent a entity or object of User in the database, to store and
# validate data, perform business logic and otherwise do the heavy lifting.
class User < ApplicationRecord

  # Associations
  has_one :account
  belongs_to :role

  # Validations
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  # encrypt password
  has_secure_password

  # Attributes validation
  validates :name,
    presence: true,
    length:   { maximum: 64 }

  validates :password_digest,
    presence: true

  validates :password,
    length: { maximum: 64 }

  validates :email,
    presence:   true,
    uniqueness: true,
    length:     { maximum: 64 },
    format:     VALID_EMAIL_REGEX

  # public class methods
  def is_admin?
    return role.code == 'ADMIN'
  end

end
