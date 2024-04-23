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


    context "with invalid parameters" do
      let(:invalid_params) do
        { data: { attributes: { email: nil, password: nil } } }
      end

      it "does not create a new account" do
        expect {
          post :create, params: invalid_params
        }.not_to change(Account, :count)
      end

      it "returns an error in the response" do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unauthorized)
        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Invalid email or password")
      end
    end


    describe "GET #index" do
        context "with existing accounts" do
          let!(:account1) { Account.create(email: "test1@example.com", password: "password123") }
          let!(:account2) { Account.create(email: "test2@example.com", password: "password456") }

          it "returns a list of accounts" do
            get :index
            expect(response).to have_http_status(:ok)
            body = JSON.parse(response.body)
            expect(body.size).to eq(2)
            expect(body[0]["email"]).to eq(account1.email)
            expect(body[1]["email"]).to eq(account2.email)
          end
        end

        context "with no existing accounts" do
          it "returns an error message" do
            get :index
            expect(response).to have_http_status(:not_found)
            body = JSON.parse(response.body)
            expect(body["error"]).to eq("No accounts found")
          end
        end
      end
    end
    

    context "with existing account" do
      let(:account) { Account.create(email: "test@example.com", password: "password123") }
        it "returns the specified account" do
          get :show, params: { id: account.id }
          expect(response).to have_http_status(:ok)
          body = JSON.parse(response.body)
          expect(body["email"]).to eq(account.email)
        end
        it "returns an error message" do
          get :show, params: { id: 999 } # Assuming 999 is a non-existing ID
          expect(response).to have_http_status(:not_found)
          body = JSON.parse(response.body)
          expect(body["error"]).to eq("Account not found")
        end
    end


    describe "DELETE #destroy" do
      context "when the account exists" do
      let(:account) { Account.create(email: 'test@example.com', password: 'password123') }

      it "deletes the account" do
        expect {
          delete :destroy, params: { id: account.id }
          expect(response).to have_http_status(:ok) # Add this line to ensure successful response
          expect(JSON.parse(response.body)['message']).to eq('Account deleted successfully')
        }
      end
        it "returns a success response" do
          delete :destroy, params: { id: account.id }
          expect(response).to have_http_status(:ok)
          expect(response.body).to include("Account deleted successfully")
        end
      end

      context "when the account does not exist" do
        it "returns a not found response" do
          delete :destroy, params: { id: 999 } # Assuming ID 999 doesn't exist
          expect(response).to have_http_status(:not_found)
          expect(response.body).to include("Account not found")
        end
      end
    end







end
