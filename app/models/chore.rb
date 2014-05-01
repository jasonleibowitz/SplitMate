class Chore < ActiveRecord::Base

  belongs_to :apartment
  belongs_to :user
  has_many :chore_histories

  validates :name, :points_value, :due_date, presence: true
  validates :points_value, numericality: { only_integer: true, less_than_or_equal_to: 20, greater_than_or_equal_to: 1 }

	def complete_chore(comments)
    @user = self.user

    # Give user points for completing chore
    @user.update_points(self.points_value)
    @user.save!

    # If chore had money value, give user that amount and remove it from the chore object
    if self.dollar_value > 0
      @user.dollar_balance += self.dollar_value
      @user.save!
      self.dollar_value = 0
      self.save!
    end

    # Mark chore as unassigned
    self.user = nil
    self.save!

    # Mark chore's current_due_date as nil
    self.current_due_date = nil
    self.save!
  end

  def overdue_chore?
    if (self.current_due_date == Date.yesterday)
      @user = self.user
      @user.dollar_balance -= self.points_value
      @user.save!
      self.user = nil
      self.dollar_value += self.points_value
      self.save!
    end
  end


  def calculate_percentage
    today = Date.today
    due_on = self.current_due_date
    assigned_on = Chronic.parse("last #{self.apartment.chore_assignment_day}").to_date
    # assigned_on = self.current_assigned_date

    chore_length = (due_on - assigned_on).to_i
    remaining_time = (due_on - today).to_i
    time_passed = (assigned_on - today).to_i.abs
    return (((time_passed + 0.0) / chore_length)*100)
  end

  def assign_chore(user)
    self.user = user
    self.current_due_date = Chronic.parse(self.due_date)
    self.current_assigned_date = Date.today
    self.save!

    user.total_week_points += self.points_value
    user.save!
  end

  def assign_drop_chore(user, buyer)
    if user == buyer
      self.user = user
      self.current_due_date = Chronic.parse(self.due_date)
      self.current_assigned_date = Date.today
      self.save!

      user.total_week_points += self.points_value
      user.save!
    elsif user != buyer
      if buyer.points_balance > (self.points_value * 10)
        buyer.points_balance -= (self.points_value * 10)
        buyer.save!

        self.user = user
        self.current_due_date = Chronic.parse(self.due_date)
        self.current_assigned_date = Date.today
        self.save!

        user.total_week_points += self.points_value
        user.save!
      else
        return false
      end
    end
  end

end

