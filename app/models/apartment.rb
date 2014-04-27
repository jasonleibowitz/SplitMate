class Apartment < ActiveRecord::Base

  has_many :users
  has_many :chores
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates :name, :street, :apt, :zipcode, presence: true
  validates :zipcode, numericality: { only_integer: true }
  validates :zipcode, length: { is: 5 }

end
