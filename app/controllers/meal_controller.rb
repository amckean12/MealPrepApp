class MealController < ApplicationController

  get '/recipes' do
    @user = current_user
    erb :'/recipes'
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

  get '/recipe/:id/edit' do
    if session[:user_id]
      @recipe = Meal.find_by_id(params[:id])
      if @recipe.user_id == session[:user_id] then erb :'meals/edit_recipe' else redirect to '/user_home' end
    else
      redirect "/login"
    end
  end

  patch '/recipe/:id' do
   if params[:content] != ""
     @recipe = Meal.find_by_id(params[:id])
     @recipe.content = params[:content]
     @recipe.save
     redirect "/recipe/#{@recipe.id}"
   else
     redirect "/recipe/#{params[:id]}/edit"
   end
 end


end
