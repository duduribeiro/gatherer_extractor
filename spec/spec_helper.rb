require './gatherer_extractor'
require 'webmock/rspec'
require 'dm-transactions'
require 'database_cleaner'
require './database.rb'
require './models/magic_set.rb'
require './models/magic_card.rb'
#require 'dm-rspec'

SUPPORT_PATH = File.expand_path("support", File.dirname(__FILE__))
DatabaseCleaner[:data_mapper].strategy = :transaction
Database.new.setup

RSpec.configure do |config|
  config.mock_with :rspec
  config.color = true
  #config.include(DataMapper::Matchers)

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
