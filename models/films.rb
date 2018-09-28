require_relative('../db/sql_runner.rb')

class Film


  def intialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
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
    @id = film['id'].to_i
  end

  def delete()
    sql = "
    DELETE FROM films
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

end
