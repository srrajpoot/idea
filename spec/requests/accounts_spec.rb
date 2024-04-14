require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  describe "POST #create" do

    context "with valid parameters" do
      let(:valid_params) do
        {data: {attributes: {email: "sada@example.com",password: "password123456"}}}
      end

      it "creates a new account" do
        expect {
          post :create, params: valid_params
        }.to change(Account, :count).by(1)
      end

      it "returns a token in the response" do
        post :create, params: valid_params
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body["token"]).to be_present
      end
    end

      # context "with invalid parameters" do
      #     let(:invalid_params) do
      #       { data: { attributes: { email: nil, password: nil } } }
      #     end

      #     it "does not create a new account" do
      #       expect {
      #         post :create, params: invalid_params
      #       }.not_to change(Account, :count)
      #     end

      #     # it "returns an error in the response" do
      #     #   post :create, params: invalid_params
      #     #   expect(response).to have_http_status(:unauthorized)
      #     #   body = JSON.parse(response.body)
      #     #   expect(body["error"]).to eq("Invalid email or password")
      #     end
      # end

  end
end
