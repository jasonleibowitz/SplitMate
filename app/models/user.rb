class User < ActiveRecord::Base

  belongs_to :apartment
  has_many :chores
  has_many :chore_histories
  has_many :approvals, dependent: :destroy

  has_secure_password
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "images/:style/missing.png"

  validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true, :on => :create
  validates :password, length: { minimum: 5 }, :on => :create
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  def update_points(points_value)
    self.points_balance += points_value
    self.points_lifetime += points_value
    self.completed_week_points += points_value
    self.total_week_points += points_value
  end

end
