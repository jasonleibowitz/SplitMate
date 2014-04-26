class Apartment < ActiveRecord::Base

  has_many :users
  has_many :chores

  validates :name, :street, :apt, :zipcode, presence: true
  validates :zipcode, numericality: { only_integer: true }
  validates :zipcode, length: { is: 5 }

end
