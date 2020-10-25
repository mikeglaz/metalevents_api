require 'rails_helper'

RSpec.describe "Events", type: :request do


  describe "CRUD /events" do
      let!(:event) {
        create(:event)
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
      get event_path(event.id)
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq(JSON.parse(event.to_json))
    end
  end
end
