require_relative '../spec_helper.rb'

describe User do
  before :each do
    @vern = User.new(first_name: "Verner", last_name: "Dsouza", email: 'verner@splitmate.com', password: '12345', password_confirmation: '12345' )
  end

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :password_confirmation }

  it { should have_many :chores }
  it { should have_many :chore_histories }
  it { should belong_to :apartment }
  it { should have_many :approvals }


  describe "#update points" do
    it "should be able to update points" do
      @vern = User.create(first_name: "Verner", last_name: "Dsouza", email: 'verner@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0)
      expect(@vern.points_balance).to eq(0)
      expect(@vern.points_lifetime).to eq(0)

      @vern.update_points(10)
      expect(@vern.points_balance).to eq(10)
      expect(@vern.points_lifetime).to eq(10)
      expect(@vern.completed_week_points).to eq(10)
    end
  end


  describe "#default avatar" do
    it "should set a default avatar when picture not uploaded" do
      @vern = User.create(first_name: "Verner", last_name: "Dsouza", email: 'verner@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0)

      @vern.default_avatar

      expect(@vern.default_avatar).to eq("default_images/V.png")

    end
  end

  describe "#make_payment" do
    it "should exchange money between roommates" do
      @vern = User.create(first_name: "Verner", last_name: "Dsouza", email: 'verner@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, dollar_balance: 10)
      @eric = User.create(first_name: "Eric", last_name: "Resnick", email: 'eric@splitmate.com', password: '56789', password_confirmation: '56789', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, dollar_balance: 10)

      @vern.make_payment(@eric, 5)

      expect(@vern.dollar_balance).to eq(15)
    end
  end

  describe "#vacation_mode" do
    it "should not allow chores to be assigned to users on vacation mode" do
      @vern = User.create(first_name: "Verner", last_name: "Dsouza", email: 'verner@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, dollar_balance: 10, vacation: false)

      @vern.vacation_mode(true)

      expect(@vern.vacation).to eq(true)
    end
  end

end

