# This file implements a suit of tests to validate authentication of a current
# user with valid and invalid token, to allow requests in the system or sent
# exception messages.
require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  # create test user
  let!(:user) { create(:user) }

  # set headers for authorization
  let(:headers) do
    {
      'Authorization' => token_generator(user.id),
    }
  end

  let(:invalid_headers) do
    {
      'Authorization' => nil,
    }
  end

  describe '#authorize_request' do

    context 'when auth token is passed' do

      before { allow(request).to receive(:headers).and_return(headers) }

      # private method authorize_request returns current user
      it 'sets the current user' do
        expect(subject.instance_eval { authorize_request }).to eq(user)
      end

    end

    context 'when auth token is not passed' do

      before do
        allow(request).to receive(:headers).and_return(invalid_headers)
      end

      it 'raises MissingToken error' do
        expect { subject.instance_eval { authorize_request } }
          .to raise_error(ExceptionHandler::MissingToken, /Missing token/)
      end

    end

  end

end
