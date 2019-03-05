puts "This is a process #{Process.pid}"
require 'sinatra'
require 'erb'
include ERB::Util
set :bind, '0.0.0.0' # needed if you're running from codio

enable :sessions
set :session_secret, 'super secret'

nametest = 'Bill Murray'

get '/' do
    redirect 'login'
end

get '/admin' do
    @name = 'Bill'
    @to_location = 'Away'
    @from_location = 'Home'
    @tweet_text = 'This is a test'
    @full_name = nametest
    erb :admin
end

get '/car_table' do
    @lists = ['1','2','3']
    @listed = ['3','1','2']
    erb :car_table
end

get '/login' do
    erb :login
end

post '/login' do 
    if params[:password] == 'test' && params[:username] == 'test'
        session[:logged_in] = true
        redirect '/profile'
    end
    @error = "password incorrect"#needs sorting
    erb :login
end

get '/logout' do
    session.clear
    redirect '/login'
end

get '/profile' do
    erb :profile
end

get '/register' do
    erb :register
end
