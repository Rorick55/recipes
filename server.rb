require 'sinatra'
require_relative 'recipe_methods'
#creates a connection with the database and ensures that it gets closed after.

get '/' do
  #I want the main page to have a url of /recipes, so i simply redirect to it/
  redirect '/recipes'
end

get '/recipes' do
  @page_number = params[:page] || 1
  #I need to creat a method to make a return page that does not go into negative numbers.
  @return_page = return_page(@page_number)
  #I need to write some method that pulls in the recipe names and their id numbers to link them to their page.
  #I would also like to use pagination here in the future via sql, so I should write that method to only pull in 20 recipes at a time.
  @recipes = recipe_names(@page_number)
  @page_number = @page_number.to_i + 1
  erb :index
end

get '/recipes/:id' do
  id = params[:id]
  #The method I need for this page needs to only pull in the information for the recipe based on
  #the params[:id] for the link chosen. It also needs to pull in all the ingredients with the respective recipe id.
  #The method needs to take an argument to input each id to pull the right recipe out.
  @single_recipe = recipe_and_ingredients(id)
  erb :recipe
end
