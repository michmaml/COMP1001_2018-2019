require 'sinatra'
set :bind, '0.0.0.0'
require 'erb'
require 'sqlite3'
include ERB::Util
@db = SQLite3::Database

before do
  @db = SQLite3::Database.open './database.sqlite'
end

get '/Add_car' do
  @submitted = false
  erb :Add_cars
end

post '/Added_car' do
  @submitted = true
  @Status = params[:Status].strip
  @Type = params[:Type].strip
  @Seats = params[:Seats].strip
  CarID = @db.get_first_value 'SELECT MAX(CARID)+1 FROM Cars';
  @db.execute(
      'INSERT INTO Cars VALUES (?, ?, ?, ?)',
      [CarID, @Status, @Type, @Seats])
  erb :Add_cars
end
  