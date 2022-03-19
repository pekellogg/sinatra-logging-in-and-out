require_relative '../../config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, ".;zH6W$jMBRKyt])"
  end

  # READ
  # LOGIN FORM
  get '/' do
    erb :index
  end

  # CREATE
  # LOGIN FORM
  post '/login' do
    @user = User.where(username: params[:username], password: params[:password]).first
    if @user
      # if successful login, set session's user id to the logged in user's id
      session[:user_id] = @user.id
      redirect '/account'
    else
      erb :error
    end
  end

  # READ
  get '/account' do
    @user = User.find_by(id: session[:user_id])
    if @user
      erb :account
    else
      erb :error
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end