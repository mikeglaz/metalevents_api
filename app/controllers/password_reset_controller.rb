class PasswordResetController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user
      # user.reset_password
      user.create_reset_token
      user.send_password_reset_email

      render json: { message: "Password reset instructions have been sent to #{user.email}."}, status: :created
      # flash[:info] = 'A password reset email has been sent'
      # redirect_to root_path
    else
      render json: { message: "Email not found." }, status: :not_found
    end
  end

  def edit
    decoded_token = JsonWebToken.decode(params[:token])[0]

    if decoded_token
      user = User.find_by(email: decoded_token['email'])
    end

    if user
      token = JsonWebToken.encode({ email: user.email })
      redirect_to "#{Rails.application.config.front_end}/auth/password-update/#{token}"
    else
      redirect_to "#{Rails.application.config.front_end}/auth/activation_error"
    end

    rescue JWT::VerificationError, JWT::ExpiredSignature, JWT::DecodeError
      redirect_to "#{Rails.application.config.front_end}/auth/activation_error"
  end

  def update
    decoded_token = JsonWebToken.decode(params[:token])[0]

    if decoded_token
      user = User.find_by(email: decoded_token['email'])
    end

    if user
      user.update_password(params[:password])
      render json: { message: "Password has been successfully updated!"}, status: :created
      # redirect_to "http://localhost:4200/auth/password-update/#{token}"
    else
      redirect_to "#{Rails.application.config.front_end}/auth/activation_error"
    end

    rescue JWT::VerificationError, JWT::ExpiredSignature, JWT::DecodeError
      redirect_to "#{Rails.application.config.front_end}/auth/activation_error"
  end

  # def update
  #   user = User.find_by(email: params[:email])

  #   if user.update_attributes(user_params)
  #     flash[:success] = 'Password updated!'
  #     redirect_to sign_in_path
  #   else
  #     render :edit
  #   end
  # end

end
