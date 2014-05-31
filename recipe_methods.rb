require 'pg'

def db_connection
  begin
    connetion = PG.connect(dbname: 'recipes')

    yield(connection)

  ensure
    connection.close
  end
end
