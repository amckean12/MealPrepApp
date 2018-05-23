class MealController < ApplicationController

  get '/recipes' do
    if logged_in?
      @user = current_user
      @recipes = Meal.all
      erb :'/recipes'
    else
      redirect "/login"
    end
  end

  get '/create_recipe' do
    @user = current_user
    if session[:user_id] then erb :"/meals/create_recipe" else   redirect to "/login" end
  end

  post '/recipe' do
    if params[:content] == ""
     redirect "/create_recipe"
   else
     user = User.find_by_id(session[:user_id])
     @recipe = Meal.create(:name => params[:name], :content => params[:content], :rating => params[:rating], :user_id => user.id)
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
      if @recipe.user_id == session[:user_id] then erb :'/meals/edit_recipe' else redirect to '/recipe' end
    else
      redirect "/login"
    end
  end

  patch '/recipe/:id' do
   if params[:content] != ""
     @recipe = Meal.find_by_id(params[:id])
     @recipe.content = params[:content]
     @recipe.rating = params[:rating]
     @recipe.save
     redirect "/recipe/#{@recipe.id}"
   else
     redirect "/recipe/#{params[:id]}/edit"
   end
 end

 delete '/recipe/:id/delete' do
    while session[:user_id]
      @recipe = Meal.find_by_id(params[:id])
      #Checks to make sure the tweet's user equals the session's user if so then we delete the tweet and direct back to the tweets route
        if @recipe.user_id == session[:user_id] then @recipe.delete ; redirect "/user_home" end
        redirect "/login" #the default redirect if user not logged in
    end
  end
end
