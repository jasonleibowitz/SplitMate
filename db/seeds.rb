# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


@ga = Apartment.create(name: "GA Speakeasy", street: '10 E 21st Street', apt: '4', zipcode: 10010)

@vern = User.create(first_name: "Verner", last_name: "Dsouza", email: 'verner@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, dollar_balance: 20, apartment_id: @ga.id)
@jason = User.create(first_name: "Jason", last_name: "Leibowitz", email: 'jason@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, dollar_balance: 40, apartment_id: @ga.id )
@stephen = User.create(first_name: "Stephen", last_name: "Marsh", email: 'stephen@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, dollar_balance: 50, apartment_id: @ga.id )
@eric = User.create(first_name: "Eric", last_name: "Resnick", email: 'eric@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, dollar_balance: 60, apartment_id: @ga.id )
@bob = User.create(first_name: "Eric", last_name: "Resnick", email: 'bob@splitmate.com', password: '12345', password_confirmation: '12345', points_balance: 0, points_lifetime: 0, completed_week_points: 0, total_week_points: 0, dollar_balance: 35, apartment_id: @ga.id )
@ga = Apartment.create(name: "GA Speakeasy", street: '10 E 21st Street', apt: '4', zipcode: 10010)
