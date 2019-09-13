require_relative("../db/sql_runner.rb")

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films (title, price)
    VALUES ($1, $2)
    RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def update()
    sql = "UPDATE films (title, price)
    VALUES ($1, $2)
    RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM films"
    film = SqlRunner.run(sql)
    return Film.map_items(film)
  end

  def self.map_items(film)
    result = film.map{ |film| Film.new(film) }
    return result
  end

  def tickets()
    sql = "SELECT * FROM tickets WHERE film_id = $1"
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    return tickets.map{ |ticket| Ticket.new(ticket) }
  end

  def count_customers()
    return film.tickets.count
  end

  def customers()
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id
    WHERE film_id = $1"
    values = [@id]
    customer = SqlRunner.run(sql, values)
    return Customer.map_items(customer)
  end

end
