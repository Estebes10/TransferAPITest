# This file implements a suit of tests for User API endpoint requests
require 'rails_helper'

RSpec.describe 'Users API', type: :request do

  # Create a user test
  let(:user) { build(:user) }

  # User valid headers to test authorization
  let(:headers) { valid_headers.except('Authorization') }

  # create valid attributes for signup
  let(:valid_attributes) do

    # Use the attributes for a user and password_confirmation too
    attributes_for(:user, password_confirmation: user.password)
  end

  # User signup test suite
  describe 'POST /signup' do

    context 'when valid request' do

      # Get the total of user before to do request
      before_count = User.count

      # Before each test execute request
      before(:each) do
        post(
          '/signup',
          params: valid_attributes.to_json,
          headers: headers
        )
      end

      it 'creates a new user' do
        expect(User.count).not_to eq(before_count)
      end

      it 'returns a created status code' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end

    end

    context 'when invalid request' do

      # Get the total of user before to do request
      before_count = User.count

      # Before each test execute request
      before { post '/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(User.count).to eq(before_count)
      end

      it 'returns an unprocessable_entity status' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank, Name can't be blank, Password digest can't be blank, Email can't be blank/)
      end

    end

  end

end
