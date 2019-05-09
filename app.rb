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

require 'mail'

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

# Contact
get '/contact' do
    @view = :contact
    erb :template
end

post '/contact' do
    contact_submitted
    @view = :contact
    erb :template
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
		redirect '/not_authorised'
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

get '/user_settings' do 
    @view = :user_settings
    erb :template
end

#-------------------------------------------------------------------------------

# Tweets
get '/tweets' do
	if session[:admin_login]

		# Fetch current active orders
		fetch_tweets

		@view = :tweets
	else
		redirect '/not_authorised'
	end
	erb :template
end
post '/tweets/*' do
	if session[:admin_login]
		case params[:splat][0]
			when "reject"

				# Change tweet status to rejected
				reject_tweet

			when "accept"
			
				# Create taxi order (which also creates tweet)
				create_order
			
			when "reply"
			
				# Reply to tweet
				create_tweet
				
		end
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
		redirect '/not_authorised'
	end
	erb :template
end
post '/orders/*' do
	if session[:admin_login]
		case params[:splat][0]
			when "reply"
			
				# Reply to tweets
				create_tweet
			
			when "update"
			
				# Update taxi order
				update_order
			
			when "delete"
			
				# Cancel taxi order
				delete_order
			
			when "archive"
			
				# Archive taxi order
				archive_order
				
		end
	end
	redirect '/orders'
end

#-------------------------------------------------------------------------------

#Cars
get '/cars' do
    @Carlist = fetch_cars
    #puts @Carlist
    @view = :cars
    erb :template
end

get '/Add_car' do
    @view = :Add_cars
    erb :template
end

post '/Added_car' do
   add_cars(params[:Type][0].to_i,params[:Seats][0].to_i,params[:Location].to_s)
   redirect '/cars'
end  

post "/deletecar" do
    delete_car
    redirect "/cars"
end
#-------------------------------------------------------------------------------
# ERROR views
#-------------------------------------------------------------------------------

# Form error
get '/form_error' do
	@view = :form_error
	erb :template
end

# Not authorised
get '/not_authorised' do
	@view = :not_authorised
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
