class ApplicationController < ActionController::API


  protected
    # Validates the token and user and sets the @current_user scope
    def authorize_request!
      if !payload #|| !JsonWebToken.valid_payload(payload.first)
        return invalid_authentication
      end

      load_current_user!
      invalid_authentication unless @current_user
      # byebug

    end

    # Returns 401 response. To handle malformed / invalid requests.
    def invalid_authentication
      render json: { message: 'Unauthorized'}, status: :unauthorized
    end

    private
      # Deconstructs the Authorization header and decodes the JWT token.
      def payload
        token = request.headers['Authorization']
        JsonWebToken.decode(token)
      rescue
        nil
      end

      # Sets the @current_user with the user_id from payload
      def load_current_user!
        @current_user = User.find(payload[0]['id'])
      end
end
