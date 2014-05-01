class Chore < ActiveRecord::Base

  belongs_to :apartment
  belongs_to :user
  has_many :chore_histories

  validates :name, :points_value, :due_date, presence: true
  validates :points_value, numericality: { only_integer: true, less_than_or_equal_to: 20, greater_than_or_equal_to: 1 }

	# def complete_chore(comments, before_pic, after_pic)

	# 	@user = self.user

 #    # Give user points for completing chore
	# 	@user.update_points(self.points_value)
	# 	@user.save!

 #    # If chore had money value give user that amount and remove it from the chore object
 #    if self.dollar_value != nil || self.dollar_value > 0
 #      @user.dollar_balance += self.dollar_value
 #      @user.save!
 #      self.dollar_value = 0
 #      self.save!
 #    end

	# 	#Mark chore as unassigned
	# 	self.user = nil
	# 	self.save

 #    # Mark chore's current_due_date as nil
 #    self.current_due_date = nil

	# 	# Create a new chore history after user completed chore
 #    @chore_history = ChoreHistory.new(chore_hist_params)
 #    # @chore_history.comments = comments
 #    @chore_history.chore = self
 #    @chore_history.name = self.name
 #    @chore_history.points_value = self.points_value
 #    @chore_history.user = @user
 #    @chore_history.apartment = @user.apartment
 #    @chore_history.approval_points = 0
 #    @chore_history.approval_ratio = 0
 #    @chore_history.approved = true
 #    @chore_history.save
 #    @chore_history.js_date = @chore_history.created_at.to_i
 #    @chore_history.save!
 #  end

  def overdue_chore?
<<<<<<< HEAD
      if self.current_due_date == Date.today
         @user = self.user
         @user.dollar_balance -= self.points_value
         @user.save!
         self.user = nil
         self.save!
      end
  end

  def chore_status_bar()
      @chore = self.chore
      @today = Date.today
      @due_on = @chore.current_due_date
      @assigned_on = @chore.current_assigned_date
      @chore_length = @due_on - @assigned_on
      @remaining_time = (@due_on - @today).to_i
      @remaining_percentage = number_to_percentage(@remaining_time.to_f / @chore_length)
      return @remaining_percentage
  end

  def calculate_percentage
    today = Date.today
    due_on = self.current_due_date
    assigned_on = self.current_assigned_date
    chore_length = (due_on - assigned_on).to_i
    remaining_time = (due_on - today).to_i
    time_passed = (assigned_on - today).to_i.abs
    return (((time_passed + 0.0) / chore_length)*100)
=======
    if self.current_due_date == Date.yesterday
      @user = self.user
      @user.dollar_balance -= self.points_value
      @user.save!
      self.user = nil
      self.dollar_value += self.points_value
      self.save!
    end
  end

  def assign_chore(user)
    self.user = user
    self.current_due_date = Chronic.parse(self.due_date)
    self.save!

    user.total_week_points += self.points_value
    user.save!
>>>>>>> 6603d9767d3577c06d2dbb676e3e84e22b9d01f6
  end

end

