class UserMailer < ActionMailer::Base
  default from: "splitmate@gmail.com"

  def welcome_user(user)
    @user = user
    @url = 'http://splitmate.me/login'
    mail(to: @user.email, subject: 'Welcome to SplitMate')
  end

  def roommate_welcome(user)
    @user = user
    @url = 'http://localhost:3000/login'
    mail(to: @user.email, subject: 'You Have Been Signed Up For SplitMate By Your Roommate')
  end

end
