# frozen_string_literal: true
require 'rails_helper'

RSpec.describe V1::AccountController, type: :request do
  let!(:account) { create(:account) }
  let(:headers) { { Auhorizaion: "Bearer #{account.jwt}" } }

  describe 'GET /v1/account/:id' do
    subject(:request) { get v1_account_path(account.id), headers: headers }

    it 'fetch account' do
      request
      expect(response).to have_http_status(200)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['id']).to eq account.id
    end
  end

  describe 'PATCH /v1/account/:id' do
    subject(:request) { patch v1_account_path(account.id), params: params, headers: headers }
    let(:params) do
      { account: {
        email_verification_status: 'verified'
      } }
    end

    it 'update account' do
      request
      expect(response).to have_http_status(200)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['email_verification_status']).to eq 'verified'
    end
  end

  describe 'DELETE /v1/account/:id' do
    subject(:request) { delete v1_account_path(account.id), headers: headers }

    it 'delete account' do
      expect { request }.to change(Account, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
