require 'rails_helper'

RSpec.describe Role, type: :model do
  subject(:role) do
    # Returns a User instance that's not saved
    FactoryBot.build(:role)
  end

  # Test for all valid attributes are given
  it 'is valid if the name and are given' do
    expect(role).to be_valid
  end

  # Set of tests for each attribute that is required
  it 'is not valid without a name' do
    role.name = nil

    expect(role).not_to be_valid
  end

  it 'is not valid without a code' do
    role.code = nil

    expect(role).not_to be_valid
  end

  # Set of tests to validate the length for each attribute
  it 'is not valid if the name given contains more than 64 characters' do
    role.name = 'a' * 65

    expect(role).not_to be_valid
  end

  it 'is not valid if the code given contains more than 16 characters' do
    role.code = 'a' * 17

    expect(role).not_to be_valid
  end

  # validate uniqueness for code attribute
  it 'is not valid if the code is not unique' do
    # Create a previos record of users and then try to save the new role built
    # before
    FactoryBot.create(:role, code: role.code)

    expect(role).not_to be_valid
  end

  # test associations
  it { should belong_to(:user) }
end
