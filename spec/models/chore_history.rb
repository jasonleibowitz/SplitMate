require_relative '../spec_helper.rb'

describe ChoreHistory do

	# def calculate_score
	# need to write method to test its ability to calculate its own score

it { should belong_to :user }	
it { should belong_to :chore }	
it { should have_many :approvals }

describe "poorly done chores don't count" do
	it "should make sure a poorly done chore does not count towards the users' points" do
		@vern = User.create(first_name: "Verner", last_name: "Dsouza", email: 'verner@splitmate.com', password: '12345', password_confirmation: '12345' )
    @jason = User.create(first_name: "Jason", last_name: "Leibowitz", email: 'jason@splitmate.com', password: '12345', password_confirmation: '12345' )
    @stephen = User.create(first_name: "Stephen", last_name: "Marsh", email: 'stephen@splitmate.com', password: '12345', password_confirmation: '12345' )
    @eric = User.create(first_name: "Eric", last_name: "Resnick", email: 'eric@splitmate.com', password: '12345', password_confirmation: '12345' )
     @bob = User.create(first_name: "Eric", last_name: "Resnick", email: 'bob@splitmate.com', password: '12345', password_confirmation: '12345' )
    @ga = Apartment.create(name: "GA Speakeasy", street: '10 E 21st Street', apt: '4', zipcode: 10010)
    @windex_peephole = ChoreHistory.create(name: "windex the peephole", points_value: 25, created_at: Time.now, updated_at: Time.now, user_id: @vern.id, apartment_id: @ga.id, approval_points: 0, approval_ratio: 0 )

    
		end
	end

end