# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'


#create a subfolder under spec called "support" put methods like this in categorized folders (best practice) >> might need to put code in a module (check that...)

def sign_in_as_existing_user(existing_user)
  visit new_user_session_path
  fill_in "email", with: existing_user.email
  fill_in "password", with: existing_user.password
  click_button "Sign in"
end

def sign_up_as_a_new_user(new_user)
    fill_in "first_name", with: new_user.first_name
    fill_in "last_name", with: new_user.last_name
    fill_in "email", with: new_user.email
    fill_in "password", with: new_user.password
    fill_in "password_confirmation", with: new_user.password_confirmation
    check "terms"
    click_on "Create Account"
end

def submit_a_new_story(new_story)
  fill_in "title", with: new_story.title
  fill_in "body", with: new_story.body
  select "Junior", from: "Child's First Name:"
  click_on "Submit"
end

def save_draft_of_a_new_story(new_story)
  fill_in "title", with: new_story.title
  select "Junior", from: "Child's First Name:"
  fill_in "body", with: new_story.body
  click_on "Save as Draft"
end


def update_existing_story
  fill_in "title", with: "Eating Burgers"
  fill_in "body", with: "Burger eating story..."
  select "Jasmine", from: "Child's First Name:"
  select "private", from: "Share type" 
end

def submit_a_new_comment(new_comment)
  fill_in "body", with: "That was the funniest thing I've ever read..."
  click_on("Submit")
end

def update_an_existing_comment(comment)
  fill_in "body", with: "That was the dumbest thing I've ever read..."
  click_on("Update")
end


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



