class Chore < ActiveRecord::Base

  belongs_to :apartment
  belongs_to :user
  has_many :chore_histories

	def complete_chore(comments)
		# Give user points for completing chore
		self.user.update_points(self.points_value)
		self.user.save!

		#Mark chore as unassigned
		self.user = nil
		self.save


		# Create a new chore history after user completed chore
    @chore_history = ChoreHistory.new
    @chore_history.comments = comments
    @chore_history.chore = self
    @chore_history.name = self.name
    @chore_history.points_value = self.points_value
    @chore_history.user = self.user
    @chore_history.apartment = self.user.apartment
    @chore_history.save!
  end


end
