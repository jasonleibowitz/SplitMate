require_relative '../spec_helper.rb'

describe User do
  before :each do
    @vern = User.new(first_name: "Verner", last_name: "Dsouza", email: 'verner@splitmate.com', password: '12345', password_confirmation: '12345' )
    @jason = User.new(first_name: "Jason", last_name: "Leibowitz", email: 'jason@splitmate.com', password: '12345', password_confirmation: '12345' )
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

end
