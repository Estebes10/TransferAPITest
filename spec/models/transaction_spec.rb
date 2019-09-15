require 'rails_helper'

RSpec.describe Transaction, type: :model do

  subject(:transaction) do
    # Returns a User instance that's not saved
    FactoryBot.build(:transaction)
  end

  # Test for all valid attributes are given
  it 'is valid if the source_account, destination_account and amount are given' do
    expect(transaction).to be_valid
  end

  # Set of tests for each attribute that is required
  it 'is not valid without a source_account' do
    transaction.source_account = nil

    expect(transaction).not_to be_valid
  end

  it 'is not valid without a destination_account' do
    transaction.destination_account = nil

    expect(transaction).not_to be_valid
  end

  it 'is not valid without a amount' do
    transaction.amount = nil

    expect(transaction).not_to be_valid
  end

  # Set of tests to validate the length for each attribute
  it 'is not valid if the source_account given contains more than 16 characters' do
    transaction.source_account = 'a' * 17

    expect(transaction).not_to be_valid
  end

  it 'is not valid if the source_account given contains less than 16 characters' do
    transaction.source_account = 'a' * 15

    expect(transaction).not_to be_valid
  end

  it 'is not valid if the destination_account given contains more than 16 characters' do
    transaction.destination_account = 'a' * 17

    expect(transaction).not_to be_valid
  end

  it 'is not valid if the destination_account given contains less than 16 characters' do
    transaction.destination_account = 'a' * 15

    expect(transaction).not_to be_valid
  end

end
