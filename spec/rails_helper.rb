# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

require 'spec/spec_helper'
require 'capybara/rspec'
require 'rspec/rails'
require 'factory_bot'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

Webdrivers.cache_time = 86400

client = Selenium::WebDriver::Chrome::Remote::Http::Default.new
browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |options|
  options.args << '--headless'
  options.args << '--disable-gpu'
  options.args << '--disable-site-isolation-trials'
  options.args << '--no-sandbox'
  options.args << '--disable-dev-shm-usage'
  options.args << '--window-size=1280,720'
end

Capybara.register_driver :headless_chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    capabilities: browser_options,
    http_client: client
  )
end

RSpec.configure do |config|
  config.include Capybara::DSL, type: :system
  config.include Rails.application.routes.url_helpers
  config.include ActionDispatch::TestProcess::FixtureFile
  %i[request view].each do |type|
    config.include ::Rails::Controller::Testing::TestProcess, type: type
    config.include ::Rails::Controller::Testing::TemplateAssertions, type: type
    config.include ::Rails::Controller::Testing::Integration, type: type
  end

  config.include FactoryBot::Syntax::Methods # FactoryBot. の接頭辞を省略する

  config.use_transactional_fixtures = true

  config.before :each, type: :system do
    driven_by :rack_test
  end

  config.before :each, type: :system, js: true do
    # driven_by(:selenium_chrome)
    driven_by :headless_chrome
  end

  config.before :each, type: :controller do
    request.env['HTTP_HOST'] = 'localhost'
    request.env['SERVER_PORT'] = 3000
  end

  config.before :suite do
    FactoryBot.reload
    Rails.application.load_tasks
  end

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
