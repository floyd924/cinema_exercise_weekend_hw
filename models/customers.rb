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

end
