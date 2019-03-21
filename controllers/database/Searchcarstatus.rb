require 'sinatra'
set :bind, '0.0.0.0'
require 'erb'
require 'sqlite3'
include ERB::Util
@db = SQLite3::Database
before do
  @db = SQLite3::Database.open './database.sqlite'
end

get '/' do
    "test it's right url"
end

get '/Car_status_search' do
    unless params[:search].nil?
        query = %{ SELECT CarID, Status, Type
            FROM Cars 
            WHERE Status Like '%' || ? || '%'}
    @results = @db.execute query, params[:search]
    end
    erb:Car_status_search
end