# This file executes a generator to create a fake User object with fake data
FactoryBot.define do

  # Generate a fake record for Transaction model
  factory :transaction do
    source_account      {Faker::Number.leading_zero_number(digits: 16)}
    destination_account {Faker::Number.leading_zero_number(digits: 16)}
    amount              {Faker::Number.decimal(l_digits: 8, r_digits: 2)}
  end

end
