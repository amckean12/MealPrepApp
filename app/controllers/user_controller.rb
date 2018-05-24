class UserController < ApplicationController

  get '/login' do
    erb :"/users/login"
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end

  get '/signup' do
    erb :"/users/create_user"
  end

  post '/signup' do
    if params[:username]== ""  || params[:email] =="" || params[:password] == ""
      redirect "/signup"
    #checks to make sure username does not exist in db before creating user
    elsif User.where(:username => params[:username]).blank? && User.where(:email => params[:email]).blank?
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect '/user_home'
    #if attr exist in db then redirect to signup to create new user
    else
      redirect '/signup'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/user_home'
    else
      redirect '/login'
    end
  end

  get '/user_home' do
    @user = current_user
    erb :"/users/user_home"
  end


end
