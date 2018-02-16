require 'bundler/setup'
require 'pry'
require 'factory_bot'
require 'zoop'

require_relative 'support/zoop_helper'

RSpec.configure do |config|
  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.include FactoryBot::Syntax::Methods
  config.include ZoopHelper

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
