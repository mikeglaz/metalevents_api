require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe "GET /events" do
    let!(:event) {
      create(:event)
    }

    it "works! (now write some real specs)" do
      get events_path
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq([JSON.parse(event.to_json)])
    end
  end
end
