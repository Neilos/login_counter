require 'sinatra/base'

class ApplicationController < Sinatra::Base

get '/?' do
  erb :home
end

end