class MealController < ApplicationController

  get '/meals' do
    erb :'/meals/plan'
  end

  get '/create_recipe' do
    @user = current_user
    erb :'/meals/create_recipe'
  end

  post '/recipe' do
    if params[:content] == ""
     redirect "/create_recipe"
   else
     user = User.find_by_id(session[:user_id])
     @recipe = Meal.create(:name => params[:name], :content => params[:content], :user_id => user.id)
     redirect "/recipe/#{@recipe.id}"
   end
  end

  get '/recipe/:id' do
    if  session[:user_id]
      @recipe = Meal.find_by_id(params[:id])
      erb :"/meals/show_meal"
    else
      redirect "/login"
    end
  end


end
