require 'sinatra/base'

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

end