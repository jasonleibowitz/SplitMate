class ChoreHistory < ActiveRecord::Base

  belongs_to :user
  belongs_to :chore
  belongs_to :apartment
  has_many :approvals, dependent: :destroy

  def calculate_score
  	#this method is neccesary to the approvals model, so that we can have an accurate score for a chore, even after an approval has been deleted from the database.
  	total = 0
  	self.approvals.each do |approval|
  		total += approval.value
  	end
  	self.approval_points = total
    self.approval_ratio = (self.approval_points.to_f / self.approvals.length.to_f) * 100
  	self.save
  end

  def check_ratio
    if self.approval_ratio < 0 && self.approved 
      remaining_votes = (self.apartment.users.length - 1) - self.approvals.length
      deduction = self.points_value * (-1)
      if (self.approval_points + remaining_votes) < 0
        self.user.update_points(deduction)
        self.approved = false
        self.save
      end 
    end      

  end

  private


end
