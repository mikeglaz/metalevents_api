class JsonWebToken
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, Rails.application.credentials.dig(:secret_key_base))
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.credentials.dig(:secret_key_base))
  rescue
    nil
  end
end
