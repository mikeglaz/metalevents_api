class UserMailer < ApplicationMailer
  def activation_email(user)
    @user = user
    mail(to: @user.email, subject: 'Account Activation')
  end

  def password_reset_email(user)
    @user = user
    mail(to: @user.email, subject: 'Password Reset')
  end
end
