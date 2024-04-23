require 'rails_helper'

RSpec.describe "AddIdeas", type: :request do
    let(:account) { Account.create(email: "sada@yopmail.com", password: "password") }
    let(:valid_params) { { add_idea: { title: 'Sada', idea_type: 2, account_id: account.id } } }
    let(:invalid_params) { { add_idea: { title: 'Ram', idea_type: 2, account_id: 0 } } }


  describe "POST /add_ideas" do
    it 'creates a new idea' do
      # byebug
      post '/add_ideas', params: valid_params
      expect(response).to have_http_status(:created)
    end

    it 'does not create a new idea' do
      # byebug
      post '/add_ideas', params: invalid_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end


  describe "GET /add_ideas" do
    context "when there are add_ideas" do
      it "returns all add_ideas and a success response" do
        post '/add_ideas', params: valid_params
        get '/add_ideas'
        expect(response).to have_http_status(:ok)
      end
    end

    context "when there are no add_ideas" do
      it "returns an error message and a not found response" do
        get '/add_ideas'
        expect(response).to have_http_status(:not_found)
      end
    end
  end



  describe "GET /add_ideas/:id / show" do
  it 'returns the add_idea and a success response' do
    byebug
    post '/add_ideas', params: valid_params
    idea_id = JSON.parse(response.body)['id']
    get "/add_ideas/#{idea_id}"
    expect(response).to have_http_status(:ok)
  end
    it "returns an error message and a not found response" do
      get "/add_ideas/999"
      expect(response).to have_http_status(:not_found)
    end
  end


  describe "DELETE /add_ideas/:id" do
      it 'deletes the add_idea and returns a success response' do
        # byebug
        post '/add_ideas', params: valid_params
        idea_id = JSON.parse(response.body)['id']
        delete "/add_ideas/#{idea_id}"
        expect(response).to have_http_status(:ok)
      end

      it 'returns a not found response' do
        # byebug
        delete "/add_ideas/999" # Assuming 999 is not a valid add_idea id
        expect(response).to have_http_status(:not_found)
      end
  end


  describe "update action" do
      let(:account1) { Account.create(email: "test1@example.com", password: "password123") }
      let(:valid_params) { { add_idea: { title: 'Sada', idea_type: 2, account_id: account.id } } }
      let(:update_params) { { add_idea: { title: 'Updated Title', idea_type: 3, account_id: account.id } } }

      it "updates the add_idea and returns a success response" do
        # byebug
        post '/add_ideas', params: valid_params
        put "/add_ideas/#{AddIdea.last.id}", params: update_params
        expect(response).to have_http_status(:ok)
      end
      it "returns an error message and a not found response" do
        put "/add_ideas/999", params: { title: "Updated Title", idea_type: "Updated Type" }
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("idea not found")
      end
  end

end
