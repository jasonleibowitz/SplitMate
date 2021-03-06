require_relative '../spec_helper.rb'

describe Approval do

  it { should belong_to :user }
  it { should belong_to :chore_history }
  # need to install callback shoulda matchers before this will pass
	it { should callback(:calculate_score).after(:save) }
  it { should callback(:check_ratio).after(:save) }


	 before :each do
    @vern = User.create(first_name: "Verner", last_name: "Dsouza", email: 'verner@splitmate.com', password: '12345', password_confirmation: '12345' )
    @jason = User.create(first_name: "Jason", last_name: "Leibowitz", email: 'jason@splitmate.com', password: '12345', password_confirmation: '12345' )
    @stephen = User.create(first_name: "Stephen", last_name: "Marsh", email: 'stephen@splitmate.com', password: '12345', password_confirmation: '12345' )
    @eric = User.create(first_name: "Eric", last_name: "Resnick", email: 'eric@splitmate.com', password: '12345', password_confirmation: '12345' )
     @bob = User.create(first_name: "Eric", last_name: "Resnick", email: 'bob@splitmate.com', password: '12345', password_confirmation: '12345' )
    @ga = Apartment.create(name: "GA Speakeasy", street: '10 E 21st Street', apt: '4', zipcode: 10010)
    @windex_peephole = ChoreHistory.create(name: "windex the peephole", points_value: 25, created_at: Time.now, updated_at: Time.now, user_id: @vern.id, apartment_id: @ga.id, approval_points: 0, approval_ratio: 0 )
  end


	describe "#calculate_score" do
		it "accurately calculates the score of a chore history with approvals" do
      expect(@windex_peephole.approval_points).to eq(0)

      @approval_1 = Approval.create(user_id: @jason.id, chore_history_id: @windex_peephole.id, value: -1)

      @windex_peephole.reload
      expect(@windex_peephole.approval_points).to eq(-1)
      # expect(@approval_1.chore_history).to eq(@windex_peephole)
    end
    it "correctly calculates a negative approvals ratio" do
      @approval_1 = Approval.create(user_id: @jason.id, chore_history_id: @windex_peephole.id, value: -1)
      @approval_2 = Approval.create(user_id: @stephen.id, chore_history_id: @windex_peephole.id, value: -1)
      @approval_3 = Approval.create(user_id: @eric.id, chore_history_id: @windex_peephole.id, value: -1)
      @approval_4 = Approval.create(user_id: @bob.id, chore_history_id: @windex_peephole.id, value: 1)

      @windex_peephole.reload
      expect(@windex_peephole.approval_points).to eq(-2)
      expect(@windex_peephole.approvals.length).to eq(4)
      expect(@windex_peephole.approval_ratio).to eq(-50)
    end
    it "correctly calculates a positive approvals ratio" do
      @approval_1 = Approval.create(user_id: @jason.id, chore_history_id: @windex_peephole.id, value: 1)
      @approval_2 = Approval.create(user_id: @stephen.id, chore_history_id: @windex_peephole.id, value: 1)
      @approval_3 = Approval.create(user_id: @eric.id, chore_history_id: @windex_peephole.id, value: 1)
      @approval_4 = Approval.create(user_id: @bob.id, chore_history_id: @windex_peephole.id, value: -1)

      @windex_peephole.reload
      expect(@windex_peephole.approval_points).to eq(2)
      expect(@windex_peephole.approvals.length).to eq(4)
      expect(@windex_peephole.approval_ratio).to eq(50)
    end
  end



end
