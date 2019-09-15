class Account < ApplicationRecord

  belongs_to :user

  # Attributes validation
  validates :clabe,
    presence:   true,
    uniqueness: true,
    length:     { is: 16 }

  validates :balance,
    presence: true,
    numericality: { only_integer: false }
end
