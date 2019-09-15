require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    # Returns a User instance that's not saved
    FactoryBot.build(:user)
  end

  # Test for all valid attributes are given
  it 'is valid if the name, password and email are given' do
    expect(user).to be_valid
  end

  # Set of tests for each attribute that is required
  it 'is not valid without a name' do
    user.name = nil

    expect(user).not_to be_valid
  end

  it 'is not valid without an email' do
    user.email = nil

    expect(user).not_to be_valid
  end

  it 'is not valid without a password' do
    user.password_digest = nil

    expect(user).not_to be_valid
  end

  # Set of tests to validate the length for each attribute
  it 'is not valid if the name given contains more than 64 characters' do
    user.name = 'a' * 65

    expect(user).not_to be_valid
  end

  it 'is not valid if the email given contains more than 64 characters' do
    user.email = 'a' * 65

    expect(user).not_to be_valid
  end

  it 'is not valid if the password given contains more than 64 characters' do
    user.password = 'a' * 65

    expect(user).not_to be_valid
  end

  # validate uniqueness for email attribute
  it 'is not valid if the email is not unique' do
    # Create a previos record of users and then try to save the new user built
    # before
    FactoryBot.create(:user, email: user.email)

    expect(user).not_to be_valid
  end

  # validate email format
  it 'is not valid if email has not valid format' do
    user.email = 'correo.no-valido'

    expect(user).not_to be_valid
  end

  # test associations
  it { should have_one(:account) }

  it { should belong_to(:role) }

  # set of tests for each instance and class methods
  describe ".is_admin?" do

    after(:each) do
      Role.destroy_all
      User.destroy_all
    end

    # returns user object when request is valid
    context 'when user is admin' do

      before(:each) do
        @valid_role = Role.create(name: 'ADMINISTRATOR', code: 'ADMIN')
      end

      it 'returns true' do
        @user = FactoryBot.create(:user, role_id: @valid_role.id)

        expect(@user.is_admin?).to be(true)
      end

    end

    context 'when user is not admin' do

      before(:each) do
        @not_valid_role = Role.create(name: 'Holder', code: 'HOLDER')
      end

      it 'returns false' do
        @user = FactoryBot.create(:user, role_id: @not_valid_role.id)

        expect(@user.is_admin?).to be(false)
      end

    end
  end
end
