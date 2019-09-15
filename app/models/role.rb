class Role < ApplicationRecord

  # Associations
  has_one :user

  # Attributes validation
  validates :name,
    presence: true,
    length:   { maximum: 64 }

  validates :code,
    presence: true,
    uniqueness: true,
    length: { maximum: 16 }

end
