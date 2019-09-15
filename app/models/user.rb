class User < ApplicationRecord

  # Associations
  has_one :account
  has_one :role

  # encrypt password
  #has_secure_password

  # Attributes validation
  validates :name,
    presence: true,
    length:   { maximum: 64 }

  validates :password_digest,
    presence: true,
    length: { maximum: 32 }

  #validates :password,
  #presence: true,
  #  length: { maximum: 32 }

  validates :email,
    presence:   true,
    uniqueness: true,
    length:     { maximum: 64 }

end
