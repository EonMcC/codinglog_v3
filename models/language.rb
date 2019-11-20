require_relative('../db/sql_runner')
require_relative('timer.rb')

class Language

  attr_accessor( :id, :name, :log_time)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @log_time = options['log_time'].to_f
  end

  def save()
    sql = "INSERT INTO languages (name, log_time) VALUES ($1, $2) RETURNING id;"
    values = [@name, @log_time]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def save_time()
    sql = "INSERT INTO languages log_time VALUES $1;"
    values = [@log_time]
    results = SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE languages SET (name, log_time) = ($1, $2) WHERE id = $3;"
    values = [@name, @log_time, @id]
    SqlRunner.run(sql, values)
  end

  def self.get_time(id)
    sql = "SELECT log_time FROM languages WHERE id = $1;"
    values = [id]
    current_time = SqlRunner.run(sql, values)
    return current_time.first
  end

  def self.update_time(log_time, id)
    sql = "UPDATE languages SET log_time = $1 WHERE id = $2;"
    values = [log_time, id]
    SqlRunner.run(sql, values)
  end

  def self.find_language(id)
    sql = "SELECT * FROM languages WHERE id = $1;"
    values = [id]
    language = SqlRunner.run(sql, values)
    return language.first
  end

  def delete()
    sql = "DELETE FROM languages
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.map_items(language_data)
    return language_data.map { |language| Language.new(language)}
  end

  def self.all()
    sql = "SELECT * FROM languages;"
    language_data = SqlRunner.run(sql)
    languages = map_items(language_data)
    return languages
  end

  def self.delete_all()
    sql = "DELETE FROM languages;"
    SqlRunner.run(sql)
  end

end
