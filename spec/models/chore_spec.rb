require_relative '../spec_helper.rb'

describe Chore do

	it { should validate_presence_of :name }
	it { should validate_presence_of :points_value }
	it { should validate_presence_of :due_date }
	it { should validate_numericality_of(:points_value).only_integer }
	it { should validate_numericality_of(:points_value).is_less_than_or_equal_to(20) }
	it { should validate_numericality_of(:points_value).is_greater_than_or_equal_to(1) }

	describe "#complete chore" do
		it "can complete a chore and give the user points" do
		@vern = User.create(first_name: "Verner", last_name: "Dsouza", email: 'verner@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0)
		@ga = Apartment.create(name: "GA Speakeasy", street: '10 E 21st Street', apt: '4', zipcode: 10010)
		@chore = Chore.new(name: "Clean the toilet", points_value: 25, user_id: @vern.id, apartment_id: @ga.id, due_date: Date.today)

		expect(@vern.points_balance).to eq(0)
		@chore.complete_chore("test comment")
		@chore.reload
		@vern.reload
		expect(@vern.points_balance).to eq(25)
		end
	end


end
