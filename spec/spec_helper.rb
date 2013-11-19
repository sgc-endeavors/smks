# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

# class ActionDispatch::IntegrationTest
#     include Capybara::DSL

#     def teardown
#       Capybara.reset_sessions!
#       Capybara.use_default_driver
#     end
# end









# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

#create a subfolder under spec called "support" put methods like this in categorized folders (best practice) >> might need to put code in a module (check that...)
def sign_up_as_a_new_user(new_user)
    visit new_user_path
    fill_in "first_name", with: new_user.first_name
    fill_in "last_name", with: new_user.last_name
    fill_in "email", with: new_user.email
    check "accept_terms"
    click_on "Submit"

end

def update_existing_user_info
    fill_in "first_name", with: "Josey"
    fill_in "last_name", with: "Smiths"
    fill_in "email", with: "josey_smiths@gmail.com"
    

end
