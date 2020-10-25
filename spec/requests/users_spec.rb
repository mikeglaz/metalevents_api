require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "CRUD /users" do
    let(:user) {
      create(:user)
    }

    let(:new_user) {
      build(:user, activated: false)
    }

    it "users#index" do
      headers = login(user)
      get users_path, headers: headers

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).first['email']).to eq(user.email)
    end

    it "users#show" do
      headers = login(user)
      get user_path(user.id), headers: headers

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['email']).to eq(user.email)
    end

    it "users#create" do
      # headers = login(user)

      post users_path, params: { name: new_user.name, email: new_user.email, password: new_user.password }

      expect(response).to have_http_status(201)
      user_in_db = User.find_by(email: new_user.email)

      expect(user_in_db.email).to eq(new_user.email)
    end
  end
end

def login(user)
  post login_path, params: { email: user.email, password: user.password }

  { 'Authorization': JSON.parse(response.body)['token'] }
end
