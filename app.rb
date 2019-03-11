# app.rb
# Main controller for Twaxis web application
# COM1001 Spring Semester Assignment 2019
# Jamie Huddlestone


### Includes ###

require 'erb'
include ERB::Util

require 'sinatra'
#require 'sinatra/reloader'	# Development use only

require 'twitter'

require 'sqlite3'


### Initialisation ###

set :bind, '0.0.0.0'		# Only needed if running from Codio

enable :sessions
set :session_secret, 'e30c0ca0f0c5a22f534f99a278313195'	# MD5 hash of 'ise19team28'

before do
	@twitter = Twitter::REST::Client.new({
		:consumer_key => 'W9U8E3u06f8l71HKy1ee0Cj9R',
		:consumer_secret => 'f3j6CRS8vnUgJC74Qxfrq3lLqvl20guPrOl44K4suTFeJF7FRr',
		:access_token => '1092451400397795328-W9G9A4nhLfCcRFc9Ks3TGjzlkSwqPS',
		:access_token_secret => 'thqiEEgwQqjRdSvwmxgyQk1hNbFqG3f5bNztHlIhGNymF'
	})
	
	@db = SQLite3::Database.new('models/Twaxis.sqlite')
	# FOR DEVELOPMENT ONLY!!!
	session[:admin_login] = true
	session[:user_login] = false
	#session[:first_name] = 'customer'
end


### Routing ###

# Rather than use header and footer files, include body content in template.erb
# by setting @view to the symbol that corresponds to the .erb file for it...

# Home
get '/' do
	if session[:user_login]
		@view = :welcome
	else
		@view = :home
	end
	erb :template
end

# Join
get '/join' do
	@view = :join
	erb :template
end


#Join POST
require_relative 'controllers/create_user.rb'
    
#log_in
get '/log_in' do
    if session[:user_login]
        @view = :account
    else
        @view = :log_in                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
    end
    erb:template
end

# Account
get '/account' do
	if session[:user_login]
	
		# Fetch details of current user
		require_relative 'controllers/fetch_users.rb'
	
		@view = :account
	else
		@view = :log_in
	end
	erb :template
end
post '/account' do
	
	# Update user based on details from params[].
	require_relative 'controllers/update_user.rb'
	
	redirect '/account'
end

# Admin
get '/admin' do
	if session[:admin_login]
		@view = :admin
	else
		@view = :log_in
	end
	erb :template
end
post '/admin' do
	
	# Authenticate and create login session
	require_relative 'controllers/log_in.rb'
	
	redirect '/admin'
end

# Users
get '/users' do
	if session[:admin_login]
		
		# Fetch filtered list of users / specific details of user
		require_relative 'controllers/fetch_users.rb'
	
		@view = :users
	else
		@view = :not_authorised
	end
	erb :template
end
post '/users' do
	
	# Update user based on details from params[].
	require_relative 'controllers/update_user.rb'
	
	redirect '/admin'
end

# Orders
get '/orders' do
	if session[:admin_login]
	
		# By way of example... ----------------------------------
		screen_name = "realDonaldTrump"

		# Imagine this array is full of rows from the database...
		@orders = []
		@orders.push({

			date: Time.now.strftime("%F"),
			time: Time.now.strftime("%T"),
			from: "S3 7HB",
			to: "S10 2GJ",

			id: "1234567890",
			screen_name: screen_name,

			tweets: @twitter.user_timeline(screen_name).take(100)
		})
		# -------------------------------------------------------

		# Fetch current active orders
		require_relative 'controllers/fetch_orders.rb'

		# Fetch tweet timelines based on those orders
		require_relative 'controllers/fetch_tweets.rb'

		@view = :orders
	else
		@view = :not_authorised
	end
	erb :template
end
post '/orders' do
	
	# Confirm taxi order
	require_relative 'controllers/create_order.rb'
	
	# Update taxi order
	require_relative 'controllers/update_order.rb'
	
	redirect '/orders'
end
post '/tweet' do
		
	# Reply to tweet using posted params
	require_relative 'controllers/create_tweet.rb'
	
	redirect '/orders'
end

# Not found
not_found do
	@view = :not_found
	erb :template
end

# Error
error do
	@view = :error
	erb :template
end