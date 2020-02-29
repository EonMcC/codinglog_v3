require( 'pg' )

class SqlRunner

  def self.run( sql, values = [] )
    begin
      db = PG.connect({ dbname: 'd67640eqidsj14', host: 'postgres://vfydmdhpqfprps:61a633ebc9be273196de854c914faf8161a4809f17bab6109c400d81daff6e6c@ec2-35-172-85-250.compute-1.amazonaws.com:5432/d67640eqidsj14', port: 5432, user: 'vfydmdhpqfprps', password: '61a633ebc9be273196de854c914faf8161a4809f17bab6109c400d81daff6e6c' })
      db.prepare("query", sql)
      result = db.exec_prepared( "query", values )
      # uncomment below for local running.
      # db = PG.connect({ dbname: 'codinglog', host: 'localhost' })
      # db.prepare("query", sql)
      # result = db.exec_prepared( "query", values )
    ensure
      db.close() if db != nil
    end
    return result
  end

end
