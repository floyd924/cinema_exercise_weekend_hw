require_relative('../db/sql_runner.rb')
require_relative('./ticket.rb')

class Customer

  attr_reader :id
  attr_accessor :name, :funds


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def self.all()
    sql = "
    SELECT * FROM customers;"
    hashes = SqlRunner.run(sql)
    objects = hashes.map { |e| Customer.new(e)  }
    return objects
  end


  def self.delete_all
    sql = "
    DELETE from customers;"
    SqlRunner.run(sql)
  end

  def save()
    sql = "
    INSERT INTO customers (name, funds)
    VALUES ($1, $2)
    RETURNING id;
    "
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values)[0]
    @id = customer['id'].to_i
  end

  def delete()
    sql = "
    DELETE FROM customers
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "
    UPDATE customers
    SET (name, funds) = ($1, $2)
    WHERE id = $3;
    "
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "
    SELECT films.*
    FROM films
    INNER JOIN tickets
    ON films.id = tickets.film_id
    WHERE tickets.customer_id = $1;
    "
    values = [@id]
    result = SqlRunner.run(sql, values)
    each = result.map { |e| Film.new(e)  }
    return each

  end

#####this isn't really necessary
  # def film_count()
  #   sql = "
  #   SELECT films.*
  #   FROM films
  #   INNER JOIN tickets
  #   ON films.id = tickets.film_id
  #   WHERE tickets.customer_id = $1;"
  #   values = [@id]
  #   films_hash = SqlRunner.run(sql, values)
  #   films_array = films_hash.map { |e| Film.new(e)  }
  #   number_of_films = films_array.count
  #   return number_of_films
  # end

  def ticket_count()
    sql = "
    SELECT tickets.*
    FROM tickets
    WHERE tickets.customer_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    objects = results.map { |e| Ticket.new(e)  }
    ticket_count = objects.count
    return ticket_count

  end


  def buy_ticket(film, screening)
    ##do i need to specify which film? since the screening has a film id anyway....

    ticket1 = Ticket.new({ 'customer_id' => @id, 'film_id' => film.id, 'screening_id' => screening.id})
    ticket1.save
    cost = (film.price)
    @funds -= cost
    update()
    screening.tickets_available -= 1
    screening.update
  end



end
