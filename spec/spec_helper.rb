require './gatherer_extractor'
require 'webmock/rspec'

SUPPORT_PATH = File.expand_path("support", File.dirname(__FILE__))

RSpec.configure do |config|
  config.mock_with :rspec
  config.color = true
end
