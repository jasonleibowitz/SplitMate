class Chore < ActiveRecord::Base

  belongs_to :apartment
  belongs_to :user
  has_many :chore_histories

	def complete_chore
		self.user.update_points(self.points_value)
		self.user.save!
		self.user = nil
  end


end
