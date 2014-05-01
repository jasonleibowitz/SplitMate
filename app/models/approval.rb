class Approval < ActiveRecord::Base

	belongs_to :user
	belongs_to :chore_history

	after_save :calculate_score, :check_ratio

  validates :chore_history, uniqueness: { scope: :user_id,
    message: "should only have one vote per user" }

	
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
