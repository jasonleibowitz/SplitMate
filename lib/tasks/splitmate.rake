 task :overdue_chores => :environment do
     desc "Iterate through all assigned chores and if overdue run undone_chore method"
     @assigned_chores = Chore.where.not(user_id: nil)
     @assigned_chores.each do |chore|
      chore.overdue_chore?
    end
 end
