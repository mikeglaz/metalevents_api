class UserMailer < ApplicationMailer
  def activation_email(user)
    @user = user
    mail(to: @user.email, subject: 'Metalevents Account Activation')
  end

  def password_reset_email(user)
    @user = user
    mail(to: @user.email, subject: 'Metalevents Password Reset')
  end
end
