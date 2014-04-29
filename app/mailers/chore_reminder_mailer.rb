class ChoreReminderMailer < ActionMailer::Base

	default from: "splitmate@gmail.com"

	def chore_reminder(chore)
		@chore = chore
		@user = @chore.user
		@url = 'http://splitmate.me/login'
		mail(to: @user.email, subject: 'Chore Deadline is Approaching')
	end 

	def chore_last_chance(chore)
		@chore = chore
		@user = @chore.user
		@url = 'http://splitmate.me/login'
		mail(to: @user.email, subject: 'Last Chance! Chore Deadline is Tomorrow')
	end 

end