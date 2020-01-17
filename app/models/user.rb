class User < ApplicationRecord
  has_many :events

  has_secure_password

  attr_accessor :activation_token, :password_reset_token

  before_save :downcase_email
  before_create :create_activation_digest

  def authenticated?(digest_type, token)
    digest = self.send(digest_type)
    BCrypt::Password.new(digest).is_password?(token)
  end

  def reset_password
    self.password_reset_token = self.class.generate_token
    self.password_reset_digest = self.class.encrypt_token(password_reset_token)
    self.save
  end

  def send_reset_password_email
    UserMailer.password_reset_email(self).deliver_now
  end

  private

    def downcase_email
      self.email.downcase!
    end

    def self.encrypt_token(token)
      BCrypt::Password.create(token)
    end

    def self.generate_token
      SecureRandom.urlsafe_base64
    end

    def create_activation_digest
      self.activation_token = self.class.generate_token
      self.activation_digest = self.class.encrypt_token(activation_token)
    end
end
