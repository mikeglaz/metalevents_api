require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "CRUD /users" do
    let(:user) {
      create(:user)
    }

    let(:admin_user) {
      create(:user, admin: true)
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
      post users_path, params: { name: new_user.name, email: new_user.email, password: new_user.password }

      expect(response).to have_http_status(201)
      user_in_db = User.find_by(email: new_user.email)

      expect(user_in_db.email).to eq(new_user.email)
    end

    it "users#update" do
      headers = login(user)
      put user_path(user.id), params: { name: new_user.name, email: new_user.email, password: new_user.password }, headers: headers

      expect(response).to have_http_status(201)
      expect(JSON.parse(response.body)['email']).to eq(new_user.email)
    end

    it "users#destroy" do
      headers = login(admin_user)

      delete user_path(user.id), headers: headers
      expect(response).to have_http_status(204)
      expect(User.find_by(id: user.id)).to be_nil
    end
  end
end

def login(user)
  post login_path, params: { email: user.email, password: user.password }

  { 'Authorization': JSON.parse(response.body)['token'] }
end
