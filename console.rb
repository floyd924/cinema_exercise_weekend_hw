require_relative('./models/customers.rb')
require_relative('./models/tickets.rb')
require_relative('./films.rb')

require('pry')


Ticket.delte_all()
Film.delete_all()
Customer.delete_all()


customer1 = Customer.new({ 'name' => , 'funds' => })
customer2 = Customer.new({ 'name' => , 'funds' => })
customer3 = Customer.new({ 'name' => , 'funds' => })
customer4 = Customer.new({ 'name' => , 'funds' => })


customer1.save
customer2.save
customer3.save
customer4.save

film1 = Film.new({ 'title' => , 'price' => })
