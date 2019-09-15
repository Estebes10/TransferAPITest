class Transaction < ApplicationRecord

  # Attributes validation
  validates :source_account,
    presence: true,
    length:   { is: 16 }

  validates :destination_account,
    presence: true,
    length:   { is: 16 }

  validates :amount,
    presence: true,
    numericality: { only_integer: false }

end
