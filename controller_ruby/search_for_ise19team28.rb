require 'erb'
require 'sinatra'
require 'twitter'
require 'sqlite3'

set :bind, '0.0.0.0' 
include ERB::Util

before do
  config = {
      :consumer_key => 'W9U8E3u06f8l71HKy1ee0Cj9R',
      :consumer_secret => 'f3j6CRS8vnUgJC74Qxfrq3lLqvl20guPrOl44K4suTFeJF7FRr',
      :access_token => '1092451400397795328-W9G9A4nhLfCcRFc9Ks3TGjzlkSwqPS',
      :access_token_secret => 'thqiEEgwQqjRdSvwmxgyQk1hNbFqG3f5bNztHlIhGNymF'
  }
  @client = Twitter::REST::Client.new(config)
   
   # @db = SQLite3::Database.new './....'
end

get '/twitter_search' do
    search_string = "ise19team28"
    results = @client.search(search_string)
    @tweets = results.take(20)
  erb :twitter_search
end
