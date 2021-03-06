require 'simplecov'
SimpleCov.start
require 'capybara'
require 'rspec'
require 'capybara/cucumber'
require 'sinatra'

## Uncomment to enable SimpleCov
#require 'simplecov'

#SimpleCov.start do
#  add_filter 'features/'
#end

require_relative '../../app'


#sets root as the parent-directory of the current file
set :root, File.join(File.dirname(__FILE__),'../../')
#sets the view directory correctly
set :views, Proc.new{ File.join(root, "views")}


#ENV['RACK_ENV'] = 'test'

if ENV['RAILS_ENV'] == 'test'
  require 'simplecov'
  SimpleCov.start 'rails'
  puts "required simplecov"
end

Capybara.app = Sinatra::Application

class Sinatra::ApplicationWorld
  include RSpec::Expectations
  include RSpec::Matchers
  include Capybara::DSL
end

World do
  Sinatra::ApplicationWorld.new  
end