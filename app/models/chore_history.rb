class ChoreHistory < ActiveRecord::Base

  belongs_to :user
  belongs_to :chore
  belongs_to :apartment
  has_many :approvals, dependent: :destroy

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_attached_file :after_picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :after_picture, :content_type => /\Aimage\/.*\Z/

  scope :last_week, -> { where("created_at BETWEEN '#{1.week.ago}' AND '#{DateTime.now.end_of_day}'")  }

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
        self.chore.dollar_value += self.points_value
        self.user.dollar_balance -= self.chore.dollar_value
        self.save
        self.user.save
      end
    end

  end

  private


end
