require 'pg'

def db_connection
  begin
    connetion = PG.connect(dbname: 'recipes')

    yield(connection)

  ensure
    connection.close
  end
end

def recipe_names(page)
    #set the start of each page for the offset
  index = (page.to_i - 1) *20
  20_recipes = db_connection do |conn|
    conn.exec("SELECT name, id FROM recipes ORDER BY name OFFSET #{index} LIMIT 19;")
  end
  #change the pg to an array so I can use it easier.
  20_recipes.to_a
end

def return_page(page)
  return_page = nil
    if page.to_i <= 1
      return_page = 1
    else
      return_page = page.to_i - 1
    end
  return_page
end
