require_relative '../spec_helper.rb'
describe ChoreHistory do

	# def calculate_score
	# need to write method to test its ability to calculate its own score

it { should belong_to :user }
it { should belong_to :chore }
it { should have_many :approvals }


describe "poorly done chores don't count" do
	it "should make sure a poorly done chore does not count towards the users' points" do
	@ga = Apartment.create(name: "GA Speakeasy", street: '10 E 21st Street', apt: '4', zipcode: 10010)
	@vern = User.create(first_name: "Verner", last_name: "Dsouza", email: 'verner@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 40, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, apartment: @ga, dollar_balance: 0)
    @jason = User.create(first_name: "Jason", last_name: "Leibowitz", email: 'jason@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, apartment: @ga, dollar_balance: 0 )
    @stephen = User.create(first_name: "Stephen", last_name: "Marsh", email: 'stephen@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, apartment: @ga, dollar_balance: 0 )
    @eric = User.create(first_name: "Eric", last_name: "Resnick", email: 'eric@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, apartment: @ga, dollar_balance: 0 )
    @bob = User.create(first_name: "Eric", last_name: "Resnick", email: 'bob@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, apartment: @ga, dollar_balance: 0 )
    # @ga = Apartment.create(name: "GA Speakeasy", street: '10 E 21st Street', apt: '4', zipcode: 10010)

    @chore = Chore.create(name: "Clean the toilet", points_value: 10, user: @vern, apartment: @ga, due_date: "Sunday", dollar_value: 0)

    @chore.complete_chore("test")

    completed_chore = ChoreHistory.create(name: "Clean the toilet", points_value: 10, comments: "test", user: @vern, chore_id: 5, approval_points: 0, approval_ratio: 0, approved: true, apartment: @ga)

		@vern.reload
        @ga.reload

        expect(@ga.name).to eq("GA Speakeasy")
		expect(completed_chore.name).to eq("Clean the toilet")
		expect(completed_chore.points_value).to eq(10)
		expect(completed_chore.user).to eq(@vern)
		expect(@vern.points_balance).to eq(50)


    @approval_1 = Approval.create(user_id: @jason.id, chore_history_id: completed_chore.id, value: -1)
    @approval_2 = Approval.create(user_id: @stephen.id, chore_history_id: completed_chore.id, value: -1)
    @approval_3 = Approval.create(user_id: @eric.id, chore_history_id: completed_chore.id, value: -1)
    @approval_4 = Approval.create(user_id: @bob.id, chore_history_id: completed_chore.id, value: 1)

    @vern.reload
    completed_chore.reload
    @vern.reload


    expect(completed_chore.approval_points).to eq(-2)
    expect(completed_chore.apartment.users.length).to eq(5)
    expect(@vern.points_balance).to eq(40)


		end
	end



end
