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

task :clean_week_points => :environment do
  desc "Resets the weekly points total value for each roommate based on apartment's chore assignment day"

  @apartment = Apartment.all
  @apartment.each do |apartment|
    if apartment.chore_assignment_day == Date.today.strftime("%A")
      apartment.users.each do |roommate|
        roommate.total_week_points = 0
        roommate.completed_week_points = 0
        roommate.save
      end
    end
  end

end

task :assign_orphan_chores => :environment do
  desc "Iterates over all unassigned chores and checks if appartment chore assignment day has passed automatically assigns chores based on points. It assigns the chore with the most points to the roommate with the least points."
  @unassigned_chores = Chore.where(user_id: nil)

  @unassigned_chores.each do |unassigned_chore|

  # If chore apartment's chore assignment day was yesterday
    if unassigned_chore.apartment.chore_assignment_day == Date.yesterday.strftime("%A")

    @apartment = unassigned_chore.apartment

      # While there are unassigned chores in this apartment
      while @apartment.chores.where(user_id: nil).length > 0
        # Find the roommate with the lowest possible points for the week's chores
        bum = @apartment.users.order(total_week_points: :desc).last

        # Find the chore worth the most points
        gross_chore = @apartment.chores.where(user_id: nil).order(points_value: :desc).first

        # Assign the gross chore to the bum roommate
        gross_chore.assign_chore(bum)
      end
    end
  end
end
