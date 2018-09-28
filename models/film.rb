require_relative('../db/sql_runner.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def self.all()
    sql = "
    SELECT * FROM films;"
    result_hashes = SqlRunner.run(sql)
    array_of_objects = result_hashes.map do |flm| Film.new(flm)
    end
    return array_of_objects
  end



  def self.delete_all
    sql = "
    DELETE FROM films;
    "
    SqlRunner.run(sql)
  end

  def save()
    sql = "
    INSERT INTO films (title, price)
    VALUES ($1, $2)
    RETURNING id;
    "
    values = [@title, @price]
    result = SqlRunner.run(sql, values)[0]
    @id = result['id'].to_i
  end


  def delete()
    sql = "
    DELETE FROM films
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE films
    SET (title, price) = ($1, $2)
    WHERE id = $3;
    "
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "
    SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE tickets.film_id = $1;
    "
    values = [@id]
    results = SqlRunner.run(sql, values)
    objects = results.map { |e| Customer.new(e)  }
    return objects
  end

  def customer_count()
    sql = "
    SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id
    WHERE tickets.film_id = $1;
    "
    values = [@id]
    results = SqlRunner.run(sql, values)
    objects = results.map { |e| Customer.new(e) }
    object_count = objects.count
    return object_count
  end


end
