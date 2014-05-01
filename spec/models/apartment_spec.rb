require_relative '../spec_helper.rb'

describe Apartment do
  before :each do
    Apartment.any_instance.stub(:zipcode_validation) { nil }
    @ga = Apartment.new(name: "GA Speakeasy", street: '10 E 21st Street', apt: '4', zipcode: 10010)
    @clinton = Apartment.new(name: "Jason's Sweet Pad", street: '40 Clinton Street', apt: '11B', zipcode: 11201)

    @ga.add_default_chores
    @clinton.add_default_chores
  end

  it { should validate_presence_of :name }
  it { should validate_presence_of :street }
  it { should validate_presence_of :zipcode }
 
  it { have_many :users }
  it { have_many :chores }
  it { have_many :chore_history }
  it { have_attached_file :avatar }



describe "#zipcode validation" do
  it "should throw an error if zipcode is not valid" do
    @ga = Apartment.create(name: "GA Speakeasy", street: '10 E 21st Street', apt: '4', zipcode: 13432)

    @ga.zipcode_validation

    expect(@ga.zipcode_validation).to eq("That is not a valid zipcode.")

  end
end
end
