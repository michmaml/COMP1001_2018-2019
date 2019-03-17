require 'sinatra'
set :bind, '0.0.0.0'
require 'erb'
require 'sqlite3'
include ERB::Util
@db = SQLite3::Database
before do
  @db = SQLite3::Database.open './database.sqlite'
end

get '/Delete_car' do
  @deleted = false
  erb :Delete_car
end

post '/Deleted_car' do
    @deleted = true
    unless params[:search].nil?
        @Carid = params[:search].strip
    @db.execute(
        'DELETE FROM Cars WHERE CARID = ?',
        [@Carid])
    end
    erb:Delete_car
end