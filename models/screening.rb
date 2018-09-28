require_relative('../db/sql_runner.rb')

class Screening

  attr_reader :id
  attr_accessor :film_id, :show_time, :tickets_available

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id']
    @show_time = options['show_time'].to_i
    @tickets_available = options['tickets_available'].to_i
  end

  def self.delete_all
    sql = "
    DELETE FROM screenings;
    "
    SqlRunner.run(sql)
  end

  def save

    sql = "
    INSERT INTO screenings (film_id, show_time, tickets_available)
    VALUES ($1, $2, $3)
    RETURNING id;
    "
    values = [@film_id, @show_time, @tickets_available]
    screening = SqlRunner.run(sql, values)[0]
    @id = screening['id'].to_i

  end


end
