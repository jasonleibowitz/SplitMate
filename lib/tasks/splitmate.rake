require 'chronic'

task :overdue_chores => :environment do
     desc "Iterate through all assigned chores and if overdue run undone_chore method"
     @assigned_chores = Chore.where.not(user_id: nil)
     @assigned_chores.each do |chore|
      chore.overdue_chore?
    end
end

task :chore_reminder_email => :environment do 
	desc "Iterate through all assigned chores to check for due dates within the next two days.  Send reminder emails to those users."
	@assigned_chores = Chore.where.not(user_id: nil)

    @assigned_chores.each do |chore|
      if chore.current_due_date == Chronic.parse('two days from now').to_date
      	ChoreReminderMailer.chore_reminder(chore).deliver
      elsif chore.current_due_date <= Chronic.parse('tomorrow').to_date
    	ChoreReminderMailer.chore_last_chance(chore).deliver
      end
    end
end

