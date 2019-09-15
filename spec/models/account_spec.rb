require 'rails_helper'

RSpec.describe Account, type: :model do
  subject(:account) do
    # Returns a User instance that's not saved
    FactoryBot.build(:account)
  end

  # Test for all valid attributes are given
  it 'is valid if the clabe and balance are given' do
    expect(account).to be_valid
  end

  # Set of tests for each attribute that is required
  it 'is not valid without a clabe' do
    account.clabe = nil

    expect(account).not_to be_valid
  end

  it 'is not valid without a balance' do
    account.balance = nil

    expect(account).not_to be_valid
  end

  # Set of tests to validate the length for each attribute
  it 'is not valid if the clabe given contains more than 16 characters' do
    account.clabe = 'a' * 17

    expect(account).not_to be_valid
  end

  it 'is not valid if the clabe given contains less than 16 characters' do
    account.clabe = 'a' * 15

    expect(account).not_to be_valid
  end

  # validate uniqueness for clabe attribute
  it 'is not valid if the clabe is not unique' do
    # Create a previos record of users and then try to save the new account built
    # before
    FactoryBot.create(:account, clabe: account.clabe)

    expect(account).not_to be_valid
  end

  # test associations
  it { should belong_to(:user) }

end
