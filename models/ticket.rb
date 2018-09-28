require_relative('../db/sql_runner.rb')
require_relative('./customer.rb')
require('pry')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id, :screening_id


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @screening_id = options['screening_id']
  end

  def self.delete_all()
    sql = "
    DELETE FROM tickets;
    "
    values = []
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "
    SELECT * FROM tickets;
    "
    hashes = SqlRunner.run(sql)
    objects = hashes.map { |e| Ticket.new(e) }
    return objects
  end

######################
  # def film_price
  #   sql = "SELECT films.*
  #   FROM films
  #   INNER JOIN tickets
  #   ON films.id = tickets.film_id
  #   WHERE tickets.film_id = $1;
  #   "
  #   values = [@film_id]
  #   results = SqlRunner.run(sql, values)
  #   objects = results.map { |e| Film.new(e) }
  #   fee = objects['fee'].to_i
  #   return fee
  # end
##############################

 ## I tried so haaaard, and got so faaaar, but in the eeeeend, it doesn't even maaaterrr



  def save()
    sql = "
    INSERT INTO tickets (customer_id, film_id, screening_id)
    VALUES ($1, $2, $3)
    RETURNING id;
    "
    values = [@customer_id, @film_id, @screening_id]
    ticket = SqlRunner.run(sql, values)[0]
    @id = ticket['id'].to_i

    # film_fee
    #
    # reduce_customer_funds(film_fee)

  end



  def delete()
    sql = "
    DELETE FROM tickets
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

end
