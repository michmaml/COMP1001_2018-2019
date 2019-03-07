require 'sinatra' 
set :bind, '0.0.0.0'

get '/home' do
   
    erb :home_body
end