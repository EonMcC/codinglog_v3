require_relative('../db/sql_runner')

class Timer
  attr_accessor(:id, :started, :start_time, :stop_time)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @started = options['started']
    @start_time = options['start_time'].to_f
    @stop_time = options['stop_time'].to_f
    @elapsed_time = options['elapsed_time'].to_f
  end

  def self.start_timer()
    start_time = Time.now().to_f
    sql = "UPDATE timer SET start_time = $1 WHERE id = $2;"
    values = [start_time, 1]
    SqlRunner.run(sql, values)
    Timer.update_started(1, true)
  end

  def self.stop_timer()
    stop_time = Time.now().to_f
    sql = "UPDATE timer SET stop_time = $1 WHERE id = $2;"
    values = [stop_time, 1]
    SqlRunner.run(sql, values)
    Timer.update(1, false)
  end

  def self.elapsed_time()
    # UPDATE test
    # SET duration = time_finished - time_started
    sql = "UPDATE timer SET elapsed_time = stop_time - start_time WHERE id = $1 RETURNING elapsed_time;"
    values = [1]
    result = SqlRunner.run(sql, values)
    return result.first()['elapsed_time'].to_f
  end

  def save()
    sql = "INSERT INTO timer (started) VALUES ($1) RETURNING id;"
    values = [@started]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.update(id, time)
    sql = "UPDATE timer SET started = $1 WHERE id = $2;"
    values = [time, id]
    SqlRunner.run(sql, values)
  end

  def self.update_started(id, started)
    sql = "UPDATE timer SET started = $1 WHERE id = $2;"
    values = [started, id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM timer;"
    SqlRunner.run(sql)
  end

  def self.map_items(timer_data)
    return timer_data.map { |timer| Timer.new(timer)}
  end


  def self.all()
    sql = "SELECT * FROM timer;"
    timer_data = SqlRunner.run(sql)
    timer = map_items(timer_data)
    return timer
  end

end
