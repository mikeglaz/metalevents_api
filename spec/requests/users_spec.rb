require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) {
    create(:user)
  }

  let(:admin_user) {
    create(:user, admin: true)
  }

  let(:new_user) {
    build(:user, activated: false)
  }

  let(:unactivated_user) {
    create(:user, activated: false)
  }

  context "CRUD /users" do
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

  context 'email activation' do
    it 'activates unactivated user' do
      params = { token: unactivated_user.activation_token }
      get activation_path, params: params

      unactivated_user.reload

      expect(unactivated_user.activated).to eq(true)
    end
  end

  context 'logging in' do
    it 'activated user logs in' do
      post login_path, params: { email: user.email, password: user.password }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to include('token')
    end

    it 'new user is not allowed' do
      post login_path, params: { email: new_user.email, password: new_user.password }

      expect(JSON.parse(response.body)['message']).to eq('Invalid username/password.')
      expect(response).to have_http_status(401)
    end

    it 'unactivated user is not allowed' do
      post login_path, params: { email: unactivated_user.email, password: unactivated_user.password }

      expect(JSON.parse(response.body)['message']).to eq('User not yet activated.')
      expect(response).to have_http_status(401)
    end
  end
end

def login(user)
  post login_path, params: { email: user.email, password: user.password }

  { 'Authorization': JSON.parse(response.body)['token'] }
end
