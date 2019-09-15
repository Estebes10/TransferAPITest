# This file executes a generator to create a fake User object with fake data
FactoryBot.define do

  # Generate a fake record for User model
  factory :user do
    name             {Faker::Name.name}
    password_digest         {Faker::Alphanumeric.alphanumeric(number: 20)}
    email            {Faker::Internet.email}
  end

end
