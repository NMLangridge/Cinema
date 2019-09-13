require_relative("../db/sql_runner.rb")

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers (name, funds)
    VALUES ($1, $2)
    RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers (name, funds)
    VALUES ($1, $2)
    RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customer = SqlRunner.run(sql)
    return Customer.map_items(customer)
  end

  def self.map_items(customer)
    result = customer.map{ |customer| Customer.new(customer) }
    return result
  end

  def tickets()
    sql = "SELECT * FROM tickets WHERE customer_id = $1"
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    return tickets.map{ |ticket| Ticket.new(ticket) }
  end

  def count_tickets()
    return customer.tickets.count
  end

  def films()
    sql = "SELECT films.*
    FROM films
    INNER JOIN tickets
    ON films.id = tickets.film_id
    WHERE customer_id = $1"
    values = [@id]
    film = SqlRunner.run(sql, values)
    return Film.map_items(film)
  end

end
