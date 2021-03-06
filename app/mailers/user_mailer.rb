class UserMailer < ActionMailer::Base
  default from: "splitmate@gmail.com"

  def welcome_user(user)
    @user = user
    @url = 'http://splitmate.herokuapp.com/login'
    mail(to: @user.email, subject: 'Welcome to SplitMate')
  end

  def roommate_welcome(user)
    @user = user
    @url = 'http://splitmate.herokuapp.com/login'
    mail(to: @user.email, subject: 'You Have Been Signed Up For SplitMate By Your Roommate')
  end

  def chored(user, roommate, chore)
    @user = user
    @roommate = roommate
    @chore = chore
    @url = 'http://splitmate.herokuapp.com/users'
    mail(to: @user.email, subject: 'You Just Got Chored!')
  end

end
