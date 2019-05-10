module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    
    when /the login\s?page/
      '/login' 
        
    when /the signup\s?page/
      '/signup'
        
    when /the welcome\s?page/
      '/welcome'
    
    when /the usersettings\s?page/
      '/user_settings'
        
    when /the tweets\s?page/
      '/tweets'
        
    when /the orders\s?page/
      '/orders' 
       
    when /the notfound\s?page/
      '/not_found'
        
    when /the notauthorised\s?page/
      '/not_authorised'
        
    when /the join\s?page/
      '/join'
        
    when /the formerror\s?page/
      '/form_error'
        
    when /the error\s?page/
      '/error'
    
    when /the contact\s?page/
      '/contact'
        
    when /the cars\s?page/
      '/cars'
        
    when /the admin\s?page/
      '/admin'
        
    when /the addcar\s?page/
      '/Add_car'
        
    when /the account\s?page/
      '/account'
        

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"

    end
  end
end

World(NavigationHelpers)