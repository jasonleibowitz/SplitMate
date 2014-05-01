require_relative '../spec_helper.rb'

describe Apartment do
  before :each do
    @ga = Apartment.new(name: "GA Speakeasy", street: '10 E 21st Street', apt: '4', zipcode: 10010)
    @clinton = Apartment.new(name: "Jason's Sweet Pad", street: '40 Clinton Street', apt: '11B', zipcode: 11201)
  end

  it { should validate_presence_of :name }
  it { should validate_presence_of :street }
  it { should validate_presence_of :zipcode }
  it { should validate_numericality_of :zipcode }
  it { should ensure_length_of(:zipcode).is_equal_to(5) }
  it { have_many :users }
  it { have_many :chores }

end
