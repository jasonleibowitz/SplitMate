require_relative '../spec_helper.rb'

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
		@chore = Chore.new(name: "Clean the toilet", points_value: 10, user_id: @vern.id, apartment_id: @ga.id, due_date: Date.today, dollar_value: 0)
		expect(@vern.points_balance).to eq(0)

		@chore.complete_chore("test")

		@vern.reload
		@chore.reload

		expect(@chore.user_id).to eq(nil)
		expect(@vern.points_balance).to eq(10)
		expect(@chore.current_due_date).to eq(nil)
		end
	end


end
