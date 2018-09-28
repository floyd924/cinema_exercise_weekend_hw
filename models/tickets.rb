require_relative('../db/sql_runner.rb')

class Ticket


  def intialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def self.delete_all()
    sql = "
    DELETE FROM tickets;
    "
    SqlRunner.run(sql)
  end

end
