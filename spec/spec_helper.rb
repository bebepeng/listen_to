ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.infer_base_class_for_anonymous_controllers = false

  config.order = "random"

  config.include FeatureHelpers, type: :feature

  VCR.configure do |c|
    #c.allow_http_connections_when_no_cassette = true
    c.cassette_library_dir = 'fixtures/vcr_cassettes'
    c.hook_into :webmock

    c.filter_sensitive_data('<YOUTUBE_KEY>') {ENV['YOUTUBE_API_KEY']}
    c.ignore_localhost = true
  end
end

