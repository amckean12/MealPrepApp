class UserController < ApplicationController

  get '/login' do
    erb :"/users/login"
  end

  get '/signup' do
    erb :"/users/create_user"
  end

  post '/signup' do
    if params[:username]== ""  || params[:email] =="" || params[:password] == ""
      redirect "/signup"
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect '/meals' 
    end
  end

end
