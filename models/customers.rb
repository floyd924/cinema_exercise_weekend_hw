require_relative('../db/sql_runner.rb')

class Customer


  def intialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
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
    customer = SqlRunner.run(sql, values)
    @id = customer['id'].to_i 
  end

end
