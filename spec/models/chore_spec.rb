require_relative '../spec_helper.rb'
require 'chronic'

describe Chore do

	it { should validate_presence_of :name }
	it { should validate_presence_of :points_value }
	it { should validate_presence_of :due_date }
	it { should validate_numericality_of(:points_value).only_integer }
	it { should validate_numericality_of(:points_value).is_less_than_or_equal_to(20) }
	it { should validate_numericality_of(:points_value).is_greater_than_or_equal_to(1) }

	describe "#complete_chore" do
	it "completing a chore gives the user that completed it the points that the chore had. If the chore had a dollar value, the user gets that money and the chore's dollar value reverts to 0. The chore then is unlinked from a user and its current_due_date is set to nil" do
		@vern = User.create(first_name: "Verner", last_name: "Dsouza", email: 'verner@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, dollar_balance: 0)
		@ga = Apartment.create(name: "GA Speakeasy", street: '10 E 21st Street', apt: '4', zipcode: 10010)
		@chore = Chore.new(name: "Clean the toilet", points_value: 2, user_id: @vern.id, apartment_id: @ga.id, due_date: Date.today, dollar_value: 2)
		expect(@vern.points_balance).to eq(0)
		expect(@vern.dollar_balance).to eq(0)

		@chore.complete_chore("test")

		@vern.reload
		@chore.reload

		expect(@chore.user_id).to eq(nil)
		expect(@vern.points_balance).to eq(2)
		expect(@vern.dollar_balance).to eq(2)
		expect(@chore.current_due_date).to eq(nil)
		end
	end

	describe "#calculate_percentage" do
	it "calculates the percentage of time passed from the time assigned until the time due" do
		@vern = User.create(first_name: "Verner", last_name: "Dsouza", email: 'verner@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, dollar_balance: 0)
		@ga = Apartment.create(name: "GA Speakeasy", street: '10 E 21st Street', apt: '4', zipcode: 10010, chore_assignment_day: "Sunday")
		@chore = Chore.new(name: "Clean the toilet", points_value: 2, user_id: @vern.id, apartment_id: @ga.id, due_date: Date.today, dollar_value: 0, current_assigned_date: '2014-04-28', current_due_date: '2014-05-05' )

		@chore.calculate_percentage

	end
	end

	describe "#overdue_chore?" do
	it "removes money from the users account if the chore due date equals yesterday" do
		@vern = User.create(first_name: "Verner", last_name: "Dsouza", email: 'verner@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 10, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, dollar_balance: 4, vacation: false)
		@ga = Apartment.create(name: "GA Speakeasy", street: '10 E 21st Street', apt: '4', zipcode: 10010)
		@chore = Chore.new(name: "Clean the toilet", points_value: 2, user: @vern, apartment: @ga, current_due_date: Chronic.parse("yesterday"), due_date: "Wednesday", dollar_value: 2)
		expect(@vern.points_balance).to eq(10)
		expect(@vern.dollar_balance).to eq(4)

		@chore.overdue_chore?

		expect(@vern.dollar_balance).to eq(2)
		end

		it "won't remove money from a user that is on vacation" do
		@vern = User.create(first_name: "Verner", last_name: "Dsouza", email: 'verner@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 10, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, dollar_balance: 4, vacation: true)

		@ga = Apartment.create(name: "GA Speakeasy", street: '10 E 21st Street', apt: '4', zipcode: 10010)

		@chore = Chore.new(name: "Clean the toilet", points_value: 2, user_id: @vern.id, apartment_id: @ga.id, due_date: Chronic.parse("yesterday"), dollar_value: 2)

		@chore.overdue_chore?

		expect(@vern.dollar_balance).to eq(4)
		end
	end


	describe "#assign_chore" do
	it "assign chores to users when they choose them" do
		@vern = User.create(first_name: "Verner", last_name: "Dsouza", email: 'verner@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, dollar_balance: 4)
		@ga = Apartment.create(name: "GA Speakeasy", street: '10 E 21st Street', apt: '4', zipcode: 10010)
		@chore = Chore.new(name: "Clean the toilet", points_value: 2, apartment_id: @ga.id, due_date: "Sunday")

		@chore.assign_chore(@vern)

		expect(@chore.user_id).to eq(@vern.id)

		end
	end

end
