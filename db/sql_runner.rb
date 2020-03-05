require( 'pg' )

class SqlRunner

  def self.run( sql, values = [] )
    begin
      # db = PG.connect({ dbname: 'd532jgc7ehji3k', host: 'ec2-23-22-156-110.compute-1.amazonaws.com',port: 5432, user: 'aizmxdnrkbccjn', password: 'b58a252757d70bcf28e4f87ab55b101e994d15e8657a1b2e89705e94b0ebd37f' })
      # db.prepare("query", sql)
      # result = db.exec_prepared( "query", values )

      # uncomment the below three lines if running local
      db = PG.connect({ dbname: 'codinglog', host: 'localhost' })
      db.prepare("query", sql)
      result = db.exec_prepared( "query", values )
    ensure
      db.close() if db != nil
    end
    return result
  end

end
