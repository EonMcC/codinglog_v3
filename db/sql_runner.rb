require( 'pg' )

class SqlRunner

  def self.run( sql, values = [] )
    begin
      db = PG.connect({ dbname: 'd98ikb9opt6uah', host: 'ec2-34-195-169-25.compute-1.amazonaws.com',port: 5432, user: 'cjjdhffcsfdmzf', password: '7eb1722730a90dd4e789ddfa53f9a696e6f1adc549f5e2471c2ba9d36852b2ae' })
      db.prepare("query", sql)
      result = db.exec_prepared( "query", values )

      # uncomment the below three lines if running local
      # db = PG.connect({ dbname: 'codinglog', host: 'localhost' })
      # db.prepare("query", sql)
      # result = db.exec_prepared( "query", values )
    ensure
      db.close() if db != nil
    end
    return result
  end

end
