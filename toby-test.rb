puts "This is a process #{Process.pid}"
require 'sinatra'
set :bind, '0.0.0.0' # needed if you're running from codio

nametest = 'Bill Murray'

get '/' do
    @name = 'Bill'
    @to_location = 'Away'
    @from_location = 'Home'
    @tweet_text = 'This is a test'
    @full_name = nametest
    erb :admin
end

get '/1' do
    @lists = ['1','2','3']
    @listed = ['3','1','2']
    erb :car_table
end

