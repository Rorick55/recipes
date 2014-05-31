require 'sinatra'
require 'pg'

#creates a connection with the database and ensures that it gets closed after.
def db_connection
  begin
    connetion = PG.connect(dbname: 'recipes')

    yield(connection)

  ensure
    connection.close
  end
end

get '/' do
  #I want the main page to have a url of /recipes, so i simply redirect to it/
  redirect '/recipes'
end

