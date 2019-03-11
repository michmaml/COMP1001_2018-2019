# fetch_tweets.rb
# <description here>
# COM1001 Spring Semester Assignment 2019
# <name here>


get '/find_tweets' do
    search_string = "ise19team28"
    results = @client.search(search_string)
    @tweets = results.take(200000)
    erb: orders
end
