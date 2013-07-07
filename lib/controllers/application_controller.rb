require 'sinatra/base'
require_relative '../models/DM_config'

class ApplicationController < Sinatra::Base

# configure sinatra app
configure do
  set :root, Proc.new { File.join(File.dirname(__FILE__), "../../") }
  use Rack::Session::Cookie, 
      :key => 'rack.session', 
      :secret => 'how many times are you going to login'
end

get '/?' do
  erb :home
end

post '/signup/?' do
  @user = User.create(
    :firstname => params[:firstname],
    :lastname => params[:lastname],
    :email => params[:email],
    :password => params[:password]
  )
  puts
  puts "*******OUTPUT*******"
  puts "params[:firstname]:#{params[:firstname]}"
  puts "params[:lastname]:#{params[:lastname]}"
  puts "params[:email]:#{params[:email]}"
  puts "params[:password]:#{params[:password]}"
  @user.errors.each do |error|
    puts "error: #{error}"
  end
  puts "********************"
  puts
  if @user.saved?
    erb(:signup_success, :layout => false) 
  else
    halt 400, erb(:signup_failure, :layout => false)
  end
end



end