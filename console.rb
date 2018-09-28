require_relative('./models/customer.rb')
require_relative('./models/ticket.rb')
require_relative('./models/film.rb')

require('pry')


Ticket.delete_all()
Film.delete_all()
Customer.delete_all()


customer1 = Customer.new({ 'name' => "Iain", 'funds' => 70})
customer2 = Customer.new({ 'name' => "Alex", 'funds' => 60})
customer3 = Customer.new({ 'name' => "Sean", 'funds' => 200})
customer4 = Customer.new({ 'name' => "Michael", 'funds' => 40})


customer1.save
customer2.save
customer3.save
customer4.save

film1 = Film.new({ 'title' => "The Blues Brothers", 'price' => 16})
film2 = Film.new({ 'title' => "The A Team", 'price' => 11})


film1.save
film2.save


ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id})
ticket2 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film2.id})
ticket3 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film1.id})
ticket4 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id})
ticket5 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film1.id})
ticket6 = Ticket.new({ 'customer_id' => customer4.id, 'film_id' => film2.id})
ticket7 = Ticket.new({ 'customer_id' => customer4.id, 'film_id' => film2.id})

ticket1.save
ticket2.save
ticket3.save
ticket4.save
ticket5.save
ticket6.save
ticket7.save

# Film.all
# Ticket.all
# Customer.all

# customer1.name = "Voldemort"
# film1.title = "Mr Beans Holiday"
# customer1.update
# film1.update

# customer1.films
# film2.customers

customer1.films_count
film2.customer_count


binding.pry
nil
