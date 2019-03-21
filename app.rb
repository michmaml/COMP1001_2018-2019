# app.rb
# Main controller for Twaxis web application
# COM1001 Spring Semester Assignment 2019
# Jamie Huddlestone


### Includes ###

require 'erb'
include ERB::Util

require 'sinatra'
#require 'sinatra/reloader'	# FOR DEVELOPMENT USE ONLY

require 'twitter'

require 'sqlite3'

require_relative 'controllers/constants_INCLUDE_FIRST.rb'
require_relative 'controllers/login_functions.rb'
require_relative 'controllers/create_functions.rb'
require_relative 'controllers/fetch_functions.rb'
require_relative 'controllers/update_functions.rb'
require_relative 'controllers/delete_functions.rb'


### Initialisation ###

set :bind, '0.0.0.0'		# Only needed if running from Codio

enable :sessions
set :session_secret, 'e30c0ca0f0c5a22f534f99a278313195'	# MD5 hash of 'ise19team28'

before do
	
	#--FOR DEVELOPMENT USE ONLY--#
	#session[:user_login] = false
	#session[:admin_login] = false
	#----------------------------#
	
	@twitter = Twitter::REST::Client.new({
		:consumer_key => 'W9U8E3u06f8l71HKy1ee0Cj9R',
		:consumer_secret => 'f3j6CRS8vnUgJC74Qxfrq3lLqvl20guPrOl44K4suTFeJF7FRr',
		:access_token => '1092451400397795328-W9G9A4nhLfCcRFc9Ks3TGjzlkSwqPS',
		:access_token_secret => 'thqiEEgwQqjRdSvwmxgyQk1hNbFqG3f5bNztHlIhGNymF'
	})
	@db = SQLite3::Database.new('models/Twaxis.sqlite')
	@db.results_as_hash = true
end


### Routing ###

# Rather than use header and footer files, include body content in template.erb
# by setting @view to the symbol that corresponds to the .erb file for it...

#-------------------------------------------------------------------------------
# PUBLIC views
#-------------------------------------------------------------------------------

# Home
get '/' do
	if session[:admin_login]
		redirect '/admin'	
	elsif session[:user_login]
		@view = :welcome
	else
		@view = :home
	end
	erb :template
end

#-------------------------------------------------------------------------------

# Join
get '/join' do
	@view = :join
	erb :template
end
post '/join' do
	
	# Create user
	create_user
	
	redirect '/'
end

#-------------------------------------------------------------------------------
# LOGIN views
#-------------------------------------------------------------------------------

# Log in
get '/login' do
	@view = :log_in
	erb :template
end
post '/login' do
	
	# Log in
	log_in
	
	redirect '/'
end

# Log out
get '/logout' do
	
	# Log out
	log_out
	
	redirect '/'
end

#-------------------------------------------------------------------------------
# USER views
#-------------------------------------------------------------------------------

# Account
get '/account' do
	if session[:user_login]
	
		# Fetch details of current user
		fetch_users
	
		@view = :account
	else
		redirect '/login'
	end
	erb :template
end
post '/account' do
	if session[:user_login]
	
		# Update user
		update_user
	
	end
	redirect '/account'
end

#-------------------------------------------------------------------------------
# ADMIN views
#-------------------------------------------------------------------------------

# Admin
get '/admin' do
	if session[:admin_login]
		@view = :admin
	else
		redirect '/login'
	end
	erb :template
end
post '/admin' do
	
end

#-------------------------------------------------------------------------------

# Users
get '/users' do
	if session[:admin_login]

		# Fetch filtered list of users / specific details of user
		fetch_users

		@view = :users
	else
		@view = :not_authorised
	end
	erb :template
end
post '/users' do
	if session[:admin_login]
		
		# Update user
		update_user
		
	end
	redirect '/users'
end

#-------------------------------------------------------------------------------

# Tweets
get '/tweets' do
	if session[:admin_login]

		# Fetch current active orders
		fetch_tweets

		@view = :tweets
	else
		@view = :not_authorised
	end
	erb :template
end
post '/tweets' do
	if session[:admin_login]
		
		# Create order from tweet
		create_order
		
	end
	redirect '/tweets'
end

#-------------------------------------------------------------------------------

# Orders
get '/orders' do
	if session[:admin_login]

		# Fetch current active orders
		fetch_orders

		@view = :orders
	else
		@view = :not_authorised
	end
	erb :template
end
post '/orders' do
	if session[:admin_login]

		# Update taxi order
		#update_order
		
	end
	redirect '/orders'
end

#-------------------------------------------------------------------------------
# ERROR views
#-------------------------------------------------------------------------------

# Form error
get '/form_error' do
	@view = :form_error
	erb :template
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
