require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it 'is valid with a name, email, and password' do
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user.name = ''
    expect(user).to_not be_valid
  end

  it 'is not valid without an email' do
    user.email = ''
    expect(user).to_not be_valid
  end

  it 'is not valid with an invalid email' do
    user.email = 'email_at_example_dot_com'
    expect(user).to_not be_valid
  end

  it 'is not valid without a password' do
    user.password_digest = ''
    expect(user).to_not be_valid
  end

  it 'is not valid without a password confirmation' do
    user.password_confirmation = ''
    expect(user).to_not be_valid
  end

  it 'is not valid with duplicate email' do
    email = Faker::Internet.email

    create(:user, email: email)
    user = build(:user, email: email)

    expect(user).to_not be_valid
  end

  it 'converts email to all lower case' do
    email = Faker::Internet.email
    user.email = email.upcase
    user.save

    expect(user.email).to eq(email)
  end
end
