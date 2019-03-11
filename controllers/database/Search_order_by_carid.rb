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

get '/Order_carid_search' do
    unless params[:search].nil?
        query = %{ SELECT OrderID, CarID, UserID, Pickup_location, Date_time, Completed
            FROM Orders 
            WHERE CarID Like '%' || ? || '%'}
    @results = @db.execute query, params[:search]
    end
    erb:Search_order_by_carid
end