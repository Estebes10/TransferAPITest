# This file executes a generator to create a fake Account object with fake data
FactoryBot.define do

  # Generate a fake record for Account model
  factory :account do
    clabe      {Faker::Number.leading_zero_number(digits: 16)}
    balance    {0}
    association(:user)
  end

end
