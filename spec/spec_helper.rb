require 'simplecov'
SimpleCov.start 'rails'

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rails'
require 'capybara/rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("spec/factories/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.include Capybara::DSL,           type: :request
  config.include Devise::TestHelpers,     type: :controller
  config.include Capybara::RSpecMatchers, type: :request
  config.include FactoryGirl::Syntax::Methods

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = true
  config.order = "random"

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.start
  end
end

def login_with( user = FactoryGirl.build(:user) )
  visit new_user_session_url

  fill_in "user[email]",    with: user.email
  fill_in "user[password]", with: "123123123"

  click_on "Sign in"
end

def post_a_new_thing( thing = FactoryGirl.build(:thing) )
  visit thing_this_path

  fill_in "thing[url]",         with: thing.url
  fill_in "thing[description]", with: thing.description

  click_on "Thing this!"
end
