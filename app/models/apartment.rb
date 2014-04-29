class Apartment < ActiveRecord::Base

  has_many :users
  has_many :chores
  has_many :chore_histories
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates :name, :street, :apt, :zipcode, presence: true
  validates :zipcode, numericality: { only_integer: true }
  validates :zipcode, length: { is: 5 }

  def add_default_chores
    @toilet = Chore.new(name: "Clean the toilet", points_value: 10, due_date: "Sunday", apartment: self)
    @toilet.save!
    @living_room = Chore.new(name: "Clean the living room", points_value: 10, due_date: "Sunday", apartment: self)
    @living_room.save!
    @kitchen = Chore.new(name: "Clean the kitchen", points_value: 10, due_date: "Sunday", apartment: self)
    @kitchen.save
    @trash = Chore.new(name: "Take the trash out", points_value: 4, due_date: "Sunday", apartment: self)
    @trash.save
  end

end

