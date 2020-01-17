class PasswordResetController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user
      user.reset_password
      user.send_reset_password_email

      render json: { message: "Password reset instructions have been sent to #{user.email}."}, status: :created
      # flash[:info] = 'A password reset email has been sent'
      # redirect_to root_path
    else
      render json: { message: "Email not found." }, status: :not_found
    end
  end

  def edit
    user = User.find_by(email: params[:email])

    if user&.authenticated?(:password_reset_digest, params[:id])
      # redirect_to "http://localhost:4200/auth/password-"
    end

    # unless user && user.authenticated?(:password_reset_digest, params[:id])
    #   flash[:danger] = "Invalid reset token"
    #   redirect_to sign_in_path
    # end
  end

  def update
    user = User.find_by(email: params[:email])

    if user.update_attributes(user_params)
      flash[:success] = 'Password updated!'
      redirect_to sign_in_path
    else
      render :edit
    end
  end

end
