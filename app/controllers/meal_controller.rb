class MealController < ApplicationController

  get '/meals' do
    erb :'/meals/meals'
  end

end
