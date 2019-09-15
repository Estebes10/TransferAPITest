# This file executes a generator to create a fake Role object with fake data
FactoryBot.define do

  # Generate a fake record of Role model
  factory :role do
    code        {Faker::Alphanumeric.alphanumeric(number: 16)}
    name        {Faker::Job.position}
  end

end
