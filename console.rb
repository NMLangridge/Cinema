require('pry')

require_relative('models/ticket.rb')
require_relative('models/customer.rb')
require_relative('models/film.rb')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

  customer1 = Customer.new({
    'name' => 'Nathan',
    'funds' => 25
    })

  customer2 = Customer.new({
    'name' => 'Faye',
    'funds' => 20
    })

  customer1.save
  customer2.save

  film1 = Film.new({
    'title' => 'Toy Story',
    'price' => 5
    })

  film2 = Film.new({
    'title' => 'Trainspotting',
    'price' => 10
    })

  film1.save
  film2.save

  ticket1 = Ticket.new({
    'customer_id' => customer1.id,
    'film_id' => film2.id
    })

  ticket2 = Ticket.new({
    'customer_id' => customer2.id,
    'film_id' => film1.id
    })

  ticket3 = Ticket.new({
    'customer_id' => customer1.id,
    'film_id' => film1.id
      })

  ticket1.save
  ticket2.save
  ticket3.save

binding.pry
nil
