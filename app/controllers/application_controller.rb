class ApplicationController < ActionController::API


  protected

    def authenticate_request
      if payload
        load_current_user
      end

    end

    def payload
      auth_header = request.headers['Authorization']
      token = auth_header.split(' ').last
      JsonWebToken.decode(token)
    end

    def load_current_user
      byebug
      @current_user = User.find(payload[0]['user_id'])
    end
end
