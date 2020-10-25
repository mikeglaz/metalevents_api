require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "CRUD /users" do
    let(:user) {
      create(:user)
    }

    it "users#index" do
      headers = login(user)

      get users_path, headers: headers

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).first['email']).to eq(user.email)
    end

    it "users#show" do
      get user_path(user.id)
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['name']).to eq(event.name)
    end
  end
end

def login(user)
  post login_path, params: { email: user.email, password: user.password }

  { 'Authorization': JSON.parse(response.body)['token'] }
end
