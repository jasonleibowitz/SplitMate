require_relative '../spec_helper.rb'

describe ChoreHistory do

	# def calculate_score
	# need to write method to test its ability to calculate its own score

it { should belong_to :user }	
it { should belong_to :chore }	
it { should have_many :approvals }


end