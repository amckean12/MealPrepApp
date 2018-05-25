class UserController < ApplicationController

  get '/login' do
    if logged_in?
       redirect to '/user_home'
    else
       erb :'/users/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect to '/'
  end

  get '/signup' do
    if logged_in?
      redirect to '/user_home'
    else
      erb :"/users/create_user"
    end
  end

  post '/signup' do
    if params[:username]== ""  || params[:email] =="" || params[:password] == ""
      flash[:signup_error] = "No field can be left Empty"
      redirect "/signup"
    #checks to make sure username does not exist in db before creating user
    elsif User.where(:username => params[:username]).blank? && User.where(:email => params[:email]).blank?
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect '/user_home'
    #if attr exist in db then redirect to signup to create new user
    else
      flash[:signup_error] = "Username and/or Email alredy exist"
      redirect '/signup'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/user_home'
    else
      flash[:login_error] = "Username or Password Incorrect"
      redirect '/login'
    end
  end

  get '/user_home' do
    if logged_in?
      @user = current_user
      erb :"/users/user_home"
    else
      redirect '/login'
    end
  end
end
