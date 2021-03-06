class JsonWebToken
  HMAC_SECRET = Rails.application.credentials.secret_key_base

  def self.encode(payload, expiresIn = 1.hour.from_now)
    payload[:exp] = expiresIn.to_i

    JWT.encode(payload, HMAC_SECRET, 'HS256')
  end

  def self.decode(token)
    JWT.decode(token, HMAC_SECRET, true, algorithm: 'HS256')
  # rescue
  #   [nil]
  end

  def self.expired(payload)
    Time.at(payload[:exp]) < Time.now
  end
end

