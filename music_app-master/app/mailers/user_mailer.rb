class UserMailer < ApplicationMailer
  default from: "MusicApp@appacademy.io"

  def welcome_email(user)
    @user = user
    mail(to:user.email, subject: "Activate Your account")

  end
end
