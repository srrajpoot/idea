require 'rails_helper'

RSpec.describe FeedbacksController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      byebug
      account = Account.create(email: "sada@yopmail.com", password: "password")
      let(:valid_params) { { feedback: { description: 'Your feedback description', account_id: account.id } } }
      let(:invalid_params) { { feedback: { description: 'Your feedback description', account_id: 0 } } }
      it 'creates a new feedback' do
        # byebug
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
      it 'creates a new feedback' do
        # byebug
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
