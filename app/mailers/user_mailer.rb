class UserMailer < ApplicationMailer
 def password_reset(phone, email)
    @user = User.find_by(phone: phone)
    mail :to => email, :subject => "Password Reset"
  end
end
