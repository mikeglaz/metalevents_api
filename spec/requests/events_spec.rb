require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe "CRUD /events" do
    let(:user) {
      create(:user)
    }

    let!(:event) {
      create(:event, user: user)
    }

    let(:new_event) {
      build(:event, user: user)
    }

    it "events#index" do
      get events_path
      expect(response).to have_http_status(200)

      expect(JSON.parse(response.body).first['name']).to eq(event.name)
    end

    it "events#show" do
      get event_path(event.id)
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['name']).to eq(event.name)
    end

    it "events#create" do
      login(user)

      headers = { 'Authorization': JSON.parse(response.body)['token'] }

      post events_path, params: { event: new_event.attributes }, headers: headers
      expect(response).to have_http_status(201)
      expect(JSON.parse(response.body)['name']).to eq(new_event.name)
    end

    it "events#update" do
      login(user)

      headers = { 'Authorization': JSON.parse(response.body)['token'] }

      put event_path(event.id), params: { event: new_event.attributes }, headers: headers
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['name']).to eq(new_event.name)
    end

  end
end

def login(user)
  post login_path, params: { email: user.email, password: user.password }
end
