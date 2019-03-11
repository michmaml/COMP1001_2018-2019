require 'sinatra'
set :bind, '0.0.0.0'
require 'erb'
require 'sqlite3'
include ERB::Util
@db = SQLite3::Database

before do
  @db = SQLite3::Database.open './database.sqlite'
end

get '/Add_Order' do
  @submitted = false
  erb :Add_order
end

post '/Added_Order' do
  @submitted = true
  @Status = params[:Status].strip
  @Type = params[:Type].strip
  @Seats = params[:Seats].strip
  CarID = @db.get_first_value 'SELECT MAX(OrderID)+1 FROM Orders';
  @db.execute(
      'INSERT INTO Orders VALUES (?, ?, ?, ?, ?)',
      [OrderID, @UserID, @Pickup_location, @CarID, 0])
  erb :Add_order
end