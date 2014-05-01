class Approval < ActiveRecord::Base

	belongs_to :user
	belongs_to :chore_history

	after_save :calculate_score, :check_ratio

  # validate :user_cannot_have_voted_multiple_times
 
  # def user_cannot_have_voted_multiple_times
  #   if Approval.find_by(chore_history_id: self.chore_history_id).length > 0
  #   all_approvals_by_chore_history_id = Approval.find_by(self.chore_history_id)
  #   all_approvals_by_chore_history_id.each do |approval|
  #     if approval.user_id = self.user_id
  #       errors.add(:approval_uniqueness, "user has already voted on this chore")
  #     end
  #   end
  #   end
  # end

	#note: after_save runs both on create and update, but always after the more specific callbacks after_create and after_update, no matter the order in which the macro calls were executed.


  #we recalculate the score only when an approval vote is created, updated, or changed.
  def calculate_score
  	self.chore_history.calculate_score
  	self.chore_history.reload
  end	

  def check_ratio
  	self.chore_history.check_ratio 
    self.chore_history.reload
  end


end
