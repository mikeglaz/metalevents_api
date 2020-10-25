require 'rails_helper'

RSpec.describe "Events", type: :request do


  describe "CRUD /events" do
      let!(:event) {
        create(:event)
      }

      let!(:user) {
        create(:user)
      }

      let(:new_event) {
        build(:event)
      }

    it "events#index" do
      get events_path
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq([JSON.parse(event.to_json)])
    end

    it "events#show" do
      get event_path(event.id)
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq(JSON.parse(event.to_json))
    end

    it "events#create" do
      post login_path, params: { email: user.email, password: user.password }

      headers = { 'Authorization': JSON.parse(response.body)['token'] }

      post events_path, params: { event: new_event.attributes }, headers: headers
      expect(response).to have_http_status(201)
      # expect(JSON.parse(response.body)).to eq(JSON.parse(event.to_json))
    end
  end
end
