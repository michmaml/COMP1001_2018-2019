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

<<<<<<< HEAD
set :root, File.join(File.dirname(__FILE__),'../../')
set :views, Proc.new{ File.join(root,"views")}
=======
#sets root as the parent-directory of the current file
set :root, File.join(File.dirname(__FILE__),'../../')
#sets the view directory correctly
set :views, Proc.new{ File.join(root, "views")}
>>>>>>> c0e7556c323b48a1e8eb4774d8f2c5d53aa7a804

ENV['RACK_ENV'] = 'test'

Capybara.app = Sinatra::Application

class Sinatra::ApplicationWorld
  include RSpec::Expectations
  include RSpec::Matchers
  include Capybara::DSL
end

World do
  Sinatra::ApplicationWorld.new  
end