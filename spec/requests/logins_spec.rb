require 'rails_helper'

RSpec.describe LoginsController, type: :controller do
  describe "POST #create" do
    
    context "with valid credentials" do
      let(:valid_params) do
        { data: { attributes: { email: "valid@example.com", password: "validpassword" } } }
      end

      before do
        Account.create(email: "valid@example.com", password: "validpassword")
      end

      it "returns a token in the response" do
        post :create, params: valid_params
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body["token"]).to be_present
      end
    end

    context "with invalid credentials" do
      let(:invalid_params) do
        { data: { attributes: { email: "invalid@example.com", password: "invalidpassword" } } }
      end

      it "returns an error in the response" do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unauthorized)
        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Invalid email or password")
      end
    end
  end
end
