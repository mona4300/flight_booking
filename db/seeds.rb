# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Admin.create([{ email: 'mona.mohamed4300@gmail.com', password: 'booking123' }])

aeroplane1 = Aeroplane.find_or_create_by!(name: 'Aeroplane 1')
aeroplane1.aeroplane_classes.each(&:destroy!)

aeroplane1.aeroplane_classes.create!(
  [
    { seat_price: 6000, category: 'Category 1', rows_number: 3, seats_per_row: 2, position: 0 },
    { seat_price: 4000, category: 'Category 2', rows_number: 5, seats_per_row: 10, position: 1 },
    { seat_price: 2000, category: 'Category 3', rows_number: 9, seats_per_row: 9, position: 2 }
  ]
)

current_time = Time.now 
Flight.find_or_create_by!(name: 'Flight1', aeroplane: aeroplane1, departure_date: current_time + 2.months)
Flight.find_or_create_by!(name: 'Flight2', aeroplane: aeroplane1, departure_date: current_time + 1.months)

aeroplane2 = Aeroplane.find_or_create_by!(name: 'Aeroplane 2')
aeroplane2.aeroplane_classes.each(&:destroy!)
aeroplane2.aeroplane_classes.create!(
  [
    { seat_price: 2500, category: 'Category 1', rows_number: 3, seats_per_row: 2, position: 0 },
    { seat_price: 1000, category: 'Category 2', rows_number: 5, seats_per_row: 7, position: 1 }
  ]
)
