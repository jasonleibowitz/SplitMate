require_relative '../spec_helper.rb'

describe Approval do

  it { should belong_to :user }
  it { should belong_to :chore_history }


  # need to install callback shoulda matchers before this will pass
	it { should callback(:calculate_score).after(:save) }


	# def calculate_score
 #  	self.chore_history.calculate_score
 #  end	


end