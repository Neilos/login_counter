require 'sinatra/base'
require_relative '../models/DM_config'

class ApplicationController < Sinatra::Base

# configure sinatra app
configure do
  set :root, Proc.new { File.join(File.dirname(__FILE__), "../../") }
  use Rack::Session::Cookie, 
      :key => 'rack.session', 
      :secret => 'how many times are you going to login',
      :httponly => true
end

get '/?' do
  if session[:user]
    redirect '/logged_in'
  else
    erb :home
  end
end

post '/signup/?' do
  @user = User.create(
    :firstname => params[:firstname],
    :lastname => params[:lastname],
    :email => params[:email],
    :password => params[:password]
  )
  if @user.saved?
    erb(:signup_success, :layout => false) 
  else
    halt 400, erb(:signup_failure, :layout => false)
  end
end

post '/login' do
  @user = User.first(:email => params[:email])
  if !@user.nil? && @user.authenticated?(params[:password])
    @user.increment_login_count
    @user.save!
    session[:user] = @user.id
    redirect to "/logged_in", 304
  else
    halt 400, erb(:login_failure, :layout => false)
  end
end

get '/logged_in' do
  if session[:user]
    @user = User.first(:id => session[:user])
    erb :logged_in
  else
    redirect '/'
  end
end

end