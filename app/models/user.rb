class User < ApplicationRecord
  has_one :account
  has_one :role
end
