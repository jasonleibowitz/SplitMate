require_relative '../spec_helper.rb'

describe ChoreHistory do

	# def calculate_score
	# need to write method to test its ability to calculate its own score

it { should belong_to :user }	
it { should belong_to :chore }	
it { should have_many :approvals }

describe "completing a chore creates a new chore history object" do
	it "should get created" do
		@vern = User.create(first_name: "Verner", last_name: "Dsouza", email: 'verner@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0)
		@ga = Apartment.create(name: "GA Speakeasy", street: '10 E 21st Street', apt: '4', zipcode: 10010)
		@chore = Chore.new(name: "Clean the toilet", points_value: 25, user_id: @vern.id, apartment_id: @ga.id, due_date: Date.today)
		expect(@vern.points_balance).to eq(0)

		@chore.complete_chore("test")
		chore_history = ChoreHistory.find_by(chore_id: @chore.id)

		@vern.reload
		
		expect(chore_history.name).to eq("Clean the toilet")
		expect(chore_history.points_value).to eq(25)
		expect(chore_history.user).to eq(@vern)
		expect(@chore.user_id).to eq(nil)
		expect(@vern.points_balance).to eq(25)
		end
	end

describe "poorly done chores don't count" do
	it "should make sure a poorly done chore does not count towards the users' points" do
		@ga = Apartment.create(name: "GA Speakeasy", street: '10 E 21st Street', apt: '4', zipcode: 10010)
		@vern = User.create(first_name: "Verner", last_name: "Dsouza", email: 'verner@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, apartment_id: @ga.id)
    @jason = User.create(first_name: "Jason", last_name: "Leibowitz", email: 'jason@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, apartment_id: @ga.id )
    @stephen = User.create(first_name: "Stephen", last_name: "Marsh", email: 'stephen@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, apartment_id: @ga.id )
    @eric = User.create(first_name: "Eric", last_name: "Resnick", email: 'eric@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, apartment_id: @ga.id )
    @bob = User.create(first_name: "Eric", last_name: "Resnick", email: 'bob@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, apartment_id: @ga.id )
    @ga = Apartment.create(name: "GA Speakeasy", street: '10 E 21st Street', apt: '4', zipcode: 10010)
    
    @chore = Chore.create(name: "Clean the toilet", points_value: 25, user_id: @vern.id, apartment_id: @ga.id, due_date: Date.today)
    
    @chore.complete_chore("test")

		completed_chore = ChoreHistory.find_by(chore_id: @chore.id)

		@vern.reload
		
		expect(completed_chore.name).to eq("Clean the toilet")
		expect(completed_chore.points_value).to eq(25)
		expect(completed_chore.user).to eq(@vern)
		expect(@chore.user_id).to eq(nil)
		expect(@vern.points_balance).to eq(25)


    @approval_1 = Approval.create(user_id: @jason.id, chore_history_id: completed_chore.id, value: -1)
    @approval_2 = Approval.create(user_id: @stephen.id, chore_history_id: completed_chore.id, value: -1)
    @approval_3 = Approval.create(user_id: @eric.id, chore_history_id: completed_chore.id, value: -1)
    @approval_4 = Approval.create(user_id: @bob.id, chore_history_id: completed_chore.id, value: 1)

    @vern.reload
    completed_chore.reload
    @vern.reload


    expect(completed_chore.approval_points).to eq(-2)
    expect(completed_chore.apartment.users.length).to eq(5)
    expect(@vern.points_balance).to eq(0)

    
		end
	end

	

end