require 'sinatra'
require_relative 'recipe_methods'
#creates a connection with the database and ensures that it gets closed after.

get '/' do
  #I want the main page to have a url of /recipes, so i simply redirect to it/
  redirect '/recipes'
end

get '/recipes' do
  #I need to write some method that pulls in the recipe names and their id numbers to link them to their page.
  #I would also like to use pagination here in the future via sql, so I should write that method to only pull in 20 recipes at a time.
  @recipes = 20_recipe_names
  #then I need to turn that into an array to more easily work with
  @recipes = @recipes.to_a
  erb :index
end

get '/recipes/:id' do
  #The method I need for this page needs to only pull in the information for the recipe based on
  #the params[:id] for the link chosen. It also needs to pull in all the ingredients with the respective recipe id.
  #The method needs to take an argument to input each id to pull the right recipe out.
  @single_recipe = recipe_and_ingredients(params[:id])
  @single_recipe = @single_recipe.to_a
  erb :recipe
end
