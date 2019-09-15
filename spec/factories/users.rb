# This file executes a generator to create a fake User object with fake data
FactoryBot.define do

  # Generate a fake record for User model
  factory :user do
    name             {Faker::Name.name}
    password         {'contrasena'}
    email            {Faker::Internet.email}
  end

end
