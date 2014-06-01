require 'pg'

def db_connection
  begin
    connection = PG.connect(dbname: 'recipes')
    yield(connection)
  ensure
    connection.close
  end
end

def recipe_names(page)
    #set the start of each page for the offset
  index = (page.to_i - 1) *20
  twenty_recipes = db_connection do |conn|
    conn.exec("SELECT name, id FROM recipes ORDER BY name OFFSET #{index} LIMIT 19;")
  end
  #change the pg to an array so I can use it easier.
  twenty_recipes.to_a
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

def recipe_and_ingredients(id)
  single_recipe = db_connection do |conn|
    conn.exec("SELECT recipes.name, recipes.description, recipes.instructions, recipes.id, ingredients.name AS ingredient
      FROM recipes LEFT OUTER JOIN ingredients ON recipes.id = ingredients.recipe_id WHERE recipes.id = '#{id}';")
  end
  single_recipe.to_a
end

def recipe_search(word_searched, page)
  index = (page.to_i - 1) * 20
  recipe_search = db_connection do |conn|
    conn.exec("SELECT name, id FROM recipes WHERE name ILIKE '%#{word_searched}%' ORDER BY name OFFSET #{index} LIMIT 19;")
  end
  recipe_search = recipe_search.to_a
end




